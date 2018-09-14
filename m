Received: from eggs.gnu.org ([2001:4830:134:3::10]:60829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0hEl-0006uJ-VF
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0hEg-00051k-Rg
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1g0hEg-00050Q-L9
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:05:46 -0400
Date: Fri, 14 Sep 2018 14:05:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180914060543.GB3653@lemon.usersys.redhat.com>
References: <CAB3eZfvRJRR1k0X1MQivPMcLRNZR07yv1ZxBiDAkF3qOryK0UQ@mail.gmail.com>
	<20180912074402.GB11164@lemon.usersys.redhat.com>
	<CAB3eZfsGcWP2WdZXocQ6wdztBbRofgXOVi+N=W3FEPxH0N1hyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB3eZfsGcWP2WdZXocQ6wdztBbRofgXOVi+N=W3FEPxH0N1hyA@mail.gmail.com>
Subject: Re: [Qemu-devel] Can I convert backing file to internal snapshot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lampahome <pahome.chen@mirlab.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 09/14 12:23, lampahome wrote:
> Can I convert from internap snapshot to external snapshot?
> If there's 3 snapshots in one qcow2, can I convert them all to external
> snapshots?

Qcow2 doesn't track internal snapshot dependencies like external snapshot, so
there is no direct way to create the "differentiative" or "delta" images in the
same way as would be with external snapshots. In theory it's possible to convert
all internal snapshots to separate full images then create delta by
sector-by-sector comparison.

Fam
