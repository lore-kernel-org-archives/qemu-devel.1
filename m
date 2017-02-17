Received: from eggs.gnu.org ([2001:4830:134:3::10]:52668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cehrd-0007ZH-IR
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cehrZ-0007VC-Kj
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:42:17 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cehrZ-0007Uh-Em
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:42:13 -0500
Received: by mail-wm0-x22f.google.com with SMTP id v77so9298492wmv.0
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 04:42:13 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <b87f8e22-1346-b1fb-90a9-572c56c36c55@richardpeters.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f68cce3-8417-79bf-e352-e25a10163e6a@redhat.com>
Date: Fri, 17 Feb 2017 13:42:15 +0100
MIME-Version: 1.0
In-Reply-To: <b87f8e22-1346-b1fb-90a9-572c56c36c55@richardpeters.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Interconnect two qemu (Stellaris LM3S6965EVB)
 instances via I2C
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Peters <mail@richardpeters.de>, qemu-devel@nongnu.org



On 17/02/2017 13:27, Richard Peters wrote:
> Hi Community,
> 
> The Qemu target 'LM3S6965EVB' supports I2C.
> I have two firmware versions for a LM3S6965EVB chip that i want to test
> with qemu. One is the master and the other is slave.
> They use I2C drivers for the LM3S6965EVB chip.

There is no solution for this and, in addition, QEMU's I2C controller
emulation only supports master mode.

I have long been thinking of adding support for I2C-to-chardev bridge,
where a QEMU device would connect to a character device backend
(typically a socket) and the data on the character device would
represent commands to/from an I2C slave.  Likewise, adding a character
device backend to an I2C controller, speaking the same protocol, would
make it possible to implement slave mode.  However, none of this is
available in QEMU.

The first step would be to implement some kind of asynchronous API in
I2CSlave, to be able to do clock stretching ("no data available on the
socket" would then stretch the clock).

Paolo

> How can i connect these two instances?
> I didn't found a simple solution for that in the docs or in google.
> Is there a simple solution without virtio driver coding, etc?
> 
> Hope you can help me with that :-)
> 
> Thank you and regards,
> Richard
> 
> 
