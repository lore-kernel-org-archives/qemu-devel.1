Received: from eggs.gnu.org ([2001:4830:134:3::10]:34516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pJm-00025M-Pv
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pJj-00017s-OI
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:51:50 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:53373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pJj-00017i-Jf
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:51:47 -0400
Received: by mail-qk0-x241.google.com with SMTP id y23so24543305qkb.10
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 19:51:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58956f2c-81b8-7a05-5fcc-dbfaab4de6b6@amsat.org>
Date: Mon, 23 Oct 2017 23:51:44 -0300
MIME-Version: 1.0
In-Reply-To: <20171020232023.15010-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 10/52] tcg: Avoid loops against variable
 bounds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 10/20/2017 08:19 PM, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> Copy s->nb_globals or s->nb_temps to a local variable for the purposes
> of iteration.  This should allow the compiler to use low-overhead
> looping constructs on some hosts.
> 
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tcg/tcg.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
