Received: from eggs.gnu.org ([2001:4830:134:3::10]:40494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRN12-0002QA-4P
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRN0y-0007Zc-0h
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 15:25:40 -0400
References: <20180608190145.10872-1-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef6bb32d-b5e0-f94b-327c-fbe6125b220a@redhat.com>
Date: Fri, 8 Jun 2018 14:25:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180608190145.10872-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND] Makefile: Remove qemu-version.h and
 qemu-options.def during 'make distclean'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org

On 06/08/2018 02:01 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> qemu-version.h and qemu-options.def are generated files
> that should be deleted during 'make distclean'.
>=20
> This solves building issues with out-of-tree builds from
> a source tree that has been built in (see d1bd2423a90):

Well, it prevents future repeats of the problem. It does not "fix"=20
existing incremental builds that already have the problem.  But I'm=20
still in favor of this change.


> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> resend: Cc Peter, removed dup line in comment
>=20
>   Makefile | 1 +
>   1 file changed, 1 insertion(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/Makefile b/Makefile
> index 023b3437ec..7ae453ffa2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -757,6 +757,7 @@ qemu-%.tar.bz2:
>   distclean: clean
>   	rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-opt=
ions.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
>   	rm -f config-all-devices.mak config-all-disas.mak config.status
> +	rm -f qemu-version.h qemu-options.def
>   	rm -f po/*.mo tests/qemu-iotests/common.env
>   	rm -f roms/seabios/config.mak roms/vgabios/config.mak
>   	rm -f qemu-doc.info qemu-doc.aux qemu-doc.cp qemu-doc.cps
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
