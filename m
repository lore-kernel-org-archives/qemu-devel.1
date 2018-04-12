Received: from eggs.gnu.org ([2001:4830:134:3::10]:37276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6XHV-0005FQ-3f
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:08:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6XHR-0004WN-Si
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:08:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f6XHR-0004VW-Mv
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:08:29 -0400
Date: Thu, 12 Apr 2018 16:08:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180412080826.GC24896@lemon.usersys.redhat.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-8-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180410193919.28026-8-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 07/24] docker: allow "cc" command to run
 in user context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, cota@braap.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, 04/10 20:39, Alex Benn=E9e wrote:
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  tests/docker/docker.py | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 9444f4bea4..f79213044d 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -399,6 +399,8 @@ class CcCommand(SubCommand):
>                              help=3D"The docker image in which to run c=
c")
>          parser.add_argument("--cc",
>                              help=3D"The compiler executable to call")
> +        parser.add_argument("--user",
> +                            help=3D"The user-id to run under")
>          parser.add_argument("--source-path", "-s", nargs=3D"*", dest=3D=
"paths",
>                              help=3D"""Extra paths to (ro) mount into c=
ontainer for
>                              reading sources""")
> @@ -414,6 +416,9 @@ class CcCommand(SubCommand):
>              for p in args.paths:
>                  cmd +=3D ["-v", "%s:%s:ro,z" % (p, p)]
> =20
> +        if args.user:
> +            cmd +=3D ["-u", args.user]
> +
>          cmd +=3D [args.image]
> =20
>          # The compile command we are running
> --=20
> 2.16.2
>=20

Reviewed-by: Fam Zheng <famz@redhat.com>
