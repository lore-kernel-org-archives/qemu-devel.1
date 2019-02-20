Received: from eggs.gnu.org ([209.51.188.92]:51554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwUdJ-0007BG-BE
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwUdG-0006Yo-Ss
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:22:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gwUdG-0006PM-HF
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:22:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04266C71BF
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 13:49:43 +0000 (UTC)
References: <20190206123625.1147-1-quintela@redhat.com>
	<20190206123625.1147-3-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2003a762-1199-257e-963a-dde196f3efea@redhat.com>
Date: Wed, 20 Feb 2019 07:49:39 -0600
MIME-Version: 1.0
In-Reply-To: <20190206123625.1147-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 2/3] migration: Create socket-address
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 2/6/19 6:36 AM, Juan Quintela wrote:
> It will be used to store the uri parameters. We want this only for
> tcp, so we don't set it for other uris.  We need it to know what port
> is migration running.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 

> +++ b/qapi/sockets.json
> @@ -152,3 +152,16 @@
>              'unix': 'UnixSocketAddress',
>              'vsock': 'VsockSocketAddress',
>              'fd': 'String' } }
> +
> +##
> +# @DummyStruct:
> +#
> +# Both block-core and migration needs SocketAddressList
> +# I am open to comments about how to share it
> +#
> +# @dummy-list: A dummy list
> +#
> +# Since: 3.1

4.0, now. And do you actually need it, now that you also have
['SocketAddress'] in MigrationInfo, which is visible to introspection?
I would try dropping this hunk and see if things would still compile.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
