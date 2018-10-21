Received: from eggs.gnu.org ([2001:4830:134:3::10]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDPb-0004B7-MJ
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:04:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDOw-0006Yu-0D
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:04:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDOv-0006YH-O7
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:04:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 189-v6so7634264wmw.2
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 06:04:13 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-18-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <da37699c-c684-d33b-fd30-b2dce783ebcb@linaro.org>
Date: Sun, 21 Oct 2018 14:04:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-18-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 17/56] s390x: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  hw/intc/s390_flic.c        |  2 +-
>  target/s390x/cpu.c         | 18 +++++++++++-------
>  target/s390x/excp_helper.c |  2 +-
>  target/s390x/kvm.c         |  2 +-
>  target/s390x/sigp.c        |  8 ++++----
>  5 files changed, 18 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
