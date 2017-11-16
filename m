Received: from eggs.gnu.org ([2001:4830:134:3::10]:41483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eFAoz-0004EP-PW
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eFAoz-0001Ip-1U
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 22:26:33 -0500
Date: Thu, 16 Nov 2017 11:26:22 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171116032622.GB14771@lemon>
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] compressed block-stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, den@virtuozzo.com

On Tue, 11/14 13:16, Anton Nefedov wrote:
> It might be useful to compress images during block-stream;
> this way the user can merge compressed images of a backing chain and
> the result will remain compressed.

I haven't looked at the patches yet so maybe the answer is obvious, but still:
would the "compress" option be still necessary if what we have is
blockdev-stream instead?

Fam
