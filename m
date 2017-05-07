Received: from eggs.gnu.org ([2001:4830:134:3::10]:48492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <netz.kernel@gmail.com>) id 1d79we-0003EA-80
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <netz.kernel@gmail.com>) id 1d79wZ-0002a9-4O
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:21:04 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:33652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <netz.kernel@gmail.com>)
	id 1d79wY-0002Zs-Ux
	for qemu-devel@nongnu.org; Sat, 06 May 2017 20:20:59 -0400
Received: by mail-oi0-x236.google.com with SMTP id w10so20078920oif.0
	for <qemu-devel@nongnu.org>; Sat, 06 May 2017 17:20:57 -0700 (PDT)
Received: from tha-monstah.mydomain (cpe-72-176-85-27.stx.res.rr.com.
	[72.176.85.27]) by smtp.gmail.com with ESMTPSA id
	w79sm4695388oiw.13.2017.05.06.17.20.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 06 May 2017 17:20:55 -0700 (PDT)
Date: Sat, 6 May 2017 19:23:26 -0500
From: Marty Plummer <netz.kernel@gmail.com>
Message-ID: <20170507002325.cg3rud5u5k5zqlsi@tha-monstah.mydomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] 'blank' address space for unknown arm peripherals?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Greetings.

Its my understanding that for creating machine definitions for qemu one
uses what amount to 'drivers' or 'hardware simulations'. I was wondering
if there was what amounted to a blank or raw memory area one could use
as a placeholder for a peripheral which is currently undocumented and
lacking source code for the linux kernel drivers the vendor ships.

My aim is to simulate as much of the hardware as I've managed to
positively identify (mostly primecell stuff) and use the
blank/placeholder address space to observe the interactions between the
blob drivers with the known address space within a simulated environment
to hopefully deduce the hardware registers for the peripherals (mostly
a/v & h264/jpeg stuff).

Any tips and tricks you could provide I would be greatly appreciative.

Marty.
