Received: from eggs.gnu.org ([2001:4830:134:3::10]:51514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPIM-0002rU-6D
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:34:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emPIL-0003QP-Fj
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 14:34:14 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fffdc547-0132-9ff1-5ae6-174a50774ade@redhat.com>
Date: Thu, 15 Feb 2018 13:33:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/27] util: Add
 qemu_opts_to_qdict_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/08/2018 01:23 PM, Kevin Wolf wrote:
> This allows, given a QemuOpts for a QemuOptsList that was merged from
> multiple QemuOptsList, to only consider those options that exist in one
> specific list. Block drivers need this to separate format-layer create
> options from protocol-level options.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/qemu/option.h |  2 ++
>   util/qemu-option.c    | 37 ++++++++++++++++++++++++++++++++-----
>   2 files changed, 34 insertions(+), 5 deletions(-)

Is there any unit test coverage we should be adding, beyond the default 
we get when the list parameter is NULL?

But what you have looks sane;
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
