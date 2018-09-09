Received: from eggs.gnu.org ([2001:4830:134:3::10]:54442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fz9Bo-0002RX-2V
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 19:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fz9Bk-0002yK-SL
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 19:32:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fz9Bk-0002wQ-LV
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 19:32:20 -0400
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-2-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0055fc2-778d-c9cd-c157-29032085e2e7@redhat.com>
Date: Mon, 10 Sep 2018 01:32:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180903171831.15446-2-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] qsp: drop atomics when using the
 seqlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 03/09/2018 19:18, Emilio G. Cota wrote:
> Using atomics here is a mistake since they're not guaranteed
> to compile.

But isn't it technically a C11 data race if you don't use atomics?
Could we make nocheck read/set degrade to just a volatile access when
used on a variable that is bigger than pointers, or perhaps always
except when using tsan?

Paolo

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  util/qsp.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
