Received: from eggs.gnu.org ([2001:4830:134:3::10]:43399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fHo3a-0000lL-IH
	for qemu-devel@nongnu.org; Sun, 13 May 2018 06:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fHo3W-0002g3-G2
	for qemu-devel@nongnu.org; Sun, 13 May 2018 06:16:46 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fHo3W-0002f0-6d
	for qemu-devel@nongnu.org; Sun, 13 May 2018 06:16:42 -0400
References: <20180512050250.12774-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4b6e384a-a48e-c2c8-9970-dca67239723c@vivier.eu>
Date: Sun, 13 May 2018 12:16:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180512050250.12774-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1.1 0/9] target/m68k: Convert to
 TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le 12/05/2018 à 07:02, Richard Henderson a écrit :
> [ Ho, hum.  I didn't clear out my scratch directory before sending v1.0. ]
> 
> FYI, I've only tested this with linux-user-test-0.3 and
> our qemu coldfire testing kernel.

I've tested m68k-softmmu with Q800 emulation and started an LXC
container with m68k-linux-user:

Tested-by: Laurent Vivier <laurent@vivier.eu>
