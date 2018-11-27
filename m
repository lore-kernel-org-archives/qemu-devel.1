Received: from eggs.gnu.org ([2001:4830:134:3::10]:46363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXm5-0000XB-5p
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:27:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXm1-00017E-8q
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:27:13 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-26-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5fedf421-a138-041a-638b-98f3fd3ffeef@redhat.com>
Date: Tue, 27 Nov 2018 08:26:53 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-26-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 25/25] MAINTAINERS: Remove
 duplicate entries of qemu-devel@nongnu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2018-11-25 21:50, Philippe Mathieu-Daud=C3=A9 wrote:
> The list is always selected by the 'All patches CC here' section.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 13 -------------
>  1 file changed, 13 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c616861ca3..9d6dae71ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -109,7 +109,6 @@ L: qemu-s390x@nongnu.org
>  Guest CPU cores (TCG):
>  ----------------------
>  Overall
> -L: qemu-devel@nongnu.org
>  M: Peter Crosthwaite <crosthwaite.peter@gmail.com>
>  M: Richard Henderson <rth@twiddle.net>
>  R: Paolo Bonzini <pbonzini@redhat.com>
> @@ -403,30 +402,25 @@ Hosts:
>  ------
> =20
>  LINUX
> -L: qemu-devel@nongnu.org
>  S: Maintained
>  F: linux-*
>  F: linux-headers/
> =20
>  POSIX
> -L: qemu-devel@nongnu.org
>  S: Maintained
>  F: *posix*

I agree that we can remove the "L: qemu-devel" entries everywhere, but
for these subsystems that have no "M:" entry, but "S: Maintained", this
now looks somewhat strange - the subsystem is "Maintained" but has no
maintainer? I think we need somebody who feels responsible to pick up
patches here...?

 Thomas
