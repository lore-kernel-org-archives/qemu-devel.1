Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9436C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676C4205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZMLxLIqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676C4205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33237 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEChd-0001BK-K3
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 09:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jECgh-0000Bm-PR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jECgd-0002ZP-7Y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:55:19 -0400
Received: from mail-ve1eur01on0719.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::719]:3227
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jECgR-00010H-Qk; Tue, 17 Mar 2020 09:55:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8Fyy5gcNmuyoygdEFLzmSSEw4Pa1Qtg2lGXmlDDhxkcILapgb9tQ/apW3KQ+6rhSjQfbJUtt90VtoZvS5J9/yUHYueeSxD+p6kQibiFXw6eYwhBMQ8dz9WgBbHsyCwl0ZxbRrsrd3MvVxtfiZ733s5H+n7UlJWCkxzUrBu4HsF79wUu/wAundKQe4DDd5diCtPtL+/TPDA3Pk3S8p3DPGpE06HP+plNqu2kgpI+Qsr9s+DH3hZttFXNZkTzS4MYH4ocsMEcfLKf0tZka6QwAxtOgZ5R0eNqY2gjCLVohVgQWIIfoJVY3fl/OWzAh86X7VFfo0aQyCPipQyMWLC6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rexgYEJO0c1zjHpp4auDkugkyaxNmnEnevBB/m5rzo8=;
 b=CgUVbeInJAZcRPtGYughoIXP/HlzJAYTJwgEx7FNfrv1BaxeoFg8WRGsXxxAtQ1Rw2tShy+JspnsmD75Wnzkf+w+wUax0sbZ3tB4gNe0FMCk+0Y4vSQG7lo6NosT83Hp57F+3p14bMAUtdnor5Z7K6P6Kz2i2G+ZBY93EgRTL0D8Nl37Vj6aBp5tmcroaXF+8OP1wdFQ7IJ5sz3wQeLxb+5Cx3iwwF3fPDsuZhw6qu1ZOV5TtZB6XzAKIGSWlbv85CWwf9hYu2zK5ssRslUmNGmpeqJrgCJn2A4qYoWgIAaxFFmzuE2zycAQG+aVEkGteqXoATXCU/XRz0ujNH5BuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rexgYEJO0c1zjHpp4auDkugkyaxNmnEnevBB/m5rzo8=;
 b=ZMLxLIqQsqslNMOXmilAkp6R86p+Np7x44H1JNmQuRncGBTdqgoXyIwA93/QZ94p+eLE6Py3eWKZw4S+7hYGlM+RAw/Mo1tBs3v6vUpI/MQq2gRAkdVg0mL1Q7kf1E4Q80KGTWvf7gcghzvZGunJfjd82Xuh+cQWrQ2WJJ83SgQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2217.eurprd08.prod.outlook.com (10.172.127.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 13:54:55 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 13:54:55 +0000
Subject: Re: [PATCH v9 02/10] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
To: Markus Armbruster <armbru@redhat.com>
References: <20200312085936.9552-1-vsementsov@virtuozzo.com>
 <20200312085936.9552-3-vsementsov@virtuozzo.com>
 <874kuto7hq.fsf@dusky.pond.sub.org>
 <4a70c6ee-10a2-fdc3-f8df-88c05340398b@virtuozzo.com>
 <875zf8gt2m.fsf@dusky.pond.sub.org>
 <7c6f9a91-76cf-242d-8166-0693ec14b24d@virtuozzo.com>
 <87blozex9v.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200317165452029
Message-ID: <3e1e5815-eb5f-7862-e6eb-596991e2842b@virtuozzo.com>
Date: Tue, 17 Mar 2020 16:54:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87blozex9v.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR08CA0062.eurprd08.prod.outlook.com
 (2603:10a6:205:2::33) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.248) by
 AM4PR08CA0062.eurprd08.prod.outlook.com (2603:10a6:205:2::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 13:54:53 +0000
X-Tagtoolbar-Keys: D20200317165452029
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03ac0a4c-4f69-4973-5599-08d7ca7ac596
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2217:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB22176545704CCC5EF8A9FE58C1F60@HE1PR0802MB2217.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(199004)(66946007)(66574012)(66556008)(66476007)(5660300002)(2906002)(7416002)(31686004)(6916009)(30864003)(4326008)(36756003)(52116002)(16576012)(8676002)(81166006)(81156014)(54906003)(316002)(53546011)(956004)(26005)(186003)(16526019)(86362001)(8936002)(478600001)(31696002)(2616005)(6486002)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2217;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QZHk7V/ZNECAh05gLLzJWkAnM+nwxregjGmnbES6JDxLDkPJf8ereypkHbDCLB94ft0z4KE6QsJoTJqe1uMmLwsMvpQS/319i68OWzrxvKRw/xs2fW58Jg1Xl2+gITr5tw/y20lbHJ6A17lOUv0Vcnoaj4POm4ne9sliJJ91dkqjg2US6M76MuhD2rVuroH0O+DshByOAnMcPbWYU2jtCRIQzL5hFeZ64ycdc0Kv7HcVi/+N3fTrDvfs870PqD82Psr6IgP+Xd3cH/ZiBAvveAvVHi9RrWWyEPaPzEQpjDEwcAzwhXNp4s+TEZWLfcgxChvnbJvM0OUlqaNKuaBi1T8XsRz11f8LmRmeMZo+SAhHtQXiwUIr3NzjnSWRWdj7UVLRUquRhqJOP7NGExfBElD7UAZE2eRP8tTxevuyjm9VlT8dnsy9ARKEXjW9WM4C/aWX4oDAzpKSEginmp7XNcJizX4cAq19aPtiDLIkhpntOgEoEj9ttPkBgZoWbaelUanWwTQt6k+f4k+6oIkdslV9ijBRqw7lJMcgicdloPcXWerCAR4wpAANEpUGkFfe
X-MS-Exchange-AntiSpam-MessageData: hKedSfOpDdML+Vv3AYnV7jfBFXpnkUlR5ttwc604umG0mu5UJ1yq6ih1d45EAOXnbsf5T0FsyjX8rhbIzASjrtnIVAYwEP7j0lmjnaO0U26qFjGKado0qzKVo0+XhJn+ySFW0H6Z2RQffymcliI/BA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ac0a4c-4f69-4973-5599-08d7ca7ac596
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 13:54:55.2366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxwHCW4+xtcWmg9B4s5LnerY1Xfq3QgDWdpWR1jypoNMgb9BQE/yrDy2f/vXy+RQv+0chi1QVhzRkOSDW/xksF8ATvNSygFg/b3QfdQIxow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2217
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:111:f400:fe1f::719
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.03.2020 0:54, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> 13.03.2020 18:42, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> 12.03.2020 19:36, Markus Armbruster wrote:
>>>>> I may have a second look tomorrow with fresher eyes, but let's get th=
is
>>>>> out now as is.
>>>>>
>>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>>
>>>>>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate a=
nd
>>>>>> does corresponding changes in code (look for details in
>>>>>> include/qapi/error.h)
>>>>>>
>>>>>> Usage example:
>>>>>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>>>     --macro-file scripts/cocci-macro-file.h --in-place --no-show-dif=
f \
>>>>>>     --max-width 80 FILES...
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>>>> ---
>>>>>>
>>>>>> Cc: Eric Blake <eblake@redhat.com>
>>>>>> Cc: Kevin Wolf <kwolf@redhat.com>
>>>>>> Cc: Max Reitz <mreitz@redhat.com>
>>>>>> Cc: Greg Kurz <groug@kaod.org>
>>>>>> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>>>>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>>>>>> Cc: Anthony Perard <anthony.perard@citrix.com>
>>>>>> Cc: Paul Durrant <paul@xen.org>
>>>>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>>>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>>>>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>>>>>> Cc: Markus Armbruster <armbru@redhat.com>
>>>>>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>>>> Cc: qemu-devel@nongnu.org
>>>>>> Cc: qemu-block@nongnu.org
>>>>>> Cc: xen-devel@lists.xenproject.org
>>>>>>
>>>>>>     scripts/coccinelle/auto-propagated-errp.cocci | 327 ++++++++++++=
++++++
>>>>>>     include/qapi/error.h                          |   3 +
>>>>>>     MAINTAINERS                                   |   1 +
>>>>>>     3 files changed, 331 insertions(+)
>>>>>>     create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>>>>>
>>>>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts=
/coccinelle/auto-propagated-errp.cocci
>>>>>> new file mode 100644
>>>>>> index 0000000000..7dac2dcfa4
>>>>>> --- /dev/null
>>>>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>>>>> @@ -0,0 +1,327 @@
>>>>>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>>>>> +//
>>>>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>>>>> +//
>>>>>> +// This program is free software; you can redistribute it and/or
>>>>>> +// modify it under the terms of the GNU General Public License as
>>>>>> +// published by the Free Software Foundation; either version 2 of t=
he
>>>>>> +// License, or (at your option) any later version.
>>>>>> +//
>>>>>> +// This program is distributed in the hope that it will be useful,
>>>>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>> +// GNU General Public License for more details.
>>>>>> +//
>>>>>> +// You should have received a copy of the GNU General Public Licens=
e
>>>>>> +// along with this program.  If not, see
>>>>>> +// <http://www.gnu.org/licenses/>.
>>>>>> +//
>>>>>> +// Usage example:
>>>>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>>> +//  --macro-file scripts/cocci-macro-file.h --in-place \
>>>>>> +//  --no-show-diff --max-width 80 FILES...
>>>>>> +//
>>>>>> +// Note: --max-width 80 is needed because coccinelle default is les=
s
>>>>>> +// than 80, and without this parameter coccinelle may reindent some
>>>>>> +// lines which fit into 80 characters but not to coccinelle default=
,
>>>>>> +// which in turn produces extra patch hunks for no reason.
>>>>>
>>>>> This is about unwanted reformatting of parameter lists due to the ___
>>>>> chaining hack.  --max-width 80 makes that less likely, but not
>>>>> impossible.
>>>>>
>>>>> We can search for unwanted reformatting of parameter lists.  I think
>>>>> grepping diffs for '^\+.*Error \*\*' should do the trick.  For the wh=
ole
>>>>> tree, I get one false positive (not a parameter list), and one hit:
>>>>>
>>>>>        @@ -388,8 +388,10 @@ static void object_post_init_with_type(O
>>>>>             }
>>>>>         }
>>>>>
>>>>>        -void object_apply_global_props(Object *obj, const GPtrArray *=
props, Error **errp)
>>>>>        +void object_apply_global_props(Object *obj, const GPtrArray *=
props,
>>>>>        +                               Error **errp)
>>>>>         {
>>>>>        +    ERRP_AUTO_PROPAGATE();
>>>>>             int i;
>>>>>
>>>>>             if (!props) {
>>>>>
>>>>> Reformatting, but not unwanted.
>>>>
>>>> Yes, I saw it. This line is 81 character length, so it's OK to fix it =
in one hunk with
>>>> ERRP_AUTO_PROPAGATE addition even for non-automatic patch.
>>>
>>> Agree.
>>>
>>>>>
>>>>> The --max-width 80 hack is good enough for me.
>>>>>
>>>>> It does result in slightly long transformed lines, e.g. this one in
>>>>> replication.c:
>>>>>
>>>>>        @@ -113,7 +113,7 @@ static int replication_open(BlockDriverS
>>>>>                 s->mode =3D REPLICATION_MODE_PRIMARY;
>>>>>                 top_id =3D qemu_opt_get(opts, REPLICATION_TOP_ID);
>>>>>                 if (top_id) {
>>>>>        -            error_setg(&local_err, "The primary side does not=
 support option top-id");
>>>>>        +            error_setg(errp, "The primary side does not suppo=
rt option top-id");
>>>>>                     goto fail;
>>>>>                 }
>>>>>             } else if (!strcmp(mode, "secondary")) {
>>>>>
>>>>> v8 did break this line (that's how I found it).  However, v9 still
>>>>> shortens the line, just not below the target.  All your + lines look
>>>>> quite unlikely to lengthen lines.  Let's not worry about this.
>>>>>
>>>>>> +// Switch unusual Error ** parameter names to errp
>>>>>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>>>>>> +//
>>>>>> +// Disable optional_qualifier to skip functions with
>>>>>> +// "Error *const *errp" parameter.
>>>>>> +//
>>>>>> +// Skip functions with "assert(_errp && *_errp)" statement, because
>>>>>> +// that signals unusual semantics, and the parameter name may well
>>>>>> +// serve a purpose. (like nbd_iter_channel_error()).
>>>>>> +//
>>>>>> +// Skip util/error.c to not touch, for example, error_propagate() a=
nd
>>>>>> +// error_propagate_prepend().
>>>>>> +@ depends on !(file in "util/error.c") disable optional_qualifier@
>>>>>> +identifier fn;
>>>>>> +identifier _errp !=3D errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(...,
>>>>>> +-   Error **_errp
>>>>>> ++   Error **errp
>>>>>> +    ,...)
>>>>>> + {
>>>>>> +(
>>>>>> +     ... when !=3D assert(_errp && *_errp)
>>>>>> +&
>>>>>> +     <...
>>>>>> +-    _errp
>>>>>> ++    errp
>>>>>> +     ...>
>>>>>> +)
>>>>>> + }
>>>>>> +
>>>>>> +// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
>>>>>> +// necessary
>>>>>> +//
>>>>>> +// Note, that without "when any" the final "..." does not mach
>>>>>> +// something matched by previous pattern, i.e. the rule will not ma=
tch
>>>>>> +// double error_prepend in control flow like in
>>>>>> +// vfio_set_irq_signaling().
>>>>>> +//
>>>>>> +// Note, "exists" says that we want apply rule even if it matches n=
ot
>>>>>> +// on all possible control flows (otherwise, it will not match
>>>>>> +// standard pattern when error_propagate() call is in if branch).
>>>>>> +@ disable optional_qualifier exists@
>>>>>> +identifier fn, local_err;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error **errp, ...)
>>>>>> + {
>>>>>> ++   ERRP_AUTO_PROPAGATE();
>>>>>> +    ...  when !=3D ERRP_AUTO_PROPAGATE();
>>>>>> +(
>>>>>> +(
>>>>>> +    error_append_hint(errp, ...);
>>>>>> +|
>>>>>> +    error_prepend(errp, ...);
>>>>>> +|
>>>>>> +    error_vprepend(errp, ...);
>>>>>> +)
>>>>>> +    ... when any
>>>>>> +|
>>>>>> +    Error *local_err =3D NULL;
>>>>>> +    ...
>>>>>> +(
>>>>>> +    error_propagate_prepend(errp, local_err, ...);
>>>>>> +|
>>>>>> +    error_propagate(errp, local_err);
>>>>>> +)
>>>>>> +    ...
>>>>>> +)
>>>>>> + }
>>>>>> +
>>>>>> +
>>>>>> +// Match functions with propagation of local error to errp.
>>>>>> +// We want to refer these functions in several following rules, but=
 I
>>>>>> +// don't know a proper way to inherit a function, not just its name
>>>>>> +// (to not match another functions with same name in following rule=
s).
>>>>>> +// Not-proper way is as follows: rename errp parameter in functions
>>>>>> +// header and match it in following rules. Rename it back after all
>>>>>> +// transformations.
>>>>>> +//
>>>>>> +// The simplest case of propagation scheme is single definition of
>>>>>> +// local_err with at most one error_propagate_prepend or
>>>>>> +// error_propagate on each control-flow. Still, we want to match mo=
re
>>>>>> +// complex schemes too. We'll warn them with help of further rules.
>>>>>
>>>>> I think what we actually want is to examine instances of this pattern=
 to
>>>>> figure out whether and how we want to transform them.  Perhaps:
>>>>>
>>>>>        // The common case is a single definition of local_err with at=
 most one
>>>>>        // error_propagate_prepend() or error_propagate() on each cont=
rol-flow
>>>>>        // path. Instances of this case we convert with this script. F=
unctions
>>>>
>>>> For me, sounds a bit like "other things we don't convert".
>>>> Actually we convert other things too.
>>>
>>> What other patterns of error propagation do we convert?
>>
>> Something like in xen_block_device_destroy, why not? Otherwise, it's bet=
ter to avoid
>> matching things like xen_block_device_destroy, not just warn them.
>> But I'd prefer to proceed now as is to fit into 5.0.. Too much time alre=
ady
>> spent on this. So, I'm OK with your wording too.
>=20
> Let's scratch "Instances of this case we convert with this script."
>=20
>>>>>        // with multiple definitions or propagates we want to examine
>>>>>        // manually. Later rules emit warnings to guide us to them.
>>>>>
>>>>>> +@rule1 disable optional_qualifier exists@
>>>>>> +identifier fn, local_err;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error **
>>>>>> +-    errp
>>>>>> ++    ____
>>>>>> +    , ...)
>>>>>> + {
>>>>>> +     ...
>>>>>> +     Error *local_err =3D NULL;
>>>>>> +     ...
>>>>>> +(
>>>>>> +     error_propagate_prepend(errp, local_err, ...);
>>>>>> +|
>>>>>> +     error_propagate(errp, local_err);
>>>>>> +)
>>>>>> +     ...
>>>>>> + }
>>>>>> +
>>>>>> +
>>>>>> +// Warn several Error * definitions.
>>>>>> +@check1 disable optional_qualifier exists@
>>>>>> +identifier fn =3D rule1.fn, local_err, local_err2;
>>>>>
>>>>> Elsewhere, you use just rule.fn instead of fn =3D rule1.fn.  Any
>>>>> particular reason for the difference?
>>>>
>>>> I didn't find other way to ref check1.fn in next python rule. It just =
don't
>>>> work if I write here just rule1.fn.
>>>>
>>>>>
>>>>> With the ___ chaining hack, I doubt we still need "=3D rule1.fn" or
>>>>> "rule1.fn".  If I replace "fn =3D rule1.fn" and "rule.fn" by just "fn=
"
>>>>> everywhere, then apply the script to the complete tree, I get the sam=
e
>>>>> result.
>>>>
>>>> I think, it's more efficient to reuse names from previous rules. I thi=
nk it should
>>>> work faster (more information, less extra matching).
>>>
>>> Nope.  With my hacked up script (patch appended) Coccinelle is actually
>>> *faster* for the .[ch] touched by this series: with your unmodified
>>> script, it takes a bit over 12s on my box, with mine around 7s.  Output
>>> is identical.
>>>
>>> Never guess performance, always measure it :)
>>
>> Hmm, whole tree results would be better proof
>>
>>>
>>> Two notes on my script:
>>>
>>> * Unlike yours, it recognizes double-propagation in my test case.
>>>     Discussed below.
>>>
>>> * Its "several definitions of" warning includes positions.  That turned
>>>     out to be useless, but I've been too lazy to take that out again.
>>>
>>>>>
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     ...
>>>>>> +     Error *local_err =3D NULL;
>>>>>> +     ... when any
>>>>>> +     Error *local_err2 =3D NULL;
>>>>>> +     ... when any
>>>>>> + }
>=20
> This flags functions that have more than one declaration along any
> control flow path.  It doesn't flag this one:
>=20
>      void gnat(bool b, Error **errp)
>      {
>          if (b) {
>              Error *local_err =3D NULL;
>              foo(arg, &local_err);
>              error_propagate(errp, local_err);
>          } else {
>              Error *local_err =3D NULL;
>              bar(arg, &local_err);
>              error_propagate(errp, local_err);
>          }
>      }
>=20
> The Coccinelle script does the right thing for this one regardless.
>=20
> I'd prefer to have such functions flagged, too.  But spending time on
> convincing Coccinelle to do it for me is not worthwhile; I can simply
> search the diff produced by Coccinelle for deletions of declarations
> that are not indented exactly four spaces.
>=20
> But if we keep this rule, we should adjust its comment
>=20
>      // Warn several Error * definitions.
>=20
> because it sure suggests it also catches functions like the one I gave
> above.
>=20
>>>>>> +
>>>>>> +@ script:python @
>>>>>> +fn << check1.fn;
>>>>>> +@@
>>>>>> +
>>>>>> +print('Warning: function {} has several definitions of '
>>>>>> +      'Error * local variable'.format(fn))
>>>>>> +
>>>>>> +// Warn several propagations in control flow.
>>>>>> +@check2 disable optional_qualifier exists@
>>>>>> +identifier fn =3D rule1.fn;
>>>>>> +symbol errp;
>>>>>> +position p1, p2;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     ...
>>>>>> +(
>>>>>> +     error_propagate_prepend(errp, ...);@p1
>>>>>> +|
>>>>>> +     error_propagate(errp, ...);@p1
>>>>>> +)
>>>>>> +     ...
>>>>>> +(
>>>>>> +     error_propagate_prepend(errp, ...);@p2
>>>>>> +|
>>>>>> +     error_propagate(errp, ...);@p2
>>>>>> +)
>>>>>> +     ... when any
>>>>>> + }
>>>>>> +
>>>>>
>>>>> Hmm, we don't catch the example I used in review of v8:
>>>>>
>>>>>        extern foo(int, Error **);
>>>>>        extern bar(int, Error **);
>>>>>
>>>>>        void frob(Error **errp)
>>>>>        {
>>>>>            Error *local_err =3D NULL;
>>>>>            int arg;
>>>>>
>>>>>            foo(arg, errp);
>>>>>            bar(arg, &local_err);
>>>>>            error_propagate(errp, local_err);
>>>>>            bar(arg + 1, &local_err);
>>>>>            error_propagate(errp, local_err);
>>>>>        }
>>>>>
>>>>> I believe this is because rule1 does not match here.
>>>>
>>>> Yes, rule1 wants at least one code flow with non-doubled propagation.
>>>>
>>>>>
>>>>> If I change the rule as follows, it catches the example:
>>>>>
>>>>>        @@ -157,24 +157,23 @@ print('Warning: function {} has several =
definitions of '
>>>>>
>>>>>         // Warn several propagations in control flow.
>>>>>         @check2 disable optional_qualifier exists@
>>>>>        -identifier fn =3D rule1.fn;
>>>>>        -symbol errp;
>>>>>        +identifier fn, _errp;
>>>>>         position p1, p2;
>>>>>         @@
>>>>>
>>>>>        - fn(..., Error ** ____, ...)
>>>>>        + fn(..., Error **_errp, ...)
>>>>>          {
>>>>>              ...
>>>>>         (
>>>>>        -     error_propagate_prepend(errp, ...);@p1
>>>>>        +     error_propagate_prepend(_errp, ...);@p1
>>>>>         |
>>>>>        -     error_propagate(errp, ...);@p1
>>>>>        +     error_propagate(_errp, ...);@p1
>>>>>         )
>>>>>              ...
>>>>>         (
>>>>>        -     error_propagate_prepend(errp, ...);@p2
>>>>>        +     error_propagate_prepend(_errp, ...);@p2
>>>>>         |
>>>>>        -     error_propagate(errp, ...);@p2
>>>>>        +     error_propagate(_errp, ...);@p2
>>>>>         )
>>>>>              ... when any
>>>>>          }
>>>>>
>>>>> To my mild surprise, it still doesn't find anything in our tree.
>>>>>
>>>>> Should we decouple the previous rule from rule1, too?  I tested the
>>>>> following on the whole tree:
>>>>
>>>> I don't think so. Why to check what we are not going to convert? If we=
 want
>>>> to check side things, it's better to do it in other coccinelle script.=
.
>>>
>>> Misunderstanding?  The rules are still chained together via the ___
>>> hack, just not via function name, because that's unreliable and
>>> redundant.
>>
>> Strange.. Then, how can it match something not matched by rule1?
>=20
> I think I got confused when I wrote the "Misunderstanding?" paragraph.
>=20
> Let me try again.
>=20
> First rule check2.
>=20
> The common case is a at most one propagation to @errp along any control
> flow path.  We trust your Coccinelle script to convert that alright.
>=20
> Any other propagation to @errp I want to review.  Whether the script
> attempts a conversion or not is unimportant, as long as it points me to
> the function to review.
>=20
> Rule rule1 matches functions that propagate to @errp once along at least
> one control flow path.
>=20
> Unchained from rule rule1, rule check2 flags any function that
> propagates to @errp multiple times along any control flow path.
>=20
> Chained to rule1, it flags only functions that also have a path with
> single propagation.
>=20
> In other words, the unchained rule flags *all* multi-propagations to
> @errp, while the chained rule flags only the ones the script attempts to
> convert.  The former is much more useful to me.
>=20
> Now rule check1.  It flags functions with multiple declarations along
> any control flow path.  Again, chaining it to rule1 restricts it to the
> functions we attempt to convert.  Makes it less useful to me.  However,
> because my desire to review multiple declarations in function we don't
> attempt to convert is lower than my desire to review multiple
> propagations to @errp in such functions, chaining check1 is tolerable
> for me.  But why chain check1 if we don't chain check2?
>=20
>>
>>>
>>>>>
>>>>>        @@ -136,10 +136,10 @@ symbol errp;
>>>>>
>>>>>         // Warn several Error * definitions.
>>>>>         @check1 disable optional_qualifier exists@
>>>>>        -identifier fn =3D rule1.fn, local_err, local_err2;
>>>>>        +identifier fn, _errp, local_err, local_err2;
>>>>>         @@
>>>>>
>>>>>        - fn(..., Error ** ____, ...)
>>>>>        + fn(..., Error **_errp, ...)
>>>>>          {
>>>>>              ...
>>>>>              Error *local_err =3D NULL;
>>>>>
>>>>> Warnings remain unchanged.
>>>>>
>>>>>> +@ script:python @
>>>>>> +fn << check2.fn;
>>>>>> +p1 << check2.p1;
>>>>>> +p2 << check2.p2;
>>>>>> +@@
>>>>>> +
>>>>>> +print('Warning: function {} propagates to errp several times in '
>>>>>> +      'one control flow: at {}:{} and then at {}:{}'.format(
>>>>>> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>>>>> +
>>>>>> +// Convert special case with goto separately.
>>>>>> +// I tried merging this into the following rule the obvious way, bu=
t
>>>>>> +// it made Coccinelle hang on block.c
>>>>>> +//
>>>>>> +// Note interesting thing: if we don't do it here, and try to fixup
>>>>>> +// "out: }" things later after all transformations (the rule will b=
e
>>>>>> +// the same, just without error_propagate() call), coccinelle fails=
 to
>>>>>> +// match this "out: }".
>>>>>> +@ disable optional_qualifier@
>>>>>> +identifier rule1.fn, rule1.local_err, out;
>>>>>
>>>>> As explained above, I doubt the need for rule1.fn.  We do need
>>>>> rule1.local_err to avoid unwanted transformations.  More of the same
>>>>> below.
>>>>
>>>> Logically, I want to inherit from rule1. So why not to stress it by in=
heriting
>>>> fn variable? It's just a correct thing to do.
>>>> And I hope it helps coccinelle to work more efficiently.
>>>>
>>>>>
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +-    goto out;
>>>>>> ++    return;
>>>>>> +     ...>
>>>>>> +- out:
>>>>>> +-    error_propagate(errp, local_err);
>>>>>> + }
>>>>>> +
>>>>>> +// Convert most of local_err related stuff.
>>>>>> +//
>>>>>> +// Note, that we update everything related to matched by rule1
>>>>>> +// function name and local_err name. We may match something not
>>>>>> +// related to the pattern matched by rule1. For example, local_err =
may
>>>>>> +// be defined with the same name in different blocks inside one
>>>>>> +// function, and in one block follow the propagation pattern and in
>>>>>> +// other block doesn't. Or we may have several functions with the s=
ame
>>>>>> +// name (for different configurations).
>>>>>> +//
>>>>>> +// Note also that errp-cleaning functions
>>>>>> +//   error_free_errp
>>>>>> +//   error_report_errp
>>>>>> +//   error_reportf_errp
>>>>>> +//   warn_report_errp
>>>>>> +//   warn_reportf_errp
>>>>>> +// are not yet implemented. They must call corresponding Error* -
>>>>>> +// freeing function and then set *errp to NULL, to avoid further
>>>>>> +// propagation to original errp (consider ERRP_AUTO_PROPAGATE in us=
e).
>>>>>> +// For example, error_free_errp may look like this:
>>>>>> +//
>>>>>> +//    void error_free_errp(Error **errp)
>>>>>> +//    {
>>>>>> +//        error_free(*errp);
>>>>>> +//        *errp =3D NULL;
>>>>>> +//    }
>>>>>> +@ disable optional_qualifier exists@
>>>>>> +identifier rule1.fn, rule1.local_err;
>>>>>> +expression list args;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +(
>>>>>> +-    Error *local_err =3D NULL;
>>>>>> +|
>>>>>> +
>>>>>> +// Convert error clearing functions
>>>>>> +(
>>>>>> +-    error_free(local_err);
>>>>>> ++    error_free_errp(errp);
>>>>>> +|
>>>>>> +-    error_report_err(local_err);
>>>>>> ++    error_report_errp(errp);
>>>>>> +|
>>>>>> +-    error_reportf_err(local_err, args);
>>>>>> ++    error_reportf_errp(errp, args);
>>>>>> +|
>>>>>> +-    warn_report_err(local_err);
>>>>>> ++    warn_report_errp(errp);
>>>>>> +|
>>>>>> +-    warn_reportf_err(local_err, args);
>>>>>> ++    warn_reportf_errp(errp, args);
>>>>>> +)
>>>>>> +?-    local_err =3D NULL;
>>>>>> +
>>>>>> +|
>>>>>> +-    error_propagate_prepend(errp, local_err, args);
>>>>>> ++    error_prepend(errp, args);
>>>>>> +|
>>>>>> +-    error_propagate(errp, local_err);
>>>>>> +|
>>>>>> +-    &local_err
>>>>>> ++    errp
>>>>>> +)
>>>>>> +     ...>
>>>>>> + }
>>>>>> +
>>>>>> +// Convert remaining local_err usage. For example, different kinds =
of
>>>>>> +// error checking in if conditionals. We can't merge this into
>>>>>> +// previous hunk, as this conflicts with other substitutions in it =
(at
>>>>>> +// least with "- local_err =3D NULL").
>>>>>> +@ disable optional_qualifier@
>>>>>> +identifier rule1.fn, rule1.local_err;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +-    local_err
>>>>>> ++    *errp
>>>>>> +     ...>
>>>>>> + }
>>>>>> +
>>>>>> +// Always use the same pattern for checking error
>>>>>> +@ disable optional_qualifier@
>>>>>> +identifier rule1.fn;
>>>>>> +symbol errp;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error ** ____, ...)
>>>>>> + {
>>>>>> +     <...
>>>>>> +-    *errp !=3D NULL
>>>>>> ++    *errp
>>>>>> +     ...>
>>>>>> + }
>>>>>> +
>>>>>> +// Revert temporary ___ identifier.
>>>>>> +@ disable optional_qualifier@
>>>>>> +identifier rule1.fn;
>>>>>> +@@
>>>>>> +
>>>>>> + fn(..., Error **
>>>>>> +-   ____
>>>>>> ++   errp
>>>>>> +    , ...)
>>>>>> + {
>>>>>> +     ...
>>>>>> + }
>>>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>>>> index 30140d9bfe..56c133520d 100644
>>>>>> --- a/include/qapi/error.h
>>>>>> +++ b/include/qapi/error.h
>>>>>> @@ -214,6 +214,9 @@
>>>>>>      *         }
>>>>>>      *         ...
>>>>>>      *     }
>>>>>> + *
>>>>>> + * For mass-conversion use script
>>>>>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>>>>>      */
>>>>>>       #ifndef ERROR_H
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 857f969aa1..047f1b9714 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -1998,6 +1998,7 @@ F: include/qemu/error-report.h
>>>>>>     F: qapi/error.json
>>>>>>     F: util/error.c
>>>>>>     F: util/qemu-error.c
>>>>>> +F: scripts/coccinelle/*err*.cocci
>>>>>>       GDB stub
>>>>>>     M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>
>>>
>>>
>>>   From 42a08c529024337d1b859839c9ce7f797f784555 Mon Sep 17 00:00:00 200=
1
>>> From: Markus Armbruster <armbru@redhat.com>
>>> Date: Fri, 13 Mar 2020 14:27:57 +0100
>>> Subject: [PATCH] fixup! scripts: Coccinelle script to use
>>>    ERRP_AUTO_PROPAGATE()
>>>
>>> ---
>>>    scripts/coccinelle/auto-propagated-errp.cocci | 37 ++++++++++-------=
--
>>>    1 file changed, 20 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/co=
ccinelle/auto-propagated-errp.cocci
>>> index 7dac2dcfa4..43b0b0e63b 100644
>>> --- a/scripts/coccinelle/auto-propagated-errp.cocci
>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>> @@ -136,45 +136,48 @@ symbol errp;
>>>      // Warn several Error * definitions.
>>>    @check1 disable optional_qualifier exists@
>>> -identifier fn =3D rule1.fn, local_err, local_err2;
>>> +identifier fn, _errp, local_err, local_err2;
>>> +position p1, p2;
>>
>>
>> Hmm, seems like I forget to define ____ as symbol in my patch
>=20
> Coccinelle defaults to symbol.
>=20
>>>    @@
>>>    - fn(..., Error ** ____, ...)
>>> + fn(..., Error **_errp, ...)
>>
>> Ahmm.. it will break compilation?
>>
>> Or, how will it work when _errp defined as meta variable is only in "+..=
." line? Should it be symbol instead, or just not defined?
>=20
> Misunderstanding?  It's a diff between your .cocci and mine.  My version
> is
>=20
>      // Warn several Error * definitions.
>      @check1 disable optional_qualifier exists@
>      identifier fn, _errp, local_err, local_err2;
>      position p1, p2;
>      @@
>=20
>       fn(..., Error **_errp, ...)
>       {
>           ...
>           Error *local_err =3D NULL;@p1
>           ... when any
>           Error *local_err2 =3D NULL;@p2
>           ... when any
>       }
>=20
>      @ script:python @
>      fn << check1.fn;
>      p1 << check1.p1;
>      p2 << check1.p2;
>      @@
>=20
>>>     {
>>>         ...
>>> -     Error *local_err =3D NULL;
>>> +     Error *local_err =3D NULL;@p1
>>
>> Why to do -/+ here? Nothing changed..
>>
>>>         ... when any
>>> -     Error *local_err2 =3D NULL;
>>> +     Error *local_err2 =3D NULL;@p2
>>>         ... when any
>>>     }
>>>      @ script:python @
>>>    fn << check1.fn;
>>> +p1 << check1.p1;
>>> +p2 << check1.p2;
>>>    @@
>>>      print('Warning: function {} has several definitions of '
>>> -      'Error * local variable'.format(fn))
>>> +      'Error * local variable: at {}:{} and then at {}:{}'.format(
>>> +          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>>>      // Warn several propagations in control flow.
>>>    @check2 disable optional_qualifier exists@
>>> -identifier fn =3D rule1.fn;
>>> -symbol errp;
>>> +identifier fn, _errp;
>>>    position p1, p2;
>>>    @@
>>>    - fn(..., Error ** ____, ...)
>>> + fn(..., Error **_errp, ...)
>>>     {
>>>         ...
>>>    (
>>> -     error_propagate_prepend(errp, ...);@p1
>>> +     error_propagate_prepend(_errp, ...);@p1
>>>    |
>>> -     error_propagate(errp, ...);@p1
>>> +     error_propagate(_errp, ...);@p1
>>>    )
>>>         ...
>>>    (
>>> -     error_propagate_prepend(errp, ...);@p2
>>> +     error_propagate_prepend(_errp, ...);@p2
>>>    |
>>> -     error_propagate(errp, ...);@p2
>>> +     error_propagate(_errp, ...);@p2
>>>    )
>>
>> You change some occurrences of errp to _errp, but not all. It breaks com=
pilation.
>>
>>>         ... when any
>>>     }
>>> @@ -198,7 +201,7 @@ print('Warning: function {} propagates to errp seve=
ral times in '
>>>    // the same, just without error_propagate() call), coccinelle fails =
to
>>>    // match this "out: }".
>>>    @ disable optional_qualifier@
>>> -identifier rule1.fn, rule1.local_err, out;
>>> +identifier fn, rule1.local_err, out;
>>
>> Hmm. If it improves performance it is strange.. But I can live with this=
 change.
>>
>>>    symbol errp;
>>>    @@
>>>    @@ -239,7 +242,7 @@ symbol errp;
>>>    //        *errp =3D NULL;
>>>    //    }
>>>    @ disable optional_qualifier exists@
>>> -identifier rule1.fn, rule1.local_err;
>>> +identifier fn, rule1.local_err;
>>>    expression list args;
>>>    symbol errp;
>>>    @@
>>> @@ -287,7 +290,7 @@ symbol errp;
>>>    // previous hunk, as this conflicts with other substitutions in it (=
at
>>>    // least with "- local_err =3D NULL").
>>>    @ disable optional_qualifier@
>>> -identifier rule1.fn, rule1.local_err;
>>> +identifier fn, rule1.local_err;
>>>    symbol errp;
>>>    @@
>>>    @@ -301,7 +304,7 @@ symbol errp;
>>>      // Always use the same pattern for checking error
>>>    @ disable optional_qualifier@
>>> -identifier rule1.fn;
>>> +identifier fn;
>>>    symbol errp;
>>>    @@
>>>    @@ -315,7 +318,7 @@ symbol errp;
>>>      // Revert temporary ___ identifier.
>>>    @ disable optional_qualifier@
>>> -identifier rule1.fn;
>>> +identifier fn;
>>>    @@
>>>       fn(..., Error **
>>>
>=20
> I append my hacked up version of auto-propagated-errp.cocci.  It
> produces the same patch as yours for the complete tree.
>=20
>=20
>=20
> // Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
> //
> // Copyright (c) 2020 Virtuozzo International GmbH.
> //
> // This program is free software; you can redistribute it and/or
> // modify it under the terms of the GNU General Public License as
> // published by the Free Software Foundation; either version 2 of the
> // License, or (at your option) any later version.
> //
> // This program is distributed in the hope that it will be useful,
> // but WITHOUT ANY WARRANTY; without even the implied warranty of
> // MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> // GNU General Public License for more details.
> //
> // You should have received a copy of the GNU General Public License
> // along with this program.  If not, see
> // <http://www.gnu.org/licenses/>.
> //
> // Usage example:
> // spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
> //  --macro-file scripts/cocci-macro-file.h --in-place \
> //  --no-show-diff --max-width 80 FILES...
> //
> // Note: --max-width 80 is needed because coccinelle default is less
> // than 80, and without this parameter coccinelle may reindent some
> // lines which fit into 80 characters but not to coccinelle default,
> // which in turn produces extra patch hunks for no reason.
>=20
> // Switch unusual Error ** parameter names to errp
> // (this is necessary to use ERRP_AUTO_PROPAGATE).
> //
> // Disable optional_qualifier to skip functions with
> // "Error *const *errp" parameter.
> //
> // Skip functions with "assert(_errp && *_errp)" statement, because
> // that signals unusual semantics, and the parameter name may well
> // serve a purpose. (like nbd_iter_channel_error()).
> //
> // Skip util/error.c to not touch, for example, error_propagate() and
> // error_propagate_prepend().
> @ depends on !(file in "util/error.c") disable optional_qualifier@
> identifier fn;
> identifier _errp !=3D errp;
> @@
>=20
>   fn(...,
> -   Error **_errp
> +   Error **errp
>      ,...)
>   {
> (
>       ... when !=3D assert(_errp && *_errp)
> &
>       <...
> -    _errp
> +    errp
>       ...>
> )
>   }
>=20
> // Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
> // necessary
> //
> // Note, that without "when any" the final "..." does not mach
> // something matched by previous pattern, i.e. the rule will not match
> // double error_prepend in control flow like in
> // vfio_set_irq_signaling().
> //
> // Note, "exists" says that we want apply rule even if it matches not
> // on all possible control flows (otherwise, it will not match
> // standard pattern when error_propagate() call is in if branch).
> @ disable optional_qualifier exists@
> identifier fn, local_err;
> symbol errp;
> @@
>=20
>   fn(..., Error **errp, ...)
>   {
> +   ERRP_AUTO_PROPAGATE();
>      ...  when !=3D ERRP_AUTO_PROPAGATE();
> (
> (
>      error_append_hint(errp, ...);
> |
>      error_prepend(errp, ...);
> |
>      error_vprepend(errp, ...);
> )
>      ... when any
> |
>      Error *local_err =3D NULL;
>      ...
> (
>      error_propagate_prepend(errp, local_err, ...);
> |
>      error_propagate(errp, local_err);
> )
>      ...
> )
>   }
>=20
>=20
> // Match functions with propagation of local error to errp.
> // We want to refer these functions in several following rules, but I
> // don't know a proper way to inherit a function, not just its name
> // (to not match another functions with same name in following rules).
> // Not-proper way is as follows: rename errp parameter in functions
> // header and match it in following rules. Rename it back after all
> // transformations.
> //
> // The simplest case of propagation scheme is single definition of
> // local_err with at most one error_propagate_prepend or
> // error_propagate on each control-flow. Still, we want to match more
> // complex schemes too. We'll warn them with help of further rules.
> @rule1 disable optional_qualifier exists@
> identifier fn, local_err;
> symbol errp;
> @@
>=20
>   fn(..., Error **
> -    errp
> +    ____
>      , ...)
>   {
>       ...
>       Error *local_err =3D NULL;
>       ...
> (
>       error_propagate_prepend(errp, local_err, ...);
> |
>       error_propagate(errp, local_err);
> )
>       ...
>   }
>=20
>=20
> // Warn several Error * definitions.
> @check1 disable optional_qualifier exists@
> identifier fn, _errp, local_err, local_err2;
> position p1, p2;
> @@
>=20
>   fn(..., Error **_errp, ...)
>   {
>       ...
>       Error *local_err =3D NULL;@p1
>       ... when any
>       Error *local_err2 =3D NULL;@p2
>       ... when any
>   }
>=20
> @ script:python @
> fn << check1.fn;
> p1 << check1.p1;
> p2 << check1.p2;
> @@
>=20
> print('Warning: function {} has several definitions of '
>        'Error * local variable: at {}:{} and then at {}:{}'.format(
>            fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>=20
> // Warn several propagations in control flow.
> @check2 disable optional_qualifier exists@
> identifier fn, _errp;
> position p1, p2;
> @@
>=20
>   fn(..., Error **_errp, ...)

Hmm, for this to work, we should move the rule above rule1, because now par=
amter
definition is different from it usage in the function body.

>   {
>       ...
> (
>       error_propagate_prepend(_errp, ...);@p1
> |
>       error_propagate(_errp, ...);@p1
> )
>       ...
> (
>       error_propagate_prepend(_errp, ...);@p2
> |
>       error_propagate(_errp, ...);@p2
> )
>       ... when any
>   }
>=20
> @ script:python @
> fn << check2.fn;
> p1 << check2.p1;
> p2 << check2.p2;
> @@
>=20
> print('Warning: function {} propagates to errp several times in '
>        'one control flow: at {}:{} and then at {}:{}'.format(
>            fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
>=20
> // Convert special case with goto separately.
> // I tried merging this into the following rule the obvious way, but
> // it made Coccinelle hang on block.c
> //
> // Note interesting thing: if we don't do it here, and try to fixup
> // "out: }" things later after all transformations (the rule will be
> // the same, just without error_propagate() call), coccinelle fails to
> // match this "out: }".
> @ disable optional_qualifier@
> identifier fn, rule1.local_err, out;
> symbol errp;
> @@
>=20
>   fn(..., Error ** ____, ...)
>   {
>       <...
> -    goto out;
> +    return;
>       ...>
> - out:
> -    error_propagate(errp, local_err);
>   }
>=20
> // Convert most of local_err related stuff.
> //
> // Note, that we update everything related to matched by rule1
> // function name and local_err name. We may match something not
> // related to the pattern matched by rule1. For example, local_err may
> // be defined with the same name in different blocks inside one
> // function, and in one block follow the propagation pattern and in
> // other block doesn't. Or we may have several functions with the same
> // name (for different configurations).
> //
> // Note also that errp-cleaning functions
> //   error_free_errp
> //   error_report_errp
> //   error_reportf_errp
> //   warn_report_errp
> //   warn_reportf_errp
> // are not yet implemented. They must call corresponding Error* -
> // freeing function and then set *errp to NULL, to avoid further
> // propagation to original errp (consider ERRP_AUTO_PROPAGATE in use).
> // For example, error_free_errp may look like this:
> //
> //    void error_free_errp(Error **errp)
> //    {
> //        error_free(*errp);
> //        *errp =3D NULL;
> //    }
> @ disable optional_qualifier exists@
> identifier fn, rule1.local_err;
> expression list args;
> symbol errp;
> @@
>=20
>   fn(..., Error ** ____, ...)
>   {
>       <...
> (
> -    Error *local_err =3D NULL;
> |
>=20
> // Convert error clearing functions
> (
> -    error_free(local_err);
> +    error_free_errp(errp);
> |
> -    error_report_err(local_err);
> +    error_report_errp(errp);
> |
> -    error_reportf_err(local_err, args);
> +    error_reportf_errp(errp, args);
> |
> -    warn_report_err(local_err);
> +    warn_report_errp(errp);
> |
> -    warn_reportf_err(local_err, args);
> +    warn_reportf_errp(errp, args);
> )
> ?-    local_err =3D NULL;
>=20
> |
> -    error_propagate_prepend(errp, local_err, args);
> +    error_prepend(errp, args);
> |
> -    error_propagate(errp, local_err);
> |
> -    &local_err
> +    errp
> )
>       ...>
>   }
>=20
> // Convert remaining local_err usage. For example, different kinds of
> // error checking in if conditionals. We can't merge this into
> // previous hunk, as this conflicts with other substitutions in it (at
> // least with "- local_err =3D NULL").
> @ disable optional_qualifier@
> identifier fn, rule1.local_err;
> symbol errp;
> @@
>=20
>   fn(..., Error ** ____, ...)
>   {
>       <...
> -    local_err
> +    *errp
>       ...>
>   }
>=20
> // Always use the same pattern for checking error
> @ disable optional_qualifier@
> identifier fn;
> symbol errp;
> @@
>=20
>   fn(..., Error ** ____, ...)
>   {
>       <...
> -    *errp !=3D NULL
> +    *errp
>       ...>
>   }
>=20
> // Revert temporary ___ identifier.
> @ disable optional_qualifier@
> identifier fn;
> @@
>=20
>   fn(..., Error **
> -   ____
> +   errp
>      , ...)
>   {
>       ...
>   }
>=20


--=20
Best regards,
Vladimir

