Received: from eggs.gnu.org ([209.51.188.92]:53139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjWAo-0003Ti-Rh
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gjWAn-0006ki-TP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:23:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gjWAn-0006iD-LD
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:23:01 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so1777752pgp.7
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 13:22:56 -0800 (PST)
References: <20190114104641.19186-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5aea70e8-b676-5fb9-b2d7-4eaf08375871@linaro.org>
Date: Wed, 16 Jan 2019 08:22:48 +1100
MIME-Version: 1.0
In-Reply-To: <20190114104641.19186-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] tests: use g_usleep instead of rem =
 sleep(time)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, cota@braap.org, ehabkost@redhat.com

On 1/14/19 9:46 PM, Alex Bennée wrote:
> Relying on sleep to always return having slept isn't safe as a signal
> may have occurred. If signals are constantly incoming the program will
> never reach it's termination condition. This is believed to be the
> mechanism causing time outs for qht-test in Travis.
> 
> The glib g_usleep() deals with all of this for us so lets use it instead.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/atomic64-bench.c   | 6 ++----
>  tests/atomic_add-bench.c | 6 ++----
>  tests/qht-bench.c        | 6 ++----
>  3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
