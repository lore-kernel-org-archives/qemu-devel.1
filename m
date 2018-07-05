Received: from eggs.gnu.org ([2001:4830:134:3::10]:44561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb7gQ-0001Qf-0r
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fb7gL-0003jj-D3
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:04:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55572 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fb7gL-0003jU-8i
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:04:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFE71416F7C9
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 17:04:36 +0000 (UTC)
References: <20180705091402.26244-1-armbru@redhat.com>
	<20180705091402.26244-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <54a3cd74-1409-fde2-939b-94465e10f78b@redhat.com>
Date: Thu, 5 Jul 2018 12:04:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180705091402.26244-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] cli qmp: Mark --preconfig,
 exit-preconfig experimental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com

On 07/05/2018 04:14 AM, Markus Armbruster wrote:
> Committing to the current --preconfig / exit-preconfig interface
> before it has seen any use is premature.  Mark both as experimental,
> the former in documentation, the latter by renaming it to
> x-exit-preconfig.
> 
> See the previous commit for more detailed rationale.

One additional point - the fact that 'x-exit-preconfig' vs. 
'exit-preconfig' is introspectable means that even if we decide to 
cement the ABI at a time when libvirt is taught to use it, libvirt will 
know that 3.0's version is not the final form of the feature (ideally, 
of course, we'll be able to fix qemu to avoid the need for the 
--preconfig hack in the first place...)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
