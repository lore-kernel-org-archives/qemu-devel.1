Received: from eggs.gnu.org ([2001:4830:134:3::10]:39602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfZhb-0004QT-IN
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfZha-0001LQ-JA
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:43:47 -0400
Date: Wed, 9 Aug 2017 18:43:40 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <186485494.2838970.1502318620647.JavaMail.zimbra@redhat.com>
In-Reply-To: <eeba95b4-23a2-51da-2c41-be5ee262c965@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-2-pbonzini@redhat.com>
	<eeba95b4-23a2-51da-2c41-be5ee262c965@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/12] qemu-iotests: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org



----- Original Message -----
> From: "Eric Blake" <eblake@redhat.com>
> To: "Paolo Bonzini" <pbonzini@redhat.com>, qemu-devel@nongnu.org
> Cc: kwolf@redhat.com, qemu-block@nongnu.org
> Sent: Thursday, August 10, 2017 12:18:54 AM
> Subject: Re: [Qemu-devel] [PATCH 01/12] qemu-iotests: remove dead code
> 
> On 08/09/2017 04:54 PM, Paolo Bonzini wrote:
> > This includes shell function, shell variables, command line options
> > (randomize.awk does not exist) and conditions that can never be true
> > (./qemu does not exist anymore).
> 
> Can we point to a commit id where we stopped making ./qemu?

commit 9aed1e036dc0de49d08d713f9e5c4655e94acb56
Author: Anthony Liguori <aliguori@us.ibm.com>
Date:   Mon Aug 29 09:55:36 2011 -0500

    Rename qemu -> qemu-system-i386
    
    This has been discussed before in the past.  The special casing really makes no
    sense anymore.  This seems like a good change to make for 1.0.
    
    Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

> Is it still worth supporting a local symlink?

Not sure who would have one...

Paolo
