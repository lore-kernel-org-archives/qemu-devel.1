Received: from eggs.gnu.org ([2001:4830:134:3::10]:39813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1df1To-0000pg-Fd
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1df1Tk-0006RV-Hs
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1df1Tk-0006Qo-Ah
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:11:12 -0400
Date: Tue, 8 Aug 2017 11:11:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170808101106.GD9393@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170804213625.3756-1-ehabkost@redhat.com>
	<20170804213625.3756-2-ehabkost@redhat.com>
	<20170808100721.GC16801@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808100721.GC16801@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/5] qmp-shell: Use argparse module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com

On Tue, Aug 08, 2017 at 11:07:21AM +0100, Stefan Hajnoczi wrote:
> On Fri, Aug 04, 2017 at 06:36:21PM -0300, Eduardo Habkost wrote:
> > It makes command-line parsing and generation of help text much
> > simpler.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  scripts/qmp/qmp-shell | 61 +++++++++++++++++----------------------------------
> >  1 file changed, 20 insertions(+), 41 deletions(-)
> 
> The minimum Python version is 2.6.  The argparse module was introduced
> in Python 2.7 so we cannot use it without increasing the minimum Python
> version:
> 
> https://docs.python.org/2.6/modindex.html
> 
> I suggest holding off on this for now.

Although its deprecated, perhaps we can use  optparse instead ? It is
available in py2 & 3 and very similar to argparse.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
