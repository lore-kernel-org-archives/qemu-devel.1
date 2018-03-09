Received: from eggs.gnu.org ([2001:4830:134:3::10]:33879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euKl8-0001I5-L1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euKl5-00077a-Ey
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:42 -0500
Received: from smtp.citrix.com ([66.165.176.89]:23089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euKl5-000764-6h
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:39 -0500
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23202.46164.466502.645911@mariner.uk.xensource.com>
Date: Fri, 9 Mar 2018 16:20:36 +0000
In-Reply-To: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
Subject: Re: [Qemu-devel] [PATCH v6.1 00/11] xen: xen-domid-restrict
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano  Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

I have folded in the comments so far and made a prototype v7 series,
which is here:

  http://xenbits.xen.org/gitweb/?p=people/iwj/qemu.git;a=summary
  https://xenbits.xen.org/git-http/people/iwj/qemu.git
  git://xenbits.xen.org/people/iwj/qemu.git

In the branch

  master..xen-restrict-v7.0

I have NOT been able to test it, unfortunately, as my test setup for
this had rotted and I am now going away for two weeks.  It does
compile.

I'm posting this here just because it seems bad form to go away with
the branch in a "secret" location on my workstation.  If someone else
wants to pick it up and shepherd it into the 2.12 release then that
would of course be fine by me; if not I will pick it up when I get
back.

I have some more work to build on top of this anyway, including wiring
this into the Xen CI, before it can be declared properly supported by
Xen.

In the meantime maybe the fixes to get_maintainer and checkpatch are
independent of the rest and should probably be applied as soon as
practical (subject to any further review that may be needed).  that
is:

 [PATCH 01/12] checkpatch: Add xendevicemodel_handle to the list of types
 [PATCH 12/12] scripts/get_maintainer.pl: Print proper error message for missing $file

Or from my branch above,

 cb3ebff4087a checkpatch: Add xendevicemodel_handle to the list of types
 15dedc627cad scripts/get_maintainer.pl: Print proper error message for missing $file

Regards,
Ian.
