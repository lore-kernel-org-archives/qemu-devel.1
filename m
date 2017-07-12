Received: from eggs.gnu.org ([2001:4830:134:3::10]:57779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVJs3-00025z-S7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVJrz-0006Eh-5x
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:48:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170609152017.7286-1-eblake@redhat.com>
	<1298d3b1-a6d6-499b-323b-b79c6e38bc7b@msgid.tls.msk.ru>
	<15dc487a-c340-e407-a7b0-b7159a5a49a2@redhat.com>
Date: Wed, 12 Jul 2017 17:48:01 +0200
In-Reply-To: <15dc487a-c340-e407-a7b0-b7159a5a49a2@redhat.com> (Eric Blake's
	message of "Wed, 12 Jul 2017 08:56:05 -0500")
Message-ID: <871spl4pxq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] qobject coccinelle followups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, marcandre.lureau@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/12/2017 08:35 AM, Michael Tokarev wrote:
>> 09.06.2017 18:20, Eric Blake wrote:
>>> Inspired by https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02505.html
>>>
>>> Surprisingly, the updated script didn't find any existing longhand
>>> use as candidates for QDECREF() (our last such use was cleaned up
>>> as a side effect, in commit b72fe9e), but it DID find another straggler
>>> missed in commit 579cf1d1.
>>>
>>> Eric Blake (2):
>>>   qobject: Update coccinelle script to catch Q{INC,DEC}REF
>>>   qobject: Catch another straggler for use of qdict_put_str()
>> 
>> Applied to -trivial, thanks!
>
> Markus has taken v2 of these patches through his qapi-next tree:
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg05589.html
>
> so you can drop this v1 from -trivial

I've dragged my feet on the pull request in the hope of still adding a
few patches of my own.  Figure I better put them into the next one.
