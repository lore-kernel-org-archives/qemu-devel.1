Received: from eggs.gnu.org ([2001:4830:134:3::10]:57507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <procmem@riseup.net>) id 1fOwqu-0008Qd-Kh
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 23:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <procmem@riseup.net>) id 1fOwqq-0008NL-Lm
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 23:05:12 -0400
Received: from mx1.riseup.net ([198.252.153.129]:38325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <procmem@riseup.net>) id 1fOwqq-0008Mu-Ah
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 23:05:08 -0400
References: <40602400-cae4-e175-e7ce-10ac70ba52f5@riseup.net>
	<20180601113444.GG8687@stefanha-x1.localdomain>
	<b25b3adb-bacc-bef1-7d18-c71a4933abc1@riseup.net>
	<20180601184855-mutt-send-email-mst@kernel.org>
	<20180601185429.GB2532@work-vm>
From: procmem <procmem@riseup.net>
Message-ID: <dbddbb35-0eac-5b23-4677-1c36b2474990@riseup.net>
Date: Sat, 2 Jun 2018 03:04:48 +0000
MIME-Version: 1.0
In-Reply-To: <20180601185429.GB2532@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Virtio-net drivers immune to Nethammer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, jasowang@redhat.com, qemu-devel@nongnu.org, whonix-devel@whonix.org



Dr. David Alan Gilbert:
> Isn't the idea to misuse CAT to detect something about access patterns;
> so it's not about it actually being related?

AFAICT, CAT is directly responsible since the way it interacts with the
cache allows it to introduce predictable bit flips that can wreak all
kinds of havoc.
