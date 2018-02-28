Received: from eggs.gnu.org ([2001:4830:134:3::10]:57505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erAay-0007kc-1g
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erAau-0003Xm-Tq
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:53:08 -0500
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:37354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1erAau-0003XC-LQ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:53:04 -0500
Received: by mail-pl0-x22d.google.com with SMTP id ay8-v6so2439761plb.4
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:53:04 -0800 (PST)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-6-git-send-email-cota@braap.org>
	<99cb6bcc-55d2-f07f-fdf4-c55355d2c39f@linaro.org>
	<20180228225021.GA11410@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2efde8db-20ff-31d3-d67b-369f7bed9013@linaro.org>
Date: Wed, 28 Feb 2018 14:53:00 -0800
MIME-Version: 1.0
In-Reply-To: <20180228225021.GA11410@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/16] translate-all: iterate over TBs in a
 page with PAGE_FOR_EACH_TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 02/28/2018 02:50 PM, Emilio G. Cota wrote:
> Is this any better?
> 
> #define TB_FOR_EACH_TAGGED(head, tb, n, field)                          \
>     for (n = (head) & 1, tb = (TranslationBlock *)((head) & ~1);        \
>          tb; tb = (TranslationBlock *)tb->field[n], n = (uintptr_t)tb & 1, \
>              tb = (TranslationBlock *)((uintptr_t)tb & ~1))

Yes, thanks.


r~
