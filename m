Received: from eggs.gnu.org ([2001:4830:134:3::10]:43166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gaLRB-0003wu-16
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gaLRA-0001Dx-8g
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:06:00 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gaLR9-0001Ao-9N
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:06:00 -0500
Received: by mail-ot1-x342.google.com with SMTP id a11so5165106otr.10
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 06:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20181220164433.21705-1-cohuck@redhat.com>
In-Reply-To: <20181220164433.21705-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Dec 2018 14:05:41 +0000
Message-ID: <CAFEAcA_TqW=FVrn_+wBc76CE0C+JYJFypwRtpV=uEr_uo1YD0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Final s390x patches for 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 20 Dec 2018 at 16:44, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit b72566a4ffaddbc0c0c1f6f5ee91b42ab13ff429:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2018-12-19 15:31:02 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20181220
>
> for you to fetch changes up to aba7a5a2de3dba5917024df25441f715b9249e31:
>
>   hw/s390x: Fix bad mask in time2tod() (2018-12-20 17:07:24 +0100)
>
> ----------------------------------------------------------------
> Two s390x bugfixes.
>
> ----------------------------------------------------------------
>
> Peter Maydell (1):
>   hw/s390/ccw.c: Don't take address of packed members
>
> Thomas Huth (1):
>   hw/s390x: Fix bad mask in time2tod()
>
>  hw/s390x/css.c         | 32 ++++++++++++++++++++++++++------
>  include/hw/s390x/tod.h |  2 +-
>  2 files changed, 27 insertions(+), 7 deletions(-)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
