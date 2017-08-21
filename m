Received: from eggs.gnu.org ([2001:4830:134:3::10]:43174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1djpYR-0006n4-Ua
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1djpYR-0000mY-8H
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:27:55 -0400
MIME-Version: 1.0
In-Reply-To: <20170821161539.11066-1-stefanha@redhat.com>
References: <20170821161539.11066-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 21 Aug 2017 17:27:53 +0100
Message-ID: <CAJSP0QWVGVn=vZWZy9isTemndDQrnzUAMO=A7T6W6Oe93ST2DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd-client: fix hang after
 server closes connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu block <qemu-block@nongnu.org>

On Mon, Aug 21, 2017 at 5:15 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>   (qemu) quit
>   ...hang...

By the way, the same issue is present in QEMU 2.9.  This is not a 2.10
regression.

Stefan
