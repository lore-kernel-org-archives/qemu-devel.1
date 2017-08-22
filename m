Received: from eggs.gnu.org ([2001:4830:134:3::10]:59047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkB4P-0004fm-4Q
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkB4O-0000wz-78
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:26:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dkB4O-0000wQ-1M
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:26:20 -0400
Date: Tue, 22 Aug 2017 16:26:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170822152613.GE5398@stefanha-x1.localdomain>
References: <1503313839-10258-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1503313839-10258-4-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503313839-10258-4-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH 3/3] Add manpage for QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com

On Mon, Aug 21, 2017 at 04:40:39PM +0530, Ishani Chugh wrote:
> +@node  List of Commands
> +@chapter  List of Commands
> +@itemize
> +@item qemu-backup guest add --guest guestname --qmp socketpath
> +@item qemu-backup guest list
> +@item qemu-backup drive add --id driveid --guest guestname --target target
> +@item qemu-backup drive add --all --guest guestname --target target
> +@item qemu-backup drive list --guest guestname
> +@item qemu-backup backup [--inc] --guest guestname
> +@item qemu-backup restore --guest guestname
> +@item qemu-backup guest remove --guest guestname
> +@item qemu-backup drive remove --guest guestname --id driveid
> +@end itemize
> +@node  Command Parameters
> +@chapter  Command Parameters
> +@itemize
> +@item --all: Add all the drives present in a guest which are suitable for backup.
> +@item --guest: Name of the guest.
> +@item --id: id of guest or drive.
> +@item --inc: (Optional) For incremental backup.
> +@item --qmp: Path of qmp socket.
> +@item --target: Destination path on which you want your backup to be made.
> +@end itemize

It would be helpful to give an example that demonstrates the workflow.
That way new users will know which sub-commands to use and in which
order.  Something like:

Perform a full backup of 'vm001', which has one drive:

  $ qemu-backup guest add --guest vm001 --qmp /path/to/vm001.sock
  $ qemu-backup add --id drive0 --guest vm001 --target /backups/vm001-drive0.img
  $ qemu-backup backup --guest vm001

Stefan
