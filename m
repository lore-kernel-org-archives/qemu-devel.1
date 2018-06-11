Received: from eggs.gnu.org ([2001:4830:134:3::10]:54528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fSUgr-0006ik-AI
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fSUgn-0006Sn-EA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:49:29 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:41509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fSUgn-0006SV-6w
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:49:25 -0400
Received: by mail-pf0-x243.google.com with SMTP id a11-v6so10932966pff.8
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 14:49:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180611203855.13269-1-ehabkost@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ae2d8283-db17-2ca1-eb7c-5ba6459dd2fd@twiddle.net>
Date: Mon, 11 Jun 2018 11:49:19 -1000
MIME-Version: 1.0
In-Reply-To: <20180611203855.13269-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Remove osxsave CPUID flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 06/11/2018 10:38 AM, Eduardo Habkost wrote:
> OSXAVE is not a static feature flag: it changes dynamically at
> runtime depending on CR4, and it was never configurable: KVM
> never returned OSXSAVE on GET_SUPPORTED_CPUID, and it is not
> included in TCG_EXT_FEATURES.
> 
> Remove OSXSAVE from the feature name array so users don't try to
> configure it manually.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
