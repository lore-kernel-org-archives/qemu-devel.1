Received: from eggs.gnu.org ([2001:4830:134:3::10]:54288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cMdZe-0003Tj-Gb
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cMdZb-0008NN-DA
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:29:02 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:45640 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cMdZb-0008NB-1W
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 11:28:59 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<31576d46-c0ed-29b9-71a0-5aca1790799a@virtuozzo.com>
	<6D1B30FC-FD7E-474C-A8E3-FD87E7AA1364@alex.org.uk>
	<5e9150ed-2127-f2e8-f9db-a514e8f0ddf8@virtuozzo.com>
	<5E697C22-5FBB-49A2-A018-A6B96E29FE84@alex.org.uk>
	<94ef3ef2-b76f-fa5d-cbaf-8990ce2b1be8@virtuozzo.com>
	<0F1DC4AE-5C9E-4AE6-8141-AE6B398EBF73@alex.org.uk>
	<2812e3e2-983a-42de-a55f-590a87b7fece@virtuozzo.com>
	<20161228001855.ukrtvzeictke4ex2@grep.be>
	<E57C32F9-8732-4F5F-AA67-997BB729F339@alex.org.uk>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1ae82a77-3e36-9b57-6221-e7cd06f0a50b@virtuozzo.com>
Date: Thu, 29 Dec 2016 19:28:43 +0300
MIME-Version: 1.0
In-Reply-To: <E57C32F9-8732-4F5F-AA67-997BB729F339@alex.org.uk>
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
To: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

29.12.2016 19:04, Alex Bligh wrote:
>> On 28 Dec 2016, at 00:18, Wouter Verhelst <w@uter.be> wrote:
>>
>> On Mon, Dec 26, 2016 at 05:52:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Shouldn't we add some flags to REP_META_CONTEXT, for client to be insure, is
>>> returned string a direct context name or some kind of wildcard? Just a flags
>>> field, with one flag defined for now: NBD_REP_META_CONTEXT_LEAF and others
>>> reserved.
>> I think it should be up to the metadata context namespace definition to
>> define which syntax represents a direct context name and which
>> represents a wildcard (if the latter are supported).
>>
>> A client which doesn't know what a given metadata context implements
>> can't reasonably ask for information from that context anyway (since
>> then the client wouldn't know what to do with the returned information),
>> so it doesn't help much to add a flag here.
> I agree.
>
> Vladimir: if this isn't clear from the text, please suggest a change.
>

I'm ok with Wouter's arguments


-- 
Best regards,
Vladimir
