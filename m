Received: from eggs.gnu.org ([2001:4830:134:3::10]:44946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fAYoy-0001Dx-Uc
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fAYou-0001sE-1U
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:35:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60148 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fAYot-0001pU-Sl
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:35:39 -0400
References: <20180420155045.18862-1-alex.bennee@linaro.org>
	<20180420183557.GA29359@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e534ce96-c2af-0c2b-1d05-9dd69c35bb7e@redhat.com>
Date: Mon, 23 Apr 2018 12:35:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180420183557.GA29359@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Convert softmmu-template into
 normal code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, richard.henderson@linaro.org

On 20/04/2018 20:35, Emilio G. Cota wrote:
> The executable is now larger:
> 
> - before:
>    text    data     bss     dec     hex filename
> 9864951 2944592 4371560 17181103        10629af aarch64-softmmu/qemu-system-aarch64
> 
> - after:
>    text    data     bss     dec     hex filename
> 9892095 2944592 4371560 17208247        10693b7 aarch64-softmmu/qemu-system-aarch64
> 
> By removing flatten we can decrease the overall size, but this might affect perf:
>    text    data     bss     dec     hex filename
> 9849967 2944592 4371560 17166119        105ef27 aarch64-softmmu/qemu-system-aarch64

This does suggest that always_inline is preferrable to flatten...

Paolo
