Received: from eggs.gnu.org ([2001:4830:134:3::10]:46643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eN16q-0000bt-65
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:41:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eN16p-0003qE-Gn
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:41:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eN16p-0003p6-AF
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:41:23 -0500
Date: Thu, 7 Dec 2017 18:41:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171207184104.GA2489@work-vm>
References: <CAO1xR-zb6Eni1LD0PB80hGRKU8PCqxjbfHtVM4aUt9i+3Utq3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO1xR-zb6Eni1LD0PB80hGRKU8PCqxjbfHtVM4aUt9i+3Utq3w@mail.gmail.com>
Subject: Re: [Qemu-devel] iSER transport name is not good
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Charles Kelimod <lichstor@gmail.com>
Cc: qemu-devel@nongnu.org, ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@kamp.de

* Charles Kelimod (lichstor@gmail.com) wrote:
> Hello,
> 
> 
> I'm on the road of modifying libvirt to add iSER support, and I found qemu
> is actually support that. But, the transport name is iSER, which should be
> RDMA and there libvirt already defined it.
> 
> Best Regards,
> Charles.

Hi Charles,
  So this is iSCSI extensions for RDMA?  I've cc'd in the qemu iSCSI
maintainers.
  Can you just explain what you're seeing libvirt do and what you think
qemu is expecting it to do for iSER?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
