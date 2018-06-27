Received: from eggs.gnu.org ([2001:4830:134:3::10]:37567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3nh-00038K-Pa
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3nd-0005sF-69
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:19:33 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY3nc-0005ra-WF
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:19:29 -0400
Received: by mail-pg0-x242.google.com with SMTP id c9-v6so480447pgf.5
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 23:19:28 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-25-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0605e3a5-221b-172b-43d8-b14371345114@linaro.org>
Date: Tue, 26 Jun 2018 23:19:25 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-25-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 24/46] hw/microblaze: Use the IEC binary
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
Cc: qemu-trivial@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org

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
>  hw/microblaze/petalogix_ml605_mmu.c      | 7 ++++---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
