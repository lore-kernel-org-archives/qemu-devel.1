Received: from eggs.gnu.org ([2001:4830:134:3::10]:55534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1dofEK-00069c-I2
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ramysameh26@gmail.com>) id 1dofEF-0004Tm-O2
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:27:08 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:33219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ramysameh26@gmail.com>)
	id 1dofEF-0004SM-Fz
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 20:27:03 -0400
Received: by mail-oi0-x229.google.com with SMTP id r203so34140300oih.0
	for <qemu-devel@nongnu.org>; Sun, 03 Sep 2017 17:27:01 -0700 (PDT)
MIME-Version: 1.0
From: Ramy Sameh <ramysameh26@gmail.com>
Date: Mon, 4 Sep 2017 02:27:00 +0200
Message-ID: <CAF6HrYxj5BoTQpQjz95Z1_N_p615jpEE12xh_afuuqE4fcTyLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Questions regarding emulated UART in VersatilePB board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ahmed Aly <ahmedaly50@gmail.com>

Hello all,

I have 2 problems regarding UART (pl011) in the emulated board VersatilePB.
(I am using *QEMU version 2.8.1.*)

*My main goal is*:
Disturbing the UART registers (such UARTCR, UARTLCR_H ... etc) in order to
simulate hardware faults (which can make bit flips in the hardware
registers through radiation for example).


*My 2 questions are:*

*First:*
Are interrupts activated in the emulated pl011 ?
I mean, if I enabled the interrupt bits for UARTTXINTR, will this trigger
an interrupt when the FIFO reaches a certain level?

*Second:*
Another problem is that I can't find some of the UART registers (which are
in the data sheet PrimeCell UART (PL011)), in QEMU's emulated UART pl011.

*These are the registers which I can't find their matches in the structure
PL011State:*

1.) Interrupt FIFO level select register, UARTIFLS
2.) Raw interrupt status register, UARTRIS
3.) Masked interrupt status register, UARTMIS
4.) Interrupt clear register, UARTICR
5.) Peripheral identification registers, UARTPeriphID0-3
6.) PrimeCell identification registers, UARTPCellID0-3

*This is the structure where I get pl011 emulated registers:*
typedef struct PL011State
{
    SysBusDevice parent_obj;

    MemoryRegion iomem;
    uint32_t readbuff;
    uint32_t flags;
    uint32_t lcr;
    uint32_t rsr;
    uint32_t cr;
    uint32_t dmacr;
    uint32_t int_enabled;
    uint32_t int_level;
    uint32_t read_fifo[16];
    uint32_t ilpr;
    uint32_t ibrd;
    uint32_t fbrd;
    uint32_t ifl;
    int read_pos;
    int read_count;
    int read_trigger;
    CharBackend chr;
    qemu_irq irq;
    const unsigned char *id;
} PL011State

-- 
Best Regards,
Ramy Sameh
Embedded Software Engineer
+2-010-172-777-14
