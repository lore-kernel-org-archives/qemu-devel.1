Received: from eggs.gnu.org ([2001:4830:134:3::10]:56745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN5qG-0006pu-5Y
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN5qC-0006Gw-I3
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:44:35 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171207165355.7559-1-david@redhat.com>
	<20171207165355.7559-4-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4ce73263-0c9e-252b-3bc2-19a4621843dc@twiddle.net>
Date: Thu, 7 Dec 2017 15:44:29 -0800
MIME-Version: 1.0
In-Reply-To: <20171207165355.7559-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 03/10] s390x/tcg: implement
 Interlocked-Access Facility 2
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

On 12/07/2017 08:53 AM, David Hildenbrand wrote:
> +static ExitStatus op_ni(DisasContext *s, DisasOps *o)
> +{
> +    o->in1 = tcg_temp_new_i64();
> +    /* Perform the atomic operation in memory. */
> +    tcg_gen_atomic_fetch_and_i64(o->in1, o->addr1, o->in2, get_mem_index(s),
> +                                 MO_UB);
> +    /* We need to recompute the operation for setting CC.  */
> +    tcg_gen_and_i64(o->out, o->in1, o->in2);
> +    return NO_EXIT;
> +}

Similarly, check interlocked-access-facility-2?


r~
