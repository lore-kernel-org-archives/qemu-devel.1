Received: from eggs.gnu.org ([2001:4830:134:3::10]:54403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fHzgU-0004u3-FC
	for qemu-devel@nongnu.org; Sun, 13 May 2018 18:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fHzNM-0003Mt-JQ
	for qemu-devel@nongnu.org; Sun, 13 May 2018 18:21:59 -0400
Received: from smtp42.i.mail.ru ([94.100.177.102]:40640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fHzNM-0003MH-7a
	for qemu-devel@nongnu.org; Sun, 13 May 2018 18:21:56 -0400
References: <1525936711-24538-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1525936711-24538-2-git-send-email-suhang16@mails.ucas.ac.cn>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <dd7e4184-2a2f-ed99-32b4-c37d32d74344@mail.ru>
Date: Mon, 14 May 2018 01:21:34 +0300
MIME-Version: 1.0
In-Reply-To: <1525936711-24538-2-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 1/2] Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, stefanha@gmail.com, darcysail@gmail.com
Cc: qemu-devel@nongnu.org

> This patch adds Intel Hexadecimal Object File format support to
> the loader.  The file format specification is available here:
> http://www.piclist.com/techref/fileext/hex/intel.htm
> 
> The file format is mainly intended for embedded systems
> and microcontrollers, such as Micro:bit Arduino, ARM, STM32, etc.
> 

The hex format is used mainly by Cortex-M boards. This code doesn't
support them, because armv7m uses its own load function. Could you add
support for armv7m?

Best regards, Julia Suvorova.
