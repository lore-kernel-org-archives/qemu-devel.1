Received: from eggs.gnu.org ([2001:4830:134:3::10]:41956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYcfh-0006VO-6z
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYcfd-0007tz-Ft
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:56:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cYcfd-0007tn-AE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 12:56:45 -0500
Date: Tue, 31 Jan 2017 19:56:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170131195603-mutt-send-email-mst@kernel.org>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<20170131165052.GD20303@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170131165052.GD20303@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 31, 2017 at 04:50:52PM +0000, Daniel P. Berrange wrote:
> On Tue, Jan 31, 2017 at 04:43:52PM +0200, Michael S. Tsirkin wrote:
> > Some headers use QEMU_BUILD_BUG_ON. This causes a problem
> > if the C file including that header happens to have
> > QEMU_BUILD_BUG_ON at the same line number.
> 
> Do we actually hit this problem in practice ?  Even if we do hit the
> problem, it surely has a trivial workaround of just inserting/removing
> a blank line somewhere in the file before the QEMU_BUILD_BUG_ON.
> 
> IOW, is it really a benefit to change to use COUNTER, given that it is
> less portable that what we have today ?
> 
> Regards,
> Daniel

It failed for me, and I'm not inclined to insert empty lines
to work around this for reasons for taste :)

> -- 
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
