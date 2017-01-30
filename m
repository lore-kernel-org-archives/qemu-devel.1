Received: from eggs.gnu.org ([2001:4830:134:3::10]:43253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYEBR-0007Cj-Gi
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYEBO-0001Ni-ES
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:47:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cYEBO-0001NV-8E
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:47:54 -0500
Date: Mon, 30 Jan 2017 15:47:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170130154749.GJ27325@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1485782396-22341-1-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485782396-22341-1-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] io: ignore case in WebSocket HTTP
 header #PSBM-57554
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>

What is #PSBM-57554 referring to ?  Is that some custom bug tracker
you have ? I'm going to drop that unless its something we need to
keep

On Mon, Jan 30, 2017 at 04:19:56PM +0300, Denis V. Lunev wrote:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
> 
> According to RFC7230 Section 3.2, header field name is case-insensitive.
> 
> The haystack string length is limited by 4096 bytes by
> qio_channel_websock_handshake_read().
> 
> Further, handshake_process() dups and NULL-terminates the string
> so it is safe to call non length-limited functions like strcasestr().
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

will add this to my io queue

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
