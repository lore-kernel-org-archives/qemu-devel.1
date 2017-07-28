Received: from eggs.gnu.org ([2001:4830:134:3::10]:52262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db0Rs-0002p0-Du
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db0Ro-0007Kk-Dh
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:16:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db0Ro-0007KR-7z
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:16:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34B04EABFA
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 08:16:35 +0000 (UTC)
Date: Fri, 28 Jul 2017 09:16:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728081626.GC31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728063415.27480-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170728063415.27480-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui: drop ac_search and ac_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Jul 28, 2017 at 08:34:15AM +0200, Gerd Hoffmann wrote:
> Both keys exist already: "ac_search" is "find" and "ac_stop" is "stop".
> 
> Fixes: 37810e80553c19f0dac3644924895a9bf5c70785
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/input/ps2.c    | 8 ++++----
>  ui/input-keymap.c | 8 ++++----
>  qapi-schema.json  | 5 +----
>  3 files changed, 9 insertions(+), 12 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
