Received: from eggs.gnu.org ([2001:4830:134:3::10]:40603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWmKD-0004Yw-Jv
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:00:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gWmK9-0003MO-Pf
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:00:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gWmK8-0003DU-DT
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:00:01 -0500
Date: Tue, 11 Dec 2018 17:59:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181211175950.GS921@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181211174253.10947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211174253.10947-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, maxim.kuvyrkov@linaro.org

On Tue, Dec 11, 2018 at 05:42:53PM +0000, Alex Benn=C3=A9e wrote:
> This is a QEMU specific version of a gitdm config for generating
> reports on the contributor base of the project. I've added enough
> group maps and domain aliases to ensure the current top ten is as
> reflective as it can be. As of this commit running:


> diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
> new file mode 100644
> index 0000000000..234e616f37
> --- /dev/null
> +++ b/contrib/gitdm/domain-map
> @@ -0,0 +1,15 @@
> +#
> +# QEMU gitdm domain-map
> +#
> +# This maps email domains to nice easy to read company names
> +#
> +
> +ibm.com         IBM
> +igalia.com      Igalia
> +ispras.ru       Institute for System Programming of RAS
> +linaro.org      Linaro
> +oracle.com      Oracle
> +redhat.com      RedHat

s/RedHat/Red Hat/

> +sifive.com      SiFive
> +virtuozzo.com   Virtuozzo
> +xilinx.com      Xilinx

> diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-r=
edhat
> new file mode 100644
> index 0000000000..2cb3d4dacd
> --- /dev/null
> +++ b/contrib/gitdm/group-map-redhat
> @@ -0,0 +1,6 @@
> +#
> +# RedHat contributors using non-corporate email
> +#
> +
> +david@gibson.dropbear.id.au
> +laurent@vivier.eu

pjp@fedoraproject.org


> +# Use GroupMap to map a file full of addresses to the
> +# same employer. This is used for people that don't post from easily
> +# identifiable corportate emails.
> +#
> +GroupMap contrib/gitdm/group-map-redhat RedHat

s/RedHat/Red Hat/

> +GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
> +GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
> +GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
> +#
> +#
> +# Use FileTypeMap to map a file types to file names using regular
> +# regular expressions.
> +#
> +FileTypeMap contrib/gitdm/filetypes.txt

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
