Received: from eggs.gnu.org ([2001:4830:134:3::10]:38753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0WhK-0003Jq-47
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0WhF-0008Fe-Qo
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:18:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0WhF-0008FL-LN
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:18:17 -0400
References: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA8-2uHpdPYHbKj3fTyPd4DEXHm2CF-xVGcg5nJfzF8RDQ@mail.gmail.com>
	<9b924dcf-d5bb-d1d9-a570-5fffd6a8db92@redhat.com>
	<CAFEAcA8qXbuR+o0h3P5HyGgqLxhn6s9W-jpZp2Cnm-YgSOeNBg@mail.gmail.com>
	<ffb62c2e-58a8-2ed4-f6e4-36921140370c@redhat.com>
	<CAFEAcA-SuZ-aEY5aFpqdrjfGeNH+FoLz5vCxf4crJJdiO6w1jw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e877bbc-a0d9-8d6b-54c0-1831d340e1e9@redhat.com>
Date: Mon, 26 Mar 2018 13:18:16 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-SuZ-aEY5aFpqdrjfGeNH+FoLz5vCxf4crJJdiO6w1jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 03/26/2018 11:59 AM, Peter Maydell wrote:
> On 26 March 2018 at 17:54, Eric Blake <eblake@redhat.com> wrote:
>> Hmm, on re-reading that, I wonder if shortlog will do the right thing when a
>> .mailmap entry exists.  I'm trying to make sure we don't have to go
>> lower-level with use of 'git log --format=%ae' (vs. --format=%aE and/or log
>> --use-mailmap).
>>
>> /me goes and experiments with:
>>

>> +Julia Suvorova <<jusual@mail.ru> Julia Suvorova via Qemu-devel
>> <qemu-devel@nongnu.org>

> 
> Your mailmap change above seems to have a stray extra '<' in it --
> was that added by the mailing list server, or is it in the original?

D'oh, extra < in my playground.  Thankfully, removing it, and trying 
again, finds the same results: 'git shortlog 
--author=qemu-devel@nongnu.org' finds all Author: entries that were 
originally spelled with the list address, even if a .mailmap entry would 
rewrite it during 'git log --use-mailmap'.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
