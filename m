Received: from eggs.gnu.org ([2001:4830:134:3::10]:43818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW15G-0004EY-Dq
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW15F-0007tY-EM
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:24:26 -0500
Received: from mail-vk0-x22b.google.com ([2607:f8b0:400c:c05::22b]:36084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW15F-0007tU-9s
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:24:25 -0500
Received: by mail-vk0-x22b.google.com with SMTP id t8so111556597vke.3
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 05:24:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 13:24:04 +0000
Message-ID: <CAFEAcA8Wa6nuLVWc+7TzH+aQ_zg7BszWoYhAZq4Wg+2ZeY+99A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/13] x86, machine, numa queue (2017-01-23)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 23 January 2017 at 23:27, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 3879284d6517dc22529395bdb259f4183b589127:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qio-2017-01-23-2' into staging (2017-01-23 15:59:09 +0000)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request
>
> for you to fetch changes up to d99569d9d8562c480e0befab601756b0b7b5d0e0:
>
>   kvm: Allow invtsc migration if tsc-khz is set explicitly (2017-01-23 21:26:27 -0200)
>
> ----------------------------------------------------------------
> x86, machine, numa queue (2017-01-23)
>
> ----------------------------------------------------------------

I get a failure in the docs on OSX:
  GEN     qemu-doc.txt
  CC      qapi/qapi-visit-core.o
/Users/pm215/src/qemu-for-merges/qemu-doc.texi:7: warning:
unrecognized encoding name `UTF-8'.
  GEN     trace/generated-tracers.c
/Users/pm215/src/qemu-for-merges/qemu-doc.texi:1419: Cross reference
to nonexistent node `bt-hcis' (perhaps incorrect sectioning?).
makeinfo: Removing output file `qemu-doc.txt' due to errors; use
--force to preserve.

This is the same error that was happening on the Travis OSX
builds but not on my personal OSX machine, and leaves me
suspicious that the qemu-doc.txt stuff is broken but also
not always being rebuilt correctly (since it's a bit
hit-and-miss whether particular things hit this.)

thanks
-- PMM
