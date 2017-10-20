Received: from eggs.gnu.org ([2001:4830:134:3::10]:57600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e5Thu-0003m2-Pz
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e5Thl-0003V9-42
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:35:06 -0400
Date: Fri, 20 Oct 2017 11:34:56 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171020093456.GA21393@stefanha-x1.localdomain>
References: <20171020091403.1479-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171020091403.1479-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] ide: avoid referencing NULL
 dev in rotational rate setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

On Fri, Oct 20, 2017 at 10:14:03AM +0100, Daniel P. Berrange wrote:
> The 'dev' variable can be NULL when the guest OS calls identify on an IDE
> unit that does not have a drive attached to it.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/ide/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
