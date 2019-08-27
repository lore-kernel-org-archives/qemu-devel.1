Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25A9C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C894F20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 09:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C894F20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2XYi-0008JW-0g
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 05:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1i2XXm-0007VV-VM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1i2XXl-0006uo-K4
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:13:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2189 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1i2XXl-0006rA-96
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 05:13:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 10C4CC48D94F9F2AE002;
 Tue, 27 Aug 2019 17:13:29 +0800 (CST)
Received: from [127.0.0.1] (10.133.205.53) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 17:13:21 +0800
To: Li Qiang <liq3ea@gmail.com>
References: <20190827080512.2417-1-fangying1@huawei.com>
 <CAKXe6SK1pZRdrigiEO1-7eONEKnfXSzhtz-EC43uWhndxFJERg@mail.gmail.com>
From: fangying <fangying1@huawei.com>
Message-ID: <f7bc839e-0e27-80b4-69a2-11e2cddd806a@huawei.com>
Date: Tue, 27 Aug 2019 17:13:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SK1pZRdrigiEO1-7eONEKnfXSzhtz-EC43uWhndxFJERg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: Re: [Qemu-devel] [PATCH] qmp: Fix memory leak in
 migrate_params_test_apply
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 zhouyibo3@huawei.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 lcf.lichaofeng@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/8/27 16:38, Li Qiang wrote:
>=20
>=20
> Ying Fang <fangying1@huawei.com <mailto:fangying1@huawei.com>> =E4=BA=8E=
2019=E5=B9=B48=E6=9C=8827=E6=97=A5=E5=91=A8=20
> =E4=BA=8C =E4=B8=8B=E5=8D=884:06=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     Address Sanitizer shows memory leak in migrate_params_test_apply
>     migration/migration.c:1253 and the stack is as bellow:
>=20
>     Direct leak of 45 byte(s) in 9 object(s) allocated from:
>      =C2=A0 =C2=A0 #0 0xffffbd7fc1db in __interceptor_malloc (/lib64/li=
basan.so.4+0xd31db)
>      =C2=A0 =C2=A0 #1 0xffffbd514163 in g_malloc (/lib64/libglib-2.0.so=
.0+0x57163)
>      =C2=A0 =C2=A0 #2 0xffffbd52f43b in g_strdup (/lib64/libglib-2.0.so=
.0+0x7243b)
>      =C2=A0 =C2=A0 #3 0xaaaadfa4d623 in migrate_params_test_apply migra=
tion/migration.c:1253
>      =C2=A0 =C2=A0 #4 0xaaaadfa4d623 in qmp_migrate_set_parameters migr=
ation/migration.c:1422
>      =C2=A0 =C2=A0 #5 0xaaaadfa963f3 in hmp_migrate_set_parameter monit=
or/hmp-cmds.c:1867
>      =C2=A0 =C2=A0 #6 0xaaaadfa8afe3 in handle_hmp_command monitor/hmp.=
c:1082
>      =C2=A0 =C2=A0 #7 0xaaaadf479c57 in qmp_human_monitor_command monit=
or/misc.c:140
>      =C2=A0 =C2=A0 #8 0xaaaadfadf87b in qmp_marshal_human_monitor_comma=
nd
>     qapi/qapi-commands-misc.c:1024
>      =C2=A0 =C2=A0 #9 0xaaaadfc7797b in do_qmp_dispatch qapi/qmp-dispat=
ch.c:131
>      =C2=A0 =C2=A0 #10 0xaaaadfc7797b in qmp_dispatch qapi/qmp-dispatch=
.c:174
>      =C2=A0 =C2=A0 #11 0xaaaadfa84fff in monitor_qmp_dispatch monitor/q=
mp.c:120
>      =C2=A0 =C2=A0 #12 0xaaaadfa85bbf in monitor_qmp_bh_dispatcher moni=
tor/qmp.c:209
>      =C2=A0 =C2=A0 #13 0xaaaadfd2228f in aio_bh_call util/async.c:89
>      =C2=A0 =C2=A0 #14 0xaaaadfd2228f in aio_bh_poll util/async.c:117
>      =C2=A0 =C2=A0 #15 0xaaaadfd29bc3 in aio_dispatch util/aio-posix.c:=
459
>      =C2=A0 =C2=A0 #16 0xaaaadfd21ff7 in aio_ctx_dispatch util/async.c:=
260
>      =C2=A0 =C2=A0 #17 0xffffbd50e2f7 in g_main_context_dispatch
>     (/lib64/libglib-2.0.so.0+0x512f7)
>      =C2=A0 =C2=A0 #18 0xaaaadfd278d7 in glib_pollfds_poll util/main-lo=
op.c:218
>      =C2=A0 =C2=A0 #19 0xaaaadfd278d7 in os_host_main_loop_wait util/ma=
in-loop.c:241
>      =C2=A0 =C2=A0 #20 0xaaaadfd278d7 in main_loop_wait util/main-loop.=
c:517
>      =C2=A0 =C2=A0 #21 0xaaaadf67b5e7 in main_loop vl.c:1806
>      =C2=A0 =C2=A0 #22 0xaaaadf15d453 in main vl.c:4488
>=20
>     Cc: zhanghailiang <zhang.zhanghailiang@huawei.com
>     <mailto:zhang.zhanghailiang@huawei.com>>
>     Signed-off-by: Ying Fang <fangying1@huawei.com <mailto:fangying1@hu=
awei.com>>
>     ---
>      =C2=A0migration/migration.c | 6 ++++++
>      =C2=A01 file changed, 6 insertions(+)
>=20
>     diff --git a/migration/migration.c b/migration/migration.c
>     index 8b9f2fe30a..05e44ff7cc 100644
>     --- a/migration/migration.c
>     +++ b/migration/migration.c
>     @@ -1250,11 +1250,17 @@ static void
>     migrate_params_test_apply(MigrateSetParameters *params,
>=20
>      =C2=A0 =C2=A0 =C2=A0if (params->has_tls_creds) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(params->tls_creds->type =3D=
=3D QTYPE_QSTRING);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dest->tls_creds) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(dest->tls_creds);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=20
>=20
> g_free can handle NULL, no need to do the NULL check.

Thanks for your remind, we can call g_free here directly.
I'll send a v2 later.
>=20
> Thanks,
> Li Qiang
>=20
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest->tls_creds =3D g_strdup(par=
ams->tls_creds->u.s);
>      =C2=A0 =C2=A0 =C2=A0}
>=20
>      =C2=A0 =C2=A0 =C2=A0if (params->has_tls_hostname) {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(params->tls_hostname->typ=
e =3D=3D QTYPE_QSTRING);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dest->tls_hostname) {
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(dest->tls_hostnam=
e);
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dest->tls_hostname =3D g_strdup(=
params->tls_hostname->u.s);
>      =C2=A0 =C2=A0 =C2=A0}
>=20
>     --=20
>     2.19.1
>=20
>=20
>=20


