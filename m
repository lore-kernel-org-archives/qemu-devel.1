Received: from eggs.gnu.org ([2001:4830:134:3::10]:58210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g04XC-0001F3-QU
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g04X8-0005gj-Vr
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:46:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g04X7-0005f1-1S
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:46:13 -0400
References: <20180911202823.21657-1-cota@braap.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1eb7d6cd-268b-4066-c024-4622451d3de0@redhat.com>
Date: Wed, 12 Sep 2018 14:46:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180911202823.21657-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/13] i386 + x86_64 mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/09/2018 22:28, Emilio G. Cota wrote:
> v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg01122.html
> 
> Changes since v2:
> 
> - Add rth's R-b tag to the last patch
> - Drop v2's first 10 patches, since Paolo already picked those up
> - Move TCG temps + x86_64_hregs to DisasContext
>   + While at it, drop the cpu_ prefix from the TCG temps,
>     e.g. cpu_A0 -> s->A0
>   + Split the conversion into separate patches to ease review.
>     The patches are quite boring and long because the temps
>     are everywhere, and I had to add DisasContext *s to quite a few
>     functions
> 
> The series is checkpatch-clean.
> 
> You can fetch these patches from:
>   https://github.com/cota/qemu/tree/i386-mttcg-v3

Great, thanks!

Paolo
