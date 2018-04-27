Received: from eggs.gnu.org ([2001:4830:134:3::10]:60697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fC3o3-0000oh-1P
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fC3o0-0000Or-18
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:52:59 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180426134305.642080-2-eblake@redhat.com>
References: <20180426134305.642080-1-eblake@redhat.com>
	<20180426134305.642080-2-eblake@redhat.com>
Date: Fri, 27 Apr 2018 15:52:17 +0200
Message-ID: <w518t98bvu6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/3] vdi: Switch to byte-based
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 26 Apr 2018 03:43:03 PM CEST, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Make the change for the last few sector-based calls
> into the block layer from the vdi driver.
>
> Ideally, the vdi driver should switch to doing everything
> byte-based, but that's a more invasive change that requires a
> bit more auditing.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
