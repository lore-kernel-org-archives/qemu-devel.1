Received: from eggs.gnu.org ([2001:4830:134:3::10]:39820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dOQKb-0005Ac-Ts
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dOQKY-0004o8-Qu
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:17:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dOQKY-0004nw-Kg
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:17:06 -0400
Date: Fri, 23 Jun 2017 12:16:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170623151657.GA5002@localhost.localdomain>
References: <20170621052935.20715-1-boqun.feng@gmail.com>
	<20170623133814.GE11773@localhost.localdomain>
	<c766613f-b84a-a7a8-5dd5-d886fbf50cf6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c766613f-b84a-a7a8-5dd5-d886fbf50cf6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target-i386: add Skylake-Server cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Boqun Feng (Intel)" <boqun.feng@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Fri, Jun 23, 2017 at 04:06:57PM +0200, Paolo Bonzini wrote:
[...]
> > I believe we should add the same comment about XSAVES from
> > Skylake-Cliente here, for consistency:
> > 
> >         /* Missing: XSAVES (not supported by some Linux versions,
> >          * including v4.1 to v4.6).
> 
> It's up to 4.12. :)

Thanks for the tip, I will update the comment.  :)

-- 
Eduardo
