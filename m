Received: from eggs.gnu.org ([209.51.188.92]:32770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBKS5-0005Xl-VF
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBKS4-0002J0-S6
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:31:49 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBKS4-0002Ir-Jr
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:31:48 -0400
Received: by mail-ot1-x32b.google.com with SMTP id o74so12286467ota.3
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 07:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190402125417.21573-1-berrange@redhat.com>
In-Reply-To: <20190402125417.21573-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 14:31:36 +0000
Message-ID: <CAFEAcA-ihTt2fmQqTzB6_FStteO_yOFYu00euo5Tvk80W6WCDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Filemon next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Tue, 2 Apr 2019 at 20:10, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The following changes since commit d61d1a1fb2f1db6c54651844a28389c523f3f8=
c7:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20190402-pull-r=
equest' into staging (2019-04-02 08:18:24 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/filemon-next-pull-request
>
> for you to fetch changes up to b4682a63f86ed81abcaa543ea6135e17f9e99d01:
>
>   filemon: fix watch IDs to avoid potential wraparound issues (2019-04-02=
 13:52:02 +0100)
>
> ----------------------------------------------------------------
> filemon: various fixes / improvements to file monitor for USB MTP
>
> Ensure watch IDs unique within a monitor and avoid integer wraparound
> issues when many watches are set & unset over time.
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (3):
>   tests: refactor file monitor test to make it more understandable
>   filemon: ensure watch IDs are unique to QFileMonitor scope
>   filemon: fix watch IDs to avoid potential wraparound issues
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
