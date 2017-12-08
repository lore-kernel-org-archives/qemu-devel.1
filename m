Received: from eggs.gnu.org ([2001:4830:134:3::10]:34430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN67b-00036O-9D
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:02:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN67a-0005Jk-E4
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 19:02:31 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171207153141.15523-1-david@redhat.com>
	<20171207153141.15523-5-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2e29bd7a-d0d2-bafd-0579-9c8235727c4c@twiddle.net>
Date: Thu, 7 Dec 2017 16:02:26 -0800
MIME-Version: 1.0
In-Reply-To: <20171207153141.15523-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 4/5] s390x/tcg: indicate value
 of TODPR in STCKE
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

On 12/07/2017 07:31 AM, David Hildenbrand wrote:
> +    /* 16 bit value store in an uint32_t (only valid bits set) */
> +    tcg_gen_ld32u_i64(todpr, cpu_env, offsetof(CPUS390XState, todpr));

Any reason not to use a uint16_t and use tcg_gen_ld16u_i64 here?


r~
