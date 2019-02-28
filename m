Received: from eggs.gnu.org ([209.51.188.92]:52017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gzOe5-00056q-EX
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:34:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gzOdx-0003cL-38
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:34:51 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-9-david@redhat.com>
	<23a43b55-4902-0440-8243-62aaff19c83a@linaro.org>
	<bb16025b-cda4-6613-7e10-a03c887b106a@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4af07456-e6d8-918f-6741-83e4e1a739bb@twiddle.net>
Date: Thu, 28 Feb 2019 08:34:33 -0800
MIME-Version: 1.0
In-Reply-To: <bb16025b-cda4-6613-7e10-a03c887b106a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 08/33] s390x/tcg: Implement VECTOR LOAD
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

On 2/27/19 11:48 PM, David Hildenbrand wrote:
> I think that would be wrong. It is only an alignment hint.
> 
> "Setting the alignment hint to a non-zero value
> that doesn’t correspond to the alignment of the second operand may
> reduce performance on some models."
> 
> So we must not inject an exception when unaligned. This, however would
> be the result of MO_ALIGN,, right?

Ah, I didn't get that an alignment exception is not raised.  (I do find that
odd.  If the user is asserting a given alignment, why would we not tell him if
he is wrong?)

So, yes, ignore all of this from me -- leave MO_ALIGN off.


r~
