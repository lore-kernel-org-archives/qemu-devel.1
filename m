Received: from eggs.gnu.org ([2001:4830:134:3::10]:39365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmi3P-0004ia-6S
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmi3L-0007kS-UE
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:03:47 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:33951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmi3L-0007k6-OC
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:03:43 -0400
Received: by mail-pg0-x236.google.com with SMTP id y15so11633692pgc.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:03:43 -0700 (PDT)
References: <20170829063313.10237-1-bobby.prani@gmail.com>
	<20170829063313.10237-5-bobby.prani@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <125ae0ee-8104-5b52-6b4b-22622ba56191@linaro.org>
Date: Tue, 29 Aug 2017 08:03:39 -0700
MIME-Version: 1.0
In-Reply-To: <20170829063313.10237-5-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 PATCH 5/5] tcg/softmmu: Increase size of
 TLB caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, "open list:Overall" <qemu-devel@nongnu.org>, "open list:AArch64 target" <qemu-arm@nongnu.org>

On 08/28/2017 11:33 PM, Pranith Kumar wrote:
> +#if HOST_LONG_BITS == 32 && TARGET_LONG_BITS == 32
> +#define TCG_TARGET_TLB_MAX_INDEX_BITS 28
> +#else
> +#define TCG_TARGET_TLB_MAX_INDEX_BITS 27
> +#endif
> +

For the record, did it not work to actually write (32 - CPU_TLB_BITS)?  I'm not
fond of repeating the conditions that go into computing CPU_TLB_BITS.


r~
