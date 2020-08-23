Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EF3C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5A42075E
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 19:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J0RwWOsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5A42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9vlC-00050a-Mc
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 15:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k9vke-0004b3-VA; Sun, 23 Aug 2020 15:34:00 -0400
Received: from mail-am6eur05on2116.outbound.protection.outlook.com
 ([40.107.22.116]:55137 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k9vka-0004Qc-Fk; Sun, 23 Aug 2020 15:33:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FahRcKjiI1vbWt9iKWw0NRMH7xQ3IGWKIHplkcOTiOnEM3NufqAUgrB9T/H5nJZRD7yRpDfVd0GLtqDWcYFeiGnQdt/Ei4ysQPjRguCJcYkU2YxMw7GcCnPo7uxnbCYcSxZdmFyUpE0kZ0IWsJ/Ln2zCgaNVjy1GmMNw4zaw+TaqgLtIWMSMpswe66BN37fOiPPKCdDqXcmwgZoQd9C3X5WdYRwQgd93/cFnYTJBQ5rg8olIe/Bzr2tGYj8xQr5d17RJgCRAZNL5Nme3405sAnmeJyV5chGfaKc7AXk4ITCjT4qm238C86eblh9xZaT1XaReHwQSvfiCf51/+RDqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3aapWDZqiJsqBtou11ImaOimQXHbuTSDnHtbn99D0o=;
 b=aOUufV8mKmBFI62zrvxtM7B5XxqZafU3XTV7Klqo88cH4CUEgAwYyTZySO9pCKoLCfwm56s4yFvwsDJePP0qrRUQEFtuNcullGNLhXxRGog6ZHgT9QPyJ2Wt8Rng8PvS+I0XO5pgCnZSrnEWkl4P+QhwXX1/DhPjwoEab0W6MO0qKcO+b2SDQHh8J5m8slQIxD8YvXWZd+odHHcdCMIHvV+uKidKHY7UKT+huJnOdYUn87lHq8XYWxu7z394hbTKqLGgezAJCCbKIBrw3Xo6B4SUhPDsX27QRQevUqR5Zlxttknbk4n4vdgbQoygyCe99yWJzoTSUshD/BA/Se5nJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3aapWDZqiJsqBtou11ImaOimQXHbuTSDnHtbn99D0o=;
 b=J0RwWOsTNpLsbsIbk1XpqU821+o1wQtm/fhvdzChI7TzpkQXzGqVAj85M+BW5rriG4OGunYrKMPRRenegKvEHeEPeSEwM2vtY/XgVqELSw8RAkcswzvuYQuADFchhKf6AouCuNGuD2e7JT6dzQGgtbKYh/87jWO8jFIHDCt0Eg4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB1642.eurprd08.prod.outlook.com (2603:10a6:3:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Sun, 23 Aug
 2020 19:33:51 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3305.026; Sun, 23 Aug 2020
 19:33:51 +0000
Subject: Re: [PATCH v6 3/4] qapi: add filter-node-name to block-stream
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1597785880-431103-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1597785880-431103-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <d49840c1-cdf2-37ba-4ca3-e81dfb039958@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <7c191d0c-aee9-4143-871e-7f744517c7b5@virtuozzo.com>
Date: Sun, 23 Aug 2020 22:33:48 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <d49840c1-cdf2-37ba-4ca3-e81dfb039958@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM3PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:207:5::14) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM3PR03CA0056.eurprd03.prod.outlook.com (2603:10a6:207:5::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Sun, 23 Aug 2020 19:33:50 +0000
X-Originating-IP: [109.252.114.22]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c93ce7-a851-41e8-e191-08d8479b76d6
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1642:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB164240502B67FE7AF4DEFB5EF4590@HE1PR0801MB1642.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FBJoDeUvAZUY/kd4+4ZWLqmuNlRpKbaqId/4+EzBbjmHPWD3aTFXMyntAf8tUnSMYoeWVSBXwNnm/ceHG5L6eQIf/iEJdnb1JhDHHqq5kppORpDE+DanJ1jZfq7uo99XQC7yBoEkhhbWu5+yD45LtPBv3fGj0fmDkqj5RBi4gMKlxT/D4NJzLsnG29zqpzdQxKBzig16l0EidTJPY7j2vNWbmEFakBPBjHdOgXY/NmUNJVeIA9Bc4LJcfTKdlCoVNU+NU9RKi15sXfVgGn3POehRlstl8Fw50v9TvncYYldyVB0qTZKN9fwxwfPq8roibsEuorOu2ElPzsbB4uuTfQAHbVLKipiHxpe2bgD9F0IzBQ+k/YDD/xnHmFXUrIW6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39830400003)(346002)(478600001)(66556008)(107886003)(8676002)(6512007)(31696002)(6486002)(8936002)(83380400001)(36756003)(66946007)(4326008)(66476007)(16526019)(186003)(26005)(53546011)(6506007)(52116002)(5660300002)(44832011)(2616005)(316002)(86362001)(956004)(2906002)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CmZrFQhMZEVDwHqi+C5SYSYrnIR0XPBvs/I5AMvx+F35aaWNOODIt/Ucqy+ygQKjEgpIEfnXga7NmP30xLdjiK0x7SjSyq0W3t/qJcj6FmYXLBPCzOhwMXG6lpfA+k0mak0e13zTDhdFqzxECXS6lDU9F8bIGuLssMyu0shRNUtuaYdY8iQHhHzLMAxjyuYXxsX8Ov2Dmf6VPV2D4N/aZqRAqP2d/sQ5wKLGEtSun3m2+Um2n0SEEVio12xueBOn8Ba+Bg3x49TPESLplSBF0fEuVVzubCSzcwN1Heq39kwRL0DWD+wz/udRqIR5aYYnnlEMJpPwv8imlnZVzlYEp6yM13sHi6yiTuwK8GVhmACEp+k9pRuRn22Ih9N43LbYJV3x1P5Ysv36omW+RTOnZxpjXrwV9ErfLmcD/S57B+WhDMU6zwHDtgTq/op+Z52iAxZVevzNRSteKe5PFBrnpr8dwpUo/D9R/sflpuHUnvxANysP4IO0Dakkep0l+8hvdgjoaWyvNJnHlVUHK+r8D9PtALN+yRGAYd3kQvPcbw2O7eS5+3UYz0fKZo12Bnio1A+w7B5rXXvu7a8/bW0UPkfFqPfNPSWi8Xx9rU+Gv+kO5OrvYzONhw9pmGeXvPsCu1HoF5IQi9EYZwy7Il3hmA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c93ce7-a851-41e8-e191-08d8479b76d6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2020 19:33:51.4251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NCCBTLaTzBjLSzg8pb6whNObatXeMENBWGoayKEGQ1EMzN6VPLlwq01m4kHIJkTVhAuJ4+anSnkzRMRaw5d44Y+zbi1lnjpFM6QHBYC0+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1642
Received-SPF: pass client-ip=40.107.22.116;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 15:33:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-1.381, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.08.2020 13:29, Vladimir Sementsov-Ogievskiy wrote:
> 19.08.2020 00:24, Andrey Shinkevich wrote:
>> Provide the possibility to pass the 'filter-node-name' parameter to the
>> block-stream job as it is done for the commit block job. That will be
>> needed for further iotests implementations.
>
> and for users as well. I think, the last sentence may be dropped.
>
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/monitor/block-hmp-cmds.c | 4 ++--
>>   block/stream.c                 | 4 +++-
>>   blockdev.c                     | 8 +++++++-
>>   include/block/block_int.h      | 7 ++++++-
>>   qapi/block-core.json           | 6 ++++++
>>   5 files changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/monitor/block-hmp-cmds.c 
>> b/block/monitor/block-hmp-cmds.c
>> index 4d3db5e..4e66775 100644
>> --- a/block/monitor/block-hmp-cmds.c
>> +++ b/block/monitor/block-hmp-cmds.c
>> @@ -507,8 +507,8 @@ void hmp_block_stream(Monitor *mon, const QDict 
>> *qdict)
>>         qmp_block_stream(true, device, device, base != NULL, base, 
>> false, NULL,
>>                        false, NULL, qdict_haskey(qdict, "speed"), 
>> speed, true,
>> -                     BLOCKDEV_ON_ERROR_REPORT, false, false, false, 
>> false,
>> -                     &error);
>> +                     BLOCKDEV_ON_ERROR_REPORT, false, NULL, false, 
>> false, false,
>> +                     false, &error);
>>         hmp_handle_error(mon, error);
>>   }
>> diff --git a/block/stream.c b/block/stream.c
>> index b9c1141..8bf6b6d 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
>> @@ -221,7 +221,9 @@ static const BlockJobDriver stream_job_driver = {
>>   void stream_start(const char *job_id, BlockDriverState *bs,
>>                     BlockDriverState *base, const char 
>> *backing_file_str,
>>                     int creation_flags, int64_t speed,
>> -                  BlockdevOnError on_error, Error **errp)
>> +                  BlockdevOnError on_error,
>> +                  const char *filter_node_name,
>> +                  Error **errp)
>>   {
>>       StreamBlockJob *s;
>>       BlockDriverState *iter;
>> diff --git a/blockdev.c b/blockdev.c
>> index 237fffb..800ecb3 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2476,6 +2476,7 @@ void qmp_block_stream(bool has_job_id, const 
>> char *job_id, const char *device,
>>                         bool has_backing_file, const char *backing_file,
>>                         bool has_speed, int64_t speed,
>>                         bool has_on_error, BlockdevOnError on_error,
>> +                      bool has_filter_node_name, const char 
>> *filter_node_name,
>>                         bool has_auto_finalize, bool auto_finalize,
>>                         bool has_auto_dismiss, bool auto_dismiss,
>>                         Error **errp)
>> @@ -2491,6 +2492,10 @@ void qmp_block_stream(bool has_job_id, const 
>> char *job_id, const char *device,
>>           on_error = BLOCKDEV_ON_ERROR_REPORT;
>>       }
>>   +    if (!has_filter_node_name) {
>> +        filter_node_name = NULL;
>> +    }
>
> this works automatically, you don't need to initialize it by hand


In the current impementation of QEMU, it may look like an excess. I will 
remove it. But the qmp_block_commit() has that check.

Andrey

>
>> +
>>       bs = bdrv_lookup_bs(device, device, errp);
>>       if (!bs) {
>>           return;
>> @@ -2558,7 +2563,8 @@ void qmp_block_stream(bool has_job_id, const 
>> char *job_id, const char *device,
>>       }
>>         stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
>> -                 job_flags, has_speed ? speed : 0, on_error, 
>> &local_err);
>> +                 job_flags, has_speed ? speed : 0, on_error,
>> +                 filter_node_name, &local_err);
>>       if (local_err) {
>>           error_propagate(errp, local_err);
>>           goto out;
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 465a601..3efde33 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -1122,6 +1122,9 @@ int is_windows_drive(const char *filename);
>>    *                  See @BlockJobCreateFlags
>>    * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
>>    * @on_error: The action to take upon error.
>> + * @filter_node_name: The node name that should be assigned to the 
>> filter
>> + * driver that the commit job inserts into the graph above @bs. NULL 
>> means
>> + * that a node name should be autogenerated.
>>    * @errp: Error object.
>>    *
>>    * Start a streaming operation on @bs.  Clusters that are unallocated
>> @@ -1134,7 +1137,9 @@ int is_windows_drive(const char *filename);
>>   void stream_start(const char *job_id, BlockDriverState *bs,
>>                     BlockDriverState *base, const char 
>> *backing_file_str,
>>                     int creation_flags, int64_t speed,
>> -                  BlockdevOnError on_error, Error **errp);
>> +                  BlockdevOnError on_error,
>> +                  const char *filter_node_name,
>> +                  Error **errp);
>>     /**
>>    * commit_start:
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 0b8ccd3..1db6ce1 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2524,6 +2524,11 @@
>>   #            'stop' and 'enospc' can only be used if the block device
>>   #            supports io-status (see BlockInfo).  Since 1.3.
>>   #
>> +# @filter-node-name: the node name that should be assigned to the
>> +#                    filter driver that the stream job inserts into 
>> the graph
>> +#                    above @device. If this option is not given, a 
>> node name is
>> +#                    autogenerated. (Since: 5.1)
>> +#
>>   # @auto-finalize: When false, this job will wait in a PENDING state 
>> after it has
>>   #                 finished its work, waiting for 
>> @block-job-finalize before
>>   #                 making any block graph changes.
>> @@ -2554,6 +2559,7 @@
>>     'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
>>               '*base-node': 'str', '*backing-file': 'str', '*speed': 
>> 'int',
>>               '*on-error': 'BlockdevOnError',
>> +            '*filter-node-name': 'str',
>>               '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
>>     ##
>>
>
>
> With extra "filter_node_name = NULL" dropped:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>

