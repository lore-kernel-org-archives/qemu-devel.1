Received: from eggs.gnu.org ([2001:4830:134:3::10]:38069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEaTR-0006hR-S6
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEaTM-00009F-6V
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:10:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEaTM-00008y-1E
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:10:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B2DCF4270963
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 13:10:03 +0000 (UTC)
References: <20180504095346.14159-1-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71760a5e-1904-b179-6d0c-dbef0aa21778@redhat.com>
Date: Fri, 4 May 2018 08:09:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180504095346.14159-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] libvhost-user: Send messages with no data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com

On 05/04/2018 04:53 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The response to a VHOST_USER_POSTCOPY_ADVISE contains a fd but doesn't

s/a fd/an fd/ ? Depends on whether you pronounce it "eff-dee" or 
"file-descriptor".

> actually contain any data.   FIx vu_message_write so that it doesn't

s/FIx/Fix/

> do a 0-byte write() call, since this was ending up with rc=0
> that was confusing the error handling code.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   contrib/libvhost-user/libvhost-user.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
