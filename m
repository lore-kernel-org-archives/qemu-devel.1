Received: from eggs.gnu.org ([2001:4830:134:3::10]:37445)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1d1Uhb-0002yX-GP
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1d1UhY-0001r1-DI
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:18:07 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:38142 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1d1UhY-0001qZ-4v
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:18:04 -0400
References: <1492511251-16720-1-git-send-email-den@openvz.org>
From: Peter Lieven <pl@kamp.de>
Message-ID: <8f297f9f-8aa2-bca8-d99e-dc9fc767abf2@kamp.de>
Date: Fri, 21 Apr 2017 11:18:01 +0200
MIME-Version: 1.0
In-Reply-To: <1492511251-16720-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] qemu-img: wait for convert coroutines
 to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-stable@nongnu.org

Am 18.04.2017 um 12:27 schrieb Denis V. Lunev:
> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>
> We should wait for other coroutines on error path, i.e. one of coroutines
> terminates with i/o error, before cleaning the common structures. In the
> other case we would crash in a lot of different places. This behaviour
> was introduced by commit 2d9187bc65.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Peter Lieven <pl@kamp.de>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>

Cc: qemu-stable@nongnu.org

This should go into 2.9.1

Peter
