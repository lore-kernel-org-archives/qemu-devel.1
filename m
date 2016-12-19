Received: from eggs.gnu.org ([2001:4830:134:3::10]:39730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cImQi-0002ZZ-2q
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 20:07:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cImQe-0002p6-TT
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 20:07:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cImQe-0002oi-O2
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 20:07:48 -0500
Date: Mon, 19 Dec 2016 09:07:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161219010743.GA2719@lemon>
References: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
Subject: Re: [Qemu-devel] Can qemu reopen image files?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christopher Pereira <kripper@imatronix.cl>
Cc: qemu-devel@nongnu.org

On Sun, 12/18 20:52, Christopher Pereira wrote:
> Hi,
> 
> We are doing a "qemu-img convert" operation (qcow2, with compression) to
> shorten the backing-chain (in the middle of the backing-chain).
> In order to force qemu to reopen files, we do a save and restore operation.
> Is there a faster way to reopen image files using virsh or qemu?

No, don't use qemu-img when the image is in use by QEMU. You want to use
"block-commit" command provided by QMP.

Fam
