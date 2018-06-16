Received: from eggs.gnu.org ([2001:4830:134:3::10]:35880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ahmedsoliman0x666@gmail.com>) id 1fU9i7-0002gV-JE
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 07:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ahmedsoliman0x666@gmail.com>) id 1fU9i6-0006dY-Ht
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 07:49:39 -0400
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:51054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ahmedsoliman0x666@gmail.com>)
	id 1fU9i6-0006cJ-C6
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 07:49:38 -0400
Received: by mail-it0-x22e.google.com with SMTP id u4-v6so6186869itg.0
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 04:49:37 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Soliman <ahmedsoliman0x666@gmail.com>
Date: Sat, 16 Jun 2018 13:49:36 +0200
Message-ID: <CAAGnT3bjYPu9bordn_Dh8z+MW6p5DDLoSsZC9xg8QxQriVus9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Design Decision for KVM based anti rootkit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, Kernel Hardening <kernel-hardening@lists.openwall.com>, riel@redhat.com, Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Hossam Hassan <7ossam9063@gmail.com>, Ahmed Lotfy <A7med.lotfey@gmail.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org

Following up on these threads:
- https://marc.info/?l=kvm&m=151929803301378&w=2
- http://www.openwall.com/lists/kernel-hardening/2018/02/22/18

I lost the original emails so I couldn't reply to them, and also sorry
for being late, it was the end of semester exams.

I was adviced on #qemu and #kernelnewbies IRCs to ask here as it will
help having better insights.

To wrap things up, the basic design will be a method for communication
between host and guest is guest can request certain pages to be read
only, and then host will force them to be read-only by guest until
next guest reboot, then it will impossible for guest OS to have them
as RW again. The choice of which pages to be set as read only is the
guest's. So this way mixed pages can still be mixed with R/W content
even if holds kernel code.

I was planning to use KVM as my hypervisor, until I found out that KVM
can't do that on its own so one will need a custom virtio driver to do
this kind of guest-host communication/coordination, I am still
sticking to KVM, and have no plans to do this for Xen at least for
now, this means that in order to get it to work there must be a QEMU
support our specific driver we are planning to write in order for
things to work properly.

The question is is this the right approach? or is there a simpler way
to achieve this goal?
