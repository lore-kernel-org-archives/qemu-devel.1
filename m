Received: from eggs.gnu.org ([2001:4830:134:3::10]:58767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG7fm-0000yy-UT
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gG7fl-0005yN-EN
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:21:30 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gG7fl-0005xs-A0
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 15:21:29 -0400
Received: by mail-oi1-x241.google.com with SMTP id e14-v6so1954551oie.12
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 12:21:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cb0e3ee3-6f69-b501-d5c9-f2297886a376@amd.com>
References: <20181025005110.249256-1-mst@redhat.com>
	<CAFEAcA9zqAOr7F_Pu1tqxJYd=4JMHa3XgR703Mb4B9LibOGB-w@mail.gmail.com>
	<20181025205612-mutt-send-email-mst@kernel.org>
	<cb0e3ee3-6f69-b501-d5c9-f2297886a376@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Oct 2018 20:21:06 +0100
Message-ID: <CAFEAcA9YMPmACmMLmV-Q45=kCztJ80q3B5nA3usBWGeDesvMvw@mail.gmail.com>
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
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 26 October 2018 at 14:26, Singh, Brijesh <brijesh.singh@amd.com> wrote:
>
>
> On 10/25/2018 07:59 PM, Michael S. Tsirkin wrote:
>> On Thu, Oct 25, 2018 at 08:16:44PM +0100, Peter Maydell wrote:
>>> These should presumably all be "ULL". (The "UL" suffix is
>>> usually a bug, as it's either unnecessary or should be ULL.)
>>
>> Yea.  Fixed. Brijesh could you start cleaning up that header generally?
>> It has all kind of weird code like using bitfields for hardware
>> accesses. That isn't portable - switch to full dword fields with shift
>> and | to operate them and proper cpu_to_le APIs or similar please.
>>
>
>
> Noted, I will look into cleaning up this and send patches for reviews.

Thanks. You might like to look at the extract32()/extract64()/
deposit32()/deposit64() functions in bitops.h, which are often (but not
always) cleaner than hand-rolled shifts-and-logical-ops for assembling
and disassembling fields.

thanks
-- PMM
