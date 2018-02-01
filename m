Received: from eggs.gnu.org ([2001:4830:134:3::10]:40070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ehBoT-0000Z7-34
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ehBoS-0002cK-44
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:49 -0500
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:52864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ehBoR-0002bU-Tm
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:48 -0500
Received: by mail-it0-x235.google.com with SMTP id u62so3505374ita.2
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 02:09:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMJs5B8W7-yfco1qkWBY0FU4hiner05jp1jBycWwT6wCTegBfA@mail.gmail.com>
References: <20180124212246.2352-1-wei@redhat.com>
	<20180125200525.GC2442@work-vm>
	<6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
	<CAFEAcA_9HJBETLvsUs9dk=Hw-G_eswNt3R+o+fs70vM9buAeBA@mail.gmail.com>
	<20180126194559.GI2610@work-vm>
	<CAFEAcA_QgROXb-7ZbWhL6zM5RmqLK5hyU7Whh+-7REMsXghQmA@mail.gmail.com>
	<20180129095330.GA2408@work-vm>
	<CAFEAcA97sfayAEypoArqg4zt5eiv-D9_VoXkeTqz3wn2LutF5Q@mail.gmail.com>
	<a7c01a48-786b-81d7-7af8-fe80a15283f6@arm.com>
	<20180131095351.GY21802@cbox>
	<CAKv+Gu-NAcUTpEUXCLudHTCFAf=Yb28q3AET9d4ED9A9z7dMfQ@mail.gmail.com>
	<CAMJs5B8jctfTEEhui3XRCTW1La2HCoVd1Jzaz4p7jy=8vqw=0A@mail.gmail.com>
	<CAKv+Gu80p5G_gWp0Dg7HJ2SAgc3WCQe+g9ear9oM44bt-KmSFA@mail.gmail.com>
	<CAMJs5B_S0fO32=uh7iavn=BN1BC3=7qZAh1YcpVJFZoRC+GgOA@mail.gmail.com>
	<CAKv+Gu-dmNOnZbfJzuJ8BauGKktO_TaDRS29PuAftccfySw6ig@mail.gmail.com>
	<CAMJs5B8CWm2bj-Be_j4p9Y_3wXr=W2K7zE8593ke-97QR20qcA@mail.gmail.com>
	<CAKv+Gu935vi1wCRAKqC-nscXa+=CKX6P=HPO-3dNA4fx0Fm-NA@mail.gmail.com>
	<CAMJs5B-S=qVWYP2eTN1qsOQctmfUR8jCXBaz2DKyaKRT7LrAyA@mail.gmail.com>
	<CAKv+Gu-7d5jbt9V8bORkrZXxNmshMNjsqg+EiwhA-CYrNLFotA@mail.gmail.com>
	<CAMJs5B8W7-yfco1qkWBY0FU4hiner05jp1jBycWwT6wCTegBfA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 1 Feb 2018 10:09:46 +0000
Message-ID: <CAKv+Gu8BM8hAEJ8O+8N15aT0Unf1hvUcU5QCOzkx9OvWsnCFug@mail.gmail.com>
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
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Andrew Jones <drjones@redhat.com>

On 1 February 2018 at 09:59, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Thu, Feb 1, 2018 at 10:33 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 1 February 2018 at 09:17, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
...
>>>
>>> Unless I'm missing something fundamental, I think we should add
>>> functionality in QEMU to clean+invalidate pages on aarch64 hosts and
>>> see if that solves both VGA and migration, and if so, what the
>>> potential performance impacts are.
>>>
>>
>> Indeed.
>>
>> Identifying the framebuffer region is easy for QEMU, so there we can
>> invalidate (without clean) selectively.
>
> Do you think there's a material win of doing invalidate rather than
> clean+invalidate or could we just aim for "access coherent" ==
> "clean+invalidate" and we don't have to make any assumptions about how
> the guest is accessing a particular piece of memory?
>

In general, invalidate should be cheaper than clean, given that just
discarding the data involves less work than writing it back to memory.
Whether that actually holds in current SMP designs, and whether it
still applies when the memory can be assumed to be clean in the first
place are things I can't really answer.

>> However, although we'd
>> probably need to capture the state of the MMU bit anyway when handling
>> the stage 2 fault for the dirty page tracking, I don't think we can
>> generally infer whether a faulting access was made via an uncached
>> mapping while the MMU was on, and so this would require
>> clean+invalidate on all dirty pages when doing a migration.
>
> My gut feeling here is that there might be some very clever scheme to
> optimize cache maintenance of the 'hot pages' when dirty page tracking
> is enabled, but since the set of hot pages by virtue of migration
> algorithms has to be small, the win is not likely to impact anything
> real-life, and it's therefore not worth looking into.
>

Sounds reasonable.
