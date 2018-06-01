Received: from eggs.gnu.org ([2001:4830:134:3::10]:51140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOqIr-0001TW-CW
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fOqIo-0004kN-5H
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:05:37 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fOqIn-0004em-Rf
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 16:05:34 -0400
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-3-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <50fa3a2c-bdaa-a276-9860-2b6fde29f58d@vivier.eu>
Date: Fri, 1 Jun 2018 22:05:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180531224911.23725-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/6] linux-user: Add host_fds and
 manipulators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, evgreen@chromium.org

Le 01/06/2018 à 00:49, Richard Henderson a écrit :
> This allows emulation of guest syscalls to reject
> manipulations to fds used by the host.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/qemu.h | 30 ++++++++++++++++++++++++++++++
>  linux-user/main.c | 27 ++++++++++++++++++++++++++-
>  2 files changed, 56 insertions(+), 1 deletion(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
