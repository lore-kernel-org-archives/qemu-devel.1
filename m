Received: from eggs.gnu.org ([2001:4830:134:3::10]:53012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1uIe-0008GT-P2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1uIY-0005yg-Ls
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:10:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1uIY-0005yK-Fp
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:10:14 -0400
Date: Tue, 10 Oct 2017 15:10:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171010151005.15dc7907.cohuck@redhat.com>
In-Reply-To: <20171004154144.88995-9-pasic@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-9-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] s390x: factor out common ioinst
 handler logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed,  4 Oct 2017 17:41:44 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Some of ioinst the handlers look very much the same: they basically
> delegate the work to the appropriate css function (doing some always the
> same stuff before and after the call to the appropriate css function).
> Let us create a template and get rid of some code.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Suggested-by: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>
> ---
>  target/s390x/ioinst.c | 59 ++++++++++++---------------------------------------
>  1 file changed, 14 insertions(+), 45 deletions(-)

Staring at this patch, I'm not sure I like it, although I can't quite
put a finger on *what* I don't like... maybe the whole 'template'
approach.
