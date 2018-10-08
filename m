Received: from eggs.gnu.org ([2001:4830:134:3::10]:48279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cQB-00054G-5w
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cQ7-0002Fn-9a
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:46:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9cQ5-00028r-6p
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:46:27 -0400
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-29-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ca2afa9-1eb3-6b01-bea9-486227dc1355@redhat.com>
Date: Mon, 8 Oct 2018 15:46:16 -0500
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-29-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 28/31] fsdev: Clean up error reporting in
 qemu_fsdev_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

On 10/8/18 12:31 PM, Markus Armbruster wrote:
> Calling error_report() from within a a function that takes an Error **

s/a a/a/

> argument is suspicious.  qemu_fsdev_add() does that, and its caller
> fsdev_init_func() then fails without setting an error.  Its caller
> main(), via qemu_opts_foreach(), is fine with it, but clean it up
> anyway.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
