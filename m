Received: from eggs.gnu.org ([2001:4830:134:3::10]:45347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cejEy-0002u2-5y
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cejEu-0002kW-Bl
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:10:28 -0500
Date: Fri, 17 Feb 2017 22:10:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170217141015.GC15819@lemon.lan>
References: <cover.1485365834.git.jcody@redhat.com>
	<a252efad890c55d5d59e7fe77a9a9b994ee83074.1485365834.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a252efad890c55d5d59e7fe77a9a9b994ee83074.1485365834.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] iscsi: Handle -iscsi user/password
 in bdrv_parse_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

On Wed, 01/25 12:42, Jeff Cody wrote:
> From: Kevin Wolf <kwolf@redhat.com>
> 
> This splits the logic in the old parse_chap() function into a part that
> parses the -iscsi options into the new driver-specific options, and
> another part that actually applies those options (called apply_chap()
> now).
> 
> Note that this means that username and password specified with -iscsi
> only take effect when a URL is provided. This is intentional, -iscsi is
> a legacy interface only supported for compatibility, new users should
> use the proper driver-specific options.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
