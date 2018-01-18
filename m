Received: from eggs.gnu.org ([2001:4830:134:3::10]:60191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecC1L-00059u-Kf
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecC1K-0005lU-Pe
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:22:27 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:33508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecC1K-0005ks-LG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:22:26 -0500
Received: by mail-ot0-x22c.google.com with SMTP id x15so20381831ote.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 07:22:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180118021000.27203-1-ehabkost@redhat.com>
References: <20180118021000.27203-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 15:22:05 +0000
Message-ID: <CAFEAcA_JX_eevQL3kM2Kvf_Z3+xTiDRkg6C-EknfMtj_-cRA1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/19] machine queue, 2018-01-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>

On 18 January 2018 at 02:09, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 901cc8d31f36ac82824ab68f656ab7050404100c:
>
>   fw_cfg: fix memory corruption when all fw_cfg slots are used (2018-01-17 23:04:37 -0200)
>
> ----------------------------------------------------------------
> machine queue, 2018-01-18
>
> ----------------------------------------------------------------

Hi. I'm afraid this doesn't build on 32-bit hosts, due to a
format string problem:

In file included from /home/peter.maydell/qemu/exec.c:20:0:
/home/peter.maydell/qemu/exec.c: In function 'file_ram_alloc':
/home/peter.maydell/qemu/include/qapi/error.h:162:25: error: format
'%llx' expects argument of type 'long long unsigned int', but argument
7 has type 'size_t {aka unsigned int}' [-Werror=format=]
                         (fmt), ## __VA_ARGS__)
                         ^
/home/peter.maydell/qemu/exec.c:1616:9: note: in expansion of macro 'error_setg'
         error_setg(errp, "aligment 0x%" PRIx64
         ^


thanks
-- PMM
