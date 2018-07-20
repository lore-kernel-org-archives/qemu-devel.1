Received: from eggs.gnu.org ([2001:4830:134:3::10]:45304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fgb9E-0002FB-3b
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fgb9A-0006dA-6o
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:33:04 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:36663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fgb9A-0006ci-0H
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 15:33:00 -0400
Received: by mail-pl0-x243.google.com with SMTP id e11-v6so5592415plb.3
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 12:32:59 -0700 (PDT)
Date: Fri, 20 Jul 2018 12:32:57 -0700
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Message-ID: <20180720193257.GB23996@breakout>
References: <20180718211256.29774-1-naravamudan@digitalocean.com>
	<a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1269390-a798-9165-aaf5-a2aa6270bd54@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org

On 20.07.2018 [15:11:14 -0400], Farhan Ali wrote:
> I am seeing another issue pop up, in a different test. Even though it's a
> different assertion, it might be related based on the call trace.

Just to be clear, this does not happen if you revert the original patch
(i.e., the one you bisected to before)?

I'm digging into the code now.

-Nish
