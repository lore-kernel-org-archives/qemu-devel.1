Received: from eggs.gnu.org ([2001:4830:134:3::10]:49287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLnnb-0000n2-EZ
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:16:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLnna-0007y4-FL
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:16:31 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:44587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eLnna-0007xw-9N
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 05:16:30 -0500
Received: by mail-oi0-x22b.google.com with SMTP id l6so791690oih.11
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 02:16:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171203064856-mutt-send-email-mst@kernel.org>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
	<CAFEAcA-B7nMNTj6+HOSu=qUzaK3+Me83v_OG04=a2W4MU-KziA@mail.gmail.com>
	<20171203064856-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Dec 2017 10:16:08 +0000
Message-ID: <CAFEAcA_yWQqGAzDuaPZo9vgwVywq9QazToVy7CYncVvSfhxDKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] pc, pci, virtio: fixes for rc3
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

On 3 December 2017 at 04:56, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Fri, Dec 01, 2017 at 06:05:25PM +0000, Peter Maydell wrote:
>> On 1 December 2017 at 17:08, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > Chao Gao (1):
>> >       i386/msi: Correct mask of destination ID in MSI address
>> >
>> > Greg Kurz (1):
>> >       vhost: fix error check in vhost_verify_ring_mappings()
>> >
>> > Igor Mammedov (1):
>> >       pc: fix crash on attempted cpu unplug
>> >
>> > Marc-Andr=C3=A9 Lureau (1):
>> >       dump-guest-memory.py: fix No symbol "vmcoreinfo_find"
>> >
>> > Maxime Coquelin (2):
>> >       virtio: Add queue interface to restore avail index from vring us=
ed index
>> >       vhost: restore avail index from vring used index on disconnectio=
n
>> >
>> > Prasad J Pandit (1):
>> >       virtio: check VirtQueue Vring object is set
>>
>> Are any of these so important that we would absolutely refuse
>> to release without the fixes (ie they justify rolling an rc4
>> that we would otherwise not have needed) ?

> The msi one is less important it just happened to be queued a while ago
> and I didn't want to rebase all testing. Others are crashers but they
> don't affect everyone. So I wouldn't be sure, but there's also a
> security fix in there, so yes, I suspect we are better off with rc4, and
> if we do I think including others is justified (except maybe the msi
> one, if you feel strongly I'll rebase and drop it).

The bar has to be set quite high here, because if it turns out
that there are problems with a bug fix then we are out of time
to rework or revert it. And the more fixes we throw in at the
last minute, even if they're individually simple, the more
likely that one of them turns out to have unexpected consequences.

So: were any of these bugs present in the 2.10 release? If so,
that strongly argues for not trying to fix them at this point.

With all of these patches plus David Gibson's, that would be
10 new patches in rc4. That is definitely more than would be
ideal.

thanks
-- PMM
