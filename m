Received: from eggs.gnu.org ([2001:4830:134:3::10]:47678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1difVo-0006B7-Gs
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1difVj-0008RE-D6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:32:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1difVj-0008QV-6J
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:32:19 -0400
Date: Fri, 18 Aug 2017 13:32:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170818133214.13414eb4.cohuck@redhat.com>
In-Reply-To: <4b80d965-d162-84eb-c6c6-0adb86d83ce8@redhat.com>
References: <20170818110015.25310-1-cohuck@redhat.com>
	<4b80d965-d162-84eb-c6c6-0adb86d83ce8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/tcg: specification exception for
 unknown diag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, borntraeger@de.ibm.com

On Fri, 18 Aug 2017 13:26:15 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 18.08.2017 13:00, Cornelia Huck wrote:
> > While the PoP is silent on the issue, z/VM documentation states
> > that unknown diagnose codes trigger a specification exception.
> > We already do that when running with kvm, so change tcg to do so
> > as well.  
> 
> I just tried on a z/VM guest what happens if I call diag with an
> unsupported code, and the Linux kernel then crashes with a specification
> exception, indeed. So this sounds like the right thing to do!

For reference, here's the relevant hunk in z/VM documentation:
https://www.ibm.com/support/knowledgecenter/SSB27U_6.4.0/com.ibm.zvm.v640.hcpb4/hcpb432.htm

> 
> > This is on top of "s390x: wire up diag288 in tcg".  
> 
> May I suggest to order the patches the other way round? ... that's less
> code churn that way.

Let me detangle my branches...
