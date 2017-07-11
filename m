Received: from eggs.gnu.org ([2001:4830:134:3::10]:35245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUuZd-000876-Oo
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUuZd-0006yJ-4d
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:47:29 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUuZc-0006y3-UR
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:47:29 -0400
Received: by mail-wr0-x232.google.com with SMTP id c11so182150686wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 05:47:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711100049.20513-1-pbonzini@redhat.com>
References: <20170711100049.20513-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 13:47:07 +0100
Message-ID: <CAFEAcA-7zJB80wQwCA=Quo+udV3fMx5J9NfC0cS9eDr35OpVVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] build: disable Xen on ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>

On 11 July 2017 at 11:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
> While ARM could present the xenpv machine, it does not and trying to enab=
le
> it breaks compilation.  Revert to the previous test which only looked at
> $target_name, not $cpu.
>
> Fixes: 3b6b75506de44c5070639943c30a0ad5850f5d02
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/configure b/configure
> index 806658c98b..5096cbcf14 100755
> --- a/configure
> +++ b/configure
> @@ -202,9 +202,9 @@ supported_kvm_target() {
>  supported_xen_target() {
>      test "$xen" =3D "yes" || return 1
>      glob "$1" "*-softmmu" || return 1
> -    case "${1%-softmmu}:$cpu" in
> -        arm:arm | aarch64:aarch64 | \
> -        i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
> +    # Only i386 and x86_64 provide the xenpv machine.
> +    case "${1%-softmmu}" in
> +        i386|x86_64)
>              return 0
>          ;;
>      esac

Thanks, applied to master as a build fix.

-- PMM
