Received: from eggs.gnu.org ([2001:4830:134:3::10]:60951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ccDCF-0000u8-8K
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ccDCA-0002ep-BJ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:33:15 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:50357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ccDC9-0002eV-RC
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:33:10 -0500
References: <20170207183356.17840-1-laurent@vivier.eu>
	<CAFEAcA_XuEA01Cnsdd7Wq-ueH0zqjcinNasW-wkJ-Us3M_MkRg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <5d8f2613-4f41-0780-059a-3f5cb4bef83c@vivier.eu>
Date: Fri, 10 Feb 2017 16:33:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_XuEA01Cnsdd7Wq-ueH0zqjcinNasW-wkJ-Us3M_MkRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/5] risu: add m68k target support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Le 10/02/2017 à 16:25, Peter Maydell a écrit :
> On 7 February 2017 at 18:33, Laurent Vivier <laurent@vivier.eu> wrote:
>> This series add the files needed to test the m68k target.
>>
>> For the moment, it doesn't support FPU instructions.
>>
>> Laurent Vivier (5):
>>   m68k: implement risugen module
>>   m68k: implement server and client side
>>   m68k: add risufile with m68k instructions.
>>   m68k: add instruction needing an extended word
>>   m68k: manage memory block
> 
> Thanks for this; I think patches 1-3 are good, and have
> applied them to risu master. For 4 I wonder if we can
> find a better way of handling variable-length instruction
> sets than !post, and I haven't yet looked at 5.

I think it should be possible but I don't know perl well enough to
propose a better solution.

Thanks,
Laurent
