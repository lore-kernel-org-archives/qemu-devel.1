Received: from eggs.gnu.org ([2001:4830:134:3::10]:52496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cpu2U-0007eM-07
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cpu2O-0001Qn-6p
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:55:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cpu2O-0001P5-03
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 05:55:40 -0400
Date: Mon, 20 Mar 2017 09:55:33 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170320095533.GB3792@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <11569d75b61122820f186a32cdd20689@whitewinterwolf.com>
	<20170315144124.GP7770@redhat.com>
	<23d89ab3bd16ebf7a864ab75c300de7b@whitewinterwolf.com>
	<CAFEAcA-9GXiS+ByQgo+=tQ-_ZGR5egDcZMurEyfiA9vPkE9O9w@mail.gmail.com>
	<20170315180822.GU7770@redhat.com>
	<CAFEAcA-WzT80S_NJb8rSALspBZcCQbT7eounFn9HusjtLWoi_Q@mail.gmail.com>
	<20170316102652.GG15193@redhat.com>
	<14585f602461dbefb3adaf16591ce5e5@whitewinterwolf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14585f602461dbefb3adaf16591ce5e5@whitewinterwolf.com>
Subject: Re: [Qemu-devel] [Bug 1217339] [PATCH v2] Unix signal to send
 ACPI-shutdown to Guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon <qemu.bugs@whitewinterwolf.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, Mar 18, 2017 at 02:41:16PM +0100, Simon wrote:
> Hi,
> 
> The patch below adds the new command-line option `-powerdown' which
> changes the behavior for both SIGHUP and SIGINT signals to cause a clean
> power down of the guest using an ACPI shutdown request.

If you need to add command line arguments IMHO this feature becomes
much less interesting - just use the QEMU monitor instead of inventing
an adhoc way to achieve something the monitor already does. The value of
using a signal handler comes from the fact that it would be unconditionally
available no matter what command line args were added.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
