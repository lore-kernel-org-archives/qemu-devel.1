Received: from eggs.gnu.org ([209.51.188.92]:51024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2KFT-0005ko-JE
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2KFS-00057G-Iz
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:29:35 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:39208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2KFS-00056j-8P
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:29:34 -0500
Received: by mail-ot1-x336.google.com with SMTP id e15so18185410otk.6
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 10:29:34 -0800 (PST)
MIME-Version: 1.0
References: <1552036723-1949-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1552036723-1949-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 18:29:22 +0000
Message-ID: <CAFEAcA_eMQC+fmdK9bBd=qgOXqiPyg+BRtBWgEi841qttEXs6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] qtests, clean-ups and macOS CI testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Fri, 8 Mar 2019 at 09:19, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 6cb4f6db4f4367faa33da85b15f75bbbd2bed2=
a6:
>
>   Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-requ=
est' into staging (2019-03-07 16:16:02 +0000)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-03-08
>
> for you to fetch changes up to 4966c5bd8a6ab17214f54f8016426f95303f9760:
>
>   cirrus.yml: Add macOS continuous integration task (2019-03-08 09:54:29 =
+0100)
>
> ----------------------------------------------------------------
> - qtest fixes
> - Some generic clean-ups by Philippe
> - macOS CI testing via cirrus-ci.com
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (1):
>       vhost-user-test: fix leaks
>
> Philippe Mathieu-Daud=C3=A9 (4):
>       tests: Move qdict-test-data.txt to tests/data/qobject/
>       hw: Remove unused 'hw/devices.h' include
>       hw/devices: Remove unused TC6393XB_RAM definition
>       tests/bios-tables: Improve portability by searching bash in the $PA=
TH
>
> Thomas Huth (2):
>       tests: Do not use "\n" in g_test_message() strings
>       cirrus.yml: Add macOS continuous integration task

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
