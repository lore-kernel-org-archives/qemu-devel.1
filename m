Received: from eggs.gnu.org ([2001:4830:134:3::10]:44029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVzP1-0005kG-6X
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVzP0-00008n-4p
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:08:59 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVzOz-00007w-Th
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:08:58 -0400
Received: by mail-wm0-x232.google.com with SMTP id f67so20645190wmh.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 05:08:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <32291ebe-8c5f-eddf-3cd3-6bcf75deb56d@virtuozzo.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
	<20170711160814.20941-51-mreitz@redhat.com>
	<CAFEAcA90jG=vzGX0xKQh5ZkDsnNw6mMQb5QDip7+sAqd8HVTSA@mail.gmail.com>
	<32291ebe-8c5f-eddf-3cd3-6bcf75deb56d@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 13:08:36 +0100
Message-ID: <CAFEAcA_KZJb4QibwGN1t7qksxdAyLRNsjRw6cnEOujv=p0CH5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 50/85] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 14 July 2017 at 13:04, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
> 14.07.2017 13:42, Peter Maydell wrote:
> Coverity points out that this can crash in the error-exit paths,
> because bitmap_free() doesn't handle being passed a NULL pointer.
> (CID 1377700).
>
> Probably the best fix for this is to make bitmap_free() do
> nothing when handed NULL.
>
>
> Agree, my stupid omission. Can this be fixed in flight?

No, this code has already hit master -- you'll need to send
a fresh patch to fix it.

thanks
-- PMM
