Received: from eggs.gnu.org ([209.51.188.92]:33190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dvyukov@google.com>) id 1ghY6Q-0005nb-9o
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:02:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dvyukov@google.com>) id 1ghXrb-0007vA-7Q
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:47:09 -0500
Received: from mail-it1-x12a.google.com ([2607:f8b0:4864:20::12a]:56319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dvyukov@google.com>) id 1ghXrb-0007rY-0Y
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:47:03 -0500
Received: by mail-it1-x12a.google.com with SMTP id m62so16669500ith.5
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 02:47:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
In-Reply-To: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 10 Jan 2019 11:46:49 +0100
Message-ID: <CACT4Y+bQpQgUzDP+9Sr967m5bOJRR3k2o2EnERGZCE2ttB6Lwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>, Kostya Serebryany <kcc@google.com>, Max Moroz <mmoroz@google.com>, Andrey Konovalov <andreyknvl@google.com>

On Wed, Jan 9, 2019 at 6:34 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
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

Sounds great!
+some people from OSS-Fuzz as FYI

Once a first fuzzer paves the road, it should be much simpler to add
other fuzzers as well. E.g. image parsing, or instruction emulation (I
know it's not security critical, but given a cost effective way to
find bugs it may be worth it). I understand that a GSOC project should
have a limit scope, but I think paving the road is important part of
this.

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
