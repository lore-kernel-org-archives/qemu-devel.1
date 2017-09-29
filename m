Received: from eggs.gnu.org ([2001:4830:134:3::10]:38416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxy14-0006JM-BC
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxy11-00007H-5z
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:19:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxy11-00006w-0S
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:19:51 -0400
Date: Fri, 29 Sep 2017 17:19:45 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170929161945.GI11930@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170929145629.14766-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170929145629.14766-1-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 1/1] websock: treat upgrade header in case
 insensitive way
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On Fri, Sep 29, 2017 at 05:56:29PM +0300, Denis V. Lunev wrote:
> According to rfc6455 section 4.2.1. Reading the Client's Opening Handshake
>   An |Upgrade| header field containing the value "websocket",
>   treated as an ASCII case-insensitive value.
> 
> Current implementation in QEMU accepts this header in lower-case only,
> which is revealed to have broken some real-life clients. We need to
> convert the value of this header to lower case before comparison.
> Unfortunately we can not do that for all headers. Only this specific one
> should be converted this way.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Daniel P. Berrange <berrange@redhat.com>

FYI, I already have a fix for this problem queued:

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02982.html


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
