Received: from eggs.gnu.org ([2001:4830:134:3::10]:39424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC5hp-0008Ur-RL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC5ho-00087r-No
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:22:25 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC5ho-00086u-GV
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:22:24 -0500
Received: by mail-wm0-x243.google.com with SMTP id b9so4695283wmh.0
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:22:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171107143652.15375-1-berrange@redhat.com>
References: <20171107143652.15375-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 15:22:02 +0000
Message-ID: <CAFEAcA9e1dc01TVQQ2TxK9wNRejUA3pqBz1WdwMPvnxHXvB3Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/1] Merge IO 2017/11/06
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

On 7 November 2017 at 14:36, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 5853e92207193e967abf5e4c25b4a551c7604725:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-cocoa-20171107' into staging (2017-11-07 12:19:48 +0000)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu pull-2017-11-06-2
>
> for you to fetch changes up to 10a7b7e6fd9f250f0506568345d7b4d2ab52889d:
>
>   sockets: avoid leak of listen file descriptor (2017-11-07 14:10:20 +0000)
>
> ----------------------------------------------------------------
> Pull IO 2017/11/06 v2
>
> ----------------------------------------------------------------
> Daniel P. Berrange (1):
>   sockets: avoid leak of listen file descriptor
>
>  util/qemu-sockets.c | 52 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)

Applied, thanks. (My test script expected your pullreq to
say "git://github.com/berrange/qemu tags/pull-2017-11-06-2"
but that might be the script not being as smart as it could be.)

-- PMM
