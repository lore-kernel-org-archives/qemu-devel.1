Received: from eggs.gnu.org ([2001:4830:134:3::10]:35274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eOlBE-0005CE-2B
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eOlBA-0004rM-43
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eOlB9-0004qr-TQ
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AE0A5D5E6
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 14:05:02 +0000 (UTC)
Date: Tue, 12 Dec 2017 22:04:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171212140443.GB3447@xz-mi>
References: <20171212111219.32601-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171212111219.32601-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sockets: remove obsolete code that updated
 listen address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Tue, Dec 12, 2017 at 11:12:19AM +0000, Daniel P. Berrange wrote:
> When listening on unix/tcp sockets there was optional code that would update
> the original SocketAddress struct with the info about the actual address that
> was listened on. Since the conversion of everything to QIOChannelSocket, no
> remaining caller made use of this feature. It has been replaced with the ability
> to query the listen address after the fact using the function
> qio_channel_socket_get_local_address. This is a better model when the input
> address can result in listening on multiple distinct sockets.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
