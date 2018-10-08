Received: from eggs.gnu.org ([2001:4830:134:3::10]:45238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cFg-0000AT-PE
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cFd-0002Gq-CV
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:35:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9cFd-0002CE-0y
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:35:37 -0400
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c6c11cc1-4ff2-faed-b291-da9b27515a25@redhat.com>
Date: Mon, 8 Oct 2018 15:35:30 -0500
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/31] block: Use warn_report() & friends
 to report warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Peter Lieven <pl@kamp.de>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Liu Yuan <namei.unix@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 10/8/18 12:30 PM, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  Convert a few that are actually warnings to
> warn_report().
> 
> While there, split warnings consisting of multiple sentences to
> conform to conventions spelled out in warn_report()'s contract, and
> improve a rather useless warning in sheepdog.c.
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
