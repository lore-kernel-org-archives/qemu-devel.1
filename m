Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F25C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18821218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jyuyU8ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18821218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXS5G-0004WY-UZ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kXS3Q-0003Ns-Fv; Tue, 27 Oct 2020 12:42:36 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:44448 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kXS3J-00038L-0B; Tue, 27 Oct 2020 12:42:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFJQoGLHOaC76YhxyxO5+1OlnOaG2+wkXKbdi/VvNA6O5esMhtq66FBHo3ASiUlo3Idn/36a5Lp++6iphgGDo/gj/wf3sx8LE+lgTBf3Gjd9fPN82dc7EcyOxnVW/b5ZFXK28lNezS/MSK7BveXJHeIsX5hlFirRAtLSsYtc2Ow/85hpd3UfD4nK6WpwpeicurNIkd8Wevv8+OJKwmVOEKdGHEN468pG1dQjpn0SoVdp39vClT36tqwssLcsV/SN+4/DgiLEcxou4bg65z1timUR9Z5GHkhO0HMKFYsO2BHRafKbQCeYKF6Rptc/ppv70D3SC/iSwX9fSlLKudez6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJYw5BRMqabGLMi0yFi8s9wI3CL+f/E22BueG8YHa3c=;
 b=d2RXU0csSsCHCcSWDv8FUi7k0oztZoq2S4ZfYSFRXGEMfR8M0YL4iPtfi36lOALYlK+KhAIj2jgXbyQBEYUnGRW4TWO43Xl9nCuo7Lt3LQkpWoZwW2EGSNyR+fPLfrNV173/YZfRL/Sw2MxPOxJw70Dk0flgbegY2mmrxQ8GlkkAfUUzFIvImxhbftQ9GdHBXjv+2GIAyM7c5Lxw0/yxgYpPzILDyfi3W0rzgYmnOq6AOVs4M+YqXdBCz/5x4l6dSL2PmbG6skqr6m4tIKJajIGCmNrh5poGDl1ASoEjef1ZgX4y6ssnbF32Xkc5gP7GatJ8tcuuOxSJ3tV2Z/mk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJYw5BRMqabGLMi0yFi8s9wI3CL+f/E22BueG8YHa3c=;
 b=jyuyU8tsaqIBArvYXWLycOneh20Tl1i/GP2OLHRD3ksTkesH2YliejxiVYg+Vq6cTcpdvzUorcMywZ7xoYT1pyJI+kowmC3SsVTnT6LreW5rZszIetqIqkeez5aklGgTBnSLlt0FzVFFsPCOpf2L8MxDlViBsM8taO8wV45orW4=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2412.eurprd08.prod.outlook.com (2603:10a6:3:de::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Tue, 27 Oct
 2020 16:42:24 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 16:42:24 +0000
Subject: Re: [PATCH v12 13/14] stream: skip filters when writing backing file
 name to QCOW2 header
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-14-git-send-email-andrey.shinkevich@virtuozzo.com>
 <4dadeb14-0744-1cbd-04c5-516ba509cc14@virtuozzo.com>
 <fbcca331-9cca-12c8-d829-4fae360c8ef4@virtuozzo.com>
 <5703e680-a731-2aec-33da-26c431f4b89b@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <e751c20d-7cf0-6e31-80cd-1f6a827a5243@virtuozzo.com>
Date: Tue, 27 Oct 2020 19:42:19 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <5703e680-a731-2aec-33da-26c431f4b89b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR04CA0015.eurprd04.prod.outlook.com
 (2603:10a6:208:122::28) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:208:122::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Tue, 27 Oct 2020 16:42:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0ded7ed-211a-4bf1-48ef-08d87a9747de
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB24126FE24F01130315D7B5E7F4160@HE1PR0802MB2412.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nolyNM6GbEuSNe+XZwBjkrEiNHN60HBOW5dIrmmxnjg6okK244eMukmdC5vhtGTMVtzWWNi8V/pY6Nidn8dDQylb5gFU485feVzIzTjXcgmIQfES7mJnxkdXKoe/TTr3MA4f+KdYrd1CJKzcuF6A1uu/NWa2ilFhX7u0QL6P5i+hV0ChwXDbKLafCGBxmlwIFk0ybd5UU0vsVCPQy1S3OkT8cgp1LvdLyFegA0r4P3yxeTcl7zs2+FXGuLtydL9dpktK5bUrQchmVVEU/yADAeoMBOuCeJMqnZ9Lf4kVBYLHIk3MwVPpKU1pPdWk6qDcDmAN/zk5v3mY/1L0spgb71Tj1I3NYNKd4HA0ahFpuyaYi8FUe+Ez0CG2c7wKz2sI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39830400003)(366004)(136003)(44832011)(8936002)(956004)(5660300002)(107886003)(6666004)(4326008)(2616005)(6486002)(2906002)(316002)(66946007)(6506007)(6512007)(8676002)(31696002)(66476007)(478600001)(26005)(186003)(53546011)(16526019)(36756003)(86362001)(83380400001)(52116002)(31686004)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: S2rcrHK+rFnS17GYjbqim/hGNDJXLlQr1RfOkXaF2xU2iz9xWGw7lZRd6YCAGwdX7okGMmppgFLW6I6tAMBg48hurR+Eyt/IlphMbe1n5c0QszFMyWsnnQY9E6eGsEi7l0XZspt5oQWo2DrvaEA67NlczdvidOVK/rM82H4wkVQsQP8jMN66p+xRH1mnULqmoeAgwVYXntVJb2cMuFwckF5x6DYe2S6zHQFGoIsLCQzwoRfebEIL6RD+GovqfKzP4RyCv7Wc94BZp1Fk+anOLbRqD4tHauoujRw8F2GdGlL5u0a2Ehnqbrjx3CCBr+TsDeOn2fOazo6L0RVS1HWGFFv4FQwwJDzFVMLevOtFroqQW5t0LUcXtyLYrX2g2czrWxO2+z8ndhbllGRF+itrW8nBV88aodNYA1O//Wr8zBOyTd/IL4Ij6Iu/5RIET+/+G6Mbo+o07hmRaMG8INLQjxpcVTRQkNEM0d7UfvCHJuNlbNo4al98vtbddjniJH++nextW01IU2ehqMi581I2rwqw6xx9bHC3yd7CrYU/0d4FPmLoKhEFTK/518AhptOt0aBvK79Ln5EmXb3o2oHsXW5/nzIPeHl8nMFzZBw58IeGuiZFKfCvle7e1vxQ5Ha+lHXOPXYyq6Oryh37cSbObw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ded7ed-211a-4bf1-48ef-08d87a9747de
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 16:42:23.8714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6KYaPNUlJEiqCO7m1z3eroOPhqWSg9OjZH73NbAnOQ9XqugkronAZ19a4kZwBkLqHpQ5HiXCCwmQzeP2CQLzAKq2AGm8jhzVqJbBc8YAWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2412
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:42:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_LOW=-0.7,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27.10.2020 19:21, Vladimir Sementsov-Ogievskiy wrote:
> 27.10.2020 19:01, Andrey Shinkevich wrote:
>> On 27.10.2020 18:09, Vladimir Sementsov-Ogievskiy wrote:
>>> 22.10.2020 21:13, Andrey Shinkevich wrote:
>>>> Avoid writing a filter JSON file name and a filter format name to QCOW2
>>>> image when the backing file is changed after the block stream job.
>>>> A user is still able to assign the 'backing-file' parameter for a
>>>> block-stream job keeping in mind the possible issue mentioned above.
>>>> If the user does not specify the 'backing-file' parameter, QEMU will
>>>> assign it automatically.
>>>>
>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>>> ---
>>>>   block/stream.c | 15 +++++++++++++--
>>>>   blockdev.c     |  9 ++-------
>>>>   2 files changed, 15 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/block/stream.c b/block/stream.c
>>>> index e0540ee..1ba74ab 100644
>>>> --- a/block/stream.c
>>>> +++ b/block/stream.c
>>>> @@ -65,6 +65,7 @@ static int stream_prepare(Job *job)
>>>>       BlockDriverState *bs = blk_bs(bjob->blk);
>>>>       BlockDriverState *unfiltered_bs = bdrv_skip_filters(bs);
>>>>       BlockDriverState *base = bdrv_filter_or_cow_bs(s->above_base);
>>>> +    BlockDriverState *base_unfiltered = NULL;
>>>>       Error *local_err = NULL;
>>>>       int ret = 0;
>>>> @@ -75,8 +76,18 @@ static int stream_prepare(Job *job)
>>>>           const char *base_id = NULL, *base_fmt = NULL;
>>>>           if (base) {
>>>>               base_id = s->backing_file_str;
>>>> -            if (base->drv) {
>>>> -                base_fmt = base->drv->format_name;
>>>> +            if (base_id) {
>>>> +                if (base->drv) {
>>>> +                    base_fmt = base->drv->format_name;
>>>
>>> hmm. this doesn't make real sense: so, we assume that user specified 
>>> backing_file_str, which may not relate to base, but we use 
>>> base->drv->format_name? But it may be name of the filter driver, 
>>> which would be wrong..
>>>
>>> Any ideas?
>>>
>>> 1. we can use base_fmt=NULL, to provoke probing on next open of the 
>>> qcow2 file..
>>
>> I would choose this item #1 but have to check the probing code 
>> logic... Particularly, I do not remember now if the probing is able to 
>> recognize a protocol.
>> The logic for the format_name in the QEMU existent code (I has kept it 
>> here in the patch) is a slippery way for an imprudent user. That's why 
>> I staked on the backing_file_str deprication in the previous version.
>>
>>> 2. we can do probing now
>>> 3. we can at least check, if backing_file_str == 
>>
>> Not bad for the sanity check but we will search a node by the file 
>> name again - not good ((
> 
> Not search, but only check one very likely option.

Yes, just strcmp(). And why a user may not merely specify a desired 
backing file as the base?

> 
> Additionally to 1. or 3. (or combined), or even keeping things as is 
> (i.e. wrong, but it is preexisting), we can:
> 
>   - add backing-format argument to qapi as pair for backing-file
>   - deprecate using backing-file without backing-format.
> 
> Then, after deprecation period we'll have correct code. This may be done 
> in separate.
> 
>>
>>> base_unfiltered->filename, in this case we can use 
>>> base_unfiltered->drv->format_name
>>>
>>>
>>>> +                }
>>>> +            } else {
>>>> +                base_unfiltered = bdrv_skip_filters(base);
>>>> +                if (base_unfiltered) {
>>>> +                    base_id = base_unfiltered->filename;
>>>> +                    if (base_unfiltered->drv) {
>>>> +                        base_fmt = base_unfiltered->drv->format_name;
>>>> +                    }
>>>> +                }
>>>>               }
>>>>           }
>>>>           bdrv_set_backing_hd(unfiltered_bs, base, &local_err);
>>>> diff --git a/blockdev.c b/blockdev.c
>>>> index c917625..0e9c783 100644
>>>> --- a/blockdev.c
>>>> +++ b/blockdev.c
>>
>> [...]
>>
>>>> -    stream_start(has_job_id ? job_id : NULL, bs, base_bs, base_name,
>>>> +    stream_start(has_job_id ? job_id : NULL, bs, base_bs,
>>>> +                 has_backing_file ? backing_file : NULL,
>>>
>>> backing_file should be NULL if has_backing_file is false, so you can 
>>> use just backing_file instead of ternary operator.
>>>
>>
>> Yes, if reliable. I has kept the conformation with the ternary 
>> operator at the first parameter above.
>>
>> Andrey
>>
>>>>                    job_flags, has_speed ? speed : 0, on_error,
>>>>                    filter_node_name, &local_err);
>>>>       if (local_err) {
>>>>
>>>
>>>
> 
> 

