Received: from eggs.gnu.org ([2001:4830:134:3::10]:35435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC5tX-0005gk-M5
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC5tT-0004UD-K1
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:39:03 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC5tT-0004Te-CR
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 12:38:59 -0400
Received: by mail-pg1-x543.google.com with SMTP id 23-v6so9417700pgc.8
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 09:38:59 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07e7c534-c9b4-4d07-6f1a-797b2904d9e4@linaro.org>
Date: Mon, 15 Oct 2018 09:38:55 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/21] accel/tcg/cputlb: convert
 remaining tlb_debug() to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, Paolo Bonzini <pbonzini@redhat.com>, vilanova@ac.upc.edu, Richard Henderson <rth@twiddle.net>

On 10/5/18 8:48 AM, Alex Bennée wrote:
> To avoid overly long lines in trace events I've split the event into
> tlb_set_page and tlb_set_page_attrs.

I don't think this split is a good idea.  It allows data from different threads
to be interleaved.


r~
