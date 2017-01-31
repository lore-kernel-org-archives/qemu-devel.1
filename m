Received: from eggs.gnu.org ([2001:4830:134:3::10]:53235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYbe2-0002hx-Qb
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYbdz-0000tg-PA
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:51:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cYbdz-0000s9-K7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:50:59 -0500
Date: Tue, 31 Jan 2017 16:50:52 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170131165052.GD20303@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485873796-15095-1-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 31, 2017 at 04:43:52PM +0200, Michael S. Tsirkin wrote:
> Some headers use QEMU_BUILD_BUG_ON. This causes a problem
> if the C file including that header happens to have
> QEMU_BUILD_BUG_ON at the same line number.

Do we actually hit this problem in practice ?  Even if we do hit the
problem, it surely has a trivial workaround of just inserting/removing
a blank line somewhere in the file before the QEMU_BUILD_BUG_ON.

IOW, is it really a benefit to change to use COUNTER, given that it is
less portable that what we have today ?

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
