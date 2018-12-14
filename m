Received: from eggs.gnu.org ([2001:4830:134:3::10]:57344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXkcg-00015V-QT
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:23:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXkcf-0002Ow-Rf
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:23:10 -0500
Date: Fri, 14 Dec 2018 10:22:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181214102211.GF4265@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181213223737.11793-1-pbonzini@redhat.com>
	<20181213223737.11793-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213223737.11793-3-pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] avoid TABs in files that only contain
 a few
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Andrzej Zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Fam Zheng <famz@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:bochs" <qemu-block@nongnu.org>, "open list:Stellaris" <qemu-arm@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:ppc4xx" <qemu-ppc@nongnu.org>

On Thu, Dec 13, 2018 at 11:37:37PM +0100, Paolo Bonzini wrote:
> Most files that have TABs only contain a handful of them.  Change
> them to spaces so that we don't confuse people.
>=20
> disas, standard-headers, linux-headers and libdecnumber are imported
> from other projects and probably should be exempted from the check.
> Outside those, after this patch the following files still contain both
> 8-space and TAB sequences at the beginning of the line.  Many of them
> have a majority of TABs, or were initially committed with all tabs.

>     crypto/aes.c

Since you already cleaned some tabs in the previous patch, and the
rest of crypto/ except desrfb.c is tab-clean, I'd like this to be
fully cleaned too.


>     ui/vnc-enc-hextile-template.h
>     ui/vnc-enc-zywrle.h

The VNC code was historically heavily tab-damaged and we've
progressively cleaned it up when making changes.=20

> The following have only TABs:

>     crypto/desrfb.c

I'd rather like this to be cleaned to finish the job for
crypto/.



> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---


>  ui/vnc-enc-zywrle-template.c               |  4 +-
>  ui/vnc.c                                   |  4 +-

That you've finished tab-cleaning of these files, reinforces to
me that we should clean those other vnc files listed above.

None the less

  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

since those ones mentioned above can still be done as a separate
commit to this.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
