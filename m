Received: from eggs.gnu.org ([2001:4830:134:3::10]:59860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOhL-00028H-Uf
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOhI-0001HF-UH
	for qemu-devel@nongnu.org; Wed, 09 May 2018 09:00:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGOhI-0001GV-PL
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:59:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A014406C78C
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 12:59:56 +0000 (UTC)
References: <20180509112406.6183-1-quintela@redhat.com>
	<20180509112406.6183-37-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <db5c05c3-4786-22a7-33de-9951649e805c@redhat.com>
Date: Wed, 9 May 2018 07:59:55 -0500
MIME-Version: 1.0
In-Reply-To: <20180509112406.6183-37-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 36/41] migration/qmp: add command
 migrate-pause
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 05/09/2018 06:24 AM, Juan Quintela wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> It pauses an ongoing migration.  Currently it only supports postcopy.
> Note that this command will work on either side of the migration.
> Basically when we trigger this on one side, it'll interrupt the other
> side as well since the other side will get notified on the disconnect
> event.
> 
> However, it's still possible that the other side is not notified, for
> example, when the network is totally broken, or due to some firewall
> configuration changes.  In that case, we will also need to run the same
> command on the other side so both sides will go into the paused state.
> 

> +++ b/qapi/migration.json
> @@ -1211,3 +1211,19 @@
>   ##
>   { 'command': 'migrate-recover', 'data': { 'uri': 'str' },
>     'allow-oob': true }
> +
> +##
> +# @migrate-pause:
> +#
> +# Pause a migration.  Currently it only supports postcopy.
> +#
> +# Returns: nothing.
> +#
> +# Example:
> +#
> +# -> { "execute": "migrate-pause" }
> +# <- { "return": {} }
> +#
> +# Since: 2.12

Another 2.13 fixup

> +##
> +{ 'command': 'migrate-pause', 'allow-oob': true }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
