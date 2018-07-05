Received: from eggs.gnu.org ([2001:4830:134:3::10]:37986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fb7MF-0006PD-3J
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fb7MB-0003uX-Lx
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:43:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fb7MB-0003u8-Fs
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:43:47 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B62C2317C40A
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 16:43:46 +0000 (UTC)
Date: Thu, 5 Jul 2018 17:43:43 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180705164343.GE16293@redhat.com>
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
	<d154245b-46c0-58b0-b6f9-1f1313634c80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d154245b-46c0-58b0-b6f9-1f1313634c80@redhat.com>
Subject: Re: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, berrange@redhat.com, jferlan@redhat.com

On Thu, Jul 05, 2018 at 04:20:33PM +0200, Laszlo Ersek wrote:
> QEMU does the right thing. If other hypervisors don't do this -- while
> still taking and displaying the value in UUID / GUID textual format --,
> they are wrong. The VMGENID spec from Microsoft
> <http://go.microsoft.com/fwlink/?LinkId=260709> specifically mentions
> "GUID".

The MSFT spec does mention GUID, but it seems to me that it's only
using GUID as an incidental example -- ie. that you might use the VM
Generation ID to generate a GUID.  Outside that example it
consistently refers to the VM Gen ID as a 128-bit integer.  It also
says that it could be used as a "high entropy random data source",
which is not in fact true if it's a UUID.

It has to be said that after reading the spec again [the MSFT spec,
not qemu's spec] and what other hypervisors are doing, I'm not sure
qemu is doing the right thing here.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
