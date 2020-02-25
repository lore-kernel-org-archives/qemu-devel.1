Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9545EC35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8152064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NZ0erQVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8152064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c4X-0002DD-G6
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6c32-0000KX-Fe
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6c2z-00063h-BY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:23:00 -0500
Received: from mail-eopbgr70111.outbound.protection.outlook.com
 ([40.107.7.111]:3139 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j6c2y-00062M-Df; Tue, 25 Feb 2020 10:22:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bltRUm8+7vp7fI8uBGMZKdWpcv0dkBMsAlL6ckFkImKiqLe9HIq2v5d4WVgmpqJjWV0DfFHlA/UCyHNj2Mr5wLNN57a8FFH0k2LY9Sk8oBhUlzX1xNNx59Ulay84sp+K0yRdJv7So62AbP2ujb6CHg2wg+cFJ6SDGD+ZDpZyrf6f3/tkaPP9t5EGDA/x1XjxO+g+MryRODaVeUhw1fH5U23sBuYQ7nPIT1dqyIqI63gMNTcX/yyaT8p7HW03ECb5Pk+6zxt1/cyX5sjhh6gVjAITuic9X9AUExL5huiIZdS6tVXbTYWp0qZ6rwDy0H9B4+4yN6CNoDdjgD+QZf8ZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA6OdMo+HRYFcpRz4GY+QG/za/1o8rXZz0UH8sfdhcQ=;
 b=gBQwTo2Ag5LmBe10U+Bk6VtWeJQbodOWavKGvZXF2DE3ZWjw6If8aMLNMaEZ97joR4vt17O8FvMqAmP5g2k03O6JlILeSEFk8nV8l2iJOt7c5KhlvpNqkh4AhxMGD18Bo8C9iDk10uiivPVG8lmE5km8+yW+zhE56EAQL3KAjPwTpwO22kMsgv0yBU5WTc2JDEdFyA93RCsMSjSWaKHKhgPNA10bUaDD7z62pGqy+wkOzQ0aOic2lMIloDg40UfKMpIV9EtkcYMJHWCY1VCZ5QzQj/dBjJSuztlvTsZft1Rif4lyyZDO8eylbRt/254/PgZMHVJw6YiWcjpqoKlFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA6OdMo+HRYFcpRz4GY+QG/za/1o8rXZz0UH8sfdhcQ=;
 b=NZ0erQVNUOZll6fLzpT7Gp9/ZKQtb3c1Zmo7LV2eiuMqg86Ns2zgiF/usDYqDDpjurQXs4U2hi0m0nN7gz8CSEj/xtnGV2yQL8QSjBYCh1IB2OxT4qFfPOFHnEBRtlHn2OP4RlYX5Qa6a2OyZDqVL0jiPDI/+ueXRohyKjUxS7Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4005.eurprd08.prod.outlook.com (20.179.0.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Tue, 25 Feb 2020 15:22:53 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 15:22:53 +0000
Subject: Re: [PATCH v7 03/11] scripts: add coccinelle script to use auto
 propagated errp
To: Markus Armbruster <armbru@redhat.com>
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-4-vsementsov@virtuozzo.com>
 <87v9nxwulz.fsf@dusky.pond.sub.org>
 <cff01a02-f99a-574d-c750-200da0c1d925@virtuozzo.com>
 <87wo8aesn0.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200225182250311
Message-ID: <b53674e2-2484-4f18-fc3f-f2a2a3d6168b@virtuozzo.com>
Date: Tue, 25 Feb 2020 18:22:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87wo8aesn0.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0401CA0082.eurprd04.prod.outlook.com
 (2603:10a6:3:19::50) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0401CA0082.eurprd04.prod.outlook.com (2603:10a6:3:19::50) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 15:22:52 +0000
X-Tagtoolbar-Keys: D20200225182250311
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5873cd7-1f8d-451b-fb44-08d7ba069514
X-MS-TrafficTypeDiagnostic: AM6PR08MB4005:
X-Microsoft-Antispam-PRVS: <AM6PR08MB40050DF4DB1A8636F209DEC3C1ED0@AM6PR08MB4005.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(81156014)(81166006)(8676002)(478600001)(36756003)(30864003)(2906002)(956004)(8936002)(5660300002)(54906003)(16576012)(316002)(31686004)(6486002)(86362001)(26005)(16526019)(186003)(52116002)(4326008)(2616005)(66476007)(66556008)(66946007)(7416002)(31696002)(6916009)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4005;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d/SYvu3+1mLnyjtND4UOf/h33lxTKn0z5KMysNSFP3XXBTA5e58oyOcBt8IIenhyjxnv/BN1lu2My/HFecmZwHb59FHvAi9YcycD5+uww9+yJQXMTPodoh3vJRm+FCUDTM0DzGqi3GeYzSHe7Ce8BjDOUrAvSy+nAG/5woTz+HrjxAvHi8pyg500nML+Byf2MpRA5n1EmyXYGjAvw4i0T7sUulGsi8wELQrLfihtAGvhvw0/mPmK+ZiE2Wg3baJTqROw741/jslPyDRvmQ7johW8Pw9F37GB7i3tzqbhrtNI+yeF9seNPhjHxrS7Eqz83/8tGIykmQyAJGQX/CmMftb9bH/fRp6mWwwnUGLO7UOIQTw3YjOMKF4qvJI6goiumJWKMx7krlWQgWPRKCzLW4GXDsMpMhrMV3jOZ+4IOjMNiu5bZowTHo8s3/GN1uIfZ7xqcU+xyNhhodTiH6sYpnBHbLBNx8Bvz1XGy43uQ/fV9fC2oiyXGn6Ucqh7qlpcncd+j+9mb1yEETe0G+NW8mYTsAQ5a7DyYA89ylC5a0d98KThBIAgofRHdm8Q8WXn
X-MS-Exchange-AntiSpam-MessageData: qdHCh4+2pEsNFRMr+ObKBhQ42mROBoZdn4EO0jeqU62z7f5bC8CsD91YWxSz5LHgAbXRA3UgoKUIf0Tjhukd2ZUR6InarwsWqL8aDJctUAyADnlocf32BuiygHDThnw8NBKICAaQFK0CpIv7ix6StA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5873cd7-1f8d-451b-fb44-08d7ba069514
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 15:22:53.2653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozQNv91BDDp01SqmQrxqPwUaG5BLx+/cwOhO6PO/kh8wwQ+K5+6xOjaOI1BbXhvf6l0AHBfLFKWvNPZMYOBrU7KsIbZ2Smoi96LncKoMPVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4005
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.111
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

25.02.2020 15:52, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> 23.02.2020 11:55, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>
>>>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
>>>> does corresponding changes in code (look for details in
>>>> include/qapi/error.h)
>>>>
>>>> Usage example:
>>>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>>    --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>>>>    blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc=
]
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>
>>>> CC: Eric Blake <eblake@redhat.com>
>>>> CC: Kevin Wolf <kwolf@redhat.com>
>>>> CC: Max Reitz <mreitz@redhat.com>
>>>> CC: Greg Kurz <groug@kaod.org>
>>>> CC: Stefano Stabellini <sstabellini@kernel.org>
>>>> CC: Anthony Perard <anthony.perard@citrix.com>
>>>> CC: Paul Durrant <paul@xen.org>
>>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>>> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>>>> CC: Laszlo Ersek <lersek@redhat.com>
>>>> CC: Gerd Hoffmann <kraxel@redhat.com>
>>>> CC: Stefan Berger <stefanb@linux.ibm.com>
>>>> CC: Markus Armbruster <armbru@redhat.com>
>>>> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
>>>> CC: qemu-block@nongnu.org
>>>> CC: xen-devel@lists.xenproject.org
>>>>
>>>>    include/qapi/error.h                          |   3 +
>>>>    scripts/coccinelle/auto-propagated-errp.cocci | 158 +++++++++++++++=
+++
>>>>    2 files changed, 161 insertions(+)
>>>>    create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>>>
>>>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>>>> index b9452d4806..79f8e95214 100644
>>>> --- a/include/qapi/error.h
>>>> +++ b/include/qapi/error.h
>>>> @@ -141,6 +141,9 @@
>>>>     *         ...
>>>>     *     }
>>>>     *
>>>> + * For mass conversion use script
>>>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>>>> + *
>>>>     *
>>>>     * Receive and accumulate multiple errors (first one wins):
>>>>     *     Error *err =3D NULL, *local_err =3D NULL;
>>>
>>> Extra blank line.
>>>
>>>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/c=
occinelle/auto-propagated-errp.cocci
>>>> new file mode 100644
>>>> index 0000000000..fb03c871cb
>>>> --- /dev/null
>>>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>>>> @@ -0,0 +1,158 @@
>>>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>>>> +//
>>>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>>>> +//
>>>> +// This program is free software; you can redistribute it and/or modi=
fy
>>>> +// it under the terms of the GNU General Public License as published =
by
>>>> +// the Free Software Foundation; either version 2 of the License, or
>>>> +// (at your option) any later version.
>>>> +//
>>>> +// This program is distributed in the hope that it will be useful,
>>>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> +// GNU General Public License for more details.
>>>> +//
>>>> +// You should have received a copy of the GNU General Public License
>>>> +// along with this program.  If not, see <http://www.gnu.org/licenses=
/>.
>>>> +//
>>>> +// Usage example:
>>>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>>> +//  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff=
 \
