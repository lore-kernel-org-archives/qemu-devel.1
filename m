Received: from eggs.gnu.org ([209.51.188.92]:54908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGiO0-0003Ui-LS
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGiNz-0005HT-NN
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 07:05:52 -0400
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-2-david@redhat.com>
	<7ab7e798-1d68-99f8-acda-873ad94a5fae@linaro.org>
	<74ad67c6-bd3e-d37f-598a-334d2febcea1@redhat.com>
	<e80a4dda-5837-4ba3-a14e-dad6a4a5b460@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <85267b5d-8608-0612-8b7f-3c0820b7eaaa@redhat.com>
Date: Wed, 17 Apr 2019 13:05:47 +0200
MIME-Version: 1.0
In-Reply-To: <e80a4dda-5837-4ba3-a14e-dad6a4a5b460@twiddle.net>
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
To: Richard Henderson <rth@twiddle.net>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 17.04.19 11:14, Richard Henderson wrote:
> On 4/16/19 9:42 PM, David Hildenbrand wrote:
>> On 17.04.19 06:30, Richard Henderson wrote:
>>> On 4/16/19 8:52 AM, David Hildenbrand wrote:
>>>> Let's add tcg_gen_gvec_3i(), similar to tcg_gen_gvec_2i(), however
>>>> without introducing "gen_helper_gvec_3i *fnoi", as it isn't needed
>>>> for now.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  tcg/tcg-op-gvec.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++
>>>>  tcg/tcg-op-gvec.h |  24 ++++++++
>>>>  2 files changed, 163 insertions(+)
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>>
>>> r~
>>>
>>
>> Thanks, can this go via Conny's tree or do you want to include this one
>> in your next TCG pull request?
>>
> 
> Hmm.  Lemme take it through my tree, so that I can handle the
> conflict that's certain to arise with the .opc adjustment.
> 
> There's only one patch in this set that depends on this, I think?

Yes,

[PATCH v2 28/41] s390x/tcg: Implement VECTOR ELEMENT ROTATE AND INSERT
UNDER MASK

> Connie may be able to take the other 39 in the meantime.
> 

I'll have to wait for extract2 either way, so I can also wait until this
patch reaches upstream.

-- 

Thanks,

David / dhildenb
