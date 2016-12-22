Received: from eggs.gnu.org ([2001:4830:134:3::10]:51925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJzkX-0001kd-By
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cJzkT-0004RR-Kj
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:33:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cJzkT-0004RI-En
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:33:17 -0500
Date: Thu, 22 Dec 2016 09:33:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20161222093311.GJ965@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CA+scX6nh8NeTWZ44KG85T_ywzVnSc6bMhO69hhGhzbh8ZLnwOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+scX6nh8NeTWZ44KG85T_ywzVnSc6bMhO69hhGhzbh8ZLnwOg@mail.gmail.com>
Subject: Re: [Qemu-devel] [libvirt] Cannot add iothreads label in libvirt
 xml configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Weiwei Jia <harrynjit@gmail.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org

On Wed, Dec 21, 2016 at 12:11:51PM -0500, Weiwei Jia wrote:
> Hi,
> 
> I cannot add iothreads
> (https://libvirt.org/formatdomain.html#elementsIOThreadsAllocation) in
> the libvirt xml configuration file. Once I add
> "<iothreads>4</iothreads>" and other related config for IOthreads into
> the libvirt xml configuration file with virsh command and save it,
> these iothreads related configuration will disappear after I open
> libvirt xml configuration file again for double-check.

If XML disappears after saving it, this usually indicates that either you
made a mistake and used the wrong XML element or in the wrong place, or
that your libvirt version is too old to support it. You can use the
virt-xml-validate too to verify your XML file against the schema for
your installed version of libvirt, which will report any errrors.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
