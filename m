Received: from eggs.gnu.org ([2001:4830:134:3::10]:35839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1efoZz-0003r6-Sc
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 10:09:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1efoZy-0007v4-UZ
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 10:09:11 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1efoZy-0007uS-Ou
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 10:09:10 -0500
Received: by mail-ot0-x232.google.com with SMTP id d7so4347535oti.0
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 07:09:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180126194559.GI2610@work-vm>
References: <20180124212246.2352-1-wei@redhat.com>
	<20180125200525.GC2442@work-vm>
	<6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
	<CAFEAcA_9HJBETLvsUs9dk=Hw-G_eswNt3R+o+fs70vM9buAeBA@mail.gmail.com>
	<20180126194559.GI2610@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Jan 2018 15:08:49 +0000
Message-ID: <CAFEAcA_QgROXb-7ZbWhL6zM5RmqLK5hyU7Whh+-7REMsXghQmA@mail.gmail.com>
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
Cc: Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>

On 26 January 2018 at 19:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> I think the correct fix here is that your test code should turn
>> its MMU on. Trying to treat guest RAM as uncacheable doesn't work
>> for Arm KVM guests (for the same reason that VGA device video memory
>> doesn't work). If it's RAM your guest has to arrange to map it as
>> Normal Cacheable, and then everything should work fine.
>
> Does this cause problems with migrating at just the wrong point during
> a VM boot?

It wouldn't surprise me if it did, but I don't think I've ever
tried to provoke that problem...

thanks
-- PMM
