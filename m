Received: from eggs.gnu.org ([2001:4830:134:3::10]:49995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5jpg-0003fM-B6
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5jpe-0001kR-KT
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:20:31 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:40085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5jpe-0001jv-DF
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:20:30 -0400
Received: by mail-pf0-x22a.google.com with SMTP id y66so7070333pfi.7
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 20:20:30 -0700 (PDT)
References: <20180410021745.32378-1-jcmvbkbc@gmail.com>
	<20180410021745.32378-2-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a59566f6-2423-cd50-9ff4-cf8ec227dbde@linaro.org>
Date: Tue, 10 Apr 2018 13:20:22 +1000
MIME-Version: 1.0
In-Reply-To: <20180410021745.32378-2-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 1/1] linux-user: fix preadv/pwritev offsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 04/10/2018 12:17 PM, Max Filippov wrote:
> +    uint64_t off = tlow |
> +        ((unsigned long long)thigh << TARGET_LONG_BITS / 2) <<

There's a second instance of long long here; needs uint64_t.


r~
