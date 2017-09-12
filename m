Received: from eggs.gnu.org ([2001:4830:134:3::10]:44993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1drhNQ-0005AG-Tr
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1drhNL-0002Qw-AK
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1drhNL-0002QL-4o
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:20:59 -0400
Date: Tue, 12 Sep 2017 10:20:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170912092051.GB6123@stefanha-x1.localdomain>
References: <1504888905-22396-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504888905-22396-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v4 0/3] QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, famz@redhat.com

On Fri, Sep 08, 2017 at 10:11:42PM +0530, Ishani Chugh wrote:
> This patch series is intended to introduce QEMU Backup tool.
> qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action.
> This patch series contains three patches,
>                1) QEMU Backup command line tool.
>                2) Test for full backup.
>                3) Manpage for the tool.
> v4:
> * Reorganize patch structure.
> * Modify commit message for backup tool commit.
> * Organize examples by subcommands.
> * Add checks for required arguments.
> * Adds required arguments group to mandatory arguments.
> * Add checks for validating socket path.
> 
> Ishani Chugh (3):
>   Add manpage for QEMU Backup Tool
>   backup: Adds Backup Tool
>   Test for full Backup
> 
>  Makefile                        |  14 +-
>  contrib/backup/qemu-backup.py   | 373 ++++++++++++++++++++++++++++++++++++++++
>  contrib/backup/qemu-backup.texi | 142 +++++++++++++++
>  tests/qemu-iotests/191          |  86 +++++++++
>  tests/qemu-iotests/191.out      |  35 ++++
>  tests/qemu-iotests/group        |   1 +
>  6 files changed, 647 insertions(+), 4 deletions(-)
>  create mode 100755 contrib/backup/qemu-backup.py
>  create mode 100644 contrib/backup/qemu-backup.texi
>  create mode 100755 tests/qemu-iotests/191
>  create mode 100644 tests/qemu-iotests/191.out
> 
> --
> 2.7.4

Aside from Fam's comment:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
