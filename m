Received: from eggs.gnu.org ([2001:4830:134:3::10]:47237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ey5PI-0000SR-93
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ey5PD-000227-Jp
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:45:40 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ey5PD-0001zm-DS
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 20:45:35 -0400
Received: by mail-pl0-x243.google.com with SMTP id w15-v6so11332743plq.9
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 17:45:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180319113544.704-1-laurent@vivier.eu>
	<20180319113544.704-2-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <35bd16f3-c403-423c-d31e-76d5a459d738@twiddle.net>
Date: Tue, 20 Mar 2018 08:45:31 +0800
MIME-Version: 1.0
In-Reply-To: <20180319113544.704-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] target/m68k: add DisasContext
 parameter to gen_extend()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 03/19/2018 07:35 PM, Laurent Vivier wrote:
> This parameter will be needed to manage automatic release
> of temporary allocated TCG variables.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
