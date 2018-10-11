Received: from eggs.gnu.org ([2001:4830:134:3::10]:55339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gAOXu-0002Kf-U4
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gAOXs-0001Kw-8U
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:09:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gAOXs-0001Kg-2L
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 20:09:40 -0400
Date: Thu, 11 Oct 2018 08:09:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181011000933.GB5014@xz-x1>
References: <20180928075832.18586-1-w.bumiller@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180928075832.18586-1-w.bumiller@proxmox.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] delay monitor iothread creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Sep 28, 2018 at 09:58:30AM +0200, Wolfgang Bumiller wrote:
> The early monitor iothread creation conflicts with the -daemonize option
> causing crashes at shutdown of a daemonized qemu instance.
> These patches will delay the creation to when a monitor using it is
> actually spawned.
> 
> While the second patch depends on the first one, the first is a
> consistency cleanup on its own, therefore split out.
> 
> v2:
> This version incorporates Markus Armbruster's requested change to
> protect mon_iothread initialization by monitor_lock (and moves the
> variable declaration to reflect this), and adds a comments about
> monitor_init() expecting to be run in the main thread.
> 
> Wolfgang Bumiller (2):
>   monitor: guard iothread access by mon->use_io_thread
>   monitor: delay monitor iothread creation

Hi, Wolfgang,

Do you have plan to repost this series?

Regards,

-- 
Peter Xu
