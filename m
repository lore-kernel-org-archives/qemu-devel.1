Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A428C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB60220708
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iEtP4NxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB60220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPQ0-00037m-Vg
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jrPOz-0001Cs-H2; Fri, 03 Jul 2020 13:23:06 -0400
Received: from mail-vi1eur05on2135.outbound.protection.outlook.com
 ([40.107.21.135]:44401 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jrPOw-000460-6L; Fri, 03 Jul 2020 13:23:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHBOq4IOcx4XuAAPDcQQ5OvqkYsG3KoLDdqWzWNqdlgneCFOC7qwTm4lThmuK/MhBs0fBRrXutesdWZ+mlTFLgwG54/lZA7mPASC6IfOEFIq6kdr3Bg/8vsejvin5Uxq+c6SmwAuU0lBPPAtmTfEfhuTamApSpq3tJ7aUaCqOYsCFm1mVxtCkt0wOPiJDvNDllBARtgJz9AEnw52FBqAMwdjFX7Xf6PL+8OdmI38DI8SNF8eRcMk8ioiRjm1V62/qesrQ0uSGMLkaHNNIfo/Ywkbrn3nfFfRR3oehSd85IkcLg8bErUpFaPsNABFKD3Z7bmvjlGWlz/vch7D/8p04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5BMcQCuT7jTC3Oar2lUEIm1A4LwdT/lMEONlbIgq3Y=;
 b=VavdMNT7XT0tvI1ag2BxCigqTR4TSpZDwcdBcB6Fa5gEe3gC+VwDvYMRJXmX1H1j3M+KmHdNnx4SRwnOjh8cHF5O6oY7I+yK4dW9gCGRWX7YcAUknebJAo34SkK3ny+KVThKDnfkJjiqHc88gS62lrcw6eN6iXoxctspwqrp1+o1X1yjImEfZIkJyF0n7GV/cOaVMvWgZ2zIprUZIv/6fOwRpz1VFNx3SaiAGf76+0I1qdOiTaybsyveIIB3H4BLjAy3eqdWOwJCVoWOiJi42NXOASk0wljVis/R1AJdJQI73ZTyk/OCHXMqYg1gQqC1xZowxMFRlM1UsEg8EfiYPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5BMcQCuT7jTC3Oar2lUEIm1A4LwdT/lMEONlbIgq3Y=;
 b=iEtP4NxQN6izhIrIvXQR3cDTHabiNNc1BtKJiEJbj+WQincV7MZTe99p2xyfy/hkzikY0lqC2XIk7Uv3NUHTa1H7L1EtRcXeBMKpGr+ptVQQVP28ROHpYbSne+wgyWy0fF+FC1nQkvjCAEbryWNvzqg0L/7I7y0SvGA3FsXqt4E=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3288.eurprd08.prod.outlook.com (2603:10a6:209:47::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Fri, 3 Jul
 2020 17:22:58 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 17:22:58 +0000
Subject: Re: [PATCH 2/6] migration: introduce savevm, loadvm, delvm QMP
 commands
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-3-berrange@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <491152d2-82a2-2319-e24f-ebbc473f9090@virtuozzo.com>
Date: Fri, 3 Jul 2020 20:22:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200702175754.2211821-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0348.eurprd05.prod.outlook.com
 (2603:10a6:7:92::43) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR05CA0348.eurprd05.prod.outlook.com (2603:10a6:7:92::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23 via Frontend Transport; Fri, 3 Jul 2020 17:22:57 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bade75e-b2bb-46ee-e589-08d81f75baca
X-MS-TrafficTypeDiagnostic: AM6PR08MB3288:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3288CA9E427F42E5BD50A8B2B66A0@AM6PR08MB3288.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBla745X4CSHlKoOM/XlcbboVmn4oTNW0q+uL1qCDRhXi5hRaU1Ht8CSmKkAz6XLBhlDKQRM4qN/u+uGC50Dl4GCxrS44IHkeOm3e2htwOxP1BBL2Ud8njK6L9FlucI7huKr44vD+DDN0KHNNq8maC5Qx7uSYre6nzN/dTgkoUmT53YF3F6/O+Obu8wrU+K5Yyub0Eh3wdffN/QzB4ARfEBRTjutvLI+2fXelHs4v0KG8vVWL6lqExr+P+X8VCUKoxeciP+P+GOyzx/vxe0n0byZYbpbDP3jPQV59leEx245R4YcbH/Y8S+vFLKeMHqnca/ul9gc8uX2Q2HqJFyWO8zZPvTI99PGFNq22CmRseL0xwX5rg24jwJoKgDSmbNX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(136003)(396003)(366004)(376002)(346002)(66946007)(5660300002)(8676002)(16526019)(186003)(52116002)(31686004)(16576012)(6486002)(26005)(36756003)(53546011)(4326008)(66476007)(66556008)(316002)(54906003)(86362001)(956004)(31696002)(2616005)(8936002)(83380400001)(2906002)(478600001)(7416002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aZ827VS3MwJWccmYFyBgHDbCRVd/urmGI18pqibB+tqKzFz+RS0v6BzO7EwqWjUlTLH3lcJB0wIqtgZfTWVsUSae8/5wXQRoq6iHlEnhoCi1eLSQr6G60BgZWC6+RLWz7OmRujtM/DroDgPsDg+nN1Vq2hEY1nJ14WvtpRU1ZpHPcJVljNtS4CbgFCS42YExniQmhd9VqNpGdWo8WIlMpUMqJhsOjOagVcolFgeW1WKXGYewBW+NpFpcCwHxLxj1Gz8vbCQDa6VaXnm/uOJ2t9sghQEUos1WA7w1Wi2YQeh1GqCWrL+9qsMfRapfF9rTAtBbUR7W+QJ2sfzIz2snKpnW1a0ishf/2LuNNe+qkzromGpI0BvNSYYmBT33I7i8zAWSEB/ogbrVOL2Cjpg51VFyJQOpI7As+r4DoE8N7XQPBkjKexn1G2MeS3FzZyKeD/dRs6TIyAotZ04kcABL8hJp0x1/hCNljVHamboQ9v2c0So1OyT6op38eO4xmHtf
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bade75e-b2bb-46ee-e589-08d81f75baca
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 17:22:58.0617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1LLGO6kxIeUZIDewXjK/alPq3Ylx3/m+EB1QpU0KbLSwXzJxJR5C7tQu/t81q2rmAruQezfoVfspWjzK6Nsvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3288
Received-SPF: pass client-ip=40.107.21.135; envelope-from=den@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 13:22:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 8:57 PM, Daniel P. Berrangé wrote:
> savevm, loadvm and delvm are some of the few commands that have never
> been converted to use QMP. The primary reason for this lack of
> conversion is that they block execution of the thread for as long as
> they run.
>
> Despite this downside, however, libvirt and applications using libvirt
> has used these commands for as long as QMP has existed, via the
> "human-monitor-command" passthrough command. IOW, while it is clearly
> desirable to be able to fix the blocking problem, this is not an
> immediate obstacle to real world usage.
>
> Meanwhile there is a need for other features which involve adding new
> parameters to the commands. This is possible with HMP passthrough, but
> it provides no reliable way for apps to introspect features, so using
> QAPI modelling is highly desirable.
>
> This patch thus introduces trival savevm, loadvm, delvm commands
> to QMP that are functionally identical to the HMP counterpart, including
> the blocking problem.
>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  migration/savevm.c  | 27 ++++++++++++++++
>  monitor/hmp-cmds.c  | 18 ++---------
>  qapi/migration.json | 76 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 106 insertions(+), 15 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 72dbad95ed..53586a6406 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2943,3 +2943,30 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
>  
>      return !(vmsd && vmsd->unmigratable);
>  }
> +
> +void qmp_savevm(const char *tag, Error **errp)
> +{
> +    save_snapshot(tag, errp);
> +}
> +
> +void qmp_loadvm(const char *tag, Error **errp)
> +{
> +    int saved_vm_running  = runstate_is_running();
> +
> +    vm_stop(RUN_STATE_RESTORE_VM);
> +
> +    if (load_snapshot(tag, errp) == 0 && saved_vm_running) {
> +        vm_start();
> +    }
> +}
> +
> +void qmp_delvm(const char *tag, Error **errp)
> +{
> +    BlockDriverState *bs;
> +
> +    if (bdrv_all_delete_snapshot(tag, &bs, errp) < 0) {
> +        error_prepend(errp,
> +                      "deleting snapshot on device '%s': ",
> +                      bdrv_get_device_or_node_name(bs));
> +    }
> +}
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 2b0b58a336..26a5a1a701 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -1089,15 +1089,9 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
>  
>  void hmp_loadvm(Monitor *mon, const QDict *qdict)
>  {
> -    int saved_vm_running  = runstate_is_running();
> -    const char *name = qdict_get_str(qdict, "name");
>      Error *err = NULL;
>  
> -    vm_stop(RUN_STATE_RESTORE_VM);
> -
> -    if (load_snapshot(name, &err) == 0 && saved_vm_running) {
> -        vm_start();
> -    }
> +    qmp_loadvm(qdict_get_str(qdict, "name"), &err);
>      hmp_handle_error(mon, err);
>  }
>  
> @@ -1105,21 +1099,15 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
>  
> -    save_snapshot(qdict_get_try_str(qdict, "name"), &err);
> +    qmp_savevm(qdict_get_try_str(qdict, "name"), &err);
>      hmp_handle_error(mon, err);
>  }
>  
>  void hmp_delvm(Monitor *mon, const QDict *qdict)
>  {
> -    BlockDriverState *bs;
>      Error *err = NULL;
> -    const char *name = qdict_get_str(qdict, "name");
>  
> -    if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
> -        error_prepend(&err,
> -                      "deleting snapshot on device '%s': ",
> -                      bdrv_get_device_name(bs));
> -    }
> +    qmp_delvm(qdict_get_str(qdict, "name"), &err);
>      hmp_handle_error(mon, err);
>  }
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index d5000558c6..849de38fb0 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1621,3 +1621,79 @@
>  ##
>  { 'event': 'UNPLUG_PRIMARY',
>    'data': { 'device-id': 'str' } }
> +
> +##
> +# @savevm:
> +#
> +# Save a VM snapshot
> +#
> +# @tag: name of the snapshot to create. If it already
> +# exists it will be replaced.
> +#
> +# Note that execution of the VM will be paused during the time
> +# it takes to save the snapshot
> +#
> +# Returns: nothing
> +#
> +# Example:
> +#
> +# -> { "execute": "savevm",
> +#      "data": {
> +#         "tag": "my-snap"
> +#      }
> +#    }
> +# <- { "return": { } }
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'savevm',
> +  'data': { 'tag': 'str' } }
> +
> +##
> +# @loadvm:
> +#
> +# Load a VM snapshot
> +#
> +# @tag: name of the snapshot to load.
> +#
> +# Returns: nothing
> +#
> +# Example:
> +#
> +# -> { "execute": "loadvm",
> +#      "data": {
> +#         "tag": "my-snap"
> +#      }
> +#    }
> +# <- { "return": { } }
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'loadvm',
> +  'data': { 'tag': 'str' } }
> +
> +##
> +# @delvm:
> +#
> +# Delete a VM snapshot
> +#
> +# @tag: name of the snapshot to delete.
> +#
> +# Note that execution of the VM will be paused during the time
> +# it takes to delete the snapshot
> +#
> +# Returns: nothing
> +#
> +# Example:
> +#
> +# -> { "execute": "delvm",
> +#      "data": {
> +#         "tag": "my-snap"
> +#      }
> +#    }
> +# <- { "return": { } }
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'delvm',
> +  'data': { 'tag': 'str' } }
The interface proposed is not good from the interface point of view.
The problem is that savevm and loadvm are VERY lengthy operations
especially for VM with big amount of RAM. Thus they can run
for hours f.e. with 1 Tb RAM.

This "feature" was available in the old legacy HMP interface, but
this should be fixed in the new and clear one.

Den

