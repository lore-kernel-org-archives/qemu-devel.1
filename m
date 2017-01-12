Received: from eggs.gnu.org ([2001:4830:134:3::10]:34217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cRZSK-0002bj-7F
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cRZSF-0006tf-A2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:05:52 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:31792 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cRZSE-0006tQ-SV
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:05:47 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<e3c30f7c-8d5b-5cfc-1cc0-5e673a30cd8a@virtuozzo.com>
	<6986E12E-AE0A-4502-BB43-77C4E83C9DC4@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <dcaf043a-9e76-3be2-1740-e90085928f6a@virtuozzo.com>
Date: Thu, 12 Jan 2017 10:05:28 +0300
MIME-Version: 1.0
In-Reply-To: <6986E12E-AE0A-4502-BB43-77C4E83C9DC4@alex.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>
Cc: Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Pargmann <mpa@pengutronix.de>, "Denis V . Lunev" <den@openvz.org>

11.01.2017 22:00, Alex Bligh wrote:
>> On 11 Jan 2017, at 15:31, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>
>>>>> If an error occurs, the server SHOULD set the appropriate error code in the error field of an error chunk. However, if the error does not involve invalid usage (such as a request beyond the bounds of the file), a server MAY reply with a single block status descriptor with length matching the requested length, and status of 0 rather than reporting the error.
>> - single block status descriptor for each context? Isn't it implementation defined? Or we finally decided to force 0 status to be safe default for all contexts? If it is so, it would be better to describe this separately. However, personally, I'd prefer to not define contexts internal semantics at all.
> I think this is Wouter's wording, but I think 'a status appropriate to the context' would be better. Each context then needs to define what that is. Either that or 'the context's default status' and that should be in the definition of the context.
>

Yes this is better. But is it actually needed to force contexts have 
some safe default? If context wants it may define such default without 
this requirement.. So, should it be requirement at all?


-- 
Best regards,
Vladimir
