Received: from eggs.gnu.org ([2001:4830:134:3::10]:50813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtEBd-0007iJ-Af
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtEBc-0005XI-89
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:35:13 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:49580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtEBc-0005Wc-1N
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 10:35:12 -0400
Received: by mail-wr0-x22f.google.com with SMTP id u96so3509779wrb.6
	for <qemu-devel@nongnu.org>; Sat, 16 Sep 2017 07:35:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170916010330.10435-1-jsnow@redhat.com>
References: <20170916010330.10435-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Sep 2017 15:34:50 +0100
Message-ID: <CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 September 2017 at 02:03, John Snow <jsnow@redhat.com> wrote:
> The following changes since commit 5faf2d376af3cb4eb92da44c2580e08d39832caa:
>
>   Merge remote-tracking branch 'remotes/huth/tags/check-20170915' into staging (2017-09-15 20:29:44 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to 2a94e34d3ecef91727f467cc012587c632099d40:
>
>   AHCI: remove DPRINTF macro (2017-09-15 20:36:18 -0400)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Hi; I'm afraid this doesn't build with clang:

/home/petmay01/linaro/qemu-for-merges/hw/ide/core.c:70:15: error:
comparison of unsigned enum expression >= 0 is always true
[-Werror,-Wtautological-compare]
    if (enval >= 0 && enval < IDE_DMA__COUNT) {
        ~~~~~ ^  ~
1 error generated.

(It's impdef whether an enum with all positive values is
a signed type or unsigned type, so just deleting the
comparison against 0 would also be wrong...)

thanks
-- PMM
