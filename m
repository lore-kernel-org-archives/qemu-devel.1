Received: from eggs.gnu.org ([2001:4830:134:3::10]:56274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eme5R-0001pz-6y
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:21:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eme5M-0003Ph-8y
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:21:53 -0500
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:43400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eme5M-0003Nk-1m
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:21:48 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 698AE14F521
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 12:21:38 +0100 (CET)
Date: Fri, 16 Feb 2018 12:21:17 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180216122117.739d4b71@bahia.lan>
In-Reply-To: <63ffd605-a8ee-9642-7a18-0bac29db81cd@huawei.com>
References: <20180208180019.13683-1-antonios.motakis@huawei.com>
	<20180208180019.13683-4-antonios.motakis@huawei.com>
	<20180209161326.653f3468@bahia.lan>
	<3c73d37f-36f6-e487-7add-34c18310bda7@redhat.com>
	<20180209185749.7ecbd272@bahia.lan>
	<63ffd605-a8ee-9642-7a18-0bac29db81cd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] 9pfs: stat_to_qid: use device as input
 to qid.path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antonios Motakis <antonios.motakis@huawei.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, veaceslav.falico@huawei.com, Eduard.Shishkin@huawei.com, andy.wangguoli@huawei.com, Jani.Kokkonen@huawei.com, cota@braap.org, berrange@redhat.com

On Fri, 16 Feb 2018 11:20:33 +0100
Antonios Motakis <antonios.motakis@huawei.com> wrote:

<snip>
> 
> I'm not that sure that we can make the assumption that all entries in a 
> dir will share the st_dev,

The assumption stands for any entry that is not a directory actually.
But indeed a directory could be a mount point, and have a different
st_dev.

> I think we have to check it for each entry...
> 

Only if the entry might be a directory, ie,

dent->d_type == DT_DIR || dent->d_type == DT_UNKNOWN

> >  
> >> Also, POSIX permits returning specific errno codes that aren't otherwise
> >> listed for a syscall if the usual semantics of that errno code are
> >> indeed the reason for the failure (you should prefer to fail with errno
> >> codes documented by POSIX where possible, but POSIX does not limit you
> >> to just that set).
> >>  
> > Ok, then ENFILE wouldn't be that bad in the end.
> >
> > Thanks for your POSIX expertise :)  
> Will keep that one then!
> 
> >
> > Cheers,
> >
> > --
> > Greg  
> 
