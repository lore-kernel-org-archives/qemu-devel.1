Received: from eggs.gnu.org ([2001:4830:134:3::10]:60932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbGV2-00029y-Hl
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbGUz-0000Z2-7j
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:52:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbGUy-0000Xs-Uz
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 19:52:41 -0500
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<20170118181918.783cb7bd@nial.brq.redhat.com>
	<CAAibmn0OEBsZUyxuKcssk-4V-=fA94QWFCk04Lt9rbFN66OgEg@mail.gmail.com>
	<20170131165802-mutt-send-email-mst@kernel.org>
	<fe787fcc-0c92-5842-1a67-b50466b6f38f@redhat.com>
	<CAAibmn1eEFMdn_-hcaFudOO8D7crkfYYw+k88=CGJfJ0fmU6JA@mail.gmail.com>
	<58a49e30-7e64-9d0f-3a45-f0ff19e72210@redhat.com>
	<CAAibmn1teqEghW0C5qSKL3zJXkH9obkLfKZ3VtBjuu4U2V99kw@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <19398592-8b69-9fd3-5532-c53234a07837@redhat.com>
Date: Wed, 8 Feb 2017 01:52:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAAibmn1teqEghW0C5qSKL3zJXkH9obkLfKZ3VtBjuu4U2V99kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 02/07/17 22:02, Phil Dennis-Jordan wrote:
> On 7 February 2017 at 20:54, Laszlo Ersek <lersek@redhat.com> wrote:

>> I filed <https://bugzilla.tianocore.org/show_bug.cgi?id=368>.
> 
> That looks nice and thorough.
> 
>>> Your EDK2 patch
>>
>> For the record:
>> [1] https://lists.01.org/pipermail/edk2-devel/2017-February/007072.html
>>
>>> fixes the problem with values OVMF writes to
>>> DSDT/X_DSDT, but the issue of it refusing Qemu's linker commands for
>>> those two still needs to be solved so that SeaBIOS can boot a wide
>>> range of OSes.
>>>
>>> I'd be happy to give writing the memoising patch a go myself if that
>>> helps. Looks like setting up an ORDERED_COLLECTION during phase 2
>>> might be the simplest solution?
>>
>> Thanks for the offer. :)
>>
>> * If you'd like to help me with my load and reach a good "development
>>   throughput", then I prefer to write the patch myself. On this
>>   *specific* occasion, I think it will be faster.
>>
>>   I intend to send an OVMF series this week that addresses both
>>   TianoCore#368 (see above) and TianoCore#359 too (mentioned earlier).
>>   Both are for OvmfPkg/AcpiPlatformDxe, and it makes sense to round
>>   them up.
>>
>>   I plan to CC the QEMU stakeholders as appropriate. Your feedback
>>   would be greatly appreciated; the same way as [1] is very helpful
>>   (thanks again for it!)
>>
>> * If your main interest is rather to get into OVMF development, then I
>>   positively welcome that, and encourage you to send the patch.
>>   Completing the patch will likely take longer (the edk2 coding style
>>   is... arcane... and your reviewer is somewhat pedantic :)), but if
>>   you plan to get into OVMF development, then it's worth both our times.
>>
>> (The above should not be misunderstood as "Laszlo doesn't value one-off
>> contributions" -- it really depends on feature size and area. Hence the
>> emphasis on "specific" above.)
>>
>> Your call :) If possible, please let me know it tomorrow.
> 
> I actually ended up writing said pointer memoisation patch yesterday,
> and it appears to work fine in initial tests. I still need to fully
> work my way through the edk2 coding and contribution guidelines, so
> I'll need to re-visit that patch with a fine tooth comb before
> submitting it. In any case, here it is so far:
> https://github.com/pmj/edk2/commit/58e0510c6da62d5a985b97e9bff84bc53442d3fe
> 
> I am intending to submit more patches to edk2 over time - like this
> one, they'll mostly be based on Reza Jelveh's GSoC project from a few
> years ago. Some of his work on getting OS X/macOS guests working in
> Qemu/OVMF have got upstreamed, most of it has not. I'm hoping I can
> improve the ratio a little.
> 
> I've also written an EFI framebuffer driver for the VMware virtual
> SVGA adapter in Qemu, which again I need to tidy up to conform with
> the coding conventions before submitting. (The only advantage of this
> vs. QXL or virtio-gpu being that there are OSes, including OSX/macOS
> for which there exist drivers for neither QXL nor virtio-gpu.)
> 
> So I guess I may as well get some practice. :-)
> 
> 
> I anticipate submitting the memoisation patch for review on Thursday
> or Friday as I'll be out tomorrow.

Sounds good to me!

Thanks,
Laszlo
