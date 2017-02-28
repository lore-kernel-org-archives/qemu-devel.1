Received: from eggs.gnu.org ([2001:4830:134:3::10]:53370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cipuE-0001ud-Qe
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cipuD-0008SE-LD
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:06:02 -0500
Date: Tue, 28 Feb 2017 23:05:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170228220553.GH4090@noname.redhat.com>
References: <1488317230-26248-1-git-send-email-armbru@redhat.com>
	<1488317230-26248-22-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488317230-26248-22-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 21/24] block: Initial implementation of
 -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pkrempa@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Am 28.02.2017 um 22:27 hat Markus Armbruster geschrieben:
> The new command line option -blockdev works like QMP command
> blockdev-add.
> 
> The option argument may be given in JSON syntax, exactly as in QMP.
> Example usage:
> 
>     -blockdev '{"node-name": "foo", "driver": "raw", "file": {"driver": "file", "filename": "foo.img"} }'
> 
> The JSON argument doesn't exactly blend into the existing option
> syntax, so the traditional KEY=VALUE,... syntax is also supported,
> using dotted keys to do the nesting:
> 
>     -blockdev node-name=foo,driver=raw,file.driver=file,file.filename=foo.img
> 
> This does not yet support lists or downstream extensions, i.e. keys
> with __RFQDN_ prefix, but the next few patches will take care of that.
> 
> Note that calling qmp_blockdev_add() (say via qmp_marshal_block_add())
> right away would crash.  We need to stash the configuration for later
> instead.  This is crudely done, and bypasses QemuOpts, even though
> storing configuration is what QemuOpts is for.  Need to revamp option
> infrastructure to support QAPI types like BlockdevOptions.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Double S-o-B? Anyway:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
