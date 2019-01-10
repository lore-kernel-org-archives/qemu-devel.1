Received: from eggs.gnu.org ([209.51.188.92]:52261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1ghaf1-0003tl-1e
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1ghaf0-00081s-0k
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:46:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1ghaez-00080O-PS
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:46:13 -0500
From: Bandan Das <bsd@redhat.com>
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
Date: Thu, 10 Jan 2019 08:40:41 -0500
In-Reply-To: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	(Stefan Hajnoczi's message of "Wed, 9 Jan 2019 17:34:29 +0000")
Message-ID: <jpgsgy0aaw6.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Internship idea: virtio-blk oss-fuzz support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, dvyukov@google.com

Hi Stefan,

Stefan Hajnoczi <stefanha@gmail.com> writes:

> Hi folks,
> I'd like to start fuzzing emulated devices in QEMU.  Here is an
> internship project idea I'm proposing to do this.
>
> Any thoughts?  Want to co-mentor this in Google Summer of Code or Outreachy?
>
> Stefan
>
> '''Summary:''' Integrate oss-fuzz into QEMU so that the virtio-blk
> device can be fuzz tested.
>
> oss-fuzz offers a fuzz testing service to open source projects.  This
> means random inputs are continuously tested against the program in
> order to find crashes and other bugs.  Fuzz testing complements
> hand-written test suites by exploring the input space of a program and
> therefore the code paths that may be taken.
>
> The goal of this project is to integrate oss-fuzz into QEMU so that
> the virtio-blk-pci device can be fuzzed at both the VIRTIO and PCI bus
> level.  virtio-blk-pci is a PCI device, which means it is connected to
> the virtual machine's PCI bus and has a certain set of registers that
> can be programmed by the guest.  Furthermore, it is a VIRTIO device -
> this is the specification the describes most of the functionality of
> virtio-blk.  Bugs exist at both the PCI and VIRTIO levels, so it's
> important to fuzz both of them.
>
> Fuzzing emulated devices involves accessing their hardware registers
> randomly to make the device respond.  QEMU has a device testing
> interface called "qtest" that accepts read/write and other commands
> over a socket and is ideal for writing device-level tests.  You may
> find that oss-fuzz works better integrated directly into the QEMU
> program instead of as a separate qtest program, so you can consider
> adding a new command-line option to QEMU for running in oss-fuzz mode.

This sounds very interesting and if successful can easily be a stepping stone
to other sections. I would be interested in co-mentoring specifically focusing
on the PCI code.

One of the things I remember getting into trouble with when I was trying to hack
on this, especially fuzzing Qemu as a whole is what would the run environment
be like ? Would Qemu attempt to run a regular guest in oss-fuzz mode or only
a certain part of Qemu (emulated devices for example) be somehow run without
interacting with other dependent components ?

Bandan

>
> This project involves learning about VIRTIO and PCI devices, as well
> as figuring out how to integrate oss-fuzz into QEMU so that it can
> effective explore the code paths in virtio-blk device emulation code.
> You will enjoy this project if you want to learn how device emulation
> works and are interested in fuzzers.
>
> '''Links:'''
> * [https://github.com/google/oss-fuzz/blob/master/docs/ideal_integration.md
> oss-fuzz integration overview]
> * [https://github.com/google/fuzzer-test-suite/blob/master/tutorial/libFuzzerTutorial.md
> libfuzzer tutorial]
> * [http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html
> VIRTIO specification]
> * [https://wiki.osdev.org/PCI PCI bus overview]
>
> '''Details:'''
> * Skill level: intermediate
> * Language: C
> * Mentor: Stefan Hajnoczi <stefanha@redhat.com>
