Received: from eggs.gnu.org ([2001:4830:134:3::10]:52271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e84uA-000520-O0
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e84uA-0004jd-0L
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:42:34 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:50983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e84u9-0004iQ-PT
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 09:42:33 -0400
Received: by mail-wr0-x236.google.com with SMTP id p96so6193649wrb.7
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 06:42:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2017 14:42:11 +0100
Message-ID: <CAFEAcA8fu0PCd8snz3yqv+Oys=6zdD4XbyCtrezJQjZV4UO0Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/39] x86/cpu/numa queue, 2017-10-26
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

On 26 October 2017 at 15:03, Eduardo Habkost <ehabkost@redhat.com> wrote:
> (Note that master is currently broken with --disable-tcg, but I
> don't want to hold the queue until this is fixed.)
>
> The following changes since commit ae49fbbcd8e4e9d8bf7131add34773f579e1aff7:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20171025' into staging (2017-10-25 16:38:57 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
>
> for you to fetch changes up to ba2975aa134fdb0208f0a54c544402fed1890217:
>
>   x86: Skip check apic_id_limit for Xen (2017-10-26 15:29:38 +0200)
>
> ----------------------------------------------------------------
> x86/machine/numa queue, 2017-10-26

Hi. I'm afraid this breaks the sh4 linux-user code:

/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sh4-linux-user/qemu-sh4
-L ./gnemul/qemu-sh4 sh4/ls -l dummyfile
unable to find CPU model 'sh7785-superh-cpu'


thanks
-- PMM
