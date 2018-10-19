Received: from eggs.gnu.org ([2001:4830:134:3::10]:50904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDTHp-0006AF-MR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gDTHh-0001DP-Jn
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gDTHh-00015K-23
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:49:41 -0400
References: <20181019104326.28052-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <01f294bd-30bb-cf62-c0d6-7018e713d78c@redhat.com>
Date: Fri, 19 Oct 2018 13:49:36 +0200
MIME-Version: 1.0
In-Reply-To: <20181019104326.28052-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: set cross_cc_FOO from cc,
 not host_cc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org

On 2018-10-19 12:43, Alex Benn=C3=A9e wrote:
> The purpose of the code is to use the designated compiler for building
> the targets test cases. This is not actually host_cc which will still
> be cc even when we are cross compiling. As the tests for $cpu all use
> $cc we should do the same.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/configure b/configure
> index 9138af37f8..d6605bd633 100755
> --- a/configure
> +++ b/configure
> @@ -717,37 +717,37 @@ case "$cpu" in
>    ppc|ppc64|s390|s390x|sparc64|x32)
>      cpu=3D"$cpu"
>      supported_cpu=3D"yes"
> -    eval "cross_cc_${cpu}=3D\$host_cc"
> +    eval "cross_cc_${cpu}=3D\$cc"
>    ;;
>    i386|i486|i586|i686|i86pc|BePC)
>      cpu=3D"i386"
>      supported_cpu=3D"yes"
> -    cross_cc_i386=3D$host_cc
> +    cross_cc_i386=3D$cc
>    ;;
>    x86_64|amd64)
>      cpu=3D"x86_64"
>      supported_cpu=3D"yes"
> -    cross_cc_x86_64=3D$host_cc
> +    cross_cc_x86_64=3D$cc
>    ;;
>    armv*b|armv*l|arm)
>      cpu=3D"arm"
>      supported_cpu=3D"yes"
> -    cross_cc_arm=3D$host_cc
> +    cross_cc_arm=3D$cc
>    ;;
>    aarch64)
>      cpu=3D"aarch64"
>      supported_cpu=3D"yes"
> -    cross_cc_aarch64=3D$host_cc
> +    cross_cc_aarch64=3D$cc
>    ;;
>    mips*)
>      cpu=3D"mips"
>      supported_cpu=3D"yes"
> -    cross_cc_mips=3D$host_cc
> +    cross_cc_mips=3D$cc
>    ;;
>    sparc|sun4[cdmuv])
>      cpu=3D"sparc"
>      supported_cpu=3D"yes"
> -    cross_cc_sparc=3D$host_cc
> +    cross_cc_sparc=3D$cc
>    ;;
>    *)
>      # This will result in either an error or falling back to TCI later
>=20

Sounds like the right thing to do.

Reviewed-by: Thomas Huth <thuth@redhat.com>
