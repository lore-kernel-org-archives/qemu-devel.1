Received: from eggs.gnu.org ([2001:4830:134:3::10]:56503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgAnB-0005Ku-Sa
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgAn8-0005bd-Pn
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:24:33 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:32992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgAn8-0005b3-K5
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:24:30 -0400
Received: by mail-pl0-x242.google.com with SMTP id 6-v6so3817616plb.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:24:30 -0700 (PDT)
References: <20180718200648.22529-1-richard.henderson@linaro.org>
	<87wotr4bpv.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <221519ed-ca43-7c03-bb20-57c8e744e1d2@linaro.org>
Date: Thu, 19 Jul 2018 08:24:26 -0700
MIME-Version: 1.0
In-Reply-To: <87wotr4bpv.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/ppc: Implement swapcontext
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

On 07/19/2018 06:05 AM, Alex Bennée wrote:
> I'm confused by the lock_user_struct/unlock_user_struct which AFAICT are
> basically access checks. Is there an implied locking I'm missing?

I have no idea why those have that name.  There's no lock,
just a validation of the underlying pages and a transform to
the corresponding host address.


r~
