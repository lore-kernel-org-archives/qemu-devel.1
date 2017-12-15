Received: from eggs.gnu.org ([2001:4830:134:3::10]:60527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePuSC-0006yj-06
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePuS6-00066I-Tc
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:11:23 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ePuS6-00064D-NR
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:11:18 -0500
Received: by mail-wm0-f52.google.com with SMTP id 64so19193150wme.3
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:11:18 -0800 (PST)
References: <20171213181540.7949-1-danielhb@linux.vnet.ibm.com>
	<20171213181540.7949-2-danielhb@linux.vnet.ibm.com>
	<de0c5647-ca81-f5be-db52-9f0d3b173dac@redhat.com>
	<87ind9xrl6.fsf@dusky.pond.sub.org>
	<949be39f-d2a9-29b4-d9b7-46378d827161@linux.vnet.ibm.com>
	<87ind8nlh9.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf9ded69-6cf6-f7bf-cfca-a31a6b784211@redhat.com>
Date: Fri, 15 Dec 2017 19:11:14 +0100
MIME-Version: 1.0
In-Reply-To: <87ind8nlh9.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] qmp.c: (re)implement qmp_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On 15/12/2017 14:56, Markus Armbruster wrote:
> 
> Paolo, we have numerous Features/ pages, and I suspect many of them are
> too outdated to serve any purpose but confusing readers.  In theory,
> "somebody" could go through them to identify stale ones.  In practice,
> "somebody" doesn't exist, I'm afraid.  Should we summarily delete
> Features/ pages that haven't seen an update in say more than a year?  Or
> at least mark them as obsolete somehow?

Plenty of them are marked as complete or obsolete:

https://wiki.qemu.org/Category:Completed_feature_pages
https://wiki.qemu.org/Category:Obsolete_feature_pages

Last time I cleaned them up, I couldn't quite decide if some were
completed or obsolete, and QAPI is one of them.

Paolo
