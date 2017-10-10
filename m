Received: from eggs.gnu.org ([2001:4830:134:3::10]:34383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1uny-0002Kb-0B
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1unx-0006re-2H
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:42:42 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:48442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1unw-0006po-Ql
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 09:42:40 -0400
Received: by mail-wm0-x231.google.com with SMTP id i124so5258507wmf.3
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 06:42:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171010024001.4526-1-ehabkost@redhat.com>
References: <20171010024001.4526-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 14:42:19 +0100
Message-ID: <CAFEAcA9a0eO_OjaiPkXwOF4XZw6C3gqd=ZsgP7z7vXwUMXNNNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/8] x86 and machine queue, 2017-10-09
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

On 10 October 2017 at 03:39, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Changes on v2:
> * Removed NUMA/ACPI patches until we figure out what's breaking
>   the tests.
>   (See: https://www.mail-archive.com/qemu-devel@nongnu.org/msg486368.html)
>   Note that I didn't reproduce the failure yet.  I am just
>   removing those patches because they are the only ones touching
>   ACPI code.
>
> The following changes since commit 530049bc1dcc24c1178a29d99ca08b6dd08413e0:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-10-06 17:43:02 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
>
> for you to fetch changes up to e0dd5fd41a1a38766009f442967fab700d2d0550:
>
>   x86: Correct translation of some rdgsbase and wrgsbase encodings (2017-10-09 23:29:20 -0300)
>
> ----------------------------------------------------------------
> x86 and machine queue, 2017-10-09
>
> Includes x86, QOM, CPU, and option/config parsing patches.
>
> Highlights:
> * Deprecation of -nodefconfig option;
> * MachineClass::valid_cpu_types field.
>

Applied, thanks.

-- PMM
