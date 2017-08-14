Received: from eggs.gnu.org ([2001:4830:134:3::10]:44758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhCoP-0004pm-MK
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhCoP-0005ut-0U
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:41:33 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhCoO-0005uI-PL
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 06:41:32 -0400
Received: by mail-wm0-x22e.google.com with SMTP id f15so40355865wmg.1
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 03:41:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170811140627.22421-1-cohuck@redhat.com>
References: <20170811140627.22421-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Aug 2017 11:41:11 +0100
Message-ID: <CAFEAcA9g8n56kQ3Xbs5r2JZBZ1oWhOUZzfHg2wtzcBvRM846cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.10 0/1] bugfix for boot-serial-test
 and no tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 11 August 2017 at 15:06, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 473a321122fd3c2c327a5a5d01a9a41f26f1734c:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-08-10 17:50:55 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/boot-serial-no-tcg-20170811
>
> for you to fetch changes up to 480bc11e61693796debd3a9566be0ca1795bb7b7:
>
>   boot-serial-test: fallback to kvm accelerator (2017-08-11 15:44:05 +0200)
>
> ----------------------------------------------------------------
> Fix the boot-serial test to work with the new --disable-tcg.
>
> ----------------------------------------------------------------
>
> Cornelia Huck (1):
>   boot-serial-test: fallback to kvm accelerator
>
>  tests/boot-serial-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
