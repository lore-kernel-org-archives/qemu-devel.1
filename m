Received: from eggs.gnu.org ([2001:4830:134:3::10]:41455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSrt-0002gy-4f
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSrp-0003VF-6x
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:23:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDSro-0003UA-6p
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:22:56 -0400
Date: Fri, 19 Oct 2018 12:22:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019112250.GA19474@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180823102502.28122-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823102502.28122-1-berrange@redhat.com>
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
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

Copying Paolo, since this probably falls under the "misc patches"
maintainer bucket.

On Thu, Aug 23, 2018 at 11:25:02AM +0100, Daniel P. Berrang=C3=A9 wrote:
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
> +		if ($line =3D~ /^Author: .*via Qemu-devel.*<qemu-devel\@nongnu.org>/=
) {
> +		    ERROR("Author email address is mangled by the mailing list\n" . =
$herecurr);
> +		}
> +
>  #check the patch for a signoff:
>  		if ($line =3D~ /^\s*signed-off-by:/i) {
>  			# This is a signoff, if ugly, so do not double report.
> --=20
> 2.17.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
