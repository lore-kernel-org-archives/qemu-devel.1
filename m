Received: from eggs.gnu.org ([2001:4830:134:3::10]:40616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC5l8-0001kO-H5
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eC5l5-0002GS-5E
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:25:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eC5l4-0002Er-Ue
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:25:47 -0500
Date: Tue, 7 Nov 2017 15:25:42 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171107152542.GH3213@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171107143652.15375-1-berrange@redhat.com>
	<CAFEAcA9e1dc01TVQQ2TxK9wNRejUA3pqBz1WdwMPvnxHXvB3Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9e1dc01TVQQ2TxK9wNRejUA3pqBz1WdwMPvnxHXvB3Bw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v2 0/1] Merge IO 2017/11/06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Nov 07, 2017 at 03:22:02PM +0000, Peter Maydell wrote:
> On 7 November 2017 at 14:36, Daniel P. Berrange <berrange@redhat.com> wrote:
> > The following changes since commit 5853e92207193e967abf5e4c25b4a551c7604725:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-cocoa-20171107' into staging (2017-11-07 12:19:48 +0000)
> >
> > are available in the git repository at:
> >
> >   git://github.com/berrange/qemu pull-2017-11-06-2
> >
> > for you to fetch changes up to 10a7b7e6fd9f250f0506568345d7b4d2ab52889d:
> >
> >   sockets: avoid leak of listen file descriptor (2017-11-07 14:10:20 +0000)
> >
> > ----------------------------------------------------------------
> > Pull IO 2017/11/06 v2
> >
> > ----------------------------------------------------------------
> > Daniel P. Berrange (1):
> >   sockets: avoid leak of listen file descriptor
> >
> >  util/qemu-sockets.c | 52 +++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 29 insertions(+), 23 deletions(-)
> 
> Applied, thanks. (My test script expected your pullreq to
> say "git://github.com/berrange/qemu tags/pull-2017-11-06-2"
> but that might be the script not being as smart as it could be.)

Oh my bad. I forgot to actually push the tag to github before generating
the cover letter text, and I guess that caused git to leave off the 'tags/'
bit

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
