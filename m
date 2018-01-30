Received: from eggs.gnu.org ([2001:4830:134:3::10]:38804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egWh8-0000M9-NJ
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egWh3-0008Qa-PH
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:15:30 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1egWh3-0008Px-GX
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:15:25 -0500
Received: by mail-qt0-f194.google.com with SMTP id g14so17388937qti.2
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 06:15:24 -0800 (PST)
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801232242.31243.pisa@cmp.felk.cvut.cz>
	<ca52867f-08bf-e79f-db63-0698ccd1a106@redhat.com>
	<201801252233.45477.pisa@cmp.felk.cvut.cz>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe13d005-de44-fea3-6102-e9723aac398a@redhat.com>
Date: Tue, 30 Jan 2018 15:15:22 +0100
MIME-Version: 1.0
In-Reply-To: <201801252233.45477.pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 0/7] CAN bus support for QEMU (SJA1000
 PCI so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 25/01/2018 22:33, Pavel Pisa wrote:
> Hello Paolo,
> 
> thanks for suggestions. I understand and fully agree with your
> request to switch to QOM. I have succeed with that for CAN devices
> some time ago. It worth to be done for the rest of the objects
> but I fear that I do not find time to complete QOMification
> in reasonable future. Contributions/suggestions from other
> are welcomed. I can look for students for GSoC at our university
> or under other funding.

Please take a look at branch can-pci-qom of github.com/bonzini/qemu.git.
 Apart from QOMification of the backend include, I simplified the IRQ
handling in can_kvaser_pci (fixing bugs too I think), and removed an
unnecessary mutex.  I also moved the files to net/can and hw/net/can so
that in the future Jason (networking maintainer) can take care of pull
requests.

I might have broken something, and the top commit in particular is
completely untested.

Paolo
