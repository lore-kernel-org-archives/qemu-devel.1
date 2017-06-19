Received: from eggs.gnu.org ([2001:4830:134:3::10]:51845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dN5l4-00052X-VG
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dN5l0-00038m-1j
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:06:58 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:37554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1dN5kz-00036k-RL
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:06:53 -0400
Date: Tue, 20 Jun 2017 01:06:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170619115834.GA2242@HEDWIG.INI.CMU.EDU>
Message-ID: <alpine.BSF.2.21.1706200028170.64612@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1706182319020.18505@zero.eik.bme.hu>
	<20170619115834.GA2242@HEDWIG.INI.CMU.EDU>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] Commit 77af8a2b9 breaks (mac)OS X 10.11.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>

On Mon, 19 Jun 2017, Gabriel L. Somlo wrote:
> On Sun, Jun 18, 2017 at 11:25:15PM +0200, BALATON Zoltan wrote:
>> After 77af8a2b9 (hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to
>> improve guest OS support.) OS X 10.11.6 hangs during boot near detecting
>> IOAPIC. (Gabriel's latest v3 applesmc patch series does not fix this.) Maybe
>> another register needs to be implemented somewhere?
>
> I can (still) boot off my 10.11.0 installer iso image, and
> successfully upgraded from 10.11.4 to 10.11.6, with the latter
> continuing to boot without problems.

I had Clover with unpatched OVMF which worked before but hangs after 
"AppleKeyStore starting" and before "IOAPIC: Version..." messages since 
the above patch. Maybe it's a problem in Clover and I should try a newer 
version.

> This is with qemu master (patched for applesmc with the latest v3
> pending series that's also on the mailing list), and OVMF master
> (patched for HFS+).

It boots with your patched OVMF so now I'm using that instead. (No boot 
menu but it's faster.)

> Zoltan: did reverting 77af8a2b9 actually help in your case ? Leaving
> it in doesn't seem to be a problem for me...

I could not test reverting because this patch does not cleanly revert on 
HEAD now but my image with Clover booted with the version before 77af8a2b9 
and hangs starting with that patch. So since OS X 10.11.6 can be booted in 
another way the subject should be this commit breaks Clover (at least the 
old version I had). I can't test with a newer Clover version at the moment 
but my problem is solved for now.

Thank you,
BALATON Zoltan
