Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E192C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB8421744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ItQrqlh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB8421744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WDc-0007KK-1T
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6WCw-0006pe-VM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j6WCu-0007bs-PU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:08:50 -0500
Received: from mail-eopbgr50104.outbound.protection.outlook.com
 ([40.107.5.104]:16853 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j6WCo-0007XM-9j; Tue, 25 Feb 2020 04:08:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtBkEvs6SclKQirdRFxRsTdYmlW+fslORNq2Euq20uaNMyF5lfY7nSLALsAOPPYHz9RBhVvcS39dqCpvYKKLpX9/QKDmkoMFIyuW+45WSBAL+EIT4HdoNYe7Ix2eFF5EOt9Tu30hNSHfmY+H+J5Q6+2y2C/p1s37WKy32H3sqP/r0M1vm/sCig0URK9a571w/k3LoRbdBbfH2aG4kPdcEDZkRYyQcTJyH4k95Djq4VacT8uPVr737+JYamT9wBtHftaR9z3dnyr0cHpjPMvjGigNqbcI1Oj0nGva9pvttNTB3cKQ2Ygnb+zq+Bgy6IdJbFuO9AJEsOmLSIG61BWKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFMQmqotNJjEGzKuU52R/Qq8mBIG7Z62QjPsFlGDiYU=;
 b=CTSLrRT/Sb1lfAhOWa9oJjeSyFSyKzHKPn3bsYgnBnJKRTB62XkslD4kpU8xXZ3VWDCj0etQJOTWTlwsQCCweAoSv8VfSVh1dcO0fLP06yjCKKVkGWpOn+TkqASnhuKn87w+oKR5Ck21Ewgm93n5FdVV/s+uCr6RL2hQDgjnS4F6IcbOTb0CjP7IbbZp3Cp7Lag320Xbk/40aTVqRBO99rYh2MybcXBeU4ksZthUhgQ7YU7hMJIFyvLp6Gy3i7/zG8C+tkags4HWrgdSEho/3epAxo0ryQ9BLg4OE0FiQQwmjAmy2PlxhgC0zMj6AOU7yowjpljh/wNAtGc6VjIXPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFMQmqotNJjEGzKuU52R/Qq8mBIG7Z62QjPsFlGDiYU=;
 b=ItQrqlh7uMRhxD+xhFvu2QC5smHhff9pfpqUeIdOkS0gyMg//XNp5/zihxULxnuztXu6pOwOAx2NhbEr/AjG+v77Fz7LNUhr3pro3JbFdt3jBZvkRh4b0CEakTcLUU4n+AmJjcLDzytingVNobO7TSf5tjCrpSt7wO/HZPlDEAM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4424.eurprd08.prod.outlook.com (20.179.18.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Tue, 25 Feb 2020 09:08:40 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 09:08:39 +0000
Subject: Re: [PATCH v7 03/11] scripts: add coccinelle script to use auto
 propagated errp
To: Markus Armbruster <armbru@redhat.com>
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <20200131130118.1716-4-vsementsov@virtuozzo.com>
 <87v9nxwulz.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200225120837059
Message-ID: <cff01a02-f99a-574d-c750-200da0c1d925@virtuozzo.com>
Date: Tue, 25 Feb 2020 12:08:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87v9nxwulz.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::18) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR0102CA0005.eurprd01.prod.exchangelabs.com (2603:10a6:7:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend
 Transport; Tue, 25 Feb 2020 09:08:38 +0000
X-Tagtoolbar-Keys: D20200225120837059
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f554bb-34bb-4251-a562-08d7b9d24dd9
X-MS-TrafficTypeDiagnostic: AM6PR08MB4424:
X-Microsoft-Antispam-PRVS: <AM6PR08MB44249DD0A180F521972CF69CC1ED0@AM6PR08MB4424.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(39850400004)(346002)(376002)(366004)(199004)(189003)(31686004)(16526019)(6916009)(6486002)(7416002)(4326008)(66556008)(2616005)(956004)(2906002)(66476007)(26005)(186003)(478600001)(66946007)(8676002)(54906003)(16576012)(316002)(5660300002)(81166006)(86362001)(31696002)(8936002)(30864003)(52116002)(36756003)(81156014)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4424;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQDxj2b8cKuGK3QQXuA4T6HBBmB89nIAB5wWOyJ87KqW/ci7BzRYCRW5Fb5uY6ngtj3bGwiJpaVnhXF+dLnVcDBUxgK3ItueFeip84CmXtrSFQ2uwZpbbsvPol78Nu9/ldHy6C0u9WXTxzfWC0Mr7GysNwW0Qf4z8gr69e8fuZ2eEwuaRs5olEBpf15gOd+80fUCbrQ7YqV3EhuoOGImBwwKT26DOR9m/IhnZFUUZz2vz26QKDbZxyRspw9E6BhcL8omXE+WPokc0dSylYAv8Ymk6r6pdk+zbC/+Y50rFOELmfdpUzV9hQwwoo39qv1MBaxcEtvHD0CwWpdyNwPnWNsJd1u5pSGW/PeUEQ2kpPN5WxnQtPtTu3MzHa8TqqAeSC8a9CvTxTB16l+QmRRLxAacZjUXdKbFN4iJ/CkwoSbu5iDGe2oJ7mzDGMucSVTZ93k50gUuD7WyyvoKGYBRE4j2sDp+wzG0bkIGpANiRt/S9n4v71JTKdpztZorDdxROGEv4qigcapIeYyUfX46TVvF/NR7oQpxAZoxco2S9hSs/VB5RtL9+0VC3icUvIFJ
X-MS-Exchange-AntiSpam-MessageData: kzGJnPFrsI4fXRN21lxP6M7iFxaIOJ522I9qwxqVYw6/yBTfj3P/4+etq828+MyoKIJXjz7IAgzLijOhgPRRzvTOOK/piK19JUxfmVnm2EdY6EeQa2BzUIEX4YZ3Qc3xAMKMP1C+1FgeRt///EAADA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f554bb-34bb-4251-a562-08d7b9d24dd9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 09:08:39.8323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFG5NVa1bLzTiLJzJVN7vSiDhE9u5oYrQWGLtwK/hnKQ3OYjz0ZEmshoT6cWgGdr+rAAOmBfnnkS/s5RMhFcdPgMYzE3mPaJzAx5AJiIuJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4424
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.104
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
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.02.2020 11:55, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>=20
>> Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
>> does corresponding changes in code (look for details in
>> include/qapi/error.h)
>>
>> Usage example:
>> spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>   --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>>   blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc]
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Greg Kurz <groug@kaod.org>
>> CC: Stefano Stabellini <sstabellini@kernel.org>
>> CC: Anthony Perard <anthony.perard@citrix.com>
>> CC: Paul Durrant <paul@xen.org>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
>> CC: Laszlo Ersek <lersek@redhat.com>
>> CC: Gerd Hoffmann <kraxel@redhat.com>
>> CC: Stefan Berger <stefanb@linux.ibm.com>
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
>> CC: qemu-block@nongnu.org
>> CC: xen-devel@lists.xenproject.org
>>
>>   include/qapi/error.h                          |   3 +
>>   scripts/coccinelle/auto-propagated-errp.cocci | 158 ++++++++++++++++++
>>   2 files changed, 161 insertions(+)
>>   create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>>
>> diff --git a/include/qapi/error.h b/include/qapi/error.h
>> index b9452d4806..79f8e95214 100644
>> --- a/include/qapi/error.h
>> +++ b/include/qapi/error.h
>> @@ -141,6 +141,9 @@
>>    *         ...
>>    *     }
>>    *
>> + * For mass conversion use script
>> + *   scripts/coccinelle/auto-propagated-errp.cocci
>> + *
>>    *
>>    * Receive and accumulate multiple errors (first one wins):
>>    *     Error *err =3D NULL, *local_err =3D NULL;
>=20
> Extra blank line.
>=20
>> diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/coc=
cinelle/auto-propagated-errp.cocci
>> new file mode 100644
>> index 0000000000..fb03c871cb
>> --- /dev/null
>> +++ b/scripts/coccinelle/auto-propagated-errp.cocci
>> @@ -0,0 +1,158 @@
>> +// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
>> +//
>> +// Copyright (c) 2020 Virtuozzo International GmbH.
>> +//
>> +// This program is free software; you can redistribute it and/or modify
>> +// it under the terms of the GNU General Public License as published by
>> +// the Free Software Foundation; either version 2 of the License, or
>> +// (at your option) any later version.
>> +//
>> +// This program is distributed in the hope that it will be useful,
>> +// but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +// GNU General Public License for more details.
>> +//
>> +// You should have received a copy of the GNU General Public License
>> +// along with this program.  If not, see <http://www.gnu.org/licenses/>=
.
>> +//
>> +// Usage example:
>> +// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>> +//  --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
>> +//  blockdev-nbd.c qemu-nbd.c {block/nbd*,nbd/*,include/block/nbd*}.[hc=
]
>> +
>> +@rule0@
>> +// Add invocation to errp-functions where necessary
>> +// We should skip functions with "Error *const *errp"
>> +// parameter, but how to do it with coccinelle?
>> +// I don't know, so, I skip them by function name regex.
>> +// It's safe: if we did not skip some functions with
>> +// "Error *const *errp", ERRP_AUTO_PROPAGATE invocation
>> +// will fail to compile, because of const violation.
>=20
> Not skipping a function we should skip fails to compile.
>=20
> What about skipping a function we should not skip?

