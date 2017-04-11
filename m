Received: from eggs.gnu.org ([2001:4830:134:3::10]:56603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxuCf-0000DC-Ec
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cxuCe-0001Xi-Sh
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:43:21 -0400
Date: Tue, 11 Apr 2017 07:43:05 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1907823835.12728634.1491910985108.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170411100642.GH4516@noname.str.redhat.com>
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-10-famz@redhat.com>
	<20170411100642.GH4516@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 09/10] block: Use
 bdrv_coroutine_enter to start I/O coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


> So I think we should have another look at Sheepdog, the rest seems to be
> fine.

Sheepdog currently SEGVs and this might be the cause.  I can look at it
on Thursday.

Paolo
