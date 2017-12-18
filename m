Received: from eggs.gnu.org ([2001:4830:134:3::10]:46591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQrb6-0006Yk-F5
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQrb1-0001ii-Hg
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:20:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eQrb1-0001hs-49
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:20:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
	<20171213181540.7949-2-danielhb@linux.vnet.ibm.com>
	<de0c5647-ca81-f5be-db52-9f0d3b173dac@redhat.com>
	<87ind9xrl6.fsf@dusky.pond.sub.org>
	<949be39f-d2a9-29b4-d9b7-46378d827161@linux.vnet.ibm.com>
	<87ind8nlh9.fsf@dusky.pond.sub.org>
	<bf9ded69-6cf6-f7bf-cfca-a31a6b784211@redhat.com>
Date: Mon, 18 Dec 2017 10:20:23 +0100
In-Reply-To: <bf9ded69-6cf6-f7bf-cfca-a31a6b784211@redhat.com> (Paolo
	Bonzini's message of "Fri, 15 Dec 2017 19:11:14 +0100")
Message-ID: <87shc8gzoo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 1/2] qmp.c: (re)implement qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, dgilbert@redhat.com

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 15/12/2017 14:56, Markus Armbruster wrote:
>> 
>> Paolo, we have numerous Features/ pages, and I suspect many of them are
>> too outdated to serve any purpose but confusing readers.  In theory,
>> "somebody" could go through them to identify stale ones.  In practice,
>> "somebody" doesn't exist, I'm afraid.  Should we summarily delete
>> Features/ pages that haven't seen an update in say more than a year?  Or
>> at least mark them as obsolete somehow?
>
> Plenty of them are marked as complete or obsolete:
>
> https://wiki.qemu.org/Category:Completed_feature_pages
> https://wiki.qemu.org/Category:Obsolete_feature_pages

I see.

> Last time I cleaned them up, I couldn't quite decide if some were
> completed or obsolete, and QAPI is one of them.

Probably because Features/QAPI is both: it was completed long ago, less
a number of ideas described in this page.

The page should be updated accordingly.  I'll try to find time for it,
but don't hold your breath.
