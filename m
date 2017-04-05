Received: from eggs.gnu.org ([2001:4830:134:3::10]:40191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvh11-000072-B2
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvh0x-0006mT-L6
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:14:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cvh0x-0006mC-Fb
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 05:14:07 -0400
Date: Wed, 5 Apr 2017 10:14:01 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170405091401.GG21911@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <4712D8F4B26E034E80552F30A67BE0B1A4E5F6@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A4E5F6@ORSMSX112.amr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH] Put all trace.o into libqemuutil.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, 'Stefan Hajnoczi' <stefanha@gmail.com>, 'Paolo Bonzini' <pbonzini@redhat.com>

On Tue, Apr 04, 2017 at 09:39:39PM +0000, Xu, Anthony wrote:
> Put all trace.o into libqemuutil.a
> 
> Currently all trace.o are linked into qemu-system, qemu-img, 
> qemu-nbd, qemu-io etc., even the corresponding components 
> are not included.
> Put all trace.o into libqemuutil.a that the linker would only pull in .o 
> files containing symbols that are actually referenced by the 
> program.
> 
> 
> Signed-off -by: Anthony Xu <anthony.xu@intel.com>

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
