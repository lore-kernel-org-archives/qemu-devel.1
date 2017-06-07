Received: from eggs.gnu.org ([2001:4830:134:3::10]:56504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIcDy-0000jf-LP
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dIcDt-0003yK-Dy
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:46:18 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:44281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dIcDt-0003xe-7j
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:46:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR6006Q6MCTG690@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:46:05 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <3e680032-8f14-9272-e7ff-a3624268770b@samsung.com>
Date: Wed, 07 Jun 2017 17:46:01 +0300
MIME-version: 1.0
In-reply-to: <87lgp4ez1k.fsf@secure.mitica>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094729eucas1p15097f154039365d5e135f92b72aad1bf@eucas1p1.samsung.com>
	<1496828798-27548-8-git-send-email-a.perevalov@samsung.com>
	<87lgp4ez1k.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v8 07/11] migration: add bitmap for copied
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, dgilbert@redhat.com

On 06/07/2017 03:56 PM, Juan Quintela wrote:
> Alexey Perevalov <a.perevalov@samsung.com> wrote:
>
>> +static unsigned long get_copiedmap_size(RAMBlock *rb)
>> +{
>> +    unsigned long pages;
>> +    pages = rb->max_length >> find_first_bit((unsigned long *)&rb->page_size,
>> +                                             sizeof(rb->page_size));
>> +    return pages;
> Are you sure that you want this and not:
>
> pages = rb->max_length >> TARGET_PAGE_BITS?
I just wish to optimize size of bitmap,
>
> Otherwise, in some architectures/configurations you can end with a
> bitmap size that is different of the migration bitmap size.
>
looks like, yes, that solution is for le only, so I feel luck
of converting to le, here.

>
>

-- 
Best regards,
Alexey Perevalov
