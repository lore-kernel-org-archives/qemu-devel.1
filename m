Received: from eggs.gnu.org ([2001:4830:134:3::10]:51850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g82mE-0000j8-9T
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g82lN-0000Sd-Uq
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 08:29:54 -0400
Date: Thu, 4 Oct 2018 14:29:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181004122940.GB6009@localhost.localdomain>
References: <1532433124-25881-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532433124-25881-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] block/vvfat: Fix crash when reporting
 error about too many files in directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

Am 24.07.2018 um 13:52 hat Thomas Huth geschrieben:
> When using the vvfat driver with a directory that contains too many files,
> QEMU currently crashes. This can be triggered like this for example:
> 
>  mkdir /tmp/vvfattest
>  cd /tmp/vvfattest
>  for ((x=0;x<=513;x++)); do mkdir $x; done
>  qemu-system-x86_64 -drive \
>    file.driver=vvfat,file.dir=.,read-only=on,media=cdrom
> 
> Seems like read_directory() is changing the mapping->path variable. Make
> sure we use the right pointer instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Thanks, applied to the block branch.

Kevin
