Received: from eggs.gnu.org ([2001:4830:134:3::10]:42837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXTMn-0002bJ-3N
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXTMj-0007Rn-UK
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:25:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fXTMj-0007Re-Ol
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:25:17 -0400
Date: Mon, 25 Jun 2018 16:25:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180625152513.GI18580@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa9ce054-f58c-097d-aee3-8fae769d0840@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Choosing PCR banks for swtpm's TPM 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: tpm2@lists.01.org, Kenneth Goldman <kgoldman@us.ibm.com>, Chris Friesen <chris.friesen@windriver.com>, "Qi, Yadong" <yadong.qi@intel.com>, qemu-devel <qemu-devel@nongnu.org>, "Xu, Quan" <quan.xu@intel.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Mon, Jun 25, 2018 at 11:05:55AM -0400, Stefan Berger wrote:
> Hi!
>=20
> =C2=A0I am sending this email to solicit input on the choice of the PCR=
 banks to
> enable for swtpm's TPM 2. I have currently enabled 4 PCR banks for
> SHA{1,256,384,512}. The downside of this is that running the TPM 2 with=
 so
> many PCR banks has a performance impact when the Linux integrity measur=
ement
> architecture is used and has to extend measurements into all PCR banks,
> which Linux does already.
>=20
> TPM 2 has the PCR_Allocate() command for a user to select the PCR banks=
 to
> use. This command allows to make some PCR banks invisible. The change h=
as to
> be done through the firmware and has the downside that the TPM2 does no=
t
> support TPM2_Shutdown(SU_STATE) after this command was used. This preve=
nts
> suspend/resume from working properly. So, it seems that one shouldn't h=
ave
> to use this command, which in turn means the number of PCR banks should=
 be
> small.
>=20
> Another complication with the swtpm is the upgrade path. Suspended VMs =
will
> expect that the PCR banks that were available before the suspend will b=
e
> available after the resume and a possible swtpm upgrade. This in turn m=
eans
> that the PCR banks should be chosen now and we'll have to stick with th=
em.

Anything that has a risk of needing to change between versions would need
to be tied into the machine type in some way.

>=20
> That said, my suggestion would be to enable only PCR banks for SHA256 f=
or
> 'now' and SHA512 for the future. Having two PCR banks should enable dec=
ent
> performance. If someone wants to have better performance he will have t=
o go
> through the firmware to select the PCR banks at the expense of loosing
> suspend/resume support.
>=20
> The change of PCR banks for the current 4 PCR banks will break the stat=
e of
> all swtpms.
>=20
> If you have suggestions, please let me know.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
