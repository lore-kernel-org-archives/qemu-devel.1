Received: from eggs.gnu.org ([2001:4830:134:3::10]:54831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFJXr-0003Y3-03
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:45:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFJXq-0007Qg-4X
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:45:27 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:41020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eFJXp-0007QC-SG
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:45:26 -0500
Received: by mail-wm0-x244.google.com with SMTP id b189so9523675wmd.0
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 04:45:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510749069-22059-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510749069-22059-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2017 12:45:03 +0000
Message-ID: <CAFEAcA-iOk7EuA58YY02Bcj2rEz9_Awj-=_X1YabESx+BLYcGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/4] Merge tpm 2017/11/15 v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>

On 15 November 2017 at 12:31, Stefan Berger <stefanb@linux.vnet.ibm.com> wr=
ote:
> This pull request is for 2.11 and extends documentation as well as fixes
> bugs related to concurrency and failure mode.
>
> The following changes since commit 4ffa88c99c54d2a30f79e3dbecec50b023eff1=
c8:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-1=
1-08-1' into staging (2017-11-10 16:01:35 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-11-15-1
>
> for you to fetch changes up to 6cd65969da57eaa9bdff07b80ecca2becce0597a:
>
>   tpm_tis: Return 0 for every register in case of failure mode (2017-11-1=
5 06:47:35 -0500)
>
> ----------------------------------------------------------------
> Merge tpm 2017/11/15 v1
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       tpm-emulator: protect concurrent ctrl_chr access
>
> Stefan Berger (3):
>       specs: Extend TPM spec with TPM emulator description
>       tpm_tis: Return TPM_VERSION_UNSPEC in case of BE failure
>       tpm_tis: Return 0 for every register in case of failure mode
>
>  docs/specs/tpm.txt    | 79 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/tpm/tpm_emulator.c | 44 +++++++++++++++++-----------
>  hw/tpm/tpm_tis.c      |  6 +++-
>  3 files changed, 112 insertions(+), 17 deletions(-)

Applied, thanks.

-- PMM
