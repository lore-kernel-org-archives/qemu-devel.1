Received: from eggs.gnu.org ([2001:4830:134:3::10]:59209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dyzPy-0000Yw-2Z
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dyzPs-0008Is-KQ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:01:50 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:38164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dyzPs-0008IL-FK
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:01:44 -0400
Received: by mail-yw0-x242.google.com with SMTP id v1so3212865ywv.5
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 05:01:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-3-git-send-email-imammedo@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c7476d93-d552-531d-bc35-0b4c9ed60ef7@twiddle.net>
Date: Mon, 2 Oct 2017 05:01:39 -0700
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/38] alpha: cleanup cpu type name
 composition
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 02:07 AM, Igor Mammedov wrote:
> Introduce ALPHA_CPU_TYPE_NAME macro to replace rather ununique
> TYPE macro that alpha uses. With new macro it will follow
> the same naming convention as other targets.
> 
> While at it put scattered TypeInfo into one array which places
> type desriptions at one place and reduces code a bit.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: rth@twiddle.net
> ---
>  target/alpha/cpu.h |   3 ++
>  target/alpha/cpu.c | 107 +++++++++++++++++------------------------------------
>  2 files changed, 37 insertions(+), 73 deletions(-)

Acked-by: Richard Henderson <rth@twiddle.net>


r~
