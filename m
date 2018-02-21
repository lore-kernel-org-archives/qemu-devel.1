Received: from eggs.gnu.org ([208.118.235.92]:54528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eobEW-0003qz-Ss
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eobDD-0004IY-Hz
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:43:20 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-9-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12b2587c-2069-e4ea-067e-ab239133f234@redhat.com>
Date: Wed, 21 Feb 2018 14:38:42 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/36] util: Add
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

On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> This allows, given a QemuOpts for a QemuOptsList that was merged from
> multiple QemuOptsList, to only consider those options that exist in one
> specific list. Block drivers need this to separate format-layer create
> options from protocol-level options.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/qemu/option.h |  2 ++
>   util/qemu-option.c    | 42 +++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 39 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
