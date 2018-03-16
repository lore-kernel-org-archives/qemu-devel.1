Received: from eggs.gnu.org ([2001:4830:134:3::10]:59560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewufn-0006i5-V9
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewufn-0003YO-51
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:05:51 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:39678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewufm-0003WK-VR
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:05:51 -0400
Received: by mail-ot0-x230.google.com with SMTP id h8-v6so11404132oti.6
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:05:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180315181420.8694-1-ehabkost@redhat.com>
References: <20180315181420.8694-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 19:05:29 +0000
Message-ID: <CAFEAcA9itE11dUF-Z22M13XT2_sgr0vgDPAsJ_QhUvdT07L5nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/7] Machine queue, 2018-03-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 15 March 2018 at 18:14, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Changes in v2 (v1 was 2018-03-12):
> * Fix bsd-user build error
>
> The following changes since commit 56e8698ffa8aba9f762f980bc21b5340b006f24b:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-130318-1' into staging (2018-03-15 14:48:09 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 7cbb6fd8926b9b590c0725b9b7d0a11db6aefd08:
>
>   cpu: drop unnecessary NULL check and cpu_common_class_by_name() (2018-03-15 14:52:40 -0300)
>
> ----------------------------------------------------------------
> Machine queue, 2018-03-15
>

Hi. This produces several warning messages running make check:

WARNING: cpu name for target 'riscv32' isn't defined, add it to cpus_map
WARNING: cpu name for target 'riscv64' isn't defined, add it to cpus_map

thanks
-- PMM
