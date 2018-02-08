Received: from eggs.gnu.org ([2001:4830:134:3::10]:44626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejlwt-0002uk-QI
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejlwq-0002pY-Kb
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:09:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ejlwq-0002oa-Fl
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:09:08 -0500
Date: Thu, 8 Feb 2018 13:08:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180208130849.GC20703@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180208105754.19924-1-danielhb@linux.vnet.ibm.com>
	<caaad0dd-3f8e-a414-48ed-b6535d5a83a4@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <caaad0dd-3f8e-a414-48ed-b6535d5a83a4@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/audio/sb16.c: missing break
 statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Feb 08, 2018 at 09:15:10AM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 02/08/2018 07:57 AM, Daniel Henrique Barboza wrote:
> > This patch adds a break in the switch() statement of complete(),
> > value 0x42:
> >=20
> >     case 0x42:              /* FT2 sets output freq with this, go fig=
ure */
> >         qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think=
 it"
> >                       " should\n");
> >         break; <-------
> >     case 0x41:
>=20
> It seems this is an intentional fallthrough, I understand cmd 0x42 is
> expected to do the same of 0x41 and _a bit more_ (see commit 85571bc741=
5).

It might be nice to turn on -Wimplicit-fallthrough and then annotate
valid locations like this in qemu with  /* fallthrough */

Although GCC has an __attribute((fallthrough)), the warning flag impl
also looks for that magic comment, and the magic comment is portable
to clang too.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
