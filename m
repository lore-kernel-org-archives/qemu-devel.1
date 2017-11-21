Received: from eggs.gnu.org ([2001:4830:134:3::10]:47429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH5I0-0000l7-18
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eH5Hv-0007BI-BI
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:56:24 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eH5Hv-00078o-4S
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 04:56:19 -0500
Received: by mail-wr0-x241.google.com with SMTP id y42so10744416wrd.3
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 01:56:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171120152145.25853-1-cohuck@redhat.com>
References: <20171120152145.25853-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 09:55:53 +0000
Message-ID: <CAFEAcA-utzXSWExXkdBRVASwOX_+1heGRkPyy1Bn8bGktW16Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.11 0/4] s390x fixes for 2.11
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

On 20 November 2017 at 15:21, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 2e02083438962d26ef9dcc7100f3b378104183db:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-11-17 19:08:07 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20171120-v1
>
> for you to fetch changes up to 6cbf1ec85caf8a7d9f2fd829422c9f0a1c8983e1:
>
>   pc-bios/s390-ccw.img: update image (2017-11-20 16:04:11 +0100)
>
> ----------------------------------------------------------------
> Fix storing cpu status (both kvm and tcg), locking around diag 308
> (tcg only) and a non-zero variable in the s390-ccw bios.
>
> ----------------------------------------------------------------
>
> Cornelia Huck (1):
>   pc-bios/s390-ccw.img: update image
>
> David Hildenbrand (2):
>   s390x: fix storing CPU status (again)
>   s390x/tcg: fix DIAG 308 with > 1 VCPU (MTTCG)
>
> Thomas Huth (1):
>   pc-bios/s390-ccw: Fix problem with invalid virtio-scsi LUN when
>     rebooting
>
>  pc-bios/s390-ccw.img           | Bin 30520 -> 26416 bytes
>  pc-bios/s390-ccw/virtio-scsi.c |   3 ++-
>  target/s390x/helper.c          |   2 +-
>  target/s390x/misc_helper.c     |   2 ++
>  4 files changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
