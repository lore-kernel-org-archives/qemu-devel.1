Received: from eggs.gnu.org ([2001:4830:134:3::10]:43481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDYQi-0005rV-Vn
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dDYQf-0000h9-Pz
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:42:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dDYQf-0000gn-Jq
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:42:29 -0400
Date: Wed, 24 May 2017 16:42:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170524154225.GI18771@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <6ace537dec6122d5bd07e600b9ab9b6c@whitewinterwolf.com>
	<2b6ca5dc-724e-49b0-1665-80f7aa82f584@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b6ca5dc-724e-49b0-1665-80f7aa82f584@redhat.com>
Subject: Re: [Qemu-devel] Monitor file path length limitation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Simon <qemu.bugs@whitewinterwolf.com>, qemu-devel@nongnu.org

On Wed, May 24, 2017 at 10:26:58AM -0500, Eric Blake wrote:
> On 05/24/2017 10:16 AM, Simon wrote:
> > Hello,
> > 
> > It seems that the monitor file path length is limited to about 100
> > characters (107 to be precise).
> 
> Welcome to the joy of Unix socket (AF_UNIX) files.  The kernel imposes a
> hard length limit on sockaddr_un.sun_path[] (see 'man 7 unix') - and it
> is indeed 107 characters plus a NUL terminator.
> 
> > -monitor
> > 'unix:/home/user/vmtools/test/out/foobar.iso/foobar.iso_A/foobar.iso_B/foobar.iso_C/foobar.iso_D/foobar.iso_E/monitor.sock,server,nowait'
> > 
> > 
> > With this command Qemu does not produce any warning or error message but
> > create the socket file "mon" instead of the expected "monitor.sock".
> 
> Ideally, qemu should be telling you your path is too long to be created
> as a unix socket, and failing up front, rather than silently truncating
> and perhaps doing the wrong thing.

I just copied you on a patch todo that :-)



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
