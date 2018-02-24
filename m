Received: from eggs.gnu.org ([2001:4830:134:3::10]:39061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epRdw-0000XO-Cs
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 23:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epRdt-0005Oc-97
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 23:41:04 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:43431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epRdt-0005Mp-1S
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 23:41:01 -0500
Received: by mail-pl0-x241.google.com with SMTP id f23so6086192plr.10
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 20:41:00 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <16ee379f-16b3-ab78-edf2-0d1e005221c0@linaro.org>
Date: Fri, 23 Feb 2018 20:40:56 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/19] loader: Add new load_ramdisk_as()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> Add a function load_ramdisk_as() which behaves like the existing
> load_ramdisk() but allows the caller to specify the AddressSpace
> to use. This matches the pattern we have already for various
> other loader functions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/loader.h | 12 +++++++++++-
>  hw/core/loader.c    |  8 +++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
