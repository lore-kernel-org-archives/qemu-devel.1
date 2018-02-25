Received: from eggs.gnu.org ([2001:4830:134:3::10]:37437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eppMO-00051T-MS
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 01:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eppMJ-0002jn-Ox
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 01:00:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57612 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eppMJ-0002gB-Eu
	for qemu-devel@nongnu.org; Sun, 25 Feb 2018 01:00:27 -0500
Date: Sun, 25 Feb 2018 14:00:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180225060014.GA18756@lemon.usersys.redhat.com>
References: <20180215172306.10389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180215172306.10389-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: dump 'config.log' if ./configure
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

On Thu, 02/15 14:23, Philippe Mathieu-Daud=E9 wrote:
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/common.rc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 7951555e3f..dd011cdf1e 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -30,7 +30,9 @@ build_qemu()
>                   $@"
>      echo "Configure options:"
>      echo $config_opts
> -    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
> +    $QEMU_SRC/configure $config_opts || \
> +        (cat config.log && prep_fail "Failed to run 'configure'")
> +    make $MAKEFLAGS

If the configure failure is due to "this" patch, which it likely is, then
prep_fail is wrong. We want test_fail instead.

Fam