Then it will not be updated.. Not good but I don't have better solution.
Still, I hope, function called *error_append_*_hint will not return error
through errp pointer.

>=20
>> +identifier fn !~ "error_append_.*_hint";
>> +identifier local_err, ERRP;
>=20
> A few of our coccinelle scripts use ALL_CAPS for meta-variables.  Most
> don't.  Either is fine with me.  Mixing the two styles feels a bit
> confusing, though.
>=20
>> +@@
>> +
>> + fn(..., Error **ERRP, ...)
>> + {
>> ++   ERRP_AUTO_PROPAGATE();
>> +    <+...
>> +        when !=3D ERRP_AUTO_PROPAGATE();
>> +(
>> +    error_append_hint(ERRP, ...);
>> +|
>> +    error_prepend(ERRP, ...);
>> +|
>> +    Error *local_err =3D NULL;
>> +)
>> +    ...+>
>> + }
>=20
> Misses error_vprepend().  Currently harmless, but as long as we commit
> the script, we better make it as robust as we reasonably can.
>=20
> The previous patch explains this Coccinelle script's intent:
>=20
>    To achieve these goals, later patches will add invocations
>    of this macro at the start of functions with either use
>    error_prepend/error_append_hint (solving 1) or which use
>    local_err+error_propagate to check errors, switching those
>    functions to use *errp instead (solving 2 and 3).
>=20
> This rule matches "use error_prepend/error_append_hint" directly.  It
> appears to use presence of a local Error * variable as proxy for "use
> local_err+error_propagate to check errors".  Hmm.
>=20
> We obviously have such a variable when we use "local_err+error_propagate
> to check errors".  But we could also have such variables without use of
> error_propagate().  In fact, error.h documents such use:
>=20
>   * Call a function and receive an error from it:
>   *     Error *err =3D NULL;
>   *     foo(arg, &err);
>   *     if (err) {
>   *         handle the error...
>   *     }
>=20
> where "handle the error" frees it.
>=20
> I figure such uses typically occur in functions without an Error **errp
> parameter.  This rule doesn't apply then.  But they could occur even in
> functions with such a parameter.  Consider:
>=20
>      void foo(Error **errp)
>      {
>          Error *err =3D NULL;
>=20
>          bar(&err);
>          if (err) {
>              error_free(err);
>              error_setg(errp, "completely different error");
>          }
>      }
>=20
> Reasonable enough when bar() gives us an error that's misleading in this
> context, isn't it?
>=20
> The script transforms it like this:
>=20
>      void foo(Error **errp)
>      {
>     -    Error *err =3D NULL;
>     +    ERRP_AUTO_PROPAGATE();
>=20
>     -    bar(&err);
>     -    if (err) {
>     -        error_free(err);
>     +    bar(errp);
>     +    if (*errp) {
>     +        error_free_errp(errp);
>              error_setg(errp, "completely different error");
>          }
>      }
>=20
> Unwanted.

What is the problem with it? Updated code just use "new usual notation"
for handling error of sub-calls in function which reports errors through
errp pointer.

>=20
> Now, if this script applied in just a few dozen places, we could rely on
> eyeballing its output to catch unwanted transformations.  Since it
> applies in so many more, I don't feel comfortable relying on reviewer
> eyeballs.
>=20
> Can we make rule0 directly match error_propagate(errp, local_err)
> somehow?

I think it is possible, still I'm not sure we need it.

>=20
> Another observation: the rule does not match error_reportf_err() and
> warn_reportf_err().  These combine error_prepend(),
> error_report()/warn_report() and error_free(), for convenience.  Don't
> their users need ERRP_AUTO_PROPAGATE() just like error_prepend()'s
> users?

Right. These functions want to add information, which will not work
for error_fatal without wrapping.

>=20
>> +
>> +@@
>> +// Switch unusual (Error **) parameter names to errp
>> +// (this is necessary to use ERRP_AUTO_PROPAGATE).
>=20
> Please put your rule comments right before the rule, i.e. before the
> @-line introducing metavariable declarations, not after.  Same
> elsewhere.
>=20
>> +identifier rule0.fn;
>> +identifier rule0.ERRP !=3D errp;
>> +@@
>> +
>> + fn(...,
>> +-   Error **ERRP
>> ++   Error **errp
>> +    ,...)
>> + {
>> +     <...
>> +-    ERRP
>> ++    errp
>> +     ...>
>> + }
>=20
> This normalizes errp parameter naming.  It matches exactly when rule0
> matches (and inserts ERRP_AUTO_PROPAGATE()) and the Error ** parameter
> is unusual.  Good.
>=20
>> +
>> +@rule1@
>> +// We want to patch error propagation in functions regardless of
>> +// whether the function already uses ERRP_AUTO_PROPAGATE prior to
>> +// applying rule0, hence this one does not inherit from it.
>=20
> I'm not sure I get this comment.  Let's see what the rule does.
>=20
>> +identifier fn !~ "error_append_.*_hint";
>> +identifier local_err;
>> +symbol errp;
>> +@@
>> +
>> + fn(..., Error **errp, ...)
>> + {
>> +     <...
>> +-    Error *local_err =3D NULL;
>> +     ...>
>> + }
>=20
> rule1 matches like rule0, except the Error ** parameter match is
> tightened from any C identifier to the C identifier errp, and the
> function body match tightened from "either use
> error_prepend/error_append_hint or which use local_err+error_propagate
> to check errors" to just the latter.
>=20
> I figure tightening the Error ** parameter match has no effect, because
> we already normalized the parameter name.
>=20
> So rule1 deletes variable local_err where rule0 applied.  Correct?

The difference with rule0 is that rule0 contains
  "when !=3D ERRP_AUTO_PROPAGATE()", so rule0 is not applied where
we already have macro invocation.

This is why we can't inherit from rule0.

No we believe that we have ERRP_AUTO_PROPAGATE invocation in all
corresponding places (added by rule0 or before script run) and want to
update all usage of local_err objects.

>=20
>> +
>> +@@
>> +// Handle pattern with goto, otherwise we'll finish up
>> +// with labels at function end which will not compile.
>> +identifier rule1.fn, rule1.local_err;
>> +identifier OUT;
>> +@@
>> +
>> + fn(...)
>> + {
>> +     <...
>> +-    goto OUT;
>> ++    return;
>> +     ...>
>> +- OUT:
>> +-    error_propagate(errp, local_err);
>> + }
>=20
> This is one special case of error_propagate() deletion.  It additionally
> gets rid of a goto we no longer want.  For the general case, see below.
>=20
> The rule applies only where rule1 just deleted the variable.  Thus, the
> two rules work in tandem.  Makes sense.
>=20
>> +
>> +@@
>> +identifier rule1.fn, rule1.local_err;
>=20
> This rule also works in tandem with rule1.
>=20
>> +expression list args; // to reindent error_propagate_prepend
>=20
> What is the comment trying to tell me?

Hmm, we can safely drop it. It's about the following:

instead of

  -    error_propagate_prepend(errp, local_err, args);
  +    error_prepend(errp, args);

we can use "...", like

  - error_propagate_prepend(errp, local_err
  + error_prepend(errp
    , ...);

but with metavar in use, coccinelle will correctly reindent the
whole call, which looks a lot better.

>=20
>> +@@
>> +
>> + fn(...)
>> + {
>> +     <...
>> +(
>> +-    error_free(local_err);
>> +-    local_err =3D NULL;
>> ++    error_free_errp(errp);
>=20
> Reminder:
>=20
>      static inline void error_free_errp(Error **errp)
>      {
>          assert(errp && *errp);
>          error_free(*errp);
>          *errp =3D NULL;
>      }
>=20
> Now let's examine the actual change.
>=20
> The assertion's first half trivially holds, ERRP_AUTO_PROPAGATE()
> ensures it.
>=20
> The second half is new.  We now crash when we haven't set an error.  Why
> is this safe?  Note that error_free(local_err) does nothing when
> !local_err.

Hmm. Looks like we should tighten this restriction, and follow error_free
interface, which allows freeing unset errp.

>=20
> The zapping of the variable pointing to the Error just freed is
> unchanged.
>=20
>> +|
>> +-    error_free(local_err);
>> ++    error_free_errp(errp);
>=20
> Here, the zapping is new.  Zapping dangling pointers is obviously safe.
> Needed, or else the automatic error_propagate() due to
> ERRP_AUTO_PROPAGATE() would propagate the dangling pointer.
>=20
>> +|
>> +-    error_report_err(local_err);
>> ++    error_report_errp(errp);
>=20
> The only difference to the previous case is that we also report the
> error.
>=20
> The previous case has a buddy that additionally matches *errp =3D NULL.
> Why not this one?

Probably because no matches in code. But should be added here for
better case coverage.

>=20
>> +|
>> +-    warn_report_err(local_err);
>> ++    warn_report_errp(errp);
>=20
> Likewise.
>=20
> What about error_reportf_err(), warn_reportf_err()?
>=20
> Up to here, this rule transforms the various forms of error_free().
> Next: error_propagate().
>=20
>> +|
>> +-    error_propagate_prepend(errp, local_err, args);
>> ++    error_prepend(errp, args);
>> +|
>> +-    error_propagate(errp, local_err);
>=20
> rule0's adding of ERRP_AUTO_PROPAGATE() made error_propagate()
> redundant.
>=20
> This is the general case of error_propagate() deletion.
>=20
> I'd put the plain error_propagate() first, variations second, like you
> do with error_free().
>=20
> If neither of these two patterns match on a path from
> ERRP_AUTO_PROPAGATE() to return, we effectively insert error_propagate()
> where it wasn't before.  Does nothing when the local error is null
> there.  Bug fix when it isn't: it's at least a memory leak, and quite
> possibly worse.

Hmm. How can it be memory leak after any of error_free variants?

>=20
> Identifying these bug fixes would be nice, but I don't have practical
> ideas on how to do that.
>=20
> Can we explain this in the commit message?
>=20
>> +)
>> +     ...>
>> + }
>> +
>> +@@
>> +identifier rule1.fn, rule1.local_err;
>> +@@
>> +
>> + fn(...)
>> + {
>> +     <...
>> +(
>> +-    &local_err
>> ++    errp
>> +|
>> +-    local_err
>> ++    *errp
>> +)
>> +     ...>
>> + }
>=20
> Also in tandem with rule1, fixes up uses of local_err.  Good.
>=20
>> +
>> +@@
>> +identifier rule1.fn;
>> +@@
>> +
>> + fn(...)
>> + {
>> +     <...
>> +- *errp !=3D NULL
>> ++ *errp
>> +     ...>
>> + }
>=20
> Still in tandem with rule1, normalizes style.  Good.
>=20


--=20
Best regards,
Vladimir

