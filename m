Received: from eggs.gnu.org ([2001:4830:134:3::10]:36847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwE0X-0007BK-H1
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwE0W-0000Ap-S8
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:00:09 -0400
References: <20170918214649.17550-1-eblake@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <3417f4a3-9c6d-ea87-a5c5-48cad9caa413@msgid.tls.msk.ru>
Date: Sun, 24 Sep 2017 23:59:57 +0300
MIME-Version: 1.0
In-Reply-To: <20170918214649.17550-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd-client: Use correct macro
 parenthesization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

19.09.2017 00:46, Eric Blake wrote:
> If 'bs' is a complex expression, we were only casting the front half
> rather than the full expression.  Luckily, none of the callers were
> passing bad arguments, but it's better to be robust up front.

Applied to -trivial.

/mjt
