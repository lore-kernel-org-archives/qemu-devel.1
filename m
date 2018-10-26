Received: from eggs.gnu.org ([2001:4830:134:3::10]:54268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Rh-0004fp-J8
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Rd-00022V-H2
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4Rc-0001Li-Re
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:54:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id d10-v6so1871744wrs.5
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:54:26 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-62-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <554ac8d2-1d52-f958-eb50-8e27b1871a52@linaro.org>
Date: Fri, 26 Oct 2018 16:54:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-62-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 62/71] s390x: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Soon we will call cpu_has_work without the BQL.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