>>>> +//  blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[=
hc]
>>>> +
>>>> +@rule0@
>>>> +// Add invocation to errp-functions where necessary
>>>> +// We should skip functions with "Error *const *errp"
>>>> +// parameter, but how to do it with coccinelle?
>>>> +// I don't know, so, I skip them by function name regex.
>>>> +// It's safe: if we did not skip some functions with
>>>> +// "Error *const *errp", ERRP_AUTO_PROPAGATE invocation
>>>> +// will fail to compile, because of const violation.
>>>
>>> Not skipping a function we should skip fails to compile.
>>>
>>> What about skipping a function we should not skip?
>>
>> Then it will not be updated.. Not good but I don't have better solution.
>> Still, I hope, function called *error_append_*_hint will not return erro=
r
>> through errp pointer.
>=20
> Seems likely.  I just dislike inferring behavior from name patterns.
>=20
> Ideally, we recognize the true exceptional pattern instead, i.e. the
> presence of const.  But figuring out how to make Coccinelle do that for
> us may be more trouble than it's worth.
>=20
> Hmm...  Coccinelle matches the parameter even with const due to what it
> calls "isomorphism".  Can I disable it?  *Tinker* *tinker*
>=20
> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/cocc=
inelle/auto-propagated-errp.cocci
> index fb03c871cb..0c4414bff3 100644
> --- a/scripts/coccinelle/auto-propagated-errp.cocci
> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
> @@ -20,15 +20,11 @@
>   //  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>   //  blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc=
]
>  =20
> -@rule0@
> +@rule0 disable optional_qualifier@
>   // Add invocation to errp-functions where necessary
> -// We should skip functions with "Error *const *errp"
> -// parameter, but how to do it with coccinelle?
> -// I don't know, so, I skip them by function name regex.
> -// It's safe: if we did not skip some functions with
> -// "Error *const *errp", ERRP_AUTO_PROPAGATE invocation
> -// will fail to compile, because of const violation.
> -identifier fn !~ "error_append_.*_hint";
> +// Disable optional_qualifier to skip functions with "Error *const *errp=
"
> +// parameter,
> +identifier fn;
>   identifier local_err, ERRP;
>   @@
>=20
> Could you verify this results in the same tree-wide change as your
> version?

