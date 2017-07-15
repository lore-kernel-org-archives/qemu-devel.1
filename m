Received: from eggs.gnu.org ([2001:4830:134:3::10]:35396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMAm-0003rn-Ih
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMAi-00059u-L9
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:27:48 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:48322)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dWMAi-00059L-Dq
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 08:27:44 -0400
Date: Sat, 15 Jul 2017 14:27:41 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170715122741.plc63rjp56bswxnu@var.youpi.perso.aquilenet.fr>
References: <1500030745-10619-1-git-send-email-peter.maydell@linaro.org>
	<1500030745-10619-3-git-send-email-peter.maydell@linaro.org>
	<20170714142418.GA2415@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714142418.GA2415@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] slirp: Handle error returns from
 sosendoob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org, Jan Kiszka <jan.kiszka@siemens.com>

Dr. David Alan Gilbert, on ven. 14 juil. 2017 15:24:19 +0100, wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > sosendoob() can return a failure code, but all its callers ignore it.
> > This is OK in sbappend(), as the comment there states -- we will try
> > again later in sowrite(). Add a (void) cast to tell Coverity so.
> > In sowrite() we do need to check the return value -- we should handle
> > a write failure in sosendoob() the same way we handle a write failure
> > for the normal data.
> > 
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Applied to my tree, thanks!

Samuel
