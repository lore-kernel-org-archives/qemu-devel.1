Received: from eggs.gnu.org ([2001:4830:134:3::10]:47322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmufZ-0001zI-1U
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 00:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmufU-00007o-3P
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 00:32:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dmufT-00007A-Sc
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 00:31:56 -0400
Date: Wed, 30 Aug 2017 12:31:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830043148.GI4208@lemon.lan>
References: <1504025019-16820-1-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504025019-16820-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, stefanha@redhat.com

On Tue, 08/29 22:13, Ishani Chugh wrote:
> This patch series is intended to introduce QEMU Backup tool.
> qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action.
> This patch series contains three patches,
>                1) QEMU Backup command line tool.
>                2) Test for full backup.
>                3) Manpage for the tool.

Looks good in general. I've left small suggestions. Thanks for working on this
tool!

Fam

> 
> Ishani Chugh (3):
>   backup: QEMU Backup Tool
>   Test for full Backup
>   Add manpage for QEMU Backup Tool
> 
>  Makefile                        |  14 +-
>  contrib/backup/qemu-backup.py   | 335 ++++++++++++++++++++++++++++++++++++++++
>  contrib/backup/qemu-backup.texi | 144 +++++++++++++++++
>  tests/qemu-iotests/191          |  86 +++++++++++
>  tests/qemu-iotests/191.out      |  35 +++++
>  tests/qemu-iotests/group        |   2 +
>  6 files changed, 612 insertions(+), 4 deletions(-)
>  create mode 100644 contrib/backup/qemu-backup.py
>  create mode 100644 contrib/backup/qemu-backup.texi
>  create mode 100755 tests/qemu-iotests/191
>  create mode 100644 tests/qemu-iotests/191.out
> 
> -- 
> 2.7.4
> 
> 
