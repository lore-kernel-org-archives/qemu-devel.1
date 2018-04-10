Received: from eggs.gnu.org ([2001:4830:134:3::10]:51837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5tiR-0003ud-R2
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5tiQ-0004MV-My
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:53:43 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5tiQ-0004MF-HC
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:53:42 -0400
Received: by mail-oi0-x244.google.com with SMTP id 126-v6so11215970oig.0
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 06:53:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <67a47930-6e97-296a-e918-beb3d75b7a87@vivier.eu>
References: <20180314153121.23838-1-james.cowgill@mips.com>
	<20180315151348.6451-1-james.cowgill@mips.com>
	<67a47930-6e97-296a-e918-beb3d75b7a87@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 14:53:21 +0100
Message-ID: <CAFEAcA8wrCH5PpPdCbD-5zBZjAHFMbArsAQ6r=dZ6HjseyfMDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: implement HWCAP bits on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: James Cowgill <james.cowgill@mips.com>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>

On 15 March 2018 at 15:25, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 15/03/2018 =C3=A0 16:13, James Cowgill a =C3=A9crit :
>> Add support for the two currently defined HWCAP bits on MIPS - R6 and
>> MSA.
>>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1754372
>> Signed-off-by: James Cowgill <james.cowgill@mips.com>
>> ---
>> v2 changes:
>>  - Fix kernel hwcap.h path.
>>
>>  linux-user/elfload.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Hi Laurent -- did this MIPS HWCAP fix get lost somewhere? I can't
see it in master or your latest pullreq.

thanks
-- PMM
