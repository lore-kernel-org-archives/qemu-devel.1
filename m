Received: from eggs.gnu.org ([2001:4830:134:3::10]:50646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dcoMW-0001yy-Gu
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dcoMS-0002Jb-9x
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:46:36 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1dcoMR-0002Hf-Uj
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 03:46:32 -0400
Received: by mail-wr0-x230.google.com with SMTP id 12so15354185wrb.1
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 00:46:30 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <02665481-C9F5-4430-80F8-3F6A4A3E8697@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Wed, 2 Aug 2017 10:46:31 +0300
In-Reply-To: <20170801152408.75b04e17@w520.home>
References: <20170724120729.24350-1-dmitry@daynix.com>
	<20170725093148.3898b2da@w520.home>
	<8082FF9BCB2B054996454E47167FF4EC1C56E3CC@SHSMSX104.ccr.corp.intel.com>
	<751A50FA-0C7D-433F-B511-F4B13EC67DCC@daynix.com>
	<8082FF9BCB2B054996454E47167FF4EC1C572AF2@SHSMSX104.ccr.corp.intel.com>
	<9F33156D-CBD0-4F16-BB2B-055501A2BA60@daynix.com>
	<20170801152408.75b04e17@w520.home>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On 2 Aug 2017, at 24:24 AM, Alex Williamson =
<alex.williamson@redhat.com> wrote:
>=20
> On Fri, 28 Jul 2017 08:22:45 +0300
> Dmitry Fleytman <dmitry@daynix.com <mailto:dmitry@daynix.com>> wrote:
>=20
>>> On 28 Jul 2017, at 07:51 AM, Zhang, Xiong Y =
<xiong.y.zhang@intel.com> wrote:
>>>=20
>>>>> On 26 Jul 2017, at 08:22 AM, Zhang, Xiong Y =
<xiong.y.zhang@intel.com> =20
>>>> wrote: =20
>>>>>=20
>>>>> Sorry, we indeed found Intel windows guest graphic driver couldn't =
be bind =20
>>>> when GMS memory size is zero. And we have fixed it and the next =
intel
>>>> windows driver release will contain this fix. =20
>>>>> So currently please use x-igd-gms in legacy mode to work around =
this.
>>>>>=20
>>>>> BTW, how did you know window driver allocate extra ~4G memory when =
=20
>>>> GMS size set to 0 ?
>>>>=20
>>>> We noticed that with new IGD driver memory usage on VMs raised by =
around
>>>> 4G.
>>>>=20
>>>> Then we examined memory allocations with poolmon
>>>> =
(https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/poolm
>>>> on)
>>>> and saw that around 4G of memory is allocated with IGD driver pool =
tag.
>>>> Additionally we noticed that on VMs with less than 5G of memory IGD =
driver
>>>> does not load and system does fallback to standard VGA driver.
>>>>=20
>>> [Zhang, Xiong Y]  I tried our internal driver and didn't found the =
above two issues, please wait for the next intel graphic driver release. =
=20
>>=20
>> Thanks!
>=20
> So to close on this, we should just be recommending that users
> encountering this problem add the x-igd-gms=3D1 option to the device
> until the next Intel graphics release.  I won't plan to push this
> change.  Thanks all,

Hi Alex,

Agree, that makes sense.

Thanks you,
Dmitry

>=20
> Alex
