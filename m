Received: from eggs.gnu.org ([2001:4830:134:3::10]:54912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSRu9-0000yu-6g
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSRu6-0002B4-19
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:23:17 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSRu5-00029f-HU
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 14:23:13 -0500
Received: by mail-pf1-x441.google.com with SMTP id h3so1520397pfg.1
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:23:13 -0800 (PST)
References: <20181128053834.10861-1-richard.henderson@linaro.org>
	<20181128221530.GA32160@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9d890088-8dd6-517d-52a7-a6166f0cd8a6@linaro.org>
Date: Thu, 29 Nov 2018 11:23:09 -0800
MIME-Version: 1.0
In-Reply-To: <20181128221530.GA32160@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/12] tcg: Improve register allocation for
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 11/28/18 2:15 PM, Emilio G. Cota wrote:
> Unfortunately, it doesn't seem to help, performance-wise.

That is really disappointing, considering the size gains are huge -- even more
dramatically for non-x86 hosts.  I will see about some more benchmarking on
this for other host/guest combinations.

Thanks!


r~
