Received: from eggs.gnu.org ([2001:4830:134:3::10]:59801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOgu-0001Ye-NU
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOgr-0000a3-MK
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:59:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fGOgr-0000ZS-Ht
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:59:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01231818F6FF
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 12:59:29 +0000 (UTC)
References: <20180509112406.6183-1-quintela@redhat.com>
	<20180509112406.6183-34-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <611cf764-7847-6578-8c92-962d7c5dfcac@redhat.com>
Date: Wed, 9 May 2018 07:59:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180509112406.6183-34-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 33/41] qmp/migration: new command
 migrate-recover
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

On 05/09/2018 06:23 AM, Juan Quintela wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> The first allow-oob=true command.  It's used on destination side when
> the postcopy migration is paused and ready for a recovery.  After
> execution, a new migration channel will be established for postcopy to
> continue.
> 

Right now, oob is still disabled by default.  Where do we stand on 
re-enabling it after the last-minute disabling needed for a stable 2.12 
release?


> +++ b/qapi/migration.json
> @@ -1191,3 +1191,23 @@
>   # Since: 2.9
>   ##
>   { 'command': 'xen-colo-do-checkpoint' }
> +
> +##
> +# @migrate-recover:
> +#
> +# Provide a recovery migration stream URI.
> +#
> +# @uri: the URI to be used for the recovery of migration stream.
> +#
> +# Returns: nothing.
> +#
> +# Example:
> +#
> +# -> { "execute": "migrate-recover",
> +#      "arguments": { "uri": "tcp:192.168.1.200:12345" } }
> +# <- { "return": {} }
> +#
> +# Since: 2.12

This needs to be amended to 2.13 (same followup as other issues 
mentioned elsewhere in the series)

> +##
> +{ 'command': 'migrate-recover', 'data': { 'uri': 'str' },
> +  'allow-oob': true }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
