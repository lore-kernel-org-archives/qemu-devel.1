Received: from eggs.gnu.org ([2001:4830:134:3::10]:47845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLXsE-0002tB-Mk
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLXsA-0002QD-Pl
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:48:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fLXsA-0002Q3-KG
	for qemu-devel@nongnu.org; Wed, 23 May 2018 13:48:26 -0400
References: <1526752108-21204-1-git-send-email-patryk@fala.ehost.pl>
	<87o9h7q53u.fsf@dusky.pond.sub.org>
	<CAFEAcA-ce=r3izLyizhEo+a4Fkg5dQ-NnDgHRJ4GsomnqQsqRw@mail.gmail.com>
	<187f5c5b-6ce3-a9d0-3431-4e0109292888@fala.ehost.pl>
	<87zi0qba1n.fsf@dusky.pond.sub.org>
	<b3a6e022-5789-43a2-d32b-b22c8cccf7ef@fala.ehost.pl>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a24a1c97-9b6e-3b85-a8ac-d7c3d2c387c1@redhat.com>
Date: Wed, 23 May 2018 12:48:24 -0500
MIME-Version: 1.0
In-Reply-To: <b3a6e022-5789-43a2-d32b-b22c8cccf7ef@fala.ehost.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Remove unwanted crlf conversion in serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patryk Olszewski <patryk@fala.ehost.pl>, Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/23/2018 11:48 AM, Patryk Olszewski wrote:

>>> This patch is here to help fix years old bug of lf being replaced with
>>> crlf in serial, which is super problematic in binary transmissions,
>>> making communication with devices through serial from guest almost
>>> impossible.
>>>
>>> Setting OPOST flag in c_oflag enables the output processing, in other
>>> words it makes any other flag set in c_oflag come into action. From my
>>> quick experiment on serial devices on Linux I found out that by default
>>> c_oflag has enabled ONLCR flag, which is the one responsible for the
>>> crlf conversion. Unsetting OPOST disables it.
>>>
>>> Bug reports related to that:
>>>
>>> https://bugs.launchpad.net/qemu/+bug/1772086
>>>
>>> https://bugs.launchpad.net/qemu/+bug/1407813
>>>
>>> https://bugs.launchpad.net/qemu/+bug/1715296
>>>
>>> also
>>>
>>> https://lists.nongnu.org/archive/html/qemu-devel/2006-06/msg00196.html
>> Work that into your commit message, and you got a fine patch as far as
>> I'm concerned :)
>>
> First time contribution to such large project. Trying to learn how to
> properly work with mailing lists and such. If there's something I
> actually have to do now I'd like to get some pointers on how to do it.
> Thank you,

Then welcome to the qemu community!  In answer to your question, yes, 
now that you've had some valid reviewer comments, the ball is back in 
your court to incorporate the changes that were suggested to you, and 
submit a new top-level thread with a v2 in the subject line.

The easiest thing is to do 'git commit --amend' (works for a single 
commit) or even 'git rebase -i' then change the patch from 'pick' to 
'edit' (required when editing a patch series, but can also be used on a 
single patch to learn the patch flow), make the requested edits (that 
is, add your rationale into the commit message), and then send your new 
patch revision ('git send-email -1 -v2' or similar).  It also helps if 
version 2 contains a description after the '---' separator explaining 
how it is improved from v1 (in this case, improving the commit message). 
  Other patch submission hints can be found at 
http://wiki.qemu.org/Contribute/SubmitAPatch

Don't worry if you don't get everything perfect on your first try; we 
were all once beginners, so we don't mind helping someone else learn. 
But at the same time, demonstrating that you were able to make life 
easier for reviewers by following as many suggestions as possible, 
rather than leaving all the cleanup work to someone else, is an 
important skill to have if you plan to stick around for further 
contributions.

Also, feel free to ask questions on IRC where you might get faster 
response time, when it comes to figuring out your ideal setup for 
submitting patches with git.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
