Received: from eggs.gnu.org ([2001:4830:134:3::10]:36387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3jC-0000eq-DW
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3jB-0001pq-I3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:14:54 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:42566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY3jB-0001oe-Be
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:14:53 -0400
Received: by mail-pl0-x243.google.com with SMTP id w17-v6so537790pll.9
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 23:14:53 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-19-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2bbd2b7c-3b79-e3a1-2cb6-84e4705c8e34@linaro.org>
Date: Tue, 26 Jun 2018 23:14:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-19-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 18/46] hw/sparc: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fabien Chouteau <chouteau@adacore.com>, qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>

On 06/25/2018 05:42 AM, Philippe Mathieu-Daudé wrote:
> It eases code review, unit is explicit.
> 
> Patch generated using:
> 
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/
> 
> and modified manually.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/sparc/leon3.c     | 10 ++++++----
>  hw/sparc/sun4m.c     | 10 +++++-----
>  hw/sparc64/niagara.c |  3 ++-
>  hw/sparc64/sun4u.c   |  4 ++--
>  4 files changed, 15 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
