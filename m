Received: from eggs.gnu.org ([2001:4830:134:3::10]:51905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g82mZ-0000jE-6G
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g82f9-0004MU-GA
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:23:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g82f9-0004MG-73
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:23:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92B7774F17
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 12:23:26 +0000 (UTC)
Received: from [10.10.126.73] (ovpn-126-73.rdu2.redhat.com [10.10.126.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3358D69EF1
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 12:23:26 +0000 (UTC)
References: <20181003212211.812374-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7769f219-a14d-7445-c382-ed0b4aa75d9e@redhat.com>
Date: Thu, 4 Oct 2018 07:23:25 -0500
MIME-Version: 1.0
In-Reply-To: <20181003212211.812374-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/5] NBD patches through 2018-10-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 10/3/18 4:22 PM, Eric Blake wrote:
> The following changes since commit dafd95053611aa14dda40266857608d12ddce658:
> 
>    Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-02 18:27:18 +0100)
> 
> are available in the Git repository at:
> 
>    git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-10-03
> 
> for you to fetch changes up to 7f7dfe2a53446072c136d349e3150c84d322b2bc:
> 
>    nbd/server: drop old-style negotiation (2018-10-03 15:52:32 -0500)
> 
> ----------------------------------------------------------------
> nbd patches for 2018-10-03
> 
> Fix bug in NBD_CMD_CACHE, drop support for oldstyle NBD server,
> minor build and doc fixes
> 
> - Vladimir Sementsov-Ogievskiy: 0/2 server: drop old-style negotiation
> - Eric Blake: qemu-nbd: Document --tls-creds
> - Vladimir Sementsov-Ogievskiy: nbd/server: fix NBD_CMD_CACHE
> - Peter Maydell: nbd: Don't take address of fields in packed structs

NACK; a second bug in NBD_CMD_CACHE was found, I'll post a v2 series to 
include that fix as well.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
