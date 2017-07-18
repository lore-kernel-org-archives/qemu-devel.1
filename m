Received: from eggs.gnu.org ([2001:4830:134:3::10]:46932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXMug-0001OV-Pa
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXMud-0001h9-Ga
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:27:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXMud-0001gN-AD
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:27:19 -0400
Date: Tue, 18 Jul 2017 08:27:13 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718072713.GC11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170718060627.2107-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170718060627.2107-1-anton.ivanov@cambridgegreys.com>
Subject: Re: [Qemu-devel] [PATCH] Unified Socket Transport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: anton.ivanov@cambridgegreys.com
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

On Tue, Jul 18, 2017 at 07:06:27AM +0100, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> 1. Creates a common recvmmsg backend for socket transports
> 2. Migrates L2TPv3 to the new backend
> 3. Adds gre socket transport - a vm can attach directly to GRE
> 4. Adds raw socket transport - a vm can attach directly to an
> Ethernet interface
> 5. Adds simplistic static VXLAN tunnel transport (no
> control plane).
> 6. Sets up some of the infrastructure for future addition of
> sendmmsg

This list of features is a really strong sign that you should split
this patch up into a patch series with multiple commits, each commit
adding / changing a single feature. Especially keep refactoring of
existing code completely separate from adding of new features.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
