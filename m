Received: from eggs.gnu.org ([2001:4830:134:3::10]:49553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmzCI-0007Iq-35
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmzCH-0000pz-7w
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:22:06 -0400
Date: Wed, 30 Aug 2017 10:21:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830092156.GE24565@stefanha-x1.localdomain>
References: <20170829204934.9039-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829204934.9039-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/9] IDE: replace printfs
 with tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, f4bug@amsat.org

On Tue, Aug 29, 2017 at 04:49:25PM -0400, John Snow wrote:
> Wherever possible, replace all printfs with proper tracing.
> In most places I've tried to do a straight replacement, but
> forthcoming patches may calibrate the tracing to be a little nicer.
> 
> For now, it's nice to just remove the all-or-nothing tracing.
> 
> For V2, I opted to leave in the nearly redundant tracers for now
> with their individual names so that they can be targeted individually.

Looks good.  I left a comment on one patch.
