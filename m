Received: from eggs.gnu.org ([2001:4830:134:3::10]:39078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn0Om-0004ZO-6E
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn0Oj-0002aw-34
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:39:04 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn0Oi-0002af-Sa
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:39:01 -0400
Received: by mail-wm0-x241.google.com with SMTP id e204so1329859wma.2
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 03:39:00 -0700 (PDT)
Date: Wed, 30 Aug 2017 11:38:57 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830103857.GJ24565@stefanha-x1.localdomain>
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

On Tue, Aug 29, 2017 at 10:13:36PM +0530, Ishani Chugh wrote:
> This patch series is intended to introduce QEMU Backup tool.
> qemu-backup will be a command-line tool for performing full and
> incremental disk backups on running VMs. It is intended as a
> reference implementation for management stack and backup developers
> to see QEMU's backup features in action.
> This patch series contains three patches,
>                1) QEMU Backup command line tool.
>                2) Test for full backup.
>                3) Manpage for the tool.
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

When you send the next revision to address Fam's comments, please
include a changelog like this:

v3:
 * Fix typo in foo.py
 * Add missing parameter to bar()
 ...

That way reviewers know what changes to look out for.  Thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
