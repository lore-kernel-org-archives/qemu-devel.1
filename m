Received: from eggs.gnu.org ([2001:4830:134:3::10]:52194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSq7x-0004tk-Ht
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSq7u-00016m-Hx
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:42:53 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSq7u-00016I-Bo
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:42:50 -0400
Received: by mail-pl0-x241.google.com with SMTP id az12-v6so151268plb.8
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:42:50 -0700 (PDT)
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <08e5205f-c3e4-6a13-80da-cde7f51e831b@linaro.org>
Date: Tue, 12 Jun 2018 10:42:43 -1000
MIME-Version: 1.0
In-Reply-To: <20180611011501.10235-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 01/40] include: Add IEC binary prefixes
 in "qemu/units.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 06/10/2018 03:14 PM, Philippe Mathieu-Daudé wrote:
> +#define KiB     (1ULL << 10)
> +#define MiB     (1ULL << 20)
> +#define GiB     (1ULL << 30)
> +#define TiB     (1ULL << 40)
> +#define PiB     (1ULL << 50)
> +#define EiB     (1ULL << 60)

Is there any particular reason to force these to be unsigned?
Or, for that matter, 64-bit (at least for the first 3).

I ask because this changes the types of some of the expressions
in which you use these.


r~
