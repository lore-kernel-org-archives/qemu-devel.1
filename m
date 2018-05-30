Received: from eggs.gnu.org ([2001:4830:134:3::10]:47021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO4Qk-0001tA-6z
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fO4Qh-0007cr-30
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:58:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fO4Qg-0007cG-So
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:58:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id l1-v6so49146089wmb.2
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 09:58:30 -0700 (PDT)
References: <20180521140402.23318-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <87a9fff7-0a53-6b52-eb2c-e721556cf87b@redhat.com>
Date: Wed, 30 May 2018 18:58:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180521140402.23318-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/27] iommu: support txattrs,
 support TCG execution, implement TZ MPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, patches@linaro.org

On 21/05/2018 16:03, Peter Maydell wrote:
> This patchset is a rather large one, but the first half is all
> fairly simple plumbing. It does four things:
>  * support IOMMUs that are aware of memory transaction attributes and
>    may generate different translations for different attributes
>  * support TCG execution out of memory which is behind an IOMMU
>  * implement the Arm TrustZone Memory Protection Controller
>    (which needs both the above features in the IOMMU core code)
>  * use the MPC in the mps2-an505 board

Go ahead and apply it through the ARM tree.  Thanks!

Paolo
