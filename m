Received: from eggs.gnu.org ([2001:4830:134:3::10]:45927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPeUi-00075m-Oj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPeUf-0007k6-Hn
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:13:28 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gPeUd-0007Zp-Eo
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:13:25 -0500
Received: by mail-pl1-x641.google.com with SMTP id z23so8108405plo.0
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 18:13:18 -0800 (PST)
Date: Wed, 21 Nov 2018 18:13:17 -0800 (PST)
In-Reply-To: <9ee74477-105f-db2e-b69c-e67d485b9c2f@deltatee.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-105c249c-fc1f-4d85-bf75-5aeb17d95854@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 v7 5/6] hw/riscv/sifive_u: Connect
 the Xilinx PCIe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: logang@deltatee.com
Cc: linux@roeck-us.net, alistair23@gmail.com, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, abologna@redhat.com

On Wed, 21 Nov 2018 15:26:01 PST (-0800), logang@deltatee.com wrote:
>
>
> On 2018-11-21 4:10 p.m., Guenter Roeck wrote:
>> FWIW, I absoutely agree. If the board can only be used to boot an initrd,
>> it is quite pointless to have it around. Actually it is worse than pointless,
>> since it will result in people wasting their time trying to get it to work.
>
> As someone who has wasted their time on it, I second this sentiment.

So it sounds like I should target that deprecation patch set for 3.1?  Who 
wants to review it?
