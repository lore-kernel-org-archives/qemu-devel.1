Received: from eggs.gnu.org ([2001:4830:134:3::10]:54060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQXhb-0001SH-6w
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQXha-00087O-9W
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:01:23 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:34559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQXha-000877-5N
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:01:22 -0500
Received: by mail-ua0-x230.google.com with SMTP id 35so24640312uak.1
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 03:01:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170107122047.26300-1-jcd@tribudubois.net>
References: <20170107122047.26300-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 11:00:58 +0000
Message-ID: <CAFEAcA9iRhw9aiJvy71nK8n89C_T7GRMCuqRZwe3ShBJVG3BnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] [i.MX] Remove MSGDATA register support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>

On 7 January 2017 at 12:20, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> From the documentation it is not clear what this SPI register is about.
>
> Moreover, neither linux driver nor xvisor driver are using this SPI register.
>
> For now we just remove it and issue a log on register write access.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>



Applied to target-arm.next, thanks.

-- PMM
