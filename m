Received: from eggs.gnu.org ([2001:4830:134:3::10]:54226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYbix-0007KB-SY
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cYbiu-0003JU-4p
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:56:07 -0500
Date: Tue, 31 Jan 2017 16:55:57 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170131165557.GE20303@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] Drop QEMU_GNUC_PREREQ() checks for gcc
 older than 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

On Tue, Jan 31, 2017 at 04:14:47PM +0000, Peter Maydell wrote:
> We already require gcc 4.1 or newer (for the atomic
> support), so the fallback codepaths for older gcc
> versions than that are now dead code and we can
> just delete them.

Do we have any explicit check alreadu for 4.1, or do we
just let the build fail on the atomic code ?

IOW, is there any use in having..

#if !QEMU_GNUC_PREREQ(4, 1)
# error "QEMU requires GCC >= 4.1 or CLang"
#endif

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
