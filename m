Received: from eggs.gnu.org ([209.51.188.92]:57954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDRaE-0006S8-Er
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDRaD-0007Xl-01
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:32:58 -0400
References: <20190408084056.26212-1-ghorges@xiyoulinux.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <351ee1e0-578e-3c7f-b0c1-a5617a1ef4a6@redhat.com>
Date: Mon, 8 Apr 2019 12:32:48 +0200
MIME-Version: 1.0
In-Reply-To: <20190408084056.26212-1-ghorges@xiyoulinux.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Wshadow in qemu/linux-user/syscall.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ghorges <ghorges@xiyoulinux.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Riku Voipio <riku.voipio@iki.fi>


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
