Received: from eggs.gnu.org ([209.51.188.92]:35852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghHkZ-00029P-UH
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:34:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ghHkY-0004rt-W8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:34:43 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ghHkY-0004qx-PS
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:34:42 -0500
Received: by mail-wr1-x42a.google.com with SMTP id u4so8549121wrp.3
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 09:34:42 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 9 Jan 2019 17:34:29 +0000
Message-ID: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Internship idea: virtio-blk oss-fuzz support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Bandan Das <bsd@redhat.com>, dvyukov@google.com

Hi folks,
I'd like to start fuzzing emulated devices in QEMU.  Here is an
internship project idea I'm proposing to do this.

Any thoughts?  Want to co-mentor this in Google Summer of Code or Outreachy?

Stefan

'''Summary:''' Integrate oss-fuzz into QEMU so that the virtio-blk
device can be fuzz tested.

oss-fuzz offers a fuzz testing service to open source projects.  This
means random inputs are continuously tested against the program in
order to find crashes and other bugs.  Fuzz testing complements
hand-written test suites by exploring the input space of a program and
therefore the code paths that may be taken.

The goal of this project is to integrate oss-fuzz into QEMU so that
the virtio-blk-pci device can be fuzzed at both the VIRTIO and PCI bus
level.  virtio-blk-pci is a PCI device, which means it is connected to
the virtual machine's PCI bus and has a certain set of registers that
can be programmed by the guest.  Furthermore, it is a VIRTIO device -
this is the specification the describes most of the functionality of
virtio-blk.  Bugs exist at both the PCI and VIRTIO levels, so it's
important to fuzz both of them.

Fuzzing emulated devices involves accessing their hardware registers
randomly to make the device respond.  QEMU has a device testing
interface called "qtest" that accepts read/write and other commands
over a socket and is ideal for writing device-level tests.  You may
find that oss-fuzz works better integrated directly into the QEMU
program instead of as a separate qtest program, so you can consider
adding a new command-line option to QEMU for running in oss-fuzz mode.

This project involves learning about VIRTIO and PCI devices, as well
as figuring out how to integrate oss-fuzz into QEMU so that it can
effective explore the code paths in virtio-blk device emulation code.
You will enjoy this project if you want to learn how device emulation
works and are interested in fuzzers.

'''Links:'''
* [https://github.com/google/oss-fuzz/blob/master/docs/ideal_integration.md
oss-fuzz integration overview]
* [https://github.com/google/fuzzer-test-suite/blob/master/tutorial/libFuzzerTutorial.md
libfuzzer tutorial]
* [http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html
VIRTIO specification]
* [https://wiki.osdev.org/PCI PCI bus overview]

'''Details:'''
* Skill level: intermediate
* Language: C
* Mentor: Stefan Hajnoczi <stefanha@redhat.com>
