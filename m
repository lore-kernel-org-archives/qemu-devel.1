Received: from eggs.gnu.org ([2001:4830:134:3::10]:33131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gC2gh-0003ZF-NZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 09:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gC2gh-00074m-1Z
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 09:13:35 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:47002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gC2gg-00071F-Ku
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 09:13:34 -0400
Received: by mail-ot1-x329.google.com with SMTP id o21so18787646otb.13
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 06:13:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181012140538.28504-1-kraxel@redhat.com>
References: <20181012140538.28504-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Oct 2018 14:13:07 +0100
Message-ID: <CAFEAcA88+UM3ac=S6fJo3GBqiOA9f6fCvmWyCods=ENjHLAqzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Ui2 20181012 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>

On 12 October 2018 at 15:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 69ac8c4cb93f2685839ff7b857cef306b388ff=
3c:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20181012' into =
staging (2018-10-12 12:40:04 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui2-20181012-pull-request
>
> for you to fetch changes up to 58296cb61866195297510e946a51acc5f0b9639e:
>
>   ui: increase min required GTK3 version to 3.14.0 (2018-10-12 15:22:18 +=
0200)
>
> ----------------------------------------------------------------
> ui: drop gtk2 support.
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (2):
>   ui: remove support for GTK2 in favour of GTK3
>   ui: increase min required GTK3 version to 3.14.0
>
>  configure            |  51 ++-----------
>  include/ui/gtk.h     |   9 ---
>  ui/gtk-egl.c         |  10 +--
>  ui/gtk.c             | 202 ++++-----------------------------------------=
------
>  qemu-deprecated.texi |   7 --
>  5 files changed, 26 insertions(+), 253 deletions(-)

Applied, thanks.

-- PMM
