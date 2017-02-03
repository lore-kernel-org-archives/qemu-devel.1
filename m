Received: from eggs.gnu.org ([2001:4830:134:3::10]:55567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZcsq-00020W-Qv
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZcsl-0001Jw-SW
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:22:32 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:45087 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZcsl-0001JD-HI
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:22:27 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1486123043-26493-3-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1486123043-26493-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486123043-26493-3-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 03 Feb 2017 13:22:26 +0100
Message-ID: <w51inorwjjx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2 v16] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

On Fri 03 Feb 2017 12:57:23 PM CET, Pradeep Jagadeesh wrote:
> This patch removes the redundant throttle code that was present in
> block and fsdev device files. Now the common code is moved
> to a single file.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg04637.html

This line doesn't belong in the commit message.

Berto
