Received: from eggs.gnu.org ([2001:4830:134:3::10]:58941)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1eYYLh-0000G7-D5
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1eYYLe-00038F-2L
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:24:25 -0500
Received: from verein.lst.de ([213.95.11.211]:33004 helo=newverein.lst.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hch@lst.de>) id 1eYYLd-000374-S8
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:24:21 -0500
Date: Mon, 8 Jan 2018 15:24:19 +0100
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20180108142419.GA10273@lst.de>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514940265-18093-1-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v1 00/21] RISC-V QEMU Port Submission v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

> The RISC-V QEMU port implements the following specifications:
> - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10

What is the reason to support the legacy 1.9.1 privileg spec?  That
support seems to make a mess of quite a lot of the code, and has been
superseded quite a while ago.
