Received: from eggs.gnu.org ([2001:4830:134:3::10]:58746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kpe-0003JG-S8
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5kpe-00019f-2A
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:24:34 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5kpd-00018u-Rc
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:24:33 -0400
Received: by mail-pl0-x241.google.com with SMTP id t20-v6so3749045ply.9
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 21:24:33 -0700 (PDT)
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<cbad2760-7a64-7602-5734-eea0747c620f@mail.uni-paderborn.de>
	<20180409161101.GB18168@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <565df28d-2f24-1065-c00a-4cceaf5428b4@linaro.org>
Date: Tue, 10 Apr 2018 14:24:23 +1000
MIME-Version: 1.0
In-Reply-To: <20180409161101.GB18168@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/17] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc/riscv targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Michael Clark <mjc@sifive.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 04/10/2018 02:11 AM, Emilio G. Cota wrote:
> On Mon, Apr 09, 2018 at 16:01:36 +0200, Bastian Koppelmann wrote:
>> Thanks for doing this grunt work. Me and a colleague were planning to do
>> this as well after converting the RISC-V frontend to decodetree. Do you
>> have any plans to do this for the TriCore frontend as well? I have the
>> same plan for Tricore: Convert it to decodetree, then to translation loop.
> 
> I won't do any further conversions in the near future, so please go
> ahead with your plans :-)

In which case I won't review Emilio's final two patches for risc-v.


r~
