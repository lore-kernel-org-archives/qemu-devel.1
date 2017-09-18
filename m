Received: from eggs.gnu.org ([2001:4830:134:3::10]:55047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dtsLi-0007Sz-Cu
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dtsLg-0007Ve-4h
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:28:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dtsLf-0007V8-UW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:28:16 -0400
Date: Mon, 18 Sep 2017 10:28:11 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170918092811.GB2951@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <E7665638-9EE7-45B0-AF95-BC37863AC0DA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E7665638-9EE7-45B0-AF95-BC37863AC0DA@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 08/12] char: convert the escc device to
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Fri, Sep 15, 2017 at 02:32:14PM -0400, Programmingkid wrote:
> Sorry but I saw this error when I tried your patches:
> 
>   OBJC    ui/cocoa.o
>   CC      ui/curses.o
> ui/input-keymap.c:17:10: fatal error: 'ui/input-keymap-qcode-to-sun.c' file not
>       found
> #include "ui/input-keymap-qcode-to-sun.c"
>          ^
> 1 error generated.
> make: *** [ui/input-keymap.o] Error 1
> make: *** Waiting for unfinished jobs....
> 
> 
> I could not find this file.

Yes, its a bug in this series - just build without the sparc system
emulators to avoid it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
