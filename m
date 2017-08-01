Received: from eggs.gnu.org ([2001:4830:134:3::10]:60861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dceeE-0006E5-95
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dceeB-0002KS-4v
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:24:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dceeA-0002Jg-V3
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:24:11 -0400
Date: Tue, 1 Aug 2017 15:24:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170801152408.75b04e17@w520.home>
In-Reply-To: <9F33156D-CBD0-4F16-BB2B-055501A2BA60@daynix.com>
References: <20170724120729.24350-1-dmitry@daynix.com>
	<20170725093148.3898b2da@w520.home>
	<8082FF9BCB2B054996454E47167FF4EC1C56E3CC@SHSMSX104.ccr.corp.intel.com>
	<751A50FA-0C7D-433F-B511-F4B13EC67DCC@daynix.com>
	<8082FF9BCB2B054996454E47167FF4EC1C572AF2@SHSMSX104.ccr.corp.intel.com>
	<9F33156D-CBD0-4F16-BB2B-055501A2BA60@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: "Zhang, Xiong Y" <xiong.y.zhang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, 28 Jul 2017 08:22:45 +0300
Dmitry Fleytman <dmitry@daynix.com> wrote:

> > On 28 Jul 2017, at 07:51 AM, Zhang, Xiong Y <xiong.y.zhang@intel.com> wrote:
> >   
> >>> On 26 Jul 2017, at 08:22 AM, Zhang, Xiong Y <xiong.y.zhang@intel.com>  
> >> wrote:  
> >>> 
> >>> Sorry, we indeed found Intel windows guest graphic driver couldn't be bind  
> >> when GMS memory size is zero. And we have fixed it and the next intel
> >> windows driver release will contain this fix.  
> >>> So currently please use x-igd-gms in legacy mode to work around this.
> >>> 
> >>> BTW, how did you know window driver allocate extra ~4G memory when  
> >> GMS size set to 0 ?
> >> 
> >> We noticed that with new IGD driver memory usage on VMs raised by around
> >> 4G.
> >> 
> >> Then we examined memory allocations with poolmon
> >> (https://docs.microsoft.com/en-us/windows-hardware/drivers/devtest/poolm
> >> on)
> >> and saw that around 4G of memory is allocated with IGD driver pool tag.
> >> Additionally we noticed that on VMs with less than 5G of memory IGD driver
> >> does not load and system does fallback to standard VGA driver.
> >>   
> > [Zhang, Xiong Y]  I tried our internal driver and didn't found the above two issues, please wait for the next intel graphic driver release.  
> 
> Thanks!

So to close on this, we should just be recommending that users
encountering this problem add the x-igd-gms=1 option to the device
until the next Intel graphics release.  I won't plan to push this
change.  Thanks all,

Alex
