Received: from eggs.gnu.org ([209.51.188.92]:34105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gzPTY-0000ds-UV
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gzPFK-0000To-6d
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:13:23 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-13-david@redhat.com>
	<b3317597-1eed-8f02-07d4-d84c5398733c@linaro.org>
	<52631119-05fa-e08e-437b-619987750f28@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8046c492-d479-a050-c7bc-3555d24a3eae@twiddle.net>
Date: Thu, 28 Feb 2019 09:10:54 -0800
MIME-Version: 1.0
In-Reply-To: <52631119-05fa-e08e-437b-619987750f28@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 12/33] s390x/tcg: Implement VECTOR LOAD
 GR FROM VR ELEMENT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 2/28/19 12:27 AM, David Hildenbrand wrote:
> +    /* fast path if we don't need the register content */
> +    if (!get_field(s->fields, b2)) {
> +        uint8_t enr = get_field(s->fields, d2) & (NUM_VEC_ELEMENTS(es) - 1);
> +
> +        read_vec_element_i64(o->out, get_field(s->fields, v3), enr, es);
> +        return DISAS_NEXT;
> +    }
> +
> 
> Should do the trick, right?

Yep!


r~
