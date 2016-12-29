Received: from eggs.gnu.org ([2001:4830:134:3::10]:55742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cMdfx-0006Pi-ND
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cMdfu-0002Ko-Ja
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:35:33 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:16581 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cMdfu-0002KC-6q
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:35:30 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<20161214181323.mehzfmlf6z4pyajp@grep.be>
	<D71CECFD-E513-4372-BB54-BF8D8D521292@alex.org.uk>
	<20161214184937.uv5gwkijaofhjfd7@grep.be>
	<95CEC42B-486F-45F2-8879-ACF48C2380FD@alex.org.uk>
	<d7e58b6e-815c-ffb6-ac68-ef52b0082c50@virtuozzo.com>
	<0D5EAC18-B7BE-46AF-85CE-8488AB6C9448@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ccaa6a51-fa01-eda9-074c-c00e2bc4c976@virtuozzo.com>
Date: Thu, 29 Dec 2016 19:35:18 +0300
MIME-Version: 1.0
In-Reply-To: <0D5EAC18-B7BE-46AF-85CE-8488AB6C9448@alex.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>
Cc: Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>, John Snow <jsnow@redhat.com>

29.12.2016 19:08, Alex Bligh wrote:
> Vladimir,
>
>> On 26 Dec 2016, at 15:57, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>
>>> OK, so first of all, one of the changes I made earlier was that now
>>> each of the commands carries a list of queries, the way you list
>>> everything is not 'having a query that doesn't contain a namespace'
>>> but rather doing a _LIST_ with no queries at all. But that's semantics
>>> and orthogonal to the main point.
>>>
>>> What I've proposed (and pushed - but feel free to alter it) is that
>> I think, an overview in "## Metadata querying" should be updated too.
> Sorry, which bit needs updating?
>
> The only bit in that more general section that mentions _LIST_ is:
>
>> First, during negotiation, if the client wishes to query metadata
>> during transmission, the client MUST select one or more metadata
>> contexts with the NBD_OPT_SET_META_CONTEXT command. If needed, the
>> client can use NBD_OPT_LIST_META_CONTEXT to list contexts that the
>> server supports.
> That still seems correct.
>

Hmm, I am not sure. Seems like it was out of topic.. Here the only thing 
may be s/list contexts that the server supports/available list 
contexts/, to be more consistent, but it is not important.



-- 
Best regards,
Vladimir