Yes, no difference. Thanks!

>=20
>>>> +identifier fn !~ "error_append_.*_hint";
>>>> +identifier local_err, ERRP;
>>>
>>> A few of our coccinelle scripts use ALL_CAPS for meta-variables.  Most
>>> don't.  Either is fine with me.  Mixing the two styles feels a bit
>>> confusing, though.
>>>
>>>> +@@
>>>> +
>>>> + fn(..., Error **ERRP, ...)
>>>> + {
>>>> ++   ERRP_AUTO_PROPAGATE();
>>>> +    <+...
>>>> +        when !=3D ERRP_AUTO_PROPAGATE();
>>>> +(
>>>> +    error_append_hint(ERRP, ...);
>>>> +|
>>>> +    error_prepend(ERRP, ...);
>>>> +|
>>>> +    Error *local_err =3D NULL;
>>>> +)
>>>> +    ...+>
>>>> + }
>>>
>>> Misses error_vprepend().  Currently harmless, but as long as we commit
>>> the script, we better make it as robust as we reasonably can.
>>>
>>> The previous patch explains this Coccinelle script's intent:
>>>
>>>     To achieve these goals, later patches will add invocations
>>>     of this macro at the start of functions with either use
>>>     error_prepend/error_append_hint (solving 1) or which use
>>>     local_err+error_propagate to check errors, switching those
>>>     functions to use *errp instead (solving 2 and 3).
>>>
>>> This rule matches "use error_prepend/error_append_hint" directly.  It
>>> appears to use presence of a local Error * variable as proxy for "use
>>> local_err+error_propagate to check errors".  Hmm.
>>>
>>> We obviously have such a variable when we use "local_err+error_propagat=
e
>>> to check errors".  But we could also have such variables without use of
>>> error_propagate().  In fact, error.h documents such use:
>>>
>>>    * Call a function and receive an error from it:
>>>    *     Error *err =3D NULL;
>>>    *     foo(arg, &err);
>>>    *     if (err) {
>>>    *         handle the error...
>>>    *     }
>>>
>>> where "handle the error" frees it.
>>>
>>> I figure such uses typically occur in functions without an Error **errp
>>> parameter.  This rule doesn't apply then.  But they could occur even in
>>> functions with such a parameter.  Consider:
>>>
>>>       void foo(Error **errp)
>>>       {
>>>           Error *err =3D NULL;
>>>
>>>           bar(&err);
>>>           if (err) {
>>>               error_free(err);
>>>               error_setg(errp, "completely different error");
>>>           }
>>>       }
>>>
>>> Reasonable enough when bar() gives us an error that's misleading in thi=
s
>>> context, isn't it?
>>>
>>> The script transforms it like this:
>>>
>>>       void foo(Error **errp)
>>>       {
>>>      -    Error *err =3D NULL;
>>>      +    ERRP_AUTO_PROPAGATE();
>>>
>>>      -    bar(&err);
>>>      -    if (err) {
>>>      -        error_free(err);
>>>      +    bar(errp);
>>>      +    if (*errp) {
>>>      +        error_free_errp(errp);
>>>               error_setg(errp, "completely different error");
>>>           }
>>>       }
>>>
>>> Unwanted.
>>
>> What is the problem with it? Updated code just use "new usual notation"
>> for handling error of sub-calls in function which reports errors through
>> errp pointer.
>=20
> error.h's big comment asks for use of ERRP_AUTO_PROPAGATE() to "Receive
> an error and pass it on to the caller".  We're not doing that here.  We
> "Call a function and receive an error from it", then "Handle an error
> without reporting it".
>=20
> The updated code works anyway, but it's needlessly complicated.

OK, will try.

>=20
>>> Now, if this script applied in just a few dozen places, we could rely o=
n
>>> eyeballing its output to catch unwanted transformations.  Since it
>>> applies in so many more, I don't feel comfortable relying on reviewer
>>> eyeballs.
>>>
>>> Can we make rule0 directly match error_propagate(errp, local_err)
>>> somehow?
>>
>> I think it is possible, still I'm not sure we need it.
>=20
> We don't need it in the sense of "must have to avoid a buggy
> transformation".  It's more like "I'd like to have it to stay close to
> the documented usage of ERRP_AUTO_PROPAGATE(), and to avoid complicating
> cases like the one above".
>=20
>>> Another observation: the rule does not match error_reportf_err() and
>>> warn_reportf_err().  These combine error_prepend(),
>>> error_report()/warn_report() and error_free(), for convenience.  Don't
>>> their users need ERRP_AUTO_PROPAGATE() just like error_prepend()'s
>>> users?
>>
>> Right. These functions want to add information, which will not work
>> for error_fatal without wrapping.
>=20
> A simple improvement, I hope.
>=20
>>>> +
>>>> +@@
>>>> +// Switch unusual (Error **) parameter names to errp
>>>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>>>
>>> Please put your rule comments right before the rule, i.e. before the
>>> @-line introducing metavariable declarations, not after.  Same
>>> elsewhere.
>>>
>>>> +identifier rule0.fn;
>>>> +identifier rule0.ERRP !=3D errp;
>>>> +@@
>>>> +
>>>> + fn(...,
>>>> +-   Error **ERRP
>>>> ++   Error **errp
>>>> +    ,...)
>>>> + {
>>>> +     <...
>>>> +-    ERRP
>>>> ++    errp
>>>> +     ...>
>>>> + }
>>>
>>> This normalizes errp parameter naming.  It matches exactly when rule0
>>> matches (and inserts ERRP_AUTO_PROPAGATE()) and the Error ** parameter
>>> is unusual.  Good.
>>>
>>>> +
>>>> +@rule1@
>>>> +// We want to patch error propagation in functions regardless of
>>>> +// whether the function already uses ERRP_AUTO_PROPAGATE prior to
>>>> +// applying rule0, hence this one does not inherit from it.
>>>
>>> I'm not sure I get this comment.  Let's see what the rule does.
>>>
>>>> +identifier fn !~ "error_append_.*_hint";
>>>> +identifier local_err;
>>>> +symbol errp;
>>>> +@@
>>>> +
>>>> + fn(..., Error **errp, ...)
>>>> + {
>>>> +     <...
>>>> +-    Error *local_err =3D NULL;
>>>> +     ...>
>>>> + }
>>>
>>> rule1 matches like rule0, except the Error ** parameter match is
>>> tightened from any C identifier to the C identifier errp, and the
>>> function body match tightened from "either use
>>> error_prepend/error_append_hint or which use local_err+error_propagate
>>> to check errors" to just the latter.
>>>
>>> I figure tightening the Error ** parameter match has no effect, because
>>> we already normalized the parameter name.
>>>
>>> So rule1 deletes variable local_err where rule0 applied.  Correct?
>>
>> The difference with rule0 is that rule0 contains
>>   "when !=3D ERRP_AUTO_PROPAGATE()", so rule0 is not applied where
>> we already have macro invocation.
>=20
> Ah, I missed the when clause.
>=20
>> This is why we can't inherit from rule0.
>>
>> No we believe that we have ERRP_AUTO_PROPAGATE invocation in all
>> corresponding places (added by rule0 or before script run) and want to
>> update all usage of local_err objects.
>=20
> Let's see whether I got it:
>=20
> * The first rule (rule0) adds ERRP_AUTO_PROPAGATE() to all functions
>    that take an Error ** parameter, and either pass it error_prepend() or
>    error_append_hint(), or use local_err, and don't have
>    ERRP_AUTO_PROPAGATE() already, except it skips the ones named
>    error_append_FOO_hint().  Uff.
>=20
>    The "use local_err" part is an approximation of "use local_err +
>    error_propagate()".
>=20
>    The "except for the ones named error_append_FOO_hint()" part is an
>    approximation of "except for the ones taking an Error *const *
>    parameter".
>=20
>    ERRP_AUTO_PROPAGATE() requires the Error ** parameter to be named
>    @errp, which need not be the case.  The next rule fixes it up:
>=20
> * The second rule ensures the parameter is named @errp wherever the
>    first rule applied, renaming if necessary.
>=20
>    Correct?
>=20
>    Incorrect transformation followed by fixup is not ideal, because it
>    can trip up reviewers.  But ideal is too expensive; this is good
>    enough.
>=20
> * The third rule (rule1) ensures functions that take an Error **errp
>    parameter don't declare local_err, except it skips the ones named
>    error_append_FOO_hint().
>=20
>    In isolation, this rule makes no sense.  To make sense of it, we need
>    context:
>=20
>    * Subsequent rules remove all uses of @errp from any function where

of local_err

>      rule1 matches.
>=20
>    * Preceding rules ensure any function where rule1 matches has
>      ERRP_AUTO_PROPAGATE().
>=20
>    Correct?

Oh, yes, everything is correct.

>=20
>    The need for this much context is hard on reviewers.  Good enough for
>    transforming the tree now, but I'd hate having to make sense of this
>    again in six months.

Ohh, yes. Far from good design. I can try to reorder chunks a bit.

>=20
>>>> +
>>>> +@@
>>>> +// Handle pattern with goto, otherwise we'll finish up
>>>> +// with labels at function end which will not compile.
>>>> +identifier rule1.fn, rule1.local_err;
>>>> +identifier OUT;
>>>> +@@
>>>> +
>>>> + fn(...)
>>>> + {
>>>> +     <...
>>>> +-    goto OUT;
>>>> ++    return;
>>>> +     ...>
>>>> +- OUT:
>>>> +-    error_propagate(errp, local_err);
>>>> + }
>>>
>>> This is one special case of error_propagate() deletion.  It additionall=
y
>>> gets rid of a goto we no longer want.  For the general case, see below.
>>>
>>> The rule applies only where rule1 just deleted the variable.  Thus, the
>>> two rules work in tandem.  Makes sense.
>>>
>>>> +
>>>> +@@
>>>> +identifier rule1.fn, rule1.local_err;
>>>
>>> This rule also works in tandem with rule1.
>>>
>>>> +expression list args; // to reindent error_propagate_prepend
>>>
>>> What is the comment trying to tell me?
>>
>> Hmm, we can safely drop it. It's about the following:
>>
>> instead of
>>
>>   -    error_propagate_prepend(errp, local_err, args);
>>   +    error_prepend(errp, args);
>>
>> we can use "...", like
>>
>>   - error_propagate_prepend(errp, local_err
>>   + error_prepend(errp
>>     , ...);
>>
>> but with metavar in use, coccinelle will correctly reindent the
>> whole call, which looks a lot better.
>=20
> Let's drop the comment.
>=20
>>>> +@@
>>>> +
>>>> + fn(...)
>>>> + {
>>>> +     <...
>>>> +(
>>>> +-    error_free(local_err);
>>>> +-    local_err =3D NULL;
>>>> ++    error_free_errp(errp);
>>>
>>> Reminder:
>>>
>>>       static inline void error_free_errp(Error **errp)
>>>       {
>>>           assert(errp && *errp);
>>>           error_free(*errp);
>>>           *errp =3D NULL;
>>>       }
>>>
>>> Now let's examine the actual change.
>>>
>>> The assertion's first half trivially holds, ERRP_AUTO_PROPAGATE()
>>> ensures it.
>>>
>>> The second half is new.  We now crash when we haven't set an error.  Wh=
y
>>> is this safe?  Note that error_free(local_err) does nothing when
>>> !local_err.
>>
>> Hmm. Looks like we should tighten this restriction, and follow error_fre=
e
>> interface, which allows freeing unset errp.
>>
>>>
>>> The zapping of the variable pointing to the Error just freed is
>>> unchanged.
>>>
>>>> +|
>>>> +-    error_free(local_err);
>>>> ++    error_free_errp(errp);
>>>
>>> Here, the zapping is new.  Zapping dangling pointers is obviously safe.
>>> Needed, or else the automatic error_propagate() due to
>>> ERRP_AUTO_PROPAGATE() would propagate the dangling pointer.
>>>
>>>> +|
>>>> +-    error_report_err(local_err);
>>>> ++    error_report_errp(errp);
>>>
>>> The only difference to the previous case is that we also report the
>>> error.
>>>
>>> The previous case has a buddy that additionally matches *errp =3D NULL.
>>> Why not this one?
>>
>> Probably because no matches in code. But should be added here for
>> better case coverage.
>=20
> Either that or a comment pointing out what's missing, and why, namely
> because the pattern doesn't exist in the tree.
>=20
>>>
>>>> +|
>>>> +-    warn_report_err(local_err);
>>>> ++    warn_report_errp(errp);
>>>
>>> Likewise.
>>>
>>> What about error_reportf_err(), warn_reportf_err()?
>>>
>>> Up to here, this rule transforms the various forms of error_free().
>>> Next: error_propagate().
>>>
>>>> +|
>>>> +-    error_propagate_prepend(errp, local_err, args);
>>>> ++    error_prepend(errp, args);
>>>> +|
>>>> +-    error_propagate(errp, local_err);
>>>
>>> rule0's adding of ERRP_AUTO_PROPAGATE() made error_propagate()
>>> redundant.
>>>
>>> This is the general case of error_propagate() deletion.
>>>
>>> I'd put the plain error_propagate() first, variations second, like you
>>> do with error_free().
>>>
>>> If neither of these two patterns match on a path from
>>> ERRP_AUTO_PROPAGATE() to return, we effectively insert error_propagate(=
)
>>> where it wasn't before.  Does nothing when the local error is null
>>> there.  Bug fix when it isn't: it's at least a memory leak, and quite
>>> possibly worse.
>>
>> Hmm. How can it be memory leak after any of error_free variants?
>=20
> Consider nfs_options_qdict_to_qapi() right before commit 54b7af4369a
> fixed it:
>=20
>      static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
>                                                           Error **errp)
>      {
>          BlockdevOptionsNfs *opts =3D NULL;
>          QObject *crumpled =3D NULL;
>          Visitor *v;
>          Error *local_err =3D NULL;
>=20
>          crumpled =3D qdict_crumple(options, errp);
>          if (crumpled =3D=3D NULL) {
>              return NULL;
>          }
>=20
>          v =3D qobject_input_visitor_new_keyval(crumpled);
>          visit_type_BlockdevOptionsNfs(v, NULL, &opts, &local_err);
>          visit_free(v);
>          qobject_unref(crumpled);
>=20
>          if (local_err) {
>              return NULL;
>          }
>=20
>          return opts;
>      }
>=20
> When visit_type_BlockdevOptionsNfs() fails, we return null without
> setting an error.  We also leak the error we got from
> visit_type_BlockdevOptionsNfs().
>=20
> Commit 54b7af4369a fixed this:
>=20
>      --- a/block/nfs.c
>      +++ b/block/nfs.c
>      @@ -570,6 +570,7 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_=
qapi(QDict *
>      options,
>           qobject_unref(crumpled);
>=20
>           if (local_err) {
>      +        error_propagate(errp, local_err);
>               return NULL;
>           }
>=20
> If it was still broken, then your transformation would *also* fix it,
> wouldn't it?

Ah, yes. You mean addition of the macro invocation, I thought about transfo=
rming
error_free variants to error_free_errp variants.

>=20
> My point is: your transformation might fix actual bugs!
>=20
>>> Identifying these bug fixes would be nice, but I don't have practical
>>> ideas on how to do that.
>>>
>>> Can we explain this in the commit message?
>>>
>>>> +)
>>>> +     ...>
>>>> + }
>>>> +
>>>> +@@
>>>> +identifier rule1.fn, rule1.local_err;
>>>> +@@
>>>> +
>>>> + fn(...)
>>>> + {
>>>> +     <...
>>>> +(
>>>> +-    &local_err
>>>> ++    errp
>>>> +|
>>>> +-    local_err
>>>> ++    *errp
>>>> +)
>>>> +     ...>
>>>> + }
>>>
>>> Also in tandem with rule1, fixes up uses of local_err.  Good.
>>>
>>>> +
>>>> +@@
>>>> +identifier rule1.fn;
>>>> +@@
>>>> +
>>>> + fn(...)
>>>> + {
>>>> +     <...
>>>> +- *errp !=3D NULL
>>>> ++ *errp
>>>> +     ...>
>>>> + }
>>>
>>> Still in tandem with rule1, normalizes style.  Good.
>>>
>=20


--=20
Best regards,
Vladimir

