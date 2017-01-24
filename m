Received: from eggs.gnu.org ([2001:4830:134:3::10]:39253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxVm-0002Ey-2s
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxVk-0007rf-V5
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:35:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxVk-0007rW-PI
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:35:32 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE40980508
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:35:32 +0000 (UTC)
Date: Tue, 24 Jan 2017 09:35:27 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124093527.GB14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170120164322.21851-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/17] io: add methods to set I/O handlers
 on AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com

On Fri, Jan 20, 2017 at 05:43:10PM +0100, Paolo Bonzini wrote:
> This is in preparation for making qio_channel_yield work on
> AioContexts other than the main one.
> 
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: removed QIOChannelRestart [Daniel]
> 
>  include/io/channel.h | 25 +++++++++++++++++++++++++
>  io/channel-command.c | 13 +++++++++++++
>  io/channel-file.c    | 11 +++++++++++
>  io/channel-socket.c  | 16 +++++++++++-----
>  io/channel-tls.c     | 12 ++++++++++++
>  io/channel-watch.c   |  6 ++++++
>  io/channel.c         | 11 +++++++++++
>  7 files changed, 89 insertions(+), 5 deletions(-)

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
