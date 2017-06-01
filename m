Received: from eggs.gnu.org ([2001:4830:134:3::10]:43256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGRNL-0002xi-UI
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGRNL-0001Di-Ab
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:47:00 -0400
Date: Thu, 1 Jun 2017 22:46:47 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170601144647.GI13127@lemon.lan>
References: <1492838021-10538-1-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492838021-10538-1-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/8] Optimize VMDK I/O by allocating
 multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@gmail.com, qemu-devel@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

On Sat, 04/22 10:43, Ashijeet Acharya wrote:
> Changes in v4:
> - fix commit message in patch 1 (fam)
> - drop size_to_clusters() function (fam)
> - fix grammatical errors in function documentations (fam)
> - factor out metadata loading coding in a separate patch (patch 4) (fam)
> - rename vmdk_alloc_cluster_offset() to vmdk_alloc_clusters() (fam)
> - break patch 4(in v3) into separate patches (patch 3 and 8) (fam)
> - rename extent_size to extent_end (fam)
> - use QEMU_ALIGN_UP instead of vmdk_align_offset. (fam)
> - drop next and simply do m_data = m_data->next (fam)

I still don't like the m_data linked list but as this is a huge performance
improvement, I think we can merge this once the few bugs are addressed, then
clean up things on top.

Thanks,

Fam
