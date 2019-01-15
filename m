Received: from eggs.gnu.org ([209.51.188.92]:60466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjWqX-0001K0-E0
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjWqR-0004Mj-1t
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:06:05 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:43527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjWqJ-0004HR-7G
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 17:05:55 -0500
Received: by mail-pl1-x631.google.com with SMTP id gn14so1921095plb.10
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 14:05:53 -0800 (PST)
References: <1547467955-17245-1-git-send-email-thuth@redhat.com>
	<30917d5b-f8cb-e799-6c3e-3202195122b4@redhat.com>
	<871s5fp54s.fsf@linaro.org>
	<e94b51d7-c90f-b599-fb68-ea8c2603989b@redhat.com>
	<87zhs3nk1m.fsf@linaro.org>
	<a0646a85-603d-99a8-c676-76e43a42e0fb@twiddle.net>
	<87y37monyr.fsf@linaro.org>
	<CAFEAcA8u4AdhW-MF6uMP7=B4iYVO9ZEQCtcQKpN6KWALwAfLnw@mail.gmail.com>
	<87won6nfl1.fsf@linaro.org>
	<6cb80b50-0352-430e-0c46-85ed69f95c88@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7556aba5-052b-8cc1-1f92-d7d0f664cfa3@linaro.org>
Date: Wed, 16 Jan 2019 09:05:45 +1100
MIME-Version: 1.0
In-Reply-To: <6cb80b50-0352-430e-0c46-85ed69f95c88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] include/fpu/softfloat: Fix compilation
 with Clang on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 1/16/19 2:29 AM, Thomas Huth wrote:
> ... but at least it gives the same results as the DLGR instruction. The 64-bit
> version gives different results - do we have a bug here?

Yes, on your inputs.  udiv_qrnnd3 requires that D be "normalized", i.e. have
the most siginificant bit set.  (And thus N1:N0 shifted left to match, and the
returned remainder shifted right to match.)


r~
