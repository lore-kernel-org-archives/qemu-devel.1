Received: from eggs.gnu.org ([2001:4830:134:3::10]:59709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=442a0b037=Ian.Jackson@citrix.com>)
	id 1dzQw3-0002XJ-C8
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 13:24:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=442a0b037=Ian.Jackson@citrix.com>)
	id 1dzQvz-00076V-FG
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 13:24:47 -0400
Received: from smtp.citrix.com ([66.165.176.89]:61506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=442a0b037=Ian.Jackson@citrix.com>)
	id 1dzQvz-00075p-9P
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 13:24:43 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <22995.51149.836093.934334@mariner.uk.xensource.com>
Date: Tue, 3 Oct 2017 18:24:29 +0100
In-Reply-To: <150549947282.36.16369833326552913963@69b6ddf88678>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
	<150549947282.36.16369833326552913963@69b6ddf88678>
Subject: Re: [Qemu-devel] [PATCH RFC 0/6] xen: xen-domid-restrict
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, jgross@suse.com, sstabellini@kernel.org, xen-devel@nongnu.org

no-reply@patchew.org writes ("Re: [Qemu-devel] [PATCH RFC 0/6] xen: xen-domid-restrict improvements"):
> This series seems to have some coding style problems. See output below for
> more information:

Thanks for this automatic mail.  I have sorted out most of these.
However:

> ERROR: consider using qemu_strtoul in preference to strtoul
> #41: FILE: os-posix.c:159:
> +        lv = strtoul(optarg, &ep, 0);

In one of these two cases, it is not possible to use qemu_strtoul
because the expected terminator is '.'.  I have added a comment about
this.

Ian.
