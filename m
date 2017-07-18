Received: from eggs.gnu.org ([2001:4830:134:3::10]:60630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXUfE-0001pR-Tr
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXUfE-0007qb-2a
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:43:56 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXUfD-0007pm-Qx
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:43:55 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 12so34894699wrb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 08:43:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 16:43:34 +0100
Message-ID: <CAFEAcA8O7JFQvXzH93UQCyRqFhWAnuf_AqotJ5qNaxda_CCzAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] x86 and machine queue for 2.10 soft
 freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 19:50, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
>
> for you to fetch changes up to f86285c571c49e781d3fa46f3bef3835b8e6f393:
>
>   qmp: Include parent type on 'qom-list-types' output (2017-07-17 15:41:30 -0300)
>
> ----------------------------------------------------------------
> x86 and machine queue, 2017-07-17
>
> ----------------------------------------------------------------
>
> Boqun Feng (Intel) (1):
>   i386: add Skylake-Server cpu model
>
> Daniel P. Berrange (1):
>   i386: expose "TCGTCGTCGTCG" in the 0x40000000 CPUID leaf
>
> Eduardo Habkost (9):
>   device-crash-test: Fix regexp on whitelist
>   tests: Test case for object_resolve_path*()
>   test-qdev-global-props: Test global property ordering
>   Revert "machine: Convert abstract typename on compat_props to subclass
>     names"
>   qom: Fix ambiguous path detection when ambiguous=NULL
>   i386: Update comment about XSAVES on Skylake-Client
>   tests: Simplify abstract-interfaces check with a helper
>   qmp: Include 'abstract' field on 'qom-list-types' output
>   qmp: Include parent type on 'qom-list-types' output
>
> Greg Kurz (1):
>   qdev: fix the order compat and global properties are applied
>
> Mark Cave-Ayland (3):
>   fw_cfg: switch fw_cfg_find() to locate the fw_cfg device by type
>     rather than path
>   fw_cfg: move qdev_init_nofail() from fw_cfg_init1() to callers
>   fw_cfg: move QOM type defines and fw_cfg types into fw_cfg.h

Applied, thanks.

-- PMM
