Received: from eggs.gnu.org ([2001:4830:134:3::10]:48760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPli-0004mA-JG
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWPli-0005wD-07
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:50:26 -0500
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:42330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWPlh-0005vl-Ks
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 11:50:25 -0500
Received: by mail-pg0-x236.google.com with SMTP id q67so15262422pga.9
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 08:50:25 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-9-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9ca4c6cb-0a15-de72-b303-d05354dbda93@linaro.org>
Date: Tue, 2 Jan 2018 08:50:21 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-9-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/17] target/m68k: add move16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/01/2018 05:10 PM, Laurent Vivier wrote:
> +    mode = (insn >> 3) & 7;
> +
> +    if (mode & 4) {

Looks like mode should equal 4 as well.


r~
