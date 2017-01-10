Received: from eggs.gnu.org ([2001:4830:134:3::10]:36784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cR3Bx-00044U-9A
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cR3Bs-0004LL-OY
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:38:49 -0500
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11]:35798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1cR3Bs-0004G2-1J
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:38:44 -0500
References: <1483987437-12084-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <9db13b81-a3de-c482-956d-37e3479cdec6@reactos.org>
Date: Tue, 10 Jan 2017 21:38:25 +0100
MIME-Version: 1.0
In-Reply-To: <1483987437-12084-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/net/dp8393x: Avoid unintentional sign
 extensions on addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>

Le 09/01/2017 =E0 19:43, Peter Maydell a =E9crit :
> The dp8393x has several 32-bit values which are formed by concatenating
> two 16 bit device register values. Attempting to do these inline
> with ((s->reg[HI] << 16) | s->reg[LO]) can result in an unintended
> sign extension because "x << 16" is of type 'int' even though s->reg
> is unsigned, and so if the expression is used in a context where
> it is cast to uint64_t the value is incorrectly sign-extended.
> Fix this by using accessor functions with a uint32_t return type;
> this also makes the code a bit easier to read.
>
> This should fix Coverity issues 1307765, 1307766, 1307767, 1307768.
>
> (To avoid having a ctda read function only used in a DPRINTF,
> we move the DPRINTF down slightly so it can use the ttda function.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>
