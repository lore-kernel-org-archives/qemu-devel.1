Received: from eggs.gnu.org ([2001:4830:134:3::10]:59879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYtFQ-0006ga-JF
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:43:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYtFM-0005gw-Fs
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:43:20 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:39487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYtFM-0005gV-BF
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 07:43:16 -0500
Received: by mail-qt0-x244.google.com with SMTP id k19so17604175qtj.6
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 04:43:16 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <60935b06-85d3-0f85-a085-f641b2c17a2f@amsat.org>
Date: Tue, 9 Jan 2018 09:43:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/20] fpu/softfloat: re-factor mul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, richard.henderson@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com
Cc: peter.maydell@linaro.org, andrew@andrewdutcher.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/09/2018 09:22 AM, Alex Bennée wrote:
> We can now add float16_mul and use the common decompose and
> canonicalize functions to have a single implementation for
> float16/32/64 versions.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

better safe than sorry :P
