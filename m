Received: from eggs.gnu.org ([209.51.188.92]:60926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1Yh9-0001yG-0k
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h1Yh8-0000v6-8C
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:42:58 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:45934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1h1Yh7-0000rE-Tc
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:42:58 -0500
Received: by mail-pg1-x52e.google.com with SMTP id 125so8471954pgc.12
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 07:42:52 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Wed, 6 Mar 2019 18:39:15 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201903061839.16488.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: balaton@eik.bme.hu, qemu-devel@nongnu.org

> It is ati-vga specific not fulong2e specific and it's entirely possible (even likely) that my minimal ati-vga emulation is not correct for 2d acceleration yet but I've tested it with the pmon_2e.bin binary from the same place and it worked with that. So if it does not work with the binary pmon for you then that's not the same what I see or if it works with the binary but not with the one compiled then either you're compiling another version that does something differently or there's a difference in config. There are several Bonito configs in pmon and the fulong2e might use another one or different options. 


It worked fine with  binary pmon_2e.bin, and not for my self-compiled version. 
Still, I'm not sure about what kind of config they used, and at that commit.
In this sense newer pmon is more useful because it prints git commit and  build date.


Provided binary talks about pmon 1.1.2 (?) in top left corner.
I think one of my earlier self-compiled binaries behaved like this one
(printing a lot of pci info), but yes, something still not right  at my end
because for example DIMM size not detected correctly in my version.

But it gives prompt at serial console! :}

Will look at machine emulation in qemu, and try to configure pmon correctly. 
