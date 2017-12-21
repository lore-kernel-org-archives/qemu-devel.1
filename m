Received: from eggs.gnu.org ([2001:4830:134:3::10]:39992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS9uU-0000wP-43
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS9uS-0003p7-TU
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:05:54 -0500
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:44784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eS9uS-0003oV-Oz
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 18:05:52 -0500
Received: by mail-it0-x241.google.com with SMTP id b5so12425119itc.3
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 15:05:52 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20171221223704-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Thu, 21 Dec 2017 20:05:51 -0300
Message-ID: <CAAdtpL74ZyVsLwgBjpbsdSHbWdY_Uq6ouRAvgo00UdVevTKq8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter, Michael,

On Thu, Dec 21, 2017 at 5:37 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Dec 21, 2017 at 08:26:47PM +0000, Peter Maydell wrote:
>> On 21 December 2017 at 14:27, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > The following changes since commit 2babfe0c9241c239272a03fec785165a50e8288c:
>> >
>> >   Update version for v2.11.0-rc4 release (2017-12-05 16:36:46 +0000)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>> >
>> > for you to fetch changes up to 664ed92706ff6e66fa278c3163b5387f11d6daca:
>> >
>> >   smbus: do not immediately complete commands (2017-12-21 16:24:44 +0200)
>> >
>> > ----------------------------------------------------------------
>> > pc, pci, virtio: features, fixes, cleanups
>> >
>> > A bunch of fixes, cleanus and new features all over the place.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> >
>>
>> Conflicts in hw/block/nvme.c -- can you fix and resend, please?
>>
> Done and pushed - I dropped the conflicting patch.

NACK :(

you also need to drop "hw/pci: remove obsolete PCIDevice->init()"
(applied in your tree as 18951fce55d5aa58cd1629b4cb704ee51bab4420)
else the not-yet-QOM'ified NVME won't work anymore.
