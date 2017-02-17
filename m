Received: from eggs.gnu.org ([2001:4830:134:3::10]:56378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ceqVI-0005fn-BC
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ceqVH-00013K-LD
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:55:48 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ceqVH-00013A-GF
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 16:55:47 -0500
Received: by mail-oi0-x242.google.com with SMTP id u143so1036996oif.3
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 13:55:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9eh475V6H6sOoW0bLhOH_351dxAyP=WhCShqPF4jVF2g@mail.gmail.com>
References: <20170214185225.7994-1-ppandit@redhat.com>
	<CAFEAcA9eh475V6H6sOoW0bLhOH_351dxAyP=WhCShqPF4jVF2g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Feb 2017 13:55:16 -0800
Message-ID: <CAKmqyKNT8dgqyU-yEo78tV-s69Q+Yw9Osb8=pJLrWVntCZUa5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 0/4] sd: sdhci: correct transfer mode
 register usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Fri, Feb 17, 2017 at 5:21 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 14 February 2017 at 18:52, P J P <ppandit@redhat.com> wrote:
>> From: Prasad J Pandit <pjp@fedoraproject.org>
>>
>> Hello,
>>
>> In SDHCI protocol, the 'Block Count Enable' bit of the Transfer Mode
>> register is used to control 's->blkcnt' value. This bit is not relevant
>> in single block transfers. Also, Transfer Mode register value could be
>> set such that 's->blkcnt' would not see an update during multi block
>> transfers. Thus leading to an infinite loop.
>>
>> This patch set attempts to correct 'Block Count Enable' bit usage.
>>
>> This series incorporates changes suggested in patch set v3:
>>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02376.html
>>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02905.html
>
> I've gone back through the mail archives for previous versions of
> this series, and I think that we just need review for patch 4 now?

Thanks Peter, I thought I had reviewed all of them.

I just reviewed patch 4, these should be good to go now then.

Thanks,

Alistair

>
> thanks
> -- PMM
