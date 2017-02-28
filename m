Received: from eggs.gnu.org ([2001:4830:134:3::10]:50686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipkc-0003a5-VH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cipkc-0004yg-05
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:56:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
Date: Tue, 28 Feb 2017 22:55:57 +0100
In-Reply-To: <1488317230-26248-1-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Tue, 28 Feb 2017 22:26:46 +0100")
Message-ID: <87innu6kuq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/24] block: Command line option
 -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Markus Armbruster <armbru@redhat.com> writes:

> Actually, the command line option is the least part of this series.
> Its bulk is about building infrastructure and getting errors out of
> the JSON parser[*].  The latter part could be spun out in its own
> series, if that helps.  We'll see.
>
> The design of the command line interface was discussed here:
> Subject: Non-flat command line option argument syntax
> Message-ID: <87bmukmlau.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00555.html
>
> This series is based on "[PULL 00/26] QAPI patches for 2017-02-28".
> Available as branch blockdev-cmdline in my public repo
> <http://repo.or.cz/w/qemu/armbru.git>.
>
> [*] Who'd have thunk anyone actually wants to know what's wrong with
> his JSON!
>
> v2: Address review by Eric and Kevin

Forgot to mention: patches reordered, PATCH 21-23 are now PATCH 17-19.

> PATCH 03: Comment fixes, memory leak plugged
> PATCH 05: Comment fix
> PATCH 08+12: Announce followup work in commit message 
> PATCH 18: Comment fix
> PATCH 20: A missing test for failure fixed
> PATCH 21: Option help text improved, loop to call qmp_blockdev_add()
>           moved to the right place
> PATCH 22: Commit message fix
> PATCH 23: Commit message fix, qobject_input_get_keyval() fixed to set
>           v->keyval, memory leaks plugged, test case tweaked to cover
> 	  leading zero, keyval_listify() thinko fixed (this is the
> 	  only non-trivial change in v2)
