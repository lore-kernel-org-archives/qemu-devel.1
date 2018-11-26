Received: from eggs.gnu.org ([2001:4830:134:3::10]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRF2f-0003qI-Ob
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRF2d-0003Na-5B
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:27:05 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gRF2c-0003N3-Uz
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:27:03 -0500
Received: by mail-wm1-x343.google.com with SMTP id 125so17903855wmh.0
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 03:27:02 -0800 (PST)
References: <1543226179-5135-1-git-send-email-liq3ea@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1543226179-5135-1-git-send-email-liq3ea@gmail.com>
Date: Mon, 26 Nov 2018 11:27:00 +0000
Message-ID: <87pnus3wqj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target: hax: replace g_malloc with g_new0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, laurent@vivier.eu, philmd@redhat.com, armbru@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org


Li Qiang <liq3ea@gmail.com> writes:

> And also the g_malloc doesn't need check return value,
> remove it.
>
> Cc: qemu-trivial@nongnu.org
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/i386/hax-all.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index d2e512856b..502ce6f0af 100644
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
> +    vcpu =3D g_new0(struct hax_vcpu_state, 1);
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
> +    vm =3D g_new0(struct hax_vm, 1);
> +
>      ret =3D hax_host_create_vm(hax, &vm_id);
>      if (ret) {
>          fprintf(stderr, "Failed to create vm %x\n", ret);


--
Alex Benn=C3=A9e
