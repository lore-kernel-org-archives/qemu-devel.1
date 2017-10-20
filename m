Received: from eggs.gnu.org ([2001:4830:134:3::10]:42395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4594c9e72=Ian.Jackson@citrix.com>)
	id 1e5Uby-0000jF-SY
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4594c9e72=Ian.Jackson@citrix.com>)
	id 1e5Ubu-000410-BL
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:33:06 -0400
Received: from smtp.citrix.com ([66.165.176.89]:49501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4594c9e72=Ian.Jackson@citrix.com>)
	id 1e5Ubu-0003zq-6T
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:33:02 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23017.53467.384290.5153@mariner.uk.xensource.com>
Date: Fri, 20 Oct 2017 11:32:59 +0100
In-Reply-To: <150843936788.413.8319410302655093683@b58463cdfd5f>
References: <1508431916-9412-1-git-send-email-ian.jackson@eu.citrix.com>
	<150843936788.413.8319410302655093683@b58463cdfd5f>
Subject: Re: [Qemu-devel] [PATCH v5 0/8] xen: xen-domid-restrict improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, anthony.perard@citrix.com, ross.lagerwall@citrix.com, sstabellini@kernel.org, jgross@suse.com, xen-devel@lists.xenproject.org

no-reply@patchew.org writes ("Re: [Qemu-devel] [PATCH v5 0/8] xen: xen-domid-restrict improvements"):
> This series seems to have some coding style problems. See output below for
> more information:

No, it doesn't have coding style problems.  At least, this mail
contains only one complaint which is this:

> Checking PATCH 7/8: os-posix: Provide new -runas <uid>.<gid> facility...
> ERROR: consider using qemu_strtoul in preference to strtoul
> #45: FILE: os-posix.c:142:
> +    lv = strtoul(optarg, &ep, 0); /* can't qemu_strtoul, want *ep=='.' */

This is a false positive as you can see from the comment.

Ian.
