Received: from eggs.gnu.org ([2001:4830:134:3::10]:58387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cRyTj-0008Nu-BG
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:49:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cRyTf-0004JL-DI
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:48:59 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:39409 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cRyTe-0004Ic-WF
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:48:55 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<e3c30f7c-8d5b-5cfc-1cc0-5e673a30cd8a@virtuozzo.com>
	<6986E12E-AE0A-4502-BB43-77C4E83C9DC4@alex.org.uk>
	<dcaf043a-9e76-3be2-1740-e90085928f6a@virtuozzo.com>
	<5CBA6C86-A5CD-4F88-B8B2-29224BF1223D@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c0608208-de6c-fd41-95d7-e73877f8cdba@virtuozzo.com>
Date: Fri, 13 Jan 2017 12:48:38 +0300
MIME-Version: 1.0
In-Reply-To: <5CBA6C86-A5CD-4F88-B8B2-29224BF1223D@alex.org.uk>
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
Cc: Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>

12.01.2017 16:11, Alex Bligh wrote:
>> On 12 Jan 2017, at 07:05, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>>
>> Yes this is better. But is it actually needed to force contexts have some safe default? If context wants it may define such default without this requirement.. So, should it be requirement at all?
> I've changed this to:
>
>      of the file), a server MAY reply with a single block status
>      descriptor with *length* matching the requested length, rather than
>      reporting the error; in this case the context MAY mandate the
>      status returned.
>
>

Hmm, I don't understand. So, it MAY mandate and therefore MAY NOT do it? 
And what client should think, if server replies with one chunk matching 
the request length and not mandate the status?


-- 
Best regards,
Vladimir
