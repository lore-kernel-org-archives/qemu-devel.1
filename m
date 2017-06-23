Received: from eggs.gnu.org ([2001:4830:134:3::10]:35220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1dOM3T-0005xQ-La
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1dOM3S-00060k-LZ
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:43:11 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:33451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1dOM3S-00060H-EX
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 06:43:10 -0400
Received: by mail-oi0-x232.google.com with SMTP id p66so23224424oia.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 03:43:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1706200028170.64612@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1706182319020.18505@zero.eik.bme.hu>
	<20170619115834.GA2242@HEDWIG.INI.CMU.EDU>
	<alpine.BSF.2.21.1706200028170.64612@zero.eik.bme.hu>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 23 Jun 2017 12:42:47 +0200
Message-ID: <CAAibmn3mz=QvsNDg_T6JAcbH-H4qiacush_-E=dXUtkc9XaQ8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Commit 77af8a2b9 breaks (mac)OS X 10.11.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: "Gabriel L. Somlo" <gsomlo@gmail.com>, qemu-devel@nongnu.org

Hi,

Apologies for the late reply, I've been away.

On 20 June 2017 at 01:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> I can (still) boot off my 10.11.0 installer iso image, and
>> successfully upgraded from 10.11.4 to 10.11.6, with the latter
>> continuing to boot without problems.
>
> I had Clover with unpatched OVMF which worked before but hangs after
> "AppleKeyStore starting" and before "IOAPIC: Version..." messages since the
> above patch. Maybe it's a problem in Clover and I should try a newer
> version.

I never tested with Clover I'm afraid, so it's entirely possible that
it's broken something in there. Maybe it detects Qemu/KVM based on
FADT somehow, or has a FADT rewrite rule that falls over with the new
FADT. Either way, it's probably not too hard to fix on the Clover side
if nobody has done so yet.

>> This is with qemu master (patched for applesmc with the latest v3
>> pending series that's also on the mailing list), and OVMF master
>> (patched for HFS+).
>
> It boots with your patched OVMF so now I'm using that instead. (No boot menu
> but it's faster.)

I don't know if it'll work in Qemu/KVM with macOS, but if you really
need a boot menu you could try rEFInd.

HTH

Phil
