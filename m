Received: from eggs.gnu.org ([2001:4830:134:3::10]:52533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZIIy-0000W1-I9
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fZIIt-0002oC-OY
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:00:56 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fZIIt-0002mx-Id
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:00:51 -0400
Received: by mail-pg0-x241.google.com with SMTP id y1-v6so5275225pgv.1
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 09:00:51 -0700 (PDT)
References: <20180630083357.23489-1-huth@tuxfamily.org>
	<20180630083357.23489-2-huth@tuxfamily.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <49444120-add0-17fe-5e57-2d195be5d3ed@linaro.org>
Date: Sat, 30 Jun 2018 09:00:46 -0700
MIME-Version: 1.0
In-Reply-To: <20180630083357.23489-2-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/4] m68k: Add NeXTcube framebuffer
 device emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: Natalia Portillo <claunia@claunia.com>, Laurent Vivier <laurent@vivier.eu>, Bryce Lanham <blanham@gmail.com>

On 06/30/2018 01:33 AM, Thomas Huth wrote:
> +    uint32_t pal[4] = { 0xFFFFFFFF, 0xFFAAAAAA, 0xFF555555, 0xFF000000 };

static const.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
