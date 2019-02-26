Received: from eggs.gnu.org ([209.51.188.92]:58955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyjT1-00041D-Cc
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:36:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gyjT0-0003p6-Kg
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:36:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gyjT0-0003hp-DK
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 15:36:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8746F3082291
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 20:36:27 +0000 (UTC)
References: <20190226195959.28759-1-dgilbert@redhat.com>
	<20190226195959.28759-8-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0a9c174-cd26-1edc-e884-aaaad7227ba0@redhat.com>
Date: Tue, 26 Feb 2019 14:36:26 -0600
MIME-Version: 1.0
In-Reply-To: <20190226195959.28759-8-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 7/9] qmp: Add announce-self command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, jasowang@redhat.com
Cc: quintela@redhat.com

On 2/26/19 1:59 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add a qmp command that can trigger guest announcements.
> 
> It uses its own announce-timer instance, and parameters
> passed to it explicitly in the command.
> 
> Like most qmp commands, it's in the main thread/bql, so
> there's no racing with any outstanding timer.
> 
> Based on work of Germano Veit Michel <germano@redhat.com> and
>                  Vladislav Yasevich <vyasevic@redhat.com>
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  net/announce.c |  7 +++++++
>  qapi/net.json  | 20 ++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
