Received: from eggs.gnu.org ([2001:4830:134:3::10]:59074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRKlf-0001DL-80
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRKlb-0008BU-7Z
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:33:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRKlb-0008Aj-1k
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:33:51 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181121164421.20780-1-david@redhat.com>
Date: Mon, 26 Nov 2018 18:33:44 +0100
In-Reply-To: <20181121164421.20780-1-david@redhat.com> (David Hildenbrand's
	message of "Wed, 21 Nov 2018 17:44:12 +0100")
Message-ID: <87efb7iw07.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 for-4.0 0/9] qapi: Rewrite
 string-input-visitor's integer and list parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> Rewrite string-input-visitor to be (hopefully) less ugly. Support
> int and uint lists (including ranges, but not implemented via type
> "Range").
>
> Virtual walks are now supported and more errors are cought (and some bugs
> fixed). Fix and extend the tests. Parsing of uint64_t is now properly
> supported.
>
> Importantly, when parsing a list we now return the list and not an
> ordered set (we are not an ordered set parser after all). Whoever needs
> that can add it on top. As far as I can see, current code can deal with
> it but I'll have to look at the details.
>
> While at it, introduce and use qemu_strtod() and qemu_strtod_finite().
> However don't convert monitor.c as that seems to be too broken for me
> (it ignores both conversion errors and range errors, and there is an
> actual unit test in which conversion is expected to fail).

Queued for 4.0.  Thanks a lot, David!
