Received: from eggs.gnu.org ([2001:4830:134:3::10]:32980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1foBJN-0001yV-4I
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1foBJM-0005db-Dg
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:34:53 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180810141116.24016-1-muriloo@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c8096ae-fa65-3fcb-bac7-f37ae169ccf1@redhat.com>
Date: Fri, 10 Aug 2018 19:34:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180810141116.24016-1-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATH] Fix build on CentOS 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>

On 10/08/2018 16:11, Murilo Opsfelder Araujo wrote:
> After commit b3f1c8c413bc83e4a2cc7a63e4eddf9fe6449052 "qemu-pr-helper: use new
> libmultipath API", QEMU started using new libmultipath API, which is not
> available on CentOS 7.x.
> 
> This fixes that by probing the new libmultipath API in configure.  If it fails,
> then try probing the old API.  If it fails, then consider libmultipath not
> available.
> 
> With this, configure script defines CONFIG_MPATH_NEW_API that is used in
> scsi/qemu-pr-helper.c to use the new libmultipath API.
> 
> Fixes: b3f1c8c413bc83e4a2cc7a63e4eddf9fe6449052
> BugLink: https://bugs.launchpad.net/qemu/+bug/1786343
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Thanks, I'll look at the patch for 3.1.  For what it's worth, RHEL7 has
simply reverted that patch in its RPM.

Paolo
