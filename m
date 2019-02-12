Received: from eggs.gnu.org ([209.51.188.92]:39955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gteAt-0000TB-85
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gteAs-0003x4-9m
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:56:59 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-10-david@redhat.com>
	<43fda672-487e-fef9-17c8-ce0657f27dbe@linaro.org>
	<86c01eb1-5423-cd47-1173-747a4708cf87@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8bf73ad3-345e-6811-f61c-038a28732aad@twiddle.net>
Date: Tue, 12 Feb 2019 11:56:39 -0800
MIME-Version: 1.0
In-Reply-To: <86c01eb1-5423-cd47-1173-747a4708cf87@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 08/15] s390x/tcg: Handle SET FPC AND
 LOAD FPC 3-bit BFP rounding modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 2/12/19 11:32 AM, David Hildenbrand wrote:
>> Yes, you want round_to_odd.  I suppose that's not valid for float128 right now?
> 
> roundAndPackFloat64()
> 
> as well as
> 
> roundAndPackFloat128()
> 
> support it.
> 
> It's not implemented for round_canonical(), round_to_int(),

These two are easy.  I think Alex and I didn't implement it in the float32/64
rewrite because we didn't have a user.  Now we will.

> roundAndPackInt32(), roundAndPackInt64(), roundAndPackUint64(),
> roundAndPackFloat32()

Right, these would be from the float128 side.  It shouldn't be too hard...


r~
