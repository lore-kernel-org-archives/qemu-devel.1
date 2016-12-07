Received: from eggs.gnu.org ([2001:4830:134:3::10]:43682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cEVTv-0002ZB-HK
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 01:13:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cEVTs-0006Mt-As
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 01:13:31 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cEVTs-0006L0-4e
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 01:13:28 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so25666515wma.3
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 22:13:06 -0800 (PST)
References: <CAPQTB1djVJ3qey3xKc6p01YcTibODbSUzhGGqTY2VCRJx_Pz8Q@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <2e5420a8-fba8-92f0-029f-58c0a236e142@tuxfamily.org>
Date: Wed, 7 Dec 2016 07:13:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAPQTB1djVJ3qey3xKc6p01YcTibODbSUzhGGqTY2VCRJx_Pz8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Booting my laptop with images from Qemu advent
 calendar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Oscar A <ochicuelin@gmail.com>, qemu-devel@nongnu.org
Cc: kashyapc@fedoraproject.org

On 06.12.2016 23:42, Oscar A wrote:
> Hello dear all,
> 
> I just started to get interested in operative systems, booting, and
> virtual machines, and found this project, which is very nice. I have
> a question. For instance, take the Hanoi´s towers image of yesterday.
> 
> I want to boot my laptop with it. I guess that if I do it correctly, nothing
> wrong should happen. But I do not know if I have Open firmware or
> not. I have an HP pavilion dm4 1065dx laptop with Windows 7 home
> 64 bit and Fedora, and I am using H20 Insyde uefi/bios. Does this
> laptop have open firmware or is it compatible? Do you know that? Or
> can you give me some hints on this? How can I check this for instance?

 Hi Oscar,

Open Firmware is some kind of alternative to BIOS/UEFI, and it normally
can *not* be found on x86 hardware (the "One Laptop Per Child" computer
was an exception). Open Firmware is/was rather available on PowerPC and
SPARC computers.

But if you're still interested in booting small gimmicks directly on
your computer, have a look at day 7 in the advent calendar:

 http://www.qemu-advent-calendar.org/2016/#day-7

Theoretically, it should be possible to boot this game directly if you
manage to put it into a boot sector of a floppy disk (or maybe also USB
stick, but I haven't tried).

 Thomas
