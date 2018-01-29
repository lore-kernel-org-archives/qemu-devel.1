Received: from eggs.gnu.org ([2001:4830:134:3::10]:41301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg6Ic-00073S-Uf
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:04:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eg6Ib-00019u-V9
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:04:26 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:45366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eg6Ib-00019N-Qh
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:04:25 -0500
Received: by mail-oi0-x231.google.com with SMTP id c189so3927493oib.12
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 02:04:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129095330.GA2408@work-vm>
References: <20180124212246.2352-1-wei@redhat.com>
	<20180125200525.GC2442@work-vm>
	<6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
	<CAFEAcA_9HJBETLvsUs9dk=Hw-G_eswNt3R+o+fs70vM9buAeBA@mail.gmail.com>
	<20180126194559.GI2610@work-vm>
	<CAFEAcA_QgROXb-7ZbWhL6zM5RmqLK5hyU7Whh+-7REMsXghQmA@mail.gmail.com>
	<20180129095330.GA2408@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 10:04:04 +0000
Message-ID: <CAFEAcA97sfayAEypoArqg4zt5eiv-D9_VoXkeTqz3wn2LutF5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V1 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

On 29 January 2018 at 09:53, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> On 26 January 2018 at 19:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>> > * Peter Maydell (peter.maydell@linaro.org) wrote:
>> >> I think the correct fix here is that your test code should turn
>> >> its MMU on. Trying to treat guest RAM as uncacheable doesn't work
>> >> for Arm KVM guests (for the same reason that VGA device video memory
>> >> doesn't work). If it's RAM your guest has to arrange to map it as
>> >> Normal Cacheable, and then everything should work fine.
>> >
>> > Does this cause problems with migrating at just the wrong point during
>> > a VM boot?
>>
>> It wouldn't surprise me if it did, but I don't think I've ever
>> tried to provoke that problem...
>
> If you think it'll get the RAM contents wrong, it might be best to fail
> the migration if you can detect the cache is disabled in the guest.

I guess QEMU could look at the value of the "MMU disabled/enabled" bit
in the guest's system registers, and refuse migration if it's off...

(cc'd Marc, Christoffer to check that I don't have the wrong end
of the stick about how thin the ice is in the period before the
guest turns on its MMU...)

thanks
-- PMM
