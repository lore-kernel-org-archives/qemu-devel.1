Received: from eggs.gnu.org ([2001:4830:134:3::10]:57440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dAie6-0006Qt-FG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1dAie2-0000LL-GN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:00:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:45784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1dAie2-0000Kv-8Q
	for qemu-devel@nongnu.org; Tue, 16 May 2017 16:00:34 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Tue, 16 May 2017 20:00:28 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1AB8B3D@ORSMSX112.amr.corp.intel.com>
References: <618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
	<20170511163447.GA7785@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB61D5@ORSMSX112.amr.corp.intel.com>
	<ff74288a-d26d-b037-2b55-7dac459aa4ec@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1AB6AA2@ORSMSX112.amr.corp.intel.com>
	<f9c33614-be36-e789-b72b-b4ffcc8bb6a8@redhat.com>
	<20170512193840.GA22454@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB6CBF@ORSMSX112.amr.corp.intel.com>
	<20170513000141.GA542@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB6DEF@ORSMSX112.amr.corp.intel.com>
	<20170516162442.GA4177@morn.lan>
In-Reply-To: <20170516162442.GA4177@morn.lan>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On Sat, May 13, 2017 at 01:24:30AM +0000, Xu, Anthony wrote:
> > I think it is related to accel and platform, the result I gave before i=
s for q35
> tcg,
> >
> > With the above change,   I got below data
> >
> > Platform	accel		count of restoring A20 to 0
> > Q35		kvm		96
> > Q35		tcg		271
> > PC		kvm		3
> > PC		tcg		3
>=20
> Okay, thanks.  I think the number of a20 switches is due to
> differences in option rom execution interacting with the fact that
> some mode switches were occurring before SeaBIOS set
> call16_override().
>=20
> > But I still see a lot of PORT_A20 accesses in QEMU as I expected
>=20
> Yes, but it should be possible to significantly reduce the number of
> outb() calls by limiting them to when A20 changes.  This should also
> be useful to reduce the number of outb() calls needed to disable NMIs.
> I sent a patch series to the seabios mailing list to demonstrate the
> idea.

If both TCG and KVM work by ignoring A20,  why not remove all PORT_A20
access in SeaBios when CONFIG_DISABLE_A20 is not defined?
Do you see any impact?


-Anthony
