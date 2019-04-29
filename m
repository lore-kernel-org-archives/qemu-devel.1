Received: from eggs.gnu.org ([209.51.188.92]:33883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL4TX-0000wM-Ks
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hL4TW-0004ae-Oz
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:29:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hL4TW-0004aH-JP
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 07:29:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so15453808wrs.11
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 04:29:34 -0700 (PDT)
References: <20190316234456.18140-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <97745dfa-ceaf-6572-59ba-a37e8f3c1e89@redhat.com>
Date: Mon, 29 Apr 2019 13:29:31 +0200
MIME-Version: 1.0
In-Reply-To: <20190316234456.18140-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] hw/alpha: Add the CY82C693UB
 southbridge in Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

CC'ing Thomas who is a Kconfig expert.

On 3/17/19 12:44 AM, Philippe Mathieu-Daudé wrote:
> Explicit the CY82C693UB southbridge used by the 264DP.
> 
> Philippe Mathieu-Daudé (2):
>   hw/isa/southbridge: Add the Cypress 82C693UB chipset
>   hw/alpha/Kconfig: The 264DP machine use a CY82C693UB southbridge
> 
>  hw/alpha/Kconfig |  5 +----
>  hw/isa/Kconfig   | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
