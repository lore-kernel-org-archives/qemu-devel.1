Received: from eggs.gnu.org ([2001:4830:134:3::10]:55914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEEXQ-0004C7-W4
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEEXP-0004yk-RU
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:12:32 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:54797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEEXP-0004xY-KD
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:12:31 -0500
Received: by mail-wr0-x244.google.com with SMTP id l22so14359704wrc.11
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 05:12:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171109153204.26436-1-cohuck@redhat.com>
References: <20171109153204.26436-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 13:12:10 +0000
Message-ID: <CAFEAcA9vtt-7cPiCuKwNdfxk1+NFq89FH9jALXx71EtBqOAs4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.11 0/2] s390x changes for 2.11-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 9 November 2017 at 15:32, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:
>
>   Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20171109
>
> for you to fetch changes up to fdaae351435147b9be6161d0f136ca7c40308059:
>
>   target/s390x: Finish implementing RISBGN (2017-11-09 10:36:06 +0100)
>
> ----------------------------------------------------------------
> s390x changes: let pci devices start out in a usable state, and make
> RISBGN work in tcg.
>
> ----------------------------------------------------------------
>
> Christian Borntraeger (1):
>   s390x/pci: let pci devices start in configured mode
>
> Richard Henderson (1):
>   target/s390x: Finish implementing RISBGN
>
>  hw/s390x/s390-pci-bus.c  | 2 +-
>  target/s390x/translate.c | 9 +++------
>  2 files changed, 4 insertions(+), 7 deletions(-)

Applied, thanks.

-- PMM
