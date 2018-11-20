Received: from eggs.gnu.org ([2001:4830:134:3::10]:56112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gP8Rp-0001f4-Uh
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gP8Rk-0003aG-VA
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:00:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gP8Rk-0003X4-Me
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:00:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1BE9430832D0
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 16:00:15 +0000 (UTC)
References: <20181120085603.31472-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9abccebe-4bff-bc35-4fe2-fedbf23314fe@redhat.com>
Date: Tue, 20 Nov 2018 10:00:11 -0600
MIME-Version: 1.0
In-Reply-To: <20181120085603.31472-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qapi: add query-display-options command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Erik Skultety <eskultet@redhat.com>

On 11/20/18 2:56 AM, Gerd Hoffmann wrote:
> Add query-display-options command, which allows to query the qemu

s/allows to query/allows querying/

> display configuration, and -- as intentional side effect -- makes

s/as/as an/

> DisplayOptions discoverable via query-qmp-schema so libvirt can go
> figure which display options are supported.
> 
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   vl.c         | 10 ++++++++++
>   qapi/ui.json | 13 +++++++++++++
>   2 files changed, 23 insertions(+)

Conflicts with d4dc4ab1, but the resolution is obvious.  Makes sense as 
3.1 material given that d4dc4ab1 is less useful without this.

Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
