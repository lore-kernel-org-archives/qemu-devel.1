Received: from eggs.gnu.org ([2001:4830:134:3::10]:41610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRL33-0005xE-Uq
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRL31-0005Oz-Tj
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:19:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fRL31-0005Oj-Ot
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:19:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52BAB79D36
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 17:19:35 +0000 (UTC)
References: <20180608170231.27912-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e6239aaa-2f02-eb23-e9ea-968d7aaa6c8e@redhat.com>
Date: Fri, 8 Jun 2018 12:19:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180608170231.27912-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Purge uses of banned g_assert_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 06/08/2018 12:02 PM, Markus Armbruster wrote:
> We banned use of certain g_assert_FOO() functions outside tests, and
> made checkpatch.pl flag them (commit 6e9389563e5).  We neglected to
> purge existing uses.  Do that now.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
