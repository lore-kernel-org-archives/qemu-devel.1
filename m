Received: from eggs.gnu.org ([2001:4830:134:3::10]:48376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7yl1-0006SV-TL
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7ykx-0006TA-Rz
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:08:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7ykx-0006SI-LD
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 03:08:39 -0400
Date: Fri, 27 Oct 2017 08:08:33 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171027070833.GA24218@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAOE=1Z31T6nHcO4P6GWW8GK_o0VB66HivPc-m1LZRh_x6nY_6g@mail.gmail.com>
	<20171026140203.GG10055@redhat.com>
	<CAOE=1Z3Umt+mLDKyJ04qRsH-E=EPYC2ozeHm5a3jbqF0=yv-hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOE=1Z3Umt+mLDKyJ04qRsH-E=EPYC2ozeHm5a3jbqF0=yv-hQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu start VM in huge page without '-mem-prealloc'
 will get memory leak?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Oct 27, 2017 at 11:28:33AM +0800, Sam wrote:
> After restart ovs-dpdk(which is openvswitch with dpdk lib), memory is
> released.
> 
> But problem is in product environment, I could not restart ovs-dpdk......

This is a clear bug in ovs-dpdk then - it is failing to release memory
when QEMU exits.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
