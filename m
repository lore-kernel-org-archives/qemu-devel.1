Received: from eggs.gnu.org ([2001:4830:134:3::10]:38839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f9P4P-0005AV-G9
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 01:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f9P4L-0000ZN-9Y
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 01:58:53 -0400
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-3-david@gibson.dropbear.id.au>
	<20180419192105.7eb51b26@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a5ca58b2-f4f7-47e0-5e09-735a4f4080a2@redhat.com>
Date: Fri, 20 Apr 2018 07:58:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180419192105.7eb51b26@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13 02/10] spapr: Remove
 support for PowerPC 970 with pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 19.04.2018 19:21, Greg Kurz wrote:
> On Tue, 17 Apr 2018 17:17:14 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
>> Current POWER cpus allow for a VRMA, a special mapping which describes a
>> guest's view of memory when in real mode (MMU off, from the guest's point
>> of view).  Older cpus didn't have that which meant that to support a guest
>> a special host-contiguous region of memory was needed to give the guest its
>> Real Mode Area (RMA).
>>
>> This was useful in the early days of KVM on Power to allow it to be tested
>> on PowerPC 970 chips as used in Macintosh G5 machines.  Now, however, those
>> machines are so old as to be irrelevant, and the host kernel has long since
>> dropped support for this mode.  It hasn't been tested in ages either.
>>
>> So, to simplify the code, drop the support from qemu as well.
>>
> 
> So this could possibly break TCG guests with 970, which happens to be
> bootable with the current code ?
> 
> $ cat /etc/redhat-release
> Red Hat Enterprise Linux Server release 6.9 (Santiago)
> $ cat /proc/cpuinfo 
> processor       : 0
> cpu             : PPC970, altivec supported
> clock           : 1000.000000MHz
> revision        : 2.2 (pvr 0039 0202)
> 
> timebase        : 512000000
> platform        : pSeries
> model           : IBM pSeries (emulated by qemu)
> machine         : CHRP IBM pSeries (emulated by qemu)
> 
> I guess nobody uses this setup, but my understanding is that some
> rules must be followed when it comes to removing something that
> works.
> 
> https://wiki.qemu.org/Features/LegacyRemoval#Rules_for_removing_an_interface
> 
> Maybe add a warning if 970 is used, and turn it into an error in two releases
> along with this patch ?

Right, we've got a process for deprecating old features, so please
follow that process.

 Thomas
