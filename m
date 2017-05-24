Received: from eggs.gnu.org ([2001:4830:134:3::10]:37159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMiB-0003y7-Lz
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDMi8-0005r2-Gc
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dDMi8-0005qs-AA
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:11:44 -0400
Date: Wed, 24 May 2017 11:11:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170524031141.GI12279@lemon.lan>
References: <f0b11c2d-9f61-c4c2-4b55-58644b760e31@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0b11c2d-9f61-c4c2-4b55-58644b760e31@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] new to qemu with a simple question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang Dong <dongdwdw@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

On Wed, 05/24 10:56, Wang Dong wrote:
> Some C source code is generate from json file.
> 
> I wonder why this? What is the benefits of this?

This allows you to concentrate on the high level semantics of the QMP API,
without worrying about C syntax and structural code here and there. In one
word, more conciseness and little code duplication.

If done in C, it would be much more lines of code and hardly readable.

Fam
