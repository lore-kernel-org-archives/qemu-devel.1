Received: from eggs.gnu.org ([2001:4830:134:3::10]:33427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eNUhd-0007CA-MW
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 21:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eNUhb-0003oM-H0
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 21:17:21 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:40365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eNUhb-0003nh-Bh
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 21:17:19 -0500
Received: by mail-pl0-x244.google.com with SMTP id 1so1391301pla.7
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 18:17:19 -0800 (PST)
References: <20171208160207.26494-1-david@redhat.com>
	<20171208160207.26494-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <68b8f103-06f8-6341-8c13-3fffbae6996d@linaro.org>
Date: Fri, 8 Dec 2017 18:17:13 -0800
MIME-Version: 1.0
In-Reply-To: <20171208160207.26494-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.12 01/14] s390x/kvm: factor out
 build_channel_report_mcic() into cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 12/08/2017 08:01 AM, David Hildenbrand wrote:
> We'll need it later on in two places. Refactor it to just indicate the
> validity bits. While at it, introduce a define for the used CR14 bit (we'll
> also need later on).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h | 23 +++++++++++++++++++++++
>  target/s390x/kvm.c | 25 ++-----------------------
>  2 files changed, 25 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
