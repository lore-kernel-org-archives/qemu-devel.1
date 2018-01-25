Received: from eggs.gnu.org ([2001:4830:134:3::10]:52754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eeknT-0006Ml-T7
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eeknO-0000ZK-Im
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:54:43 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eeknO-0000Yq-DE
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:54:38 -0500
Received: by mail-pf0-x243.google.com with SMTP id t12so6182651pfg.2
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 08:54:38 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1516897189-11035-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <978e99e7-7ab2-a6ed-3c1f-dc8699af0436@twiddle.net>
Date: Thu, 25 Jan 2018 08:54:34 -0800
MIME-Version: 1.0
In-Reply-To: <1516897189-11035-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Drop remaining bits of ia64 host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On 01/25/2018 08:19 AM, Peter Maydell wrote:
> We dropped support for ia64 host CPUs in the 2.11 release (removing
> the TCG backend for it, and advertising the support as being
> completely removed in the changelog).  However there are a few bits
> and pieces of code still floating about.  Remove those, too.
> 
> We can drop the check in configure for "ia64 or hppa host?"
> entirely, because we don't support hppa hosts either any more.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
