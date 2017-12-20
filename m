Received: from eggs.gnu.org ([2001:4830:134:3::10]:56436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRjcW-0003zx-Lx
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRjcS-0006ul-QS
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:01:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eRjcS-0006uI-Jn
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 14:01:32 -0500
References: <151337644262.1825.7887859550366390814.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5583b2cd-a340-8dbf-ceda-ea16e44f61fa@redhat.com>
Date: Wed, 20 Dec 2017 13:01:30 -0600
MIME-Version: 1.0
In-Reply-To: <151337644262.1825.7887859550366390814.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: make pdu_marshal() and
 pdu_unmarshal() static functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

On 12/15/2017 04:20 PM, Greg Kurz wrote:
> They're only used by the 9p core code.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/9pfs/9p.c |    4 ++--
>   hw/9pfs/9p.h |    2 --
>   2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
