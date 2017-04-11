Received: from eggs.gnu.org ([2001:4830:134:3::10]:50973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxvgk-0001Zn-Aw
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxvge-00079J-C4
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:18:30 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:33579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxvge-000794-5X
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:18:24 -0400
Received: by mail-wm0-x234.google.com with SMTP id y18so13724574wmh.0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 06:18:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170411070243.635-1-kraxel@redhat.com>
References: <20170411070243.635-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Apr 2017 14:18:02 +0100
Message-ID: <CAFEAcA_Qw7Dtk8t7Pxi3ntz=WV6AgM_vQ71MhFqdfvU5rO5UsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-2.9 0/2] qxl bugfixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 April 2017 at 08:02, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Two bugfixes for qxl.  Well, one actually is a workaround for a guest
> driver bug.
>
> please pull,
>   Gerd
>
> The following changes since commit 5fe2339e6b09da7d6f48b9bef0f1a7360392b4=
89:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201704=
06.0' into staging (2017-04-07 10:29:56 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/pull-fixes-20170411-1
>
> for you to fetch changes up to 86dbcdd9c7590d06db89ca256c5eaf0b4aba8858:
>
>   qxl: add migration blocker to avoid pre-save assert (2017-04-11 08:38:1=
7 +0200)
>
> ----------------------------------------------------------------
> qxl: bugfixes.
>
> ----------------------------------------------------------------
> Gerd Hoffmann (1):
>       qxl: add migration blocker to avoid pre-save assert
>
> Marc-Andr=C3=A9 Lureau (1):
>       qxl: switch display on entering VGA
>
>  hw/display/qxl.h |  1 +
>  hw/display/qxl.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
Applied, thanks.

-- PMM
