Received: from eggs.gnu.org ([2001:4830:134:3::10]:52793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmb1s-0006Mk-SA
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 04:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fmb1r-0001k6-UJ
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 04:38:16 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fmb1r-0001jJ-G5
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 04:38:15 -0400
Received: by mail-oi0-x244.google.com with SMTP id q11-v6so20705597oic.12
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 01:38:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180803211129-mutt-send-email-mst@kernel.org>
References: <20180803083830.775669-1-mst@redhat.com>
	<CAFEAcA9r4K9qgFFqvRKqTFMUowyAAEV=QZEnhk3eheQRodbnvA@mail.gmail.com>
	<20180803211129-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Aug 2018 09:37:54 +0100
Message-ID: <CAFEAcA-rZ3Tu-u02TwGn8US_9fom+mtEy3eDxZAsFn_fWDFH0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] pc, virtio: fixes
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

On 3 August 2018 at 19:14, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Aug 03, 2018 at 11:45:36AM +0100, Peter Maydell wrote:
>> On 3 August 2018 at 10:27, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > Please consider for 3.0 if there is another rc.
>> >
>> > The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:
>> >
>> >   Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)
>> >
>> > are available in the Git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>> >
>> > for you to fetch changes up to 1c707d6990eaf3db0c9dc4557bba5458977e9f8d:
>> >
>> >   tests/acpi: update tables after memory hotplug changes (2018-08-03 11:35:21 +0300)
>> >
>> > ----------------------------------------------------------------
>> > pc, virtio: fixes
>> >
>> > A couple of last minute fixes.
>> >
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> >
>> > ----------------------------------------------------------------
>> > Dou Liyang (2):
>> >       hw/acpi-build: Add a check for memory-less NUMA nodes
>> >       tests/acpi-test: update ACPI tables test blobs
>
> This fixes a regression but from an older release.
>
>
>> >
>> > Igor Mammedov (1):
>> >       pc: acpi: fix memory hotplug regression by reducing stub SRAT entry size
>
> This fixes a regression from 2.12.
>
>> > Michael S. Tsirkin (1):
>> >       tests/acpi: update tables after memory hotplug changes
>
> This will have to be re-done if we pick this but drop two other fixes.
>
>> >
>> > Tiwei Bie (1):
>> >       vhost: check region type before casting
>
> Not a regression but an obvious fix.

This is a regression, because it fixes a code change (by me)
that's new in this release.

thanks
-- PMM
