Received: from eggs.gnu.org ([2001:4830:134:3::10]:49329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK0l1-0004l4-TP
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK0cJ-00061q-9B
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:38:00 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK0cH-0005yu-DU
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:37:57 -0500
Received: by mail-oi1-x244.google.com with SMTP id i138-v6so7553016oib.1
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 04:37:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <BN6PR18MB122007CFC965C45DF2CA20BB9FCB0@BN6PR18MB1220.namprd18.prod.outlook.com>
References: <20181106115351.9422-1-ppandit@redhat.com>
	<CAFEAcA880MNu+_C1ySic7ASsQNMth1FCGSjHJg_N7Ud+s4G_PA@mail.gmail.com>
	<BN6PR18MB122007CFC965C45DF2CA20BB9FCB0@BN6PR18MB1220.namprd18.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 12:37:34 +0000
Message-ID: <CAFEAcA9Q6-xw+GQLFUbGp6tfGMEg9_usx18AYbPdd4tiz7KSKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] lsi53c895a: check script ram address value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: li qiang <liq3ea@outlook.com>
Cc: P J P <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>

On 6 November 2018 at 12:27, li qiang <liq3ea@outlook.com> wrote:
> The addr is 0~0x1fff, but when addr is at the near the end ,for example
> 0x1fffe, the add>>2 can be 2047
>
> and as script_ram is a uint32_t and so s->script_ram[addr >> 2] can read
> out of the script_ram.

But script_ram is declared as
  uint32_t script_ram[2048];
so if addr >> 2 == 2047, that's still in-bounds, isn't it?

thanks
-- PMM
