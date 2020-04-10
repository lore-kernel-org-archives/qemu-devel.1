Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA835C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3BE20769
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 12:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcgrcANl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3BE20769
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMt6N-0005Qg-HP
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 08:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMt4l-0004TW-Tp
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMt4i-000226-N3
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:48:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60535
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMt4i-00021u-E6
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 08:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586522879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQwvTXVdeT+wA3hWyxF2D9gGSoRyOMPvYJM6ihYd5F0=;
 b=QcgrcANleX5AN+y3bnwi9pqGyqzHLD2cfx2qGH8fm4GyHPMTFKuo2Z/mZpJ5+7381OSoJx
 MBK5m9YUF7dMUlqmFeKnIXNKO35VQQ/Lrqt6p1dwr1DkMAEfgVkroWdcHgzEm1dRuUWSy7
 LRfiwMTy7ycej+I+yfhv9aZnx+wqc84=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-egH03nDiNBCcIt1bqdnICA-1; Fri, 10 Apr 2020 08:47:57 -0400
X-MC-Unique: egH03nDiNBCcIt1bqdnICA-1
Received: by mail-ed1-f70.google.com with SMTP id j10so1976976edy.21
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 05:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d/N45zHh77IenfeQlezGu1v/vC93S9fhrbshmE+v2j8=;
 b=PsTw8M8RwGLGv8YUKd5o6X8Afz25cY+4CeeGaJaoyaI1+HR1ko8wkG1O3OYLOAm3ek
 09IduOUHgztYsC+PSO3WV29rJqyHZswElLJUAxvvfXyKPsIapNXwwhkLCTG6n/t4fGji
 R6Kq+H6/vPFYi5HI67pmFldOQzs1B4CBWeD3FcZo7AUX4673CWfBq31LXORwy35USN2l
 eS3/qGhDriaBmlNVJXYpmXDVBYb6i/iJwwJuBQZapS85l97JNw01nfzUU1daRoKNDkOJ
 z/abWVi4E3mnobGFzUNHwr2+qP5RW/Zgxou2bpwxC2eoQM7ZIO146yMaatOOCciWq7xw
 gS6w==
X-Gm-Message-State: AGi0PuaJAR/PIQftGucOWRcw0qnn+yg1yUu4X9wdQmJtmuEJYPq2a5eG
 uX1KVw99nVkCivLVc6RqIuQdhRghc03B4ThoFwn/coHNHe/FIv99Pjug43HLlPM2tvGq3sKqRZY
 oeq5jHELa7dFhw0o=
X-Received: by 2002:aa7:cf07:: with SMTP id a7mr4550204edy.339.1586522876373; 
 Fri, 10 Apr 2020 05:47:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypJckjVzXdeXngFnIdGHl7zYcaRBvihK4nvfpCTjhB6MAupxPCIbp8s/zs2zVHg11WkmFRX7VA==
X-Received: by 2002:aa7:cf07:: with SMTP id a7mr4550194edy.339.1586522876139; 
 Fri, 10 Apr 2020 05:47:56 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id m24sm107641edp.49.2020.04.10.05.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 05:47:55 -0700 (PDT)
Subject: Re: [PATCH v1 10/11] linux-user: fix /proc/self/stat handling
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-11-alex.bennee@linaro.org>
 <88154583-5a03-a89c-f10e-06e6010abf95@redhat.com>
 <CAHDbmO0iF+_TfBH7ZMQD+AYX3=+xS7N_-q-4=sdkEpbYp+tFEQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3bcdc92b-99a1-5819-5c33-f7b63d87b977@redhat.com>
Date: Fri, 10 Apr 2020 14:47:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHDbmO0iF+_TfBH7ZMQD+AYX3=+xS7N_-q-4=sdkEpbYp+tFEQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 Ludovic Courtes <ludovic.courtes@inria.fr>, Riku Voipio <riku.voipio@iki.fi>,
 QEMU Developers <qemu-devel@nongnu.org>, Brice Goglin <Brice.Goglin@inria.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/10/20 2:33 PM, Alex Benn=C3=A9e wrote:
> That was by inspection on my system which seems to truncate a lot=20
> earlier. It would be nice to find where in the Linux kernel it is output=
=20
> but I failed to grep the relevant function last night.

