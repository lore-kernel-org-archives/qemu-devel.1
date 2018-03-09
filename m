Received: from eggs.gnu.org ([2001:4830:134:3::10]:39897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euQ59-0001pV-Ea
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:01:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euQ58-00082l-Kz
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 17:01:43 -0500
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <165fd85f-3131-3ffc-d72f-c88afd43a098@redhat.com>
Date: Fri, 9 Mar 2018 16:01:19 -0600
MIME-Version: 1.0
In-Reply-To: <20180309214611.19122-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] qed: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, qemu-devel@nongnu.org

On 03/09/2018 03:46 PM, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to qed, which
> enables image creation over QMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json |  25 ++++++-
>   block/qed.c          | 204 ++++++++++++++++++++++++++++++++++-----------------
>   2 files changed, 162 insertions(+), 67 deletions(-)

Similar question as to qcow (who still creates qed images these days? 
and if no one seriously does it outside of our testsuite, would it be 
better to not allow QMP creation of qed images?).  On the other hand, 
qed is newer than qcow so it doesn't have quite the legacy of poor 
usage, so it may also mean that qed gets a longer deprecation cycle than 
qcow.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
