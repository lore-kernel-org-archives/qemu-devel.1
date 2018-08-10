Received: from eggs.gnu.org ([2001:4830:134:3::10]:38001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1foDR8-0007un-4d
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1foDR7-0007Ex-Dt
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:51:02 -0400
References: <mailman.21049.1533850544.1289.qemu-devel@nongnu.org>
	<DD0AD40F-6B3E-489C-82A8-2DFCE2D03795@gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <06ef4fa5-ba66-b2c1-06c4-34cce9239ba9@reactos.org>
Date: Fri, 10 Aug 2018 21:50:50 +0200
MIME-Version: 1.0
In-Reply-To: <DD0AD40F-6B3E-489C-82A8-2DFCE2D03795@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/ppc: deprecate the machine type
 'prep', replaced by '40p'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>

Hello,

Le 10/08/2018 à 18:17, Programmingkid a écrit :
> 
> Can a real 40p machine boot Windows NT 4.0 PowerPC?
> 
> 

Yes.

A real 40p machine is able to run (at least):
- Windows NT (up to 4.0 SP1)
- AIX (up to 4.3.3)
- the beta of OS/2 PowerPC
- Solaris
- Linux
- NetBSD/PReP

However, Windows NT emulation doesn't work so well. OpenBIOS doesn't support (yet)
booting from the floppy drive.

Hervé
