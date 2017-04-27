Received: from eggs.gnu.org ([2001:4830:134:3::10]:33620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3lIp-0006JY-Nl
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3lIo-00024i-Th
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 11:25:55 -0400
Date: Thu, 27 Apr 2017 17:25:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170427152545.GI4805@noname.str.redhat.com>
References: <20170426134649.9042-1-mreitz@redhat.com>
	<20170426134649.9042-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426134649.9042-4-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-img: Document backing options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

Am 26.04.2017 um 15:46 hat Max Reitz geschrieben:
> The create and convert subcommands have shorthands to set the
> backing_file and, in the case of create, the backing_fmt options for the
> new image. However, they have not been documented so far, which is
> remedied by this patch.
> 
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

I think originally the idea was to remove the individual special case
options in the long term in favour of the uniform -o. But I don't think
the short options have fallen out of use, so we can as well document
them again...

Maybe we could change the implementation, however, so that the old
options are really just aliases for the respective -o version.

Kevin
