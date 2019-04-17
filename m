Received: from eggs.gnu.org ([209.51.188.92]:44488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGfDF-0005uE-0F
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGfDE-0005Ml-4k
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:42:32 -0400
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-2-david@redhat.com>
	<7ab7e798-1d68-99f8-acda-873ad94a5fae@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <74ad67c6-bd3e-d37f-598a-334d2febcea1@redhat.com>
Date: Wed, 17 Apr 2019 09:42:28 +0200
MIME-Version: 1.0
In-Reply-To: <7ab7e798-1d68-99f8-acda-873ad94a5fae@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 17.04.19 06:30, Richard Henderson wrote:
> On 4/16/19 8:52 AM, David Hildenbrand wrote:
>> Let's add tcg_gen_gvec_3i(), similar to tcg_gen_gvec_2i(), however
>> without introducing "gen_helper_gvec_3i *fnoi", as it isn't needed
>> for now.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  tcg/tcg-op-gvec.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tcg/tcg-op-gvec.h |  24 ++++++++
>>  2 files changed, 163 insertions(+)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 

Thanks, can this go via Conny's tree or do you want to include this one
in your next TCG pull request?

-- 

Thanks,

David / dhildenb
