Received: from eggs.gnu.org ([2001:4830:134:3::10]:47952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ergjU-0002Wd-2D
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ergjQ-0003o0-Oo
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 04:12:04 -0500
References: <20180213102258.26145-1-david.engraf@sysgo.com>
	<20180215093600.18505-1-david.engraf@sysgo.com>
	<20180302014546.GD13135@umbus.fritz.box>
	<be9b719c-b1cf-8e82-3799-fca9e5fe896e@sysgo.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <93d89925-b0c9-e974-f45e-064598b507c0@ilande.co.uk>
Date: Fri, 2 Mar 2018 09:11:41 +0000
MIME-Version: 1.0
In-Reply-To: <be9b719c-b1cf-8e82-3799-fca9e5fe896e@sysgo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] PPC: e500: Fix duplicate
 kernel load and device tree overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Engraf <david.engraf@sysgo.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 02/03/18 08:53, David Engraf wrote:

> Am 02.03.2018 um 02:45 schrieb David Gibson:
>> On Thu, Feb 15, 2018 at 10:36:00AM +0100, David Engraf wrote:
>>> This patch fixes an incorrect behavior when the -kernel argument has 
>>> been
>>> specified without -bios. In this case the kernel was loaded twice. At 
>>> address
>>> 32M as a raw image and afterwards by load_elf/load_uimage at the
>>> corresponding load address. In this case the region for the device 
>>> tree and
>>> the raw kernel image may overlap.
>>>
>>> The patch fixes the behavior by loading the kernel image once with
>>> load_elf/load_uimage and skips loading the raw image.
>>>
>>> When here do not use bios_name/size for the kernel and use a more 
>>> generic
>>> name called payload_name/size.
>>>
>>> New in v3: dtb must be stored between kernel and initrd because Linux 
>>> can
>>>             handle the dtb only within the first 64MB. Add a comment to
>>>             clarify the behavior.
>>>
>>> Signed-off-by: David Engraf <david.engraf@sysgo.com>
>>
>> Sorry I've taken so long to reply to this.  It looks fine to me,
>> however, other changes mean it longer quite applies to the
>> ppc-for-2.12 tree.  Can you fix that up and repost please.
> 
> What other changes do you mean? In v3 I just restored the old behavior 
> by putting the dtb right after the kernel image. This behavior has been 
> changed by mistake in v1/v2. v3 now uses the correct storage location 
> again.

Hi David,

I think what David means is that when he tried to apply your v3 patch to 
his ppc-for-2.12 tree at 
https://github.com/dgibson/qemu/commits/ppc-for-2.12 using git-am then 
it failed - presumably because someone else has made other changes to 
that code since you submitted your v3 patch.

Please can you submit a v4 rebased on top of the current ppc-for-2.12 
branch?


ATB,

Mark.
