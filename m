Received: from eggs.gnu.org ([2001:4830:134:3::10]:57985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHS8g-0001aY-8T
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHS8f-0002cZ-1Q
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:24:50 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:36971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHS8e-0002XN-FC
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:24:48 -0400
Received: by mail-oi1-x22f.google.com with SMTP id w66-v6so5713377oiw.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 04:24:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9-g-h8S7wucyMw+kmrZLnkeCSqnXc8ohNW_KhNxLv7hw@mail.gmail.com>
References: <20181025005110.249256-1-mst@redhat.com>
	<CAFEAcA9zqAOr7F_Pu1tqxJYd=4JMHa3XgR703Mb4B9LibOGB-w@mail.gmail.com>
	<20181025215914-mutt-send-email-mst@kernel.org>
	<CAFEAcA9-g-h8S7wucyMw+kmrZLnkeCSqnXc8ohNW_KhNxLv7hw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 11:24:25 +0000
Message-ID: <CAFEAcA-J4RmLR8kagRS3PBymFTF4qNqwE2MfbrYjNHUuXz1Tqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/28] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 October 2018 at 19:53, Peter Maydell <peter.maydell@linaro.org> wrote:
> It looks like the test/acpi-test-data/ in the build directory
> has not been populated with the MCFG.mmio64 file -- some of
> the data files have symlinks from that directory back to the
> source directory, but some do not. This seems to be done in
> configure, but there is nothing in the makefile rules which
> causes configure to be rerun because there is a new file
> in your test data directory. A manual rerun of configure
> adds the missing symlinks and causes the test to pass.
>
> So I would characterise this as a makefile issue.

Is there a reason why we need to symlink all the data files
in tests/acpi-test-data/ individually, rather than just
having tests/acpi-test-data itself be a symlink back to
the directory in the source tree ? That would avoid this
problem; it's how we handle tests/acceptance and tests/data.

thanks
-- PMM
