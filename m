Received: from eggs.gnu.org ([2001:4830:134:3::10]:50303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1daxF5-00071D-NP
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiong.y.zhang@intel.com>) id 1daxF2-0005oM-G8
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:51:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:26611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiong.y.zhang@intel.com>)
	id 1daxF2-0005nD-8D
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:51:12 -0400
From: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Date: Fri, 28 Jul 2017 04:51:03 +0000
Message-ID: <8082FF9BCB2B054996454E47167FF4EC1C572AF2@SHSMSX104.ccr.corp.intel.com>
References: <20170724120729.24350-1-dmitry@daynix.com>
	<20170725093148.3898b2da@w520.home>
	<8082FF9BCB2B054996454E47167FF4EC1C56E3CC@SHSMSX104.ccr.corp.intel.com>
	<751A50FA-0C7D-433F-B511-F4B13EC67DCC@daynix.com>
In-Reply-To: <751A50FA-0C7D-433F-B511-F4B13EC67DCC@daynix.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vfio/pci-quirks: Set non-zero GMS memory
 size for IGD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zhang, Xiong Y" <xiong.y.zhang@intel.com>

> > On 26 Jul 2017, at 08:22 AM, Zhang, Xiong Y <xiong.y.zhang@intel.com>
> wrote:
> >
> > Sorry, we indeed found Intel windows guest graphic driver couldn't be b=
ind
> when GMS memory size is zero. And we have fixed it and the next intel
> windows driver release will contain this fix.
> > So currently please use x-igd-gms in legacy mode to work around this.
> >
> > BTW, how did you know window driver allocate extra ~4G memory when
> GMS size set to 0 ?
>=20
> We noticed that with new IGD driver memory usage on VMs raised by around
> 4G.
>=20
> Then we examined memory allocations with poolmon
> (https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/poolm
> on)
> and saw that around 4G of memory is allocated with IGD driver pool tag.
> Additionally we noticed that on VMs with less than 5G of memory IGD drive=
r
> does not load and system does fallback to standard VGA driver.
>=20
[Zhang, Xiong Y]  I tried our internal driver and didn't found the above tw=
o issues, please wait for the next intel graphic driver release.

thanks
