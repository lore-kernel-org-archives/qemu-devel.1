Received: from eggs.gnu.org ([2001:4830:134:3::10]:40762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dAC7z-0004DS-8H
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dAC7w-0002YT-40
	for qemu-devel@nongnu.org; Mon, 15 May 2017 05:17:19 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170512224536.6zp3z4vs7mma5akx@eukaryote>
References: <20170512224536.6zp3z4vs7mma5akx@eukaryote>
Date: Mon, 15 May 2017 11:16:36 +0200
Message-ID: <w51vap2scnf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] QEMU seg-fault with intermediate image streaming
 -- bdrv_reopen() in stream_start()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On Sat 13 May 2017 12:45:36 AM CEST, Kashyap Chamarthy wrote:
> Try to perform intermediate streaming (pull clusters from 'disk1.qcow2'
> into 'b.qcow2':
>
>     (QEMU) block-stream device=#block832 base=disk1.qcow2
>
>
> Result
> ------
>
> QEMU crashes with SIGSEGV:

I see the problem, I'll send a patch now.

Thanks for reporting it!

Berto
