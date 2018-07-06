Received: from eggs.gnu.org ([2001:4830:134:3::10]:60506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbV7I-0003iW-Uk
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 14:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbV7H-0003Cr-TR
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 14:06:00 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:34618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbV7H-0003C0-NP
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 14:05:59 -0400
Received: by mail-oi0-x229.google.com with SMTP id 13-v6so25054548ois.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 11:05:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
References: <1530897268-22932-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 19:05:38 +0100
Message-ID: <CAFEAcA-j1eGNLcg4ygNJSQ_8jFqWn9ruz+q8nfC9BskzrXTFtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Bug fixes for 2018-07-06
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 July 2018 at 18:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 2a018f6e98782a4931b936a3087404ed81685bac:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-request' into staging (2018-07-03 23:06:18 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to e20122ff0faf07cb701d35e39e106d1783c07725:
>
>   checkpatch: handle token pasting better (2018-07-06 18:39:19 +0200)
>
> ----------------------------------------------------------------
> Bug fixes.
>
> ----------------------------------------------------------------
> Greg Kurz (1):
>       i386: fix '-cpu ?' output for host cpu type
>
> Julia Suvorova (1):
>       qtest: Use cpu address space instead of system memory
>
> Michal Privoznik (1):
>       pr-helper: Rework socket path handling
>
> Paolo Bonzini (4):
>       pr-helper: avoid error on PR IN command with zero request size
>       pr-manager-helper: fix memory leak on event
>       ioapic: remove useless lower bounds check
>       checkpatch: handle token pasting better
>
> xinhua.Cao (1):
>       qemu-char: check errno together with ret < 0

Applied, thanks.

-- PMM
