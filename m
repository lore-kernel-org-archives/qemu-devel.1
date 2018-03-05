Received: from eggs.gnu.org ([2001:4830:134:3::10]:44597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1esvJO-0002PK-3j
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1esvJN-0005mX-4S
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:58:14 -0500
Date: Mon, 5 Mar 2018 18:57:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180305185754.GE17368@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180305112732.26471-1-f4bug@amsat.org>
	<20180305112732.26471-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180305112732.26471-3-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 02/30] hw: include "qemu/cunits.h"
 and clean unused "qemu/cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Marek Vasut <marex@denx.de>, Alexander Graf <agraf@suse.de>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Chris Wulff <crwulff@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Paul Burton <paul.burton@mips.com>, "open list:New World" <qemu-ppc@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Mon, Mar 05, 2018 at 08:27:04AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> These files were including "qemu/cutils.h" to use the byte-based size
> definitions, now available in "qemu/cunits.h".

I know I'm "complaining" about bike-shed colour here....

Feels like just calling it units.h is sufficient - all our .h code is
C code so don't need reminding of it by filename, particularly since
we're avoiding system header clash by using the qemu/ prefix on #includes=
.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Regardless of whether you rename it or not though,

   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
