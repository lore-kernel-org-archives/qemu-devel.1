Received: from eggs.gnu.org ([2001:4830:134:3::10]:55693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1f69JB-0005Ph-Iu
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 02:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1f69J7-0001tq-FD
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 02:32:41 -0400
Received: from ssl.serverraum.org ([213.133.101.245]:55007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1f69J7-0001mS-5H
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 02:32:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Apr 2018 08:32:14 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <1523377186-32578-4-git-send-email-cota@braap.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
	<1523377186-32578-4-git-send-email-cota@braap.org>
Message-ID: <7bd247fa01ebf8667685b80242650dd7@walle.cc>
Subject: Re: [Qemu-devel] [PATCH 03/10] target/lm32: avoid integer overflow
 in next_page PC check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

Am 2018-04-10 18:19, schrieb Emilio G. Cota:
> If the PC is in the last page of the address space, next_page_start
> overflows to 0. Fix it.
> 
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Acked-by: Michael Walle <michael@walle.cc>
