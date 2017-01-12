Received: from eggs.gnu.org ([2001:4830:134:3::10]:35273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRe07-0002sX-BF
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRe02-00036s-ME
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:57:03 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:35284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRe02-00036c-7E
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:56:58 -0500
Received: by mail-vk0-x22f.google.com with SMTP id x75so10791546vke.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 03:56:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <148412457273.22750.983275587432075569.stgit@bahia>
References: <148412457273.22750.983275587432075569.stgit@bahia>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 11:56:36 +0000
Message-ID: <CAFEAcA96xNqxB6MiTCr0QHf953G3Kx0zMakHZbP=vDJaFcrYBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] libqtest: handle zero length
 memwrite/memread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 January 2017 at 08:49, Greg Kurz <groug@kaod.org> wrote:
> Some recently added tests pass a zero length to qtest_memwrite().
> Unfortunately, the qtest protocol doesn't implement an on-the-wire
> syntax for zero-length writes and the current code happily sends
> garbage to QEMU. This causes intermittent failures.
>
> It isn't worth the pain to enhance the protocol, so this patch
> simply fixes the issue by "just return, doing nothing". The same
> fix is applied to qtest_memread() since the issue also exists in
> the QEMU part of the "memread" command.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

Thanks; applied to master since it should fix some
intermittent failures in the tests I run on new merges.

-- PMM