OK. Patch is correct with this value, so:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> On Fri, 10 Apr 2020, 12:11 Philippe Mathieu-Daud=C3=A9, <philmd@redhat.co=
m=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     Cc'ing Ludovic in case he can test with Guix-HPC.
>=20
>     On 4/9/20 11:15 PM, Alex Benn=C3=A9e wrote:
>      > In the original bug report long files names in Guix caused
>      > /proc/self/stat be truncated without the trailing ") " as
>     specified in
>      > proc manpage which says:
>      >=C2=A0 =C2=A0 =C2=A0 (2) comm=C2=A0 %s
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The=C2=A0 filename =
of the executable, in parentheses.=C2=A0 This
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is visible whether =
or not the=C2=A0 executable=C2=A0 is=C2=A0 swapped
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out.
>      >
>      > Additionally it should only be reporting the executable name rathe=
r
>      > than the full path. Fix both these failings while cleaning up the
>     code
>      > to use GString to build up the reported values. As the whole funct=
ion
>      > is cleaned up also adjust the white space to the current coding
>     style.
>      >
>      > Message-ID: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr
>     <mailto:fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>>
>      > Reported-by: Brice Goglin <Brice.Goglin@inria.fr
>     <mailto:Brice.Goglin@inria.fr>>
>      > Cc: Philippe_Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>      > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org
>     <mailto:alex.bennee@linaro.org>>
>      > ---
>      >=C2=A0 =C2=A0linux-user/syscall.c | 43
>     +++++++++++++++++++------------------------
>      >=C2=A0 =C2=A01 file changed, 19 insertions(+), 24 deletions(-)
>      >
>      > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>      > index 6495ddc4cda..674f70e70a5 100644
>      > --- a/linux-user/syscall.c
>      > +++ b/linux-user/syscall.c
>      > @@ -7295,34 +7295,29 @@ static int open_self_stat(void *cpu_env,
>     int fd)
>      >=C2=A0 =C2=A0{
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0CPUState *cpu =3D env_cpu((CPUArchState =
*)cpu_env);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0TaskState *ts =3D cpu->opaque;
>      > -=C2=A0 =C2=A0 abi_ulong start_stack =3D ts->info->start_stack;
>      > +=C2=A0 =C2=A0 g_autoptr(GString) buf =3D g_string_new(NULL);
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < 44; i++) {
>      > -=C2=A0 =C2=A0 =C2=A0 char buf[128];
>      > -=C2=A0 =C2=A0 =C2=A0 int len;
>      > -=C2=A0 =C2=A0 =C2=A0 uint64_t val =3D 0;
>      > -
>      > -=C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* pid */
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D getpid();
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(buf, sizeof(buf), "%"PRId64 =
" ", val);
>      > -=C2=A0 =C2=A0 =C2=A0 } else if (i =3D=3D 1) {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* app name */
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(buf, sizeof(buf), "(%s) ", t=
s->bprm->argv[0]);
>      > -=C2=A0 =C2=A0 =C2=A0 } else if (i =3D=3D 27) {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* stack bottom */
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 val =3D start_stack;
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(buf, sizeof(buf), "%"PRId64 =
" ", val);
>      > -=C2=A0 =C2=A0 =C2=A0 } else {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for the rest, there is MasterCard =
*/
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(buf, sizeof(buf), "0%c", i =
=3D=3D 43 ? '\n' : ' ');
>      > -=C2=A0 =C2=A0 =C2=A0 }
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* pid */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_printf(buf, FM=
T_pid " ", getpid());
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (i =3D=3D 1) {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* app name */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *bin =3D g_strrst=
r(ts->bprm->argv[0], "/");
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bin =3D bin ? bin + 1 :=
 ts->bprm->argv[0];
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_printf(buf, "(=
%.15s) ", bin);
>=20
>     15 or 125? 15 seems short. From your previous test I understood it wa=
s
>     124, for
>     sizeof("cat_with9_123456789012345678901234567890123456789012345678901=
23456789012345678901234567890123456789012345678901234567890___40").
>=20
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (i =3D=3D 27) {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* stack bottom */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_printf(buf, TA=
RGET_ABI_FMT_ld " ",
>     ts->info->start_stack);
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* for the rest, there =
is MasterCard */

Already 23 years =3D)

>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_string_printf(buf, "0=
%c", i =3D=3D 43 ? '\n' : ' ');
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>      >
>      > -=C2=A0 =C2=A0 =C2=A0 len =3D strlen(buf);
>      > -=C2=A0 =C2=A0 =C2=A0 if (write(fd, buf, len) !=3D len) {
>      > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>      > -=C2=A0 =C2=A0 =C2=A0 }
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (write(fd, buf->str, buf->len) !=
=3D buf->len) {
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>      >
>=20


