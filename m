Received: from eggs.gnu.org ([2001:4830:134:3::10]:51331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcWne-0007Bn-SU
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcWnb-0004O9-OJ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:05:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45104 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fcWnb-0004Ng-Jn
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:05:55 -0400
Date: Mon, 9 Jul 2018 16:05:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180709160551.26d07849@redhat.com>
In-Reply-To: <aa7d4472-195d-0d40-4447-494cd4f537c4@linux.vnet.ibm.com>
References: <20180628172657.11646-1-marcandre.lureau@redhat.com>
	<89c2a128-3679-8b44-f00a-7f94bd3bdf0d@linux.vnet.ibm.com>
	<20180702135746.717e668d@redhat.com>
	<aa7d4472-195d-0d40-4447-494cd4f537c4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/4] Add support for TPM Physical
 Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 2 Jul 2018 10:54:13 -0400
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> On 07/02/2018 07:57 AM, Igor Mammedov wrote:
> > On Fri, 29 Jun 2018 08:20:38 -0400
> > Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> > =20
> >> On 06/28/2018 01:26 PM, Marc-Andr=C3=A9 Lureau wrote: =20
> >>> Hi,
> >>>
> >>> The following patches implement the TPM Physical Presence Interface
> >>> that allows a user to set a command via ACPI (sysfs entry in Linux)
> >>> that, upon the next reboot, the firmware looks for and acts upon by
> >>> sending sequences of commands to the TPM.
> >>>
> >>> A dedicated memory region is added to the TPM CRB & TIS devices, at
> >>> address/size 0xFED45000/0x400. A new "etc/tpm/config" fw_cfg entry
> >>> holds the location for that PPI region and some version details, to
> >>> allow for future flexibility.
> >>>
> >>> With the associated edk2/ovmf firmware, the Windows HLK "PPI 1.3" test
> >>> now runs successfully.
> >>>
> >>> It is based on previous work from Stefan Berger ("[PATCH v2 0/4]
> >>> Implement Physical Presence interface for TPM 1.2 and 2")
> >>>
> >>> The edk2 support is merged upstream. =20
> >> The least I could do now is test this... So, I tested this now with the
> >> SeaBIOS support I have for this series. It's here:
> >>
> >> https://github.com/stefanberger/seabios-tpm/tree/qemu-ppi.v6
> >>
> >> It works fine with at least an attached TPM 1.2. I haven't tried TPM 2
> >> yet but would not expect complications from QEMU level. A operation
> >> request value put into Linux's PPI interface can be read back also aft=
er
> >> a VM suspend / resume operation. The list of supported operations is
> >> shown correctly (needs Linux extensions for TPM 2 operation values
> >> beyond a certain number iirc). The request operation is executed
> >> correctly and the response shows the last operation and its result. So
> >> it seems to work fine.
> >>
> >>
> >>   =C2=A0=C2=A0 Stefan
> >> =20
> > Are there any instructions how to test it?
> > =20
> 1) You need to get swtpm running on a machine.
>=20
> Build libtpms from the 'TPM 2 preview' branch here:
>=20
> https://github.com/stefanberger/libtpms/tree/tpm2-preview.rev146.v2
>=20
> Instructions are here: https://github.com/stefanberger/libtpms/wiki
>=20
>=20
> Build swtpm from the TPM 2 preview branch here:
>=20
> https://github.com/stefanberger/swtpm/tree/tpm2-preview.v2
>=20
> Instructions are here: https://github.com/stefanberger/swtpm/wiki
>=20
>=20
> 2) Compile and install my branch of SeaBIOS with the PPI support:
>=20
> branch is here: https://github.com/stefanberger/seabios-tpm/tree/qemu-ppi=
.v6
it looks like repo is gone, is it merged upstream?
