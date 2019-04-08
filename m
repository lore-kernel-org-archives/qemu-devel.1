Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595EDC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3DE20870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3DE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDRb3-0006k5-D7
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 06:33:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDRaE-0006S8-Er
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDRaD-0007Xl-01
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:32:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hDRa9-0007VR-Hb; Mon, 08 Apr 2019 06:32:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 605AE461CD;
	Mon,  8 Apr 2019 10:32:52 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-50.ams2.redhat.com [10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3200C5D719;
	Mon,  8 Apr 2019 10:32:49 +0000 (UTC)
To: ghorges <ghorges@xiyoulinux.org>, qemu-devel@nongnu.org,
	qemu-block@nongnu.org
References: <20190408084056.26212-1-ghorges@xiyoulinux.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <351ee1e0-578e-3c7f-b0c1-a5617a1ef4a6@redhat.com>
Date: Mon, 8 Apr 2019 12:32:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408084056.26212-1-ghorges@xiyoulinux.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 08 Apr 2019 10:32:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Wshadow in qemu/linux-user/syscall.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408103248.msY_dTErE1XneDLq5ewH9ZzWLhmunFMSpbFpJkMweAk@z>


 Hi,

thanks for your patch! But please add a short patch description (beside
the subject), e.g. "Change the name of some variables so that the code
can be compiled with -Wshadow, too".

And you've got to put a "Signed-off-by" line at the end of the patch
description, too. See this URL for details:

https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a=
_Signed-off-by:_line

For future patches to files in the linux-user directory, please also CC:
the maintainers of this subsystem (i.e. Ruku Voipio and Laurent Vivier,
see MAINTAINERS file).

 Thanks,
  Thomas


On 08/04/2019 10.40, ghorges wrote:
> ---
>  linux-user/syscall.c | 66 ++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 208fd1813d..985095e4d5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8240,7 +8240,7 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
>                  size_t size;
>              } sig, *sig_ptr;
> =20
> -            abi_ulong arg_sigset, arg_sigsize, *arg7;
> +            abi_ulong arg_sigset, arg_sigsize, *arg7s;
>              target_sigset_t *target_sigset;
> =20
>              n =3D arg1;
> @@ -8280,13 +8280,13 @@ static abi_long do_syscall1(void *cpu_env, int =
num, abi_long arg1,
>                  sig_ptr =3D &sig;
>                  sig.size =3D SIGSET_T_SIZE;
> =20
> -                arg7 =3D lock_user(VERIFY_READ, arg6, sizeof(*arg7) * =
2, 1);
> -                if (!arg7) {
> +                arg7s =3D lock_user(VERIFY_READ, arg6, sizeof(*arg7s) =
* 2, 1);
> +                if (!arg7s) {
>                      return -TARGET_EFAULT;
>                  }
> -                arg_sigset =3D tswapal(arg7[0]);
> -                arg_sigsize =3D tswapal(arg7[1]);
> -                unlock_user(arg7, arg6, 0);
> +                arg_sigset =3D tswapal(arg7s[0]);
> +                arg_sigsize =3D tswapal(arg7s[1]);
> +                unlock_user(arg7s, arg6, 0);
> =20
>                  if (arg_sigset) {
>                      sig.set =3D &set;
> @@ -9479,14 +9479,14 @@ static abi_long do_syscall1(void *cpu_env, int =
num, abi_long arg1,
>          }
>      case TARGET_NR_getcpu:
>          {
> -            unsigned cpu, node;
> -            ret =3D get_errno(sys_getcpu(arg1 ? &cpu : NULL,
> +            unsigned cpus, node;
> +            ret =3D get_errno(sys_getcpu(arg1 ? &cpus : NULL,
>                                         arg2 ? &node : NULL,
>                                         NULL));
>              if (is_error(ret)) {
>                  return ret;
>              }
> -            if (arg1 && put_user_u32(cpu, arg1)) {
> +            if (arg1 && put_user_u32(cpus, arg1)) {
>                  return -TARGET_EFAULT;
>              }
>              if (arg2 && put_user_u32(node, arg2)) {
> @@ -10649,24 +10649,24 @@ static abi_long do_syscall1(void *cpu_env, in=
t num, abi_long arg1,
>      case TARGET_NR_listxattr:
>      case TARGET_NR_llistxattr:
>      {
> -        void *p, *b =3D 0;
> +        void *q, *b =3D 0;
>          if (arg2) {
>              b =3D lock_user(VERIFY_WRITE, arg2, arg3, 0);
>              if (!b) {
>                  return -TARGET_EFAULT;
>              }
>          }
> -        p =3D lock_user_string(arg1);
> -        if (p) {
> +        q =3D lock_user_string(arg1);
> +        if (q) {
>              if (num =3D=3D TARGET_NR_listxattr) {
> -                ret =3D get_errno(listxattr(p, b, arg3));
> +                ret =3D get_errno(listxattr(q, b, arg3));
>              } else {
> -                ret =3D get_errno(llistxattr(p, b, arg3));
> +                ret =3D get_errno(llistxattr(q, b, arg3));
>              }
>          } else {
>              ret =3D -TARGET_EFAULT;
>          }
> -        unlock_user(p, arg1, 0);
> +        unlock_user(q, arg1, 0);
>          unlock_user(b, arg2, arg3);
>          return ret;
>      }
> @@ -10686,25 +10686,25 @@ static abi_long do_syscall1(void *cpu_env, in=
t num, abi_long arg1,
>      case TARGET_NR_setxattr:
>      case TARGET_NR_lsetxattr:
>          {
> -            void *p, *n, *v =3D 0;
> +            void *q, *n, *v =3D 0;
>              if (arg3) {
>                  v =3D lock_user(VERIFY_READ, arg3, arg4, 1);
>                  if (!v) {
>                      return -TARGET_EFAULT;
>                  }
>              }
> -            p =3D lock_user_string(arg1);
> +            q =3D lock_user_string(arg1);
>              n =3D lock_user_string(arg2);
> -            if (p && n) {
> +            if (q && n) {
>                  if (num =3D=3D TARGET_NR_setxattr) {
> -                    ret =3D get_errno(setxattr(p, n, v, arg4, arg5));
> +                    ret =3D get_errno(setxattr(q, n, v, arg4, arg5));
>                  } else {
> -                    ret =3D get_errno(lsetxattr(p, n, v, arg4, arg5));
> +                    ret =3D get_errno(lsetxattr(q, n, v, arg4, arg5));
>                  }
>              } else {
>                  ret =3D -TARGET_EFAULT;
>              }
> -            unlock_user(p, arg1, 0);
> +            unlock_user(q, arg1, 0);
>              unlock_user(n, arg2, 0);
>              unlock_user(v, arg3, 0);
>          }
> @@ -10731,25 +10731,25 @@ static abi_long do_syscall1(void *cpu_env, in=
t num, abi_long arg1,
>      case TARGET_NR_getxattr:
>      case TARGET_NR_lgetxattr:
>          {
> -            void *p, *n, *v =3D 0;
> +            void *q, *n, *v =3D 0;
>              if (arg3) {
>                  v =3D lock_user(VERIFY_WRITE, arg3, arg4, 0);
>                  if (!v) {
>                      return -TARGET_EFAULT;
>                  }
>              }
> -            p =3D lock_user_string(arg1);
> +            q =3D lock_user_string(arg1);
>              n =3D lock_user_string(arg2);
> -            if (p && n) {
> +            if (q && n) {
>                  if (num =3D=3D TARGET_NR_getxattr) {
> -                    ret =3D get_errno(getxattr(p, n, v, arg4));
> +                    ret =3D get_errno(getxattr(q, n, v, arg4));
>                  } else {
> -                    ret =3D get_errno(lgetxattr(p, n, v, arg4));
> +                    ret =3D get_errno(lgetxattr(q, n, v, arg4));
>                  }
>              } else {
>                  ret =3D -TARGET_EFAULT;
>              }
> -            unlock_user(p, arg1, 0);
> +            unlock_user(q, arg1, 0);
>              unlock_user(n, arg2, 0);
>              unlock_user(v, arg3, arg4);
>          }
> @@ -10776,19 +10776,19 @@ static abi_long do_syscall1(void *cpu_env, in=
t num, abi_long arg1,
>      case TARGET_NR_removexattr:
>      case TARGET_NR_lremovexattr:
>          {
> -            void *p, *n;
> -            p =3D lock_user_string(arg1);
> +            void *q, *n;
> +            q =3D lock_user_string(arg1);
>              n =3D lock_user_string(arg2);
> -            if (p && n) {
> +            if (q && n) {
>                  if (num =3D=3D TARGET_NR_removexattr) {
> -                    ret =3D get_errno(removexattr(p, n));
> +                    ret =3D get_errno(removexattr(q, n));
>                  } else {
> -                    ret =3D get_errno(lremovexattr(p, n));
> +                    ret =3D get_errno(lremovexattr(q, n));
>                  }
>              } else {
>                  ret =3D -TARGET_EFAULT;
>              }
> -            unlock_user(p, arg1, 0);
> +            unlock_user(q, arg1, 0);
>              unlock_user(n, arg2, 0);
>          }
>          return ret;
>=20


