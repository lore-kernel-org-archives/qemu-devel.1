Received: from eggs.gnu.org ([2001:4830:134:3::10]:40907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK3Kb-0004OS-Uf
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gK3KY-0001GF-Uc
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:31:53 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:43676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gK3KV-0000zy-0Q
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:31:50 -0500
Received: by mail-ot1-x332.google.com with SMTP id k9so11733720otl.10
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 07:31:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4b68930c-1fc3-9462-8f9e-671b414e712d@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
	<20181105181353.39804-3-mst@redhat.com>
	<a21e8e21-d056-1e9a-3726-54f8ce24a162@redhat.com>
	<20181106091147-mutt-send-email-mst@kernel.org>
	<4b68930c-1fc3-9462-8f9e-671b414e712d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Nov 2018 15:31:08 +0000
Message-ID: <CAFEAcA9R9kTfznkvdFf9Eqtp80NFAt3Gd1cjooRpr2bZ6TsJiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 02/33] tests: Move
 tests/hex-loader-check-data/ to tests/data/hex-loader/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Paolo Bonzini <pbonzini@redhat.com>

On 6 November 2018 at 15:15, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> No worry, I'm not mad at all, but there might be an issue in your git PR
> workflow, this series also missed your maintainer S-o-b.
>
> Peter: Can you add a such check in your scripts? (during next merge windo=
w,
> no hurry).
>
> Rather than your scripts, this should be in scripts a maintainer can run
> locally, such ./scripts/checkpatch.pl --maintainer or
> ./scripts/checkseries.xx.

I have such a check in my own make-pullreq script which I use
for arm pull requests:
https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/make-pull=
req#n98

I can't do much about other submaintainers' workflows
(and the block tree's "sub-submaintainers" setup means
"check all commits have a signoff from the same person as
the merge commit did" won't work either.)

thanks
-- PMM
