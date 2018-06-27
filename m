Received: from eggs.gnu.org ([2001:4830:134:3::10]:35689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3gZ-0007VA-JL
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3gW-0007SL-ET
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:12:11 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:46260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY3gW-0007Qj-8F
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:12:08 -0400
Received: by mail-pg0-x22a.google.com with SMTP id q14-v6so461458pgt.13
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 23:12:08 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-14-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b6becd9c-60f5-e9e7-0bd5-95fdcc1a1716@linaro.org>
Date: Tue, 26 Jun 2018 23:12:04 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-14-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 13/46] hw/block: Use the IEC binary
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-trivial@nongnu.org, Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, Max Reitz <mreitz@redhat.com>

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
>  hw/block/m25p80.c  | 5 +++--
>  hw/block/nvme.c    | 3 ++-
>  hw/block/tc58128.c | 3 ++-
>  3 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
