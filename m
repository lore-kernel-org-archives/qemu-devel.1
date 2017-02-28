Received: from eggs.gnu.org ([2001:4830:134:3::10]:38015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1cipNP-00034I-Ic
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1cipNM-0002RR-Fg
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:32:07 -0500
Received: from mail-he1eur01on0102.outbound.protection.outlook.com
	([104.47.0.102]:16064
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1cipNL-0002Qw-OT
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:32:04 -0500
References: <20170228120754.7947-1-berrange@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <64ceaeeb-21ba-eaec-299e-e18370b1da26@virtuozzo.com>
Date: Tue, 28 Feb 2017 15:59:25 +0300
MIME-Version: 1.0
In-Reply-To: <20170228120754.7947-1-berrange@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] io: fully parse & validate HTTP headers
 for websocket protocol handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>

On 02/28/2017 03:07 PM, Daniel P. Berrange wrote:
> The current websockets protocol handshake code is very relaxed, just
> doing crude string searching across the HTTP header data. This causes
> it to both reject valid connections and fail to reject invalid
> connections. For example, according to the RFC 6455 it:
>
>  - MUST reject any method other than "GET"
>  - MUST reject any HTTP version less than "HTTP/1.1"
>  - MUST reject Connection header without "Upgrade" listed
>  - MUST reject Upgrade header which is not 'websocket'
>  - MUST reject missing Host header
>  - MUST treat HTTP header names as case insensitive
>
> To do all this validation correctly requires that we fully parse the
> HTTP headers, populating a data structure containing the header
> fields.
>
> After this change, we also reject any path other than '/'
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

thanks, this works with the client that used to fail
(tornado python lib http://www.tornadoweb.org/en/stable/)


/Anton
