Received: from eggs.gnu.org ([209.51.188.92]:58234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFyBZ-0001kk-BA
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFyBY-0001hH-9r
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:45:57 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:34990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hFyBX-0001gS-Vj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:45:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id y197so7703552wmd.0
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 02:45:55 -0700 (PDT)
Date: Mon, 15 Apr 2019 10:45:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190415094552.GC29134@stefanha-x1.localdomain>
References: <20190412152652.827-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <20190412152652.827-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hmp: gva2gpa debug command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 04:26:52PM +0100, Dr. David Alan Gilbert (git) wrote:
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index d3bad2fc27..ba4690b9ac 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -585,6 +585,21 @@ STEXI
>  @findex gpa2hpa
>  Print the host physical address at which the guest's physical address @var{addr}
>  is mapped.
> +ETEXI
> +
> +    {
> +        .name       = "gva2gpa",
> +        .args_type  = "addr:l",
> +        .params     = "addr",
> +        .help       = "print the guest physical address corresponding to a guest virtual address",
> +        .cmd        = hmp_gva2gpa,
> +    },
> +
> +STEXI
> +@item gpa2hpa @var{addr}
> +@findex gpa2hpa

s/gpa2hpa/gva2gpa/

Aside from this:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJctFLQAAoJEJykq7OBq3PIAx4H/2Jqy65fbr9jEnv2uddXwZ2k
b4oveNjiw6XfLmH+K/NllFbHCj76EpxYQv6jDZ7otKUTeOxJzRi4zN8UtBhVY1Hb
2qh3bsyenANAeCnJUNUZAKHmohYGFHMMBQh1EAHXecQLkNTVLdaJWn8OIri/kD2+
Ewy+DCs03WBN16DZV/BDnP0XWtjs3xN/Buohi19ULioXT6kNcudum2gOdRcFZL32
NXa5f7QThgrnZmkXoSDPUlQqwEupdv2nAVhImQ0J5GOkvOwa+gBCR2NVBGJ+EgnL
EZyfDmohXRwrcyyXTCFQwheBWTQR+7N/kjz3xs8Fu+YoTKg2OayNa3MAowAMReE=
=Ad1y
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
