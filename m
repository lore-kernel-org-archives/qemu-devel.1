Received: from eggs.gnu.org ([2001:4830:134:3::10]:49092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhXMs-0008Rr-Fy
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhXMp-000390-CJ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:38:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhXMp-00038J-5c
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:38:27 -0400
Date: Tue, 15 Aug 2017 09:38:22 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170815083822.GB9674@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <695CE828-CE3F-48D0-B20E-7B88C76453B8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <695CE828-CE3F-48D0-B20E-7B88C76453B8@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Aug 14, 2017 at 02:46:22PM -0400, Programmingkid wrote:
> Sorry but there appears to be an issue with your patchset. I ran this command:
> 
> ./configure --target-list=ppc-softmmu,i386-softmmu
> 
> Then saw this error message: 
> 
> error: pathspec 'ui/keycodemapdb' did not match any file(s) known to git.
> 
> Running 'make' I saw this error message:
> 
> make: *** No rule to make target `ui/input-keymap-atset1-to-qcode.c', needed by `Makefile'.  Stop.
> make: *** Waiting for unfinished jobs....
> 
> Running the 'make clean' command produces this error message:
> 
> make[1]: *** No rule to make target `ui/input-keymap-atset1-to-qcode.c', needed by `Makefile'.  Stop.
> make: *** [clean] Error 1
> 
> Perhaps a missing patch?

No, its a missing "git submodule update --init ui/keycodemapdb" call

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
