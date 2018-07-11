Received: from eggs.gnu.org ([2001:4830:134:3::10]:57293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdH76-00036C-5Q
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdH70-0005GM-Ah
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:33:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48875)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fdH70-0005FR-4D
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:33:02 -0400
Date: Wed, 11 Jul 2018 12:32:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180711153254.GR7451@localhost.localdomain>
References: <20180709203731.19865-1-ehabkost@redhat.com>
	<20180710090731.GC1612@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180710090731.GC1612@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0] pc: Use "3.0+" constant as default
 SMBIOS version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Wei Huang <wei@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Jul 10, 2018 at 10:07:31AM +0100, Daniel P. Berrang=E9 wrote:
> On Mon, Jul 09, 2018 at 05:37:31PM -0300, Eduardo Habkost wrote:
> > Every time we create new PC machine-types in QEMU, the defaults
> > for SMBIOS fields change unnecessarily because the version field
> > defaults to MachineClass::name.
> >=20
> > This can cause unexpected side-effects, like triggering license
> > reactivation on guest software, or changing the VM memory layout
> > because of BIOS table size changes.
>=20
> Does that really matter though ? By its very nature the 'Version'
> field in SMBIOS is expected to change if you alter something about
> the hardware. If guests OS don't want to be exposed to changes in
> SMBIOS they would be using a fixed machine type, not the variable
> "pc" type that continually changes.
>=20
> We could put padding in the string if we want to avoid BIOS table
> layout changes.
>=20
> Having version change though feels like it is working as intended
> for the semantics of these Version: fields in BIOS.

Michael, do you have additional info on the original motivation
for suggesting this change and why do you consider it a bug?
(I don't have any concrete examples to justify the change)

--=20
Eduardo
