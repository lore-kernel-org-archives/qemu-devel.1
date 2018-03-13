Received: from eggs.gnu.org ([2001:4830:134:3::10]:60894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evmga-0004Xd-AK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evmgY-0006Kf-3S
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:22:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36526 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evmgX-0006KM-Uf
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:21:58 -0400
References: <20180307082512.14203-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2de39ca7-b5e3-274b-53e6-0a8610fd4c6a@redhat.com>
Date: Tue, 13 Mar 2018 11:21:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180307082512.14203-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Update 051 and 186 after
 commit 1454509726719e0933c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 03/07/2018 02:25 AM, Alberto Garcia wrote:
> SCSI controllers are no longer created automatically for
> -drive if=scsi, so this patch updates the tests that relied
> on that.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   tests/qemu-iotests/051.pc.out | 20 --------------------
>   tests/qemu-iotests/186        |  4 ----
>   tests/qemu-iotests/186.out    | 28 ----------------------------
>   3 files changed, 52 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
