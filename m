Received: from eggs.gnu.org ([2001:4830:134:3::10]:57770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1dMvKT-0004NM-57
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1dMvKQ-0002G4-5T
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:58:49 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1dMvKQ-0002Fp-1Q
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:58:46 -0400
Received: by mail-qk0-x244.google.com with SMTP id 16so1060741qkg.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 04:58:45 -0700 (PDT)
Date: Mon, 19 Jun 2017 07:58:36 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Message-ID: <20170619115834.GA2242@HEDWIG.INI.CMU.EDU>
References: <alpine.BSF.2.21.1706182319020.18505@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1706182319020.18505@zero.eik.bme.hu>
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
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>

Zoltan, Phil:

On Sun, Jun 18, 2017 at 11:25:15PM +0200, BALATON Zoltan wrote:
> After 77af8a2b9 (hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to
> improve guest OS support.) OS X 10.11.6 hangs during boot near detecting
> IOAPIC. (Gabriel's latest v3 applesmc patch series does not fix this.) Maybe
> another register needs to be implemented somewhere?

I can (still) boot off my 10.11.0 installer iso image, and
successfully upgraded from 10.11.4 to 10.11.6, with the latter
continuing to boot without problems.

This is with qemu master (patched for applesmc with the latest v3
pending series that's also on the mailing list), and OVMF master
(patched for HFS+).

Zoltan: did reverting 77af8a2b9 actually help in your case ? Leaving
it in doesn't seem to be a problem for me...

Thanks,
--Gabriel
