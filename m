Received: from eggs.gnu.org ([2001:4830:134:3::10]:45127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fg9Ht-0002JW-1n
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fg9Hs-0001xL-67
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:48:09 -0400
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:40484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fg9Hr-0001x2-O2
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:48:08 -0400
Received: by mail-it0-x235.google.com with SMTP id 188-v6so9441470ita.5
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 06:48:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180719114204.13036-1-cohuck@redhat.com>
References: <20180719114204.13036-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jul 2018 14:47:46 +0100
Message-ID: <CAFEAcA8Ux0yPpO6zmkMENwL9H+VYShmgweMJZ8vCni0iuC4XMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-3.0 0/1] s390x bugfix for rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 19 July 2018 at 12:42, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit ea6abffa8a08d832feb759d359d5b935e3087cf7:
>
>   Update version for v3.0.0-rc1 release (2018-07-17 18:15:19 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180719
>
> for you to fetch changes up to 677ff32db12bcd1bca3a3df733d2478896d6df96:
>
>   s390x/cpumodel: fix segmentation fault when baselining models (2018-07-18 14:20:02 +0200)
>
> ----------------------------------------------------------------
> don't segfault when trying to baseline an odd cpu model
>
> ----------------------------------------------------------------
>
> David Hildenbrand (1):
>   s390x/cpumodel: fix segmentation fault when baselining models
>
>  target/s390x/cpu_models.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

-- PMM
