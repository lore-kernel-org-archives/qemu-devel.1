Received: from eggs.gnu.org ([2001:4830:134:3::10]:51920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddbLn-0003uf-4V
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ddbKi-0002J9-UT
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:05:06 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ddbKi-0002IM-Km
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:04:00 -0400
Received: by mail-wm0-x22e.google.com with SMTP id t201so17959504wmt.1
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 05:04:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501769263-27001-1-git-send-email-mst@redhat.com>
References: <1501769263-27001-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2017 13:03:38 +0100
Message-ID: <CAFEAcA_svMzhqBH-CbYWQXereG-1mZEz44HmpnQsVUjXd5=Z=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL] virtio: fix for rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 August 2017 at 15:07, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit aaaec6acad7cf97372d48c1b09126a09697519=
c8:
>
>   Update version for v2.10.0-rc1 release (2017-08-02 16:36:32 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to e6a74868d92f858ac33915b6772999d7de2fd288:
>
>   build-sys: add --disable-vhost-user (2017-08-03 15:55:41 +0300)
>
> ----------------------------------------------------------------
> virtio: fix for rc2
>
> Looks like the constant stream of additions of vhost-user devices is a
> problem for some people who are concerned about external connections
> from qemu. A per-device flag seems like an overkill, but a single
> configure flag seems like a sane way to support that, and it looks like
> we need to do it before the release.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       build-sys: add --disable-vhost-user

Applied, thanks.

-- PMM
