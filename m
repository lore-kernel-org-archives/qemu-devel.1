Received: from eggs.gnu.org ([2001:4830:134:3::10]:43676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fH8J2-0004lK-LY
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fH8J1-0005di-Rc
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:41:56 -0400
References: <1526042271-11983-1-git-send-email-ivanren@tencent.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d1f20f1e-69c7-bb11-3053-60bc89d06a84@redhat.com>
Date: Fri, 11 May 2018 08:41:27 -0500
MIME-Version: 1.0
In-Reply-To: <1526042271-11983-1-git-send-email-ivanren@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: fix preallocation with metadata
 on bare block device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ivan Ren <renyime@gmail.com>, mreitz@redhat.com, kwolf@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On 05/11/2018 07:37 AM, Ivan Ren wrote:
> Create a qcow2 directly on bare block device with
> "-o preallocation=metadata" option. When read this qcow2, it will
> return pre-existing data on block device, and this may lead to
> data leakage. This patch add QCOW_OFLAG_ZERO for all preallocated
> l2 entry to avoid this problem.

This is a semantic change; are we okay making it?

Does your code properly check for qcow2v2 files, which don't support 
QCOW_OFLAG_ZERO (only qcow2v3 supports it)?

> 
> Signed-off-by: Ivan Ren <ivanren@tencent.com>
> ---

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
