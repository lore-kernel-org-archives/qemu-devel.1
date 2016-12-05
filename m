Received: from eggs.gnu.org ([2001:4830:134:3::10]:45755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krister@redhat.com>) id 1cDwK1-0004ZO-NO
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krister@redhat.com>) id 1cDwJw-0005P9-RO
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:40:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <krister@redhat.com>) id 1cDwJw-0005Ok-L8
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:40:52 -0500
Reply-To: krister@redhat.com
References: <20161201192652.9509-1-stefanha@redhat.com>
	<20161205102549.GA23432@lemon>
	<20161205145626.GF30434@stefanha-x1.localdomain>
From: Karl Rister <krister@redhat.com>
Message-ID: <8a60274e-2bb8-fd1a-282d-f1b5e106d684@redhat.com>
Date: Mon, 5 Dec 2016 10:40:49 -0600
MIME-Version: 1.0
In-Reply-To: <20161205145626.GF30434@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/13] aio: experimental virtio-blk
 polling mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On 12/05/2016 08:56 AM, Stefan Hajnoczi wrote:
<snip>

> Karl: do you have time to run a bigger suite of benchmarks to identify a
> reasonable default poll-max-ns value?  Both aio=native and aio=threads
> are important.
> 
> If there is a sweet spot that improves performance without pathological
> cases then we could even enable polling by default in QEMU.
> 
> Otherwise we'd just document the recommended best polling duration as a
> starting point for users.
> 

I have collected a baseline on the latest patches and am currently
collecting poll-max-ns=16384.  I can certainly throw in a few more
scenarios.  Do we want to stick with powers of 2 or some other strategy?

-- 
Karl Rister <krister@redhat.com>
