Received: from eggs.gnu.org ([209.51.188.92]:33498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hGgej-0003qk-Jn
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 05:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hGgei-0000zQ-Bb
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 05:15:01 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-2-david@redhat.com>
	<7ab7e798-1d68-99f8-acda-873ad94a5fae@linaro.org>
	<74ad67c6-bd3e-d37f-598a-334d2febcea1@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e80a4dda-5837-4ba3-a14e-dad6a4a5b460@twiddle.net>
Date: Tue, 16 Apr 2019 23:14:52 -1000
MIME-Version: 1.0
In-Reply-To: <74ad67c6-bd3e-d37f-598a-334d2febcea1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/41] tcg: Implement tcg_gen_gvec_3i()
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

On 4/16/19 9:42 PM, David Hildenbrand wrote:
> On 17.04.19 06:30, Richard Henderson wrote:
>> On 4/16/19 8:52 AM, David Hildenbrand wrote:
>>> Let's add tcg_gen_gvec_3i(), similar to tcg_gen_gvec_2i(), however
>>> without introducing "gen_helper_gvec_3i *fnoi", as it isn't needed
>>> for now.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  tcg/tcg-op-gvec.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++
>>>  tcg/tcg-op-gvec.h |  24 ++++++++
>>>  2 files changed, 163 insertions(+)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>>
>> r~
>>
> 
> Thanks, can this go via Conny's tree or do you want to include this one
> in your next TCG pull request?
> 

Hmm.  Lemme take it through my tree, so that I can handle the
conflict that's certain to arise with the .opc adjustment.

There's only one patch in this set that depends on this, I think?
Connie may be able to take the other 39 in the meantime.


r~
