Received: from eggs.gnu.org ([2001:4830:134:3::10]:41563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gNEFv-0003OR-6k
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gNEFq-00086z-7T
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:48:11 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gNEFp-00084V-GC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:48:05 -0500
Received: by mail-wr1-x441.google.com with SMTP id j10so6232862wru.4
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 01:48:05 -0800 (PST)
References: <1542261954-4060-1-git-send-email-liq3ea@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1542261954-4060-1-git-send-email-liq3ea@gmail.com>
Date: Thu, 15 Nov 2018 09:48:02 +0000
Message-ID: <87muqad63x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target: hax: replace g_malloc with
 g_malloc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, laurent@vivier.eu, qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>


Li Qiang <liq3ea@gmail.com> writes:

> And also the g_malloc doesn't need check return value,
> remove it.
>
> Cc: qemu-trivial@nongnu.org
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/i386/hax-all.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index d2e512856b..a460c605af 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -154,13 +154,7 @@ int hax_vcpu_create(int id)
>          return 0;
>      }
>
> -    vcpu =3D g_malloc(sizeof(struct hax_vcpu_state));
> -    if (!vcpu) {
> -        fprintf(stderr, "Failed to alloc vcpu state\n");
> -        return -ENOMEM;
> -    }
> -
> -    memset(vcpu, 0, sizeof(struct hax_vcpu_state));
> +    vcpu =3D g_malloc0(sizeof(struct hax_vcpu_state));
>
>      ret =3D hax_host_create_vcpu(hax_global.vm->fd, id);
>      if (ret) {
> @@ -250,11 +244,8 @@ struct hax_vm *hax_vm_create(struct hax_state *hax)
>          return hax->vm;
>      }
>
> -    vm =3D g_malloc(sizeof(struct hax_vm));
> -    if (!vm) {
> -        return NULL;
> -    }
> -    memset(vm, 0, sizeof(struct hax_vm));
> +    vm =3D g_malloc0(sizeof(struct hax_vm));
> +
>      ret =3D hax_host_create_vm(hax, &vm_id);
>      if (ret) {
>          fprintf(stderr, "Failed to create vm %x\n", ret);


--
Alex Benn=C3=A9e
