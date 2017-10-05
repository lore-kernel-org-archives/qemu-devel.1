Received: from eggs.gnu.org ([2001:4830:134:3::10]:33682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4442ceff9=Ian.Jackson@citrix.com>)
	id 1e041x-0000Vg-Id
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4442ceff9=Ian.Jackson@citrix.com>)
	id 1e041u-00029h-94
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:09:29 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:13998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4442ceff9=Ian.Jackson@citrix.com>)
	id 1e041u-00029J-3D
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:09:26 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <22998.4833.991131.797982@mariner.uk.xensource.com>
Date: Thu, 5 Oct 2017 12:09:21 +0100
In-Reply-To: <150714217015.153.939212709472417601@b58463cdfd5f>
References: <1507132392-25051-1-git-send-email-ian.jackson@eu.citrix.com>
	<150714217015.153.939212709472417601@b58463cdfd5f>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] xen: xen-domid-restrict improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, anthony.perard@citrix.com, ross.lagerwall@citrix.com, sstabellini@kernel.org, jgross@suse.com, xen-devel@nongnu.org

no-reply@patchew.org writes ("Re: [Qemu-devel] [PATCH v2 0/7] xen: xen-domid-restrict improvements"):

> ERROR: consider using qemu_strtoul in preference to strtoul
> #42: FILE: os-posix.c:160:
> +        lv = strtoul(optarg, &ep, 0); /* can't qemu_strtoul, want *ep=='.' */
> 
> total: 1 errors, 0 warnings, 80 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

As I said earlier, it is not clear to me what to do about this.

checkpatch's suggestion to use qemu_strtoul is appropriate.  But,
qemu_strtoul isn't quite a 100% replacement for all strtoul use cases,
and this is one of the exceptions.

I have added this comment and you'll see in the patch that surrounding
that line there is attention paid to the error handling, overflows,
etc.

Maybe I should submit a patch to checkpatch that causes this
suggestion to go away if qemu_strtoul is mentioned "nearby" (maybe on
the same line or an adjacent line), so that the use of qemu_strtoul
rather thanraw strtoul has indeed been "considered" as the message
suggests ?

Regards,
Ian.
