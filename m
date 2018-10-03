Received: from eggs.gnu.org ([2001:4830:134:3::10]:47466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7h9j-0004fT-8C
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7h9f-0000dW-AW
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:25:35 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7h9f-0000cz-38
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:25:31 -0400
Received: by mail-wr1-f48.google.com with SMTP id 63-v6so6115954wra.11
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 06:25:31 -0700 (PDT)
References: <1538295197-23704-1-git-send-email-pbonzini@redhat.com>
	<1538295197-23704-76-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3b8838ba-f41c-82b7-970f-f4edefabd0b8@redhat.com>
Date: Wed, 3 Oct 2018 15:25:28 +0200
MIME-Version: 1.0
In-Reply-To: <1538295197-23704-76-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 75/79] memory: Remove old_mmio accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>

On 30/09/2018 10:13, Paolo Bonzini wrote:
> From: Peter Maydell <peter.maydell@linaro.org>
> 
> Now that all the users of old_mmio MemoryRegion accessors
> have been converted, we can remove the core code support.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Message-Id: <20180824170422.5783-2-peter.maydell@linaro.org>
> Based-on: <20180802174042.29234-1-peter.maydell@linaro.org>

Just noticed this tag.

If patchew is collecting all tags, this one should be filtered out.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
