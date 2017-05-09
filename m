Received: from eggs.gnu.org ([2001:4830:134:3::10]:59227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8719-000838-8n
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8713-0007uW-CZ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:25:39 -0400
Date: Tue, 9 May 2017 17:25:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170509152523.GI5243@noname.str.redhat.com>
References: <1493195595-4809-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493195595-4809-1-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] qemu-img: wait for convert
 coroutines to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, mreitz@redhat.com, pl@kamp.de

Am 26.04.2017 um 10:33 hat Anton Nefedov geschrieben:
> On error path (like i/o error in one of the coroutines), it's required to
>   - wait for coroutines completion before cleaning the common structures
>   - reenter dependent coroutines so they ever finish
> 
> Introduced in 2d9187bc65.
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Thanks, applied to the block branch.

Kevin
