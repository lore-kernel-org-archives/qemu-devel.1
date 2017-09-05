Received: from eggs.gnu.org ([2001:4830:134:3::10]:45549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpEjy-0007kn-92
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpEjo-0001As-Kb
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:22:10 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpEjo-0001AS-DS
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:22:00 -0400
Received: by mail-wr0-x22e.google.com with SMTP id k20so327950wre.4
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 07:22:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905123935.26645-1-berrange@redhat.com>
References: <20170905123935.26645-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 15:21:38 +0100
Message-ID: <CAFEAcA8uvmAUXkke5oFgajochZWC_+AVheQH0EVfvekFJjacuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/5] Merge QEMU I/O 2017/09/05 v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 September 2017 at 13:39, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 32f0f68bb77289b75a82925f712bb52e16eac3ba:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-09-01 17:28:54 +0100)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-20170905-2
>
> for you to fetch changes up to 689ed13e73bdb5a5ca3366524475e3065fae854a:
>
>   io: fix check for handshake completion in TLS test (2017-09-05 13:21:58 +0100)
>
> ----------------------------------------------------------------
> Merge QEMU I/O 2017/09/05 v2
>
> ----------------------------------------------------------------
>
> Changed in v2:
>
>  - Drop socket listen refactoring which had broken test suite
>
> Cao jin (1):
>   util: remove the obsolete non-blocking connect
>
> Daniel P. Berrange (4):
>   io: fix temp directory used by test-io-channel-tls test
>   io: fix typo in docs comment for qio_channel_read
>   io: add new qio_channel_{readv, writev, read, write}_all functions
>   io: fix check for handshake completion in TLS test
>

Applied, thanks.

-- PMM
