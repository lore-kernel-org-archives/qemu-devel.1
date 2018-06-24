Received: from eggs.gnu.org ([2001:4830:134:3::10]:50027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fX9me-0001Mn-Kq
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 14:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fX9mb-00078r-HM
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 14:30:44 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:43057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fX9mb-000789-9b
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 14:30:41 -0400
Received: by mail-pg0-x241.google.com with SMTP id a14-v6so5062487pgw.10
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 11:30:40 -0700 (PDT)
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
	<bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
	<4CC477CD-237F-480D-B9B5-B35FF507BD3C@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6d132e2-b2e0-5bbb-7b71-9bd13253aa22@linaro.org>
Date: Sun, 24 Jun 2018 11:30:36 -0700
MIME-Version: 1.0
In-Reply-To: <4CC477CD-237F-480D-B9B5-B35FF507BD3C@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06/24/2018 06:46 AM, Programmingkid wrote:
>> Even in your referenced PDF, table 3-13, it says that frD is unmodified.
> 
> Actually it says when FPSCR[ZE] is set is when frD is unmodified. When FPSCR[ZE] is not set it frD's sign is determined by an XOR of the signs of the operands. I have verified that this is what happens on real PowerPC 750 and 950 CPUs. 


Of course.  When ZE is not set, 1 / 0 -> inf (and -1 / 0 -> -inf, etc).
But ZE not set is not the topic of discussion, or the subject of your patch.


> I was just wondering are you able to run a PowerPC operating system in QEMU
> in KVM mode on this Power7 computer?

Sadly not.  KVM is not enabled in this setup.


r~
