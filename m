Received: from eggs.gnu.org ([2001:4830:134:3::10]:43662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cefRf-0006wo-Od
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cefRe-0006LP-Uv
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:07:19 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1487318764-29513-1-git-send-email-pagupta@redhat.com>
References: <1487318764-29513-1-git-send-email-pagupta@redhat.com>
Date: Fri, 17 Feb 2017 11:06:31 +0100
Message-ID: <w51poihqggo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block,
 migration: Use qemu_madvise inplace of madvise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

On Fri 17 Feb 2017 09:06:04 AM CET, Pankaj Gupta wrote:
>  To maintain consistency at all the places use qemu_madvise wrapper
>  inplace of madvise call.

>      if (length > 0) {
> -        madvise((uint8_t *) t + offset, length, MADV_DONTNEED);
> +        qemu_madvise((uint8_t *) t + offset, length, QEMU_MADV_DONTNEED);

This was changed two months ago from qemu_madvise() to madvise(), is
there any reason why you want to revert that change? Those two calls are
not equivalent, please see commit 2f2c8d6b371cfc6689affb0b7e for an
explanation.

> -    if (madvise(start, length, MADV_DONTNEED)) {
> +    if (qemu_madvise(start, length, QEMU_MADV_DONTNEED)) {
>          error_report("%s MADV_DONTNEED: %s", __func__, strerror(errno));

And this is the same case.

Berto
