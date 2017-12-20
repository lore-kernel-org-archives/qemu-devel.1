Received: from eggs.gnu.org ([2001:4830:134:3::10]:36531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eRlUW-0006q9-53
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eRlUT-0000fW-Lo
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:01:28 -0500
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:36156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eRlUT-0000f5-El
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:01:25 -0500
Received: by mail-pg0-x234.google.com with SMTP id k134so12393227pga.3
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 13:01:25 -0800 (PST)
References: <20171220203528.21334-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a4a917b-4e9c-e7c4-83ed-5835fc6d6418@linaro.org>
Date: Wed, 20 Dec 2017 13:01:21 -0800
MIME-Version: 1.0
In-Reply-To: <20171220203528.21334-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: add monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 12/20/2017 12:35 PM, Laurent Vivier wrote:
> +const MonitorDef monitor_defs[] = {

static.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
