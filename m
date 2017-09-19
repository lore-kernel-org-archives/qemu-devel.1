Received: from eggs.gnu.org ([2001:4830:134:3::10]:57461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duLPc-0001gw-FJ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duLPY-0001gC-SC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:30:16 -0400
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:51401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duLPY-0001fR-Mt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:30:12 -0400
Received: by mail-io0-x233.google.com with SMTP id l15so362305iol.8
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:30:12 -0700 (PDT)
References: <20170918104624.14743-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a79537e9-1053-128e-e63b-8ce969beb12d@linaro.org>
Date: Tue, 19 Sep 2017 11:30:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170918104624.14743-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] softfloat: rename make_float[x80|128]_init
 to const_float[x80|128]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 09/18/2017 05:46 AM, Laurent Vivier wrote:
> Redefine make_floatx80() and make_float128() as make_float16(),
> make_float32() and make_float64() using a variable and not only
> a cast.

I don't like this part -- (type){ init } is a standard C99 compound literal.
There's no point using a gcc extension instead.


r~
