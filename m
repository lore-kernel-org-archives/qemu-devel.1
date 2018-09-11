Received: from eggs.gnu.org ([2001:4830:134:3::10]:36663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fziMH-0007pk-Eh
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 09:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fzi8C-0005c5-Op
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:51:04 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fzi8A-0005Y6-QW
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:51:00 -0400
Received: by mail-pl1-x643.google.com with SMTP id s17-v6so11286435plp.7
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 05:50:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180910232752.31565-1-cota@braap.org>
	<20180910232752.31565-8-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <be58ff4e-044e-66d8-c1b0-2e716e774574@twiddle.net>
Date: Tue, 11 Sep 2018 05:50:54 -0700
MIME-Version: 1.0
In-Reply-To: <20180910232752.31565-8-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/12] cpus: initialize
 timers_state.vm_clock_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On 09/10/2018 04:27 PM, Emilio G. Cota wrote:
> We forgot to initialize the spinlock introduced in 94377115b2
> ("cpus: protect TimerState writes with a spinlock", 2018-08-23).
> Fix it.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  cpus.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
