Received: from eggs.gnu.org ([2001:4830:134:3::10]:39957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1daxjg-0007fm-Sd
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1daxjc-0006ah-NI
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:22:52 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1daxjc-0006YL-Ay
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 01:22:48 -0400
Received: by mail-wm0-x244.google.com with SMTP id t138so7174123wmt.4
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 22:22:46 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <9F33156D-CBD0-4F16-BB2B-055501A2BA60@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Fri, 28 Jul 2017 08:22:45 +0300
In-Reply-To: <8082FF9BCB2B054996454E47167FF4EC1C572AF2@SHSMSX104.ccr.corp.intel.com>
References: <20170724120729.24350-1-dmitry@daynix.com>
	<20170725093148.3898b2da@w520.home>
	<8082FF9BCB2B054996454E47167FF4EC1C56E3CC@SHSMSX104.ccr.corp.intel.com>
	<751A50FA-0C7D-433F-B511-F4B13EC67DCC@daynix.com>
	<8082FF9BCB2B054996454E47167FF4EC1C572AF2@SHSMSX104.ccr.corp.intel.com>
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
To: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On 28 Jul 2017, at 07:51 AM, Zhang, Xiong Y <xiong.y.zhang@intel.com> =
wrote:
>=20
>>> On 26 Jul 2017, at 08:22 AM, Zhang, Xiong Y =
<xiong.y.zhang@intel.com>
>> wrote:
>>>=20
>>> Sorry, we indeed found Intel windows guest graphic driver couldn't =
be bind
>> when GMS memory size is zero. And we have fixed it and the next intel
>> windows driver release will contain this fix.
>>> So currently please use x-igd-gms in legacy mode to work around =
this.
>>>=20
>>> BTW, how did you know window driver allocate extra ~4G memory when
>> GMS size set to 0 ?
>>=20
>> We noticed that with new IGD driver memory usage on VMs raised by =
around
>> 4G.
>>=20
>> Then we examined memory allocations with poolmon
>> =
(https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/poolm
>> on)
>> and saw that around 4G of memory is allocated with IGD driver pool =
tag.
>> Additionally we noticed that on VMs with less than 5G of memory IGD =
driver
>> does not load and system does fallback to standard VGA driver.
>>=20
> [Zhang, Xiong Y]  I tried our internal driver and didn't found the =
above two issues, please wait for the next intel graphic driver release.

Thanks!

>=20
> thanks
