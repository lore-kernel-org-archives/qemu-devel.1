Received: from eggs.gnu.org ([2001:4830:134:3::10]:35016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cFOpD-0005G4-Uf
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cFOp8-000769-TI
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:19:11 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cFOp8-00075z-P0
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:19:06 -0500
Received: by mail-qk0-f195.google.com with SMTP id h201so3008371qke.3
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 09:19:06 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1479906121-12211-1-git-send-email-rth@twiddle.net>
	<1479906121-12211-62-git-send-email-rth@twiddle.net>
	<87twadxize.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <78e5decc-7bbe-c8a2-0a47-7d63a9e4805d@twiddle.net>
Date: Fri, 9 Dec 2016 09:18:02 -0800
MIME-Version: 1.0
In-Reply-To: <87twadxize.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 61/64] qemu/host-utils.h: Reduce the
 operation count in the fallback ctpop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 12/09/2016 06:41 AM, Alex Bennée wrote:
> +struct bitcnt_test_data sixtyfour_bit_data[] = {
> +    { { .w64 = 0x0000000000000001 }, .popct=1 },

Thanks.  Merged with added ULL for the 64-bit data.


r~
