Received: from eggs.gnu.org ([2001:4830:134:3::10]:37366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1eHukD-0006fy-0R
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1eHuk9-0003UG-W4
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:52:56 -0500
Received: from mail.univention.de ([82.198.197.8]:25816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hahn@univention.de>) id 1eHuk9-0003PV-P7
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 11:52:53 -0500
References: <20171123135906.12852-1-famz@redhat.com>
	<20171123135906.12852-2-famz@redhat.com>
From: Philipp Hahn <hahn@univention.de>
Message-ID: <e36d9628-ce26-b019-3573-f1c358467d05@univention.de>
Date: Thu, 23 Nov 2017 17:07:49 +0100
MIME-Version: 1.0
In-Reply-To: <20171123135906.12852-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] docs: Add image locking subsection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com

Hello,

Am 23.11.2017 um 14:59 schrieb Fam Zheng:
> diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.texi
> index 1cb1e55686..fa2e90d15f 100644
> --- a/docs/qemu-block-drivers.texi
> +++ b/docs/qemu-block-drivers.texi
> @@ -785,6 +785,42 @@ warning: ssh server @code{ssh.example.com:22} does not support fsync
...
> +To check if image locking is active, check the output of "lslocks" command on
> +host and see if there are locks held by QEMU process on the image file. More
> +than one bytes could be locked by a QEMU instance, each byte of which reflects

"one byte", without the 's'?

> +a perticular permission that are acquired or protected by the running block

"particular", 'e' -> 'a'

Philipp
