Received: from eggs.gnu.org ([2001:4830:134:3::10]:56094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8liW-0003l0-NT
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f8liV-00082T-JI
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:57:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f8liV-00082L-DL
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 07:57:39 -0400
Date: Wed, 18 Apr 2018 12:57:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180418115734.GG27579@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180418090457.dqg5gxnzobdofkao@sirius.home.kraxel.org>
	<b3298c44-4cdf-1936-fb69-32d308ff3a25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3298c44-4cdf-1936-fb69-32d308ff3a25@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Wed, Apr 18, 2018 at 01:48:10PM +0200, Laszlo Ersek wrote:
> On 04/18/18 11:04, Gerd Hoffmann wrote:
> >> This surfaced in the RFCv1 discussion, but Daniel suggested ignoring
> >> version numbers:
> >>
> >> http://mid.mail-archive.com/20180410093412.GI5155@redhat.com
> >>
> >> On 04/10/18 11:34, Daniel P. Berrang=C3=A9 wrote:
> >>> IMHO it would be valid to just keep life simple and only record the
> >>> base machine type name that can use the firmware ie "pc", "q35", an=
d
> >>> ignore the fact that in some cases the firmware might require a
> >>> specific version of the machine type.
> >=20
> > IIRC this bit referes to the fact that SMM requires qemu >=3D 2.x (do=
n't
> > remember which x) to work.  So smm-enabled edk2 would just say
> > "pc-q35-*" instead of trying to specifying a version range somehow.
>=20
> OK. I'm fine either way; Dan, can you please confirm you are OK with th=
e
> suggested wildcard format? (I.e., we still shouldn't include actual
> version numbers in the supported machtypes list, but we should be more
> specific than just "pc" and "q35" -- if the machine type is versioned,
> use an asterisk for covering the version number.)

My suggestion to use  a bare "pc" is effectively doing globbing
anyway, just that we've left off the "*". Gerd is right that it
is probably better to be explicit and include the wildcard.

So now the question is should this string be declared to be
glob format, or regex format. Regex is more flexible, but
regex syntax is ill-defined because every regex engine is
slightly different.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
