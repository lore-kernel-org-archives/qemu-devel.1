Received: from eggs.gnu.org ([2001:4830:134:3::10]:33350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dzcRM-0005lz-8C
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dzcRH-00041s-PM
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:41:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dzcRH-00041L-Iu
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 01:41:47 -0400
Date: Wed, 4 Oct 2017 13:41:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171004054143.GC24018@lemon>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
	<150549947282.36.16369833326552913963@69b6ddf88678>
	<22995.51149.836093.934334@mariner.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22995.51149.836093.934334@mariner.uk.xensource.com>
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
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: qemu-devel@nongnu.org, jgross@suse.com, sstabellini@kernel.org, xen-devel@nongnu.org

On Tue, 10/03 18:24, Ian Jackson wrote:
> no-reply@patchew.org writes ("Re: [Qemu-devel] [PATCH RFC 0/6] xen: xen-domid-restrict improvements"):
> > This series seems to have some coding style problems. See output below for
> > more information:
> 
> Thanks for this automatic mail.  I have sorted out most of these.
> However:
> 
> > ERROR: consider using qemu_strtoul in preference to strtoul
> > #41: FILE: os-posix.c:159:
> > +        lv = strtoul(optarg, &ep, 0);
> 
> In one of these two cases, it is not possible to use qemu_strtoul
> because the expected terminator is '.'.  I have added a comment about
> this.

Thanks for taking a look at the report and helping explain. Yes, so the error is
false positive, let's ignore it.

Fam
