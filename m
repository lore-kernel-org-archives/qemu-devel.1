Received: from eggs.gnu.org ([2001:4830:134:3::10]:37902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZnrZ-0001RZ-0X
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZnrT-0001uN-RA
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:15:00 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:54193)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gZnrT-0001qM-Hs
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:14:55 -0500
Date: Thu, 20 Dec 2018 03:14:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <47126B68-3AF7-48AB-B904-4D8EAC854BC7@foghorn.io>
Message-ID: <alpine.BSF.2.21.9999.1812200305360.23312@zero.eik.bme.hu>
References: <83206F6D-0BA5-4781-8635-84D48DD33A2A@foghorn.io>
	<CAFEAcA-PJadBG0sE43N9wEx9Qm3Nxu2am_0Zy2Zqtz66C9SJ-w@mail.gmail.com>
	<ECFBC025-CD7F-444B-BF7F-62E20954A85A@foghorn.io>
	<CAFEAcA9M73BdXs345vdqkuQE3sxT+GnS4PWZ2OPO8DWwNtRQ-A@mail.gmail.com>
	<EC65CD28-C2F9-49D7-BDE1-9C3B5F68665E@foghorn.io>
	<47126B68-3AF7-48AB-B904-4D8EAC854BC7@foghorn.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Hekster <ben.hekster@foghorn.io>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 19 Dec 2018, Ben Hekster via Qemu-devel wrote:
> 	While the crashing has stopped, the window isn't responsive to 
> keystrokes.  This includes the frame buffer emulation itself (so I can't 
> actually log in)

I'm not sure that's supposed to work. I could be wrong but I think USB is 
not emulated yet so likely no keyboard is attached that you could type 
with. The framebuffer is emulated so you can see output but only way to 
input is via serial if I'm not mistaken. That's what works for me.

> as well as the QEMU Monitor; nothing I type has any effect in either.

The monitor view should work though. Does it work without the patches? If 
you start with "qemu-system-arm -M raspi2 -S" you can probably try it 
before it crashes.

Regards,
BALATON Zoltan
