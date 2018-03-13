Received: from eggs.gnu.org ([2001:4830:134:3::10]:53552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmJo-0001He-Rc
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmJn-0001yt-Ta
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:58:28 -0400
Date: Tue, 13 Mar 2018 16:58:19 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180313155819.GG4642@localhost.localdomain>
References: <ad565b5b702568c06a6660404d65d6c15c6d57f5.1520943008.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad565b5b702568c06a6660404d65d6c15c6d57f5.1520943008.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] block/mirror: change the semantic
 of 'force' of block-job-cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, liliang.opensource@gmail.com

Am 13.03.2018 um 13:12 hat Jeff Cody geschrieben:
> From: Liang Li <liliang.opensource@gmail.com>
> 
> When doing drive mirror to a low speed shared storage, if there was heavy
> BLK IO write workload in VM after the 'ready' event, drive mirror block job
> can't be canceled immediately, it would keep running until the heavy BLK IO
> workload stopped in the VM.
> 
> Libvirt depends on the current block-job-cancel semantics, which is that
> when used without a flag after the 'ready' event, the command blocks
> until data is in sync.  However, these semantics are awkward in other
> situations, for example, people may use drive mirror for realtime
> backups while still wanting to use block live migration.  Libvirt cannot
> start a block live migration while another drive mirror is in progress,
> but the user would rather abandon the backup attempt as broken and
> proceed with the live migration than be stuck waiting for the current
> drive mirror backup to finish.
> 
> The drive-mirror command already includes a 'force' flag, which libvirt
> does not use, although it documented the flag as only being useful to
> quit a job which is paused.  However, since quitting a paused job has
> the same effect as abandoning a backup in a non-paused job (namely, the
> destination file is not in sync, and the command completes immediately),
> we can just improve the documentation to make the force flag obviously
> useful.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Jeff Cody <jcody@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Reported-by: Huaitong Han <huanhuaitong@didichuxing.com>
> Signed-off-by: Huaitong Han <huanhuaitong@didichuxing.com>
> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
> 
> N.B.: This was rebased on top of Kevin's block branch,
>       and the 'force' flag added to block_job_user_cancel

Thanks, applied to the block branch.

Kevin
