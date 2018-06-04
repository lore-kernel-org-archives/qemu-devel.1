Received: from eggs.gnu.org ([2001:4830:134:3::10]:44718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvAN-0000wn-0I
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fPvAJ-00047M-Rt
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:29:18 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60145)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fPvAJ-00046X-Gk
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 15:29:15 -0400
References: <20180601073050.8054-1-richard.henderson@linaro.org>
	<20180601073050.8054-3-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <2ca89c51-28a1-52da-24c1-ca2e43946cdb@vivier.eu>
Date: Mon, 4 Jun 2018 21:29:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180601073050.8054-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/33] linux-user: Relax single exit from
 "break"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 01/06/2018 à 09:30, Richard Henderson a écrit :
> Transform outermost "break" to "return ret".  If the immediately
> preceeding statement was an assignment to ret, return the value
> directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 969 +++++++++++++++++--------------------------
>  1 file changed, 390 insertions(+), 579 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
