Received: from eggs.gnu.org ([2001:4830:134:3::10]:49495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsmvs-0007Dx-0A
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsmvp-0005w0-85
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:33:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fsmvp-0005vq-2z
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:33:37 -0400
Date: Thu, 23 Aug 2018 12:33:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180823123333.7f1d8dc8.cohuck@redhat.com>
In-Reply-To: <20180823102502.28122-1-berrange@redhat.com>
References: <20180823102502.28122-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: report on author emails that are
 mangled by the mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Thu, 23 Aug 2018 11:25:02 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> In some cases the Author: email address in patches submitted to the
> list gets mangled such that it says
>=20
>     John Doe via Qemu-devel <qemu-devel@nongnu.org>
>=20
> This change is a result of workarounds for DMARC policies.
>=20
> Subsystem maintainers accepting patches need to catch these and fix
> them before sending pull requests, so a checkpatch.pl test is highly
> desirable.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  scripts/checkpatch.pl | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 42e1c50dd8..be2114a179 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1402,6 +1402,10 @@ sub process {
>  			$is_patch =3D 1;
>  		}
> =20
> +		if ($line =3D~ /^Author: .*via Qemu-devel.*<qemu-devel\@nongnu.org>/) {
> +		    ERROR("Author email address is mangled by the mailing list\n" . $h=
erecurr);
> +		}
> +
>  #check the patch for a signoff:
>  		if ($line =3D~ /^\s*signed-off-by:/i) {
>  			# This is a signoff, if ugly, so do not double report.

Acked-by: Cornelia Huck <cohuck@redhat.com>
