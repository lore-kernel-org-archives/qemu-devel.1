Received: from eggs.gnu.org ([2001:4830:134:3::10]:43589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX7Z1-0006Vu-3p
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX7Yw-0002WC-4O
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:31:43 -0500
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d]:34661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX7Yv-0002W1-VU
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:31:38 -0500
Received: by mail-vk0-x22d.google.com with SMTP id r136so176396401vke.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:31:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170112113619.zuc5tuhmhzvawnmz@hawk.localdomain>
References: <98b1ad64-fe10-4ede-3493-f6d4b49ee1d9@sysgo.com>
	<CAFEAcA8asry6LGTuv+SLVyemNVFk9Q7WhU74Cc2YA_yud8qPMg@mail.gmail.com>
	<20170112113619.zuc5tuhmhzvawnmz@hawk.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 14:31:16 +0000
Message-ID: <CAFEAcA_OBx2ADDOU6Z6_27+EdbWS-1QJde5mB+sKrv0wYrKG1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] pflash_cfi01: fix per device sector length
 in CFI table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: David Engraf <david.engraf@sysgo.com>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 12 January 2017 at 11:36, Andrew Jones <drjones@redhat.com> wrote:
> On Thu, Jan 12, 2017 at 10:42:41AM +0000, Peter Maydell wrote:
>> Thanks for the patch. I haven't checked against the pflash spec yet,
>> but this looks like it's probably the right thing.
>>
>> The only two machines which use a setup with multiple devices (ie
>> which specify device_width to the pflash_cfi01) are vexpress and virt.
>> For all other machines this patch leaves the behaviour unchanged.
>>
>> Q: do we need to have some kind of nasty hack so that pre-2.9 virt
>> still gets the old broken values in the CFI table, for version and
>> migration compatibility? Ccing Drew for an opinion...
>>
>
> I'm pretty sure we need the nasty hack, but I'm also Ccing David for
> his opinion.

So given our decision about not needing the back-compat property
for the UEFI table entry, do we still agree that we need one here?

thanks
-- PMM
