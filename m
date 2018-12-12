Received: from eggs.gnu.org ([2001:4830:134:3::10]:57795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gX83E-0007Ju-PX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gX83A-00038P-6H
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:12:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gX839-00037j-UZ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:11:56 -0500
Date: Wed, 12 Dec 2018 15:11:51 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181212171151.GW7141@habkost.net>
References: <20181211205346.11118-1-ehabkost@redhat.com>
	<20181211205346.11118-5-ehabkost@redhat.com>
	<c4bdc91b-3946-0345-bb57-f3e2e71b9ae3@amd.com>
	<20181212170110.GJ31033@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181212170110.GJ31033@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 4/4] i386: Add "stibp" flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Dec 12, 2018 at 05:01:10PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Dec 12, 2018 at 04:57:42PM +0000, Lendacky, Thomas wrote:
> > On 12/11/2018 02:53 PM, Eduardo Habkost wrote:
> > > The STIBP flag may be supported by the host KVM module, so QEMU
> > > can allow it to be configured manually, and it can be exposed to
> > > guests when using "-cpu host".
> > >=20
> > > No additional migration code is required because the whole
> > > contents of spec_ctrl is already migrated in the "cpu/spec_ctrl"
> > > section.
> > >=20
> > > Corresponding KVM patch was submitted at:
> > > https://lore.kernel.org/lkml/20181205191956.31480-1-ehabkost@redhat=
.com/
> > >=20
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > Message-Id: <20181210180250.31299-1-ehabkost@redhat.com>
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > ---
> > >  target/i386/cpu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 86a934d450..12f559b6af 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -1042,7 +1042,7 @@ static FeatureWordInfo feature_word_info[FEAT=
URE_WORDS] =3D {
> > >              NULL, NULL, NULL, NULL,
> > >              NULL, NULL, "pconfig", NULL,
> > >              NULL, NULL, NULL, NULL,
> > > -            NULL, NULL, "spec-ctrl", NULL,
> > > +            NULL, NULL, "spec-ctrl", "stibp",
> >=20
> > I guess I missed this earlier. Is there a corresponding patch for the=
 AMD
> > STIBP bit (CPUID 0x80000008_EBX[15]) that is in KVM?
>=20
> This Intel STIBP patch is one that many distros have carried downstream
> since the flaw came to light.
>=20
> I've not seen any equiv patch for AMD STIBP bit, in either QMEU or libv=
irt,
> so guess that's a gap that needs filling.

I can submit a "amd-stibp" patch for completeness, although I
doubt many people will actually use the flag.

--=20
Eduardo
