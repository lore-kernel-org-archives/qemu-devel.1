Received: from eggs.gnu.org ([2001:4830:134:3::10]:50488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5vJg-0001XI-Nl
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5vJa-00059I-OY
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:36:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59315)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f5vJa-00058S-E3
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:36:10 -0400
References: <20180314153121.23838-1-james.cowgill@mips.com>
	<20180315151348.6451-1-james.cowgill@mips.com>
	<67a47930-6e97-296a-e918-beb3d75b7a87@vivier.eu>
	<CAFEAcA8wrCH5PpPdCbD-5zBZjAHFMbArsAQ6r=dZ6HjseyfMDg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <81fef02e-c73b-d422-73b4-67371bdda8bb@vivier.eu>
Date: Tue, 10 Apr 2018 17:34:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8wrCH5PpPdCbD-5zBZjAHFMbArsAQ6r=dZ6HjseyfMDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: implement HWCAP bits on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, James Cowgill <james.cowgill@mips.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Le 10/04/2018 à 15:53, Peter Maydell a écrit :
> On 15 March 2018 at 15:25, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 15/03/2018 à 16:13, James Cowgill a écrit :
>>> Add support for the two currently defined HWCAP bits on MIPS - R6 and
>>> MSA.
>>>
>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1754372
>>> Signed-off-by: James Cowgill <james.cowgill@mips.com>
>>> ---
>>> v2 changes:
>>>  - Fix kernel hwcap.h path.
>>>
>>>  linux-user/elfload.c | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Hi Peter,

> Hi Laurent -- did this MIPS HWCAP fix get lost somewhere? I can't
> see it in master or your latest pullreq.

yes, I've missed it. I add it to my pull request.

Thank you,
Laurent
