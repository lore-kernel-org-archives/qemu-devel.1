Received: from eggs.gnu.org ([2001:4830:134:3::10]:40950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhFuq-0002lc-Aa
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhFun-0001hH-41
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:00:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhFum-0001fv-TS
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:00:21 -0400
Date: Mon, 14 Aug 2017 15:00:03 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170814140003.GF8506@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <mailman.1778.1502715001.21954.qemu-devel@nongnu.org>
	<223B4DEC-A801-40E3-A118-33EBB9ED384D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <223B4DEC-A801-40E3-A118-33EBB9ED384D@gmail.com>
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
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>

On Mon, Aug 14, 2017 at 09:39:56AM -0400, Programmingkid wrote:
> 
> > On Aug 14, 2017, at 8:50 AM, qemu-devel-request@nongnu.org wrote:
> > 
> > An update of:
> > 
> >  v1: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02047.html
> >  v2: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02471.html
> > 
> > The keycodemap project[1] provides a database mapping between
> > many different keysym/keycode/scancode sets, along with a
> > tool to generate mapping/lookup tables in various programming
> > languages. It is already used by GTK-VNC, SPICE-GTK and
> > libvirt.
> > 
> > This series enables its use in QEMU, thus fixing a great
> > many bugs/ommissions in the 15+ key mapping tables people
> > have manually written for QEMU.
> 
> Would you have a git repository that has all your patches already applied? It would make testing your patches a lot easier.

I only maintain stable public repos for pull requests.

These are based against git master, just save the series and then 'git am'
the lot in one go.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
