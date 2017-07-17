Received: from eggs.gnu.org ([2001:4830:134:3::10]:42873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXBWi-0002rq-LI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dXBWf-0000gK-So
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:17:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dXBWf-0000fz-Lv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 15:17:49 -0400
Date: Mon, 17 Jul 2017 20:17:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170717191745.GB26923@work-vm>
References: <CAPyyD3-+LjCUD5TOp56LUut7yc9+tLiW=GgOBLK96XYjcCo5fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPyyD3-+LjCUD5TOp56LUut7yc9+tLiW=GgOBLK96XYjcCo5fg@mail.gmail.com>
Subject: Re: [Qemu-devel] CR3 difference by virsh and c program in
 Guest(update)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yu cui <cuiyudaniu@gmail.com>
Cc: qemu-devel@nongnu.org

* yu cui (cuiyudaniu@gmail.com) wrote:
> I tried virsh command, it seems CR3 value returns by qemu and dmesg by a c
> program in Guest is not same ?
> The command is :
> virsh -c qemu:///system qemu-monitor-command instance-0000009d '{"execute":
> "human-monitor-command", "arguments": {"command-line": "info registers"}}'
> 
> When Guest is 4GB,  CR3 in guest is like "cr3 = 0x39a54000", while qemu
> returns "cr3 = 0x0000000139a54000", with a gap of 4GB(0x0000000100000000).
> When Guest is 8GB,  CR3 in guest is like "cr3 = 0x39a54000", while qemu
> returns "cr3 = 0x0000000239a54000", with a gap of 8GB(0x0000000200000000).
> 
> So, it seems that CR3qemu = PysicalMem + CR3guest. Is it a bug?

Is your C program reading the full 64 bits of CR3 or just the bottom 32
bits?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
