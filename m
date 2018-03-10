Received: from eggs.gnu.org ([2001:4830:134:3::10]:60376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eun4s-0007nW-WC
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 17:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eun4r-0002sN-Vr
	for qemu-devel@nongnu.org; Sat, 10 Mar 2018 17:34:59 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1d3b01d0-4cf8-9a3a-e7a6-862599cda2dc@redhat.com>
Date: Sat, 10 Mar 2018 16:34:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180224154033.29559-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/7] block: Handle null backing link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 02/24/2018 09:40 AM, Max Reitz wrote:
> Currently, we try to rewrite every occurrence of "backing": null into
> "backing": "" in qmp_blockdev_add().  However, that breaks using the
> same "backing": null construction in json:{} file names (which do not go
> through qmp_blockdev_add()).  Currently, these then just behave as if
> the option has not been specified.
> 
> Since there is actually only one place where we evaluate the @backing
> option to find out whether not to use a backing file, we can instead
> just check for null there.  It doesn't matter that this changes the
> runtime state of the option from "" to null, because nobody really does
> anything with that runtime state anyway (except put it into qemu again,
> but qemu doesn't care whether it's "" or null).
> 
> And in the future, it's much better if we get it to be null in that
> runtime state sooner than later -- see patch 7.
> 
> 
> Note that it was Markus (who's away having a good time, I hope) who
> proposed qobject_to(), so I guess he won't object too much to seeing the
> concept having landed in his tree once he returns.
> (Although he hasn't reviewed the previous iteration of this series,
>   which included it already.)
> 

Thanks, applied to my QAPI staging tree (with qobject_to(type, obj) 
reordering - it didn't take me too long after all):
git://repo.or.cz/qemu/ericb.git qapi
http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/qapi

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
