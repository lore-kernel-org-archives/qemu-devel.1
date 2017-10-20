Received: from eggs.gnu.org ([2001:4830:134:3::10]:54844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5VYh-0004eQ-RE
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5VYd-000074-KO
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:33:44 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:56787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5VYd-00005p-DQ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:33:43 -0400
Received: by mail-wr0-x233.google.com with SMTP id r79so11089120wrb.13
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 04:33:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2017 12:33:19 +0100
Message-ID: <CAFEAcA9RmMxH6u8G0HFWO1wNrqPQc-AUOGNpJ6_BaTu=L-J=zQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 00/21] Merge tpm 2017/10/19
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

On 19 October 2017 at 19:02, Stefan Berger <stefanb@linux.vnet.ibm.com> wro=
te:
> The following changes since commit f2a48d696c12aaac12993364371daae9f6233c=
37:
>
>   Merge remote-tracking branch 'remotes/riku/tags/pull-linux-user-2017101=
8' into staging (2017-10-19 14:39:30 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-10-19-1
>
> for you to fetch changes up to 05a699985c001927a50f8f276251f2af1e0c5b58:
>
>   tpm: move recv_data_callback to TPM interface (2017-10-19 11:42:33 -040=
0)
>
> ----------------------------------------------------------------
> Merge tpm 2017/10/19 v1
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (21):
>       tpm-tis: remove unused hw_access argument
>       tpm-tis: remove RAISE_STS_IRQ
>       tpm: make tpm_get_backend_driver() static
>       tpm: lookup tpm backend class in tpm_driver_find_by_type()
>       tpm: replace tpm_get_backend_driver() to drop be_drivers
>       tpm: remove tpm_register_driver()
>       tpm: move TPMSizedBuffer to tpm_tis.h
>       tpm: remove TPMDriverOps
>       tpm: remove init() class method
>       tpm: remove configure_tpm() hop
>       tpm: remove unused TPMBackendCmd
>       tpm: remove needless cast
>       tpm: remove locty argument from receive_cb
>       tpm: add TPMBackendCmd to hold the request state
>       tpm-emulator: fix error handling
>       tpm: remove locty_data from TPMState
>       tpm-tis: move TPMState to TIS header
>       tpm-tis: remove tpm_tis.h header
>       tpm-tis: fold TPMTISEmuState in TPMState
>       tpm: add a QOM TPM interface
>       tpm: move recv_data_callback to TPM interface
>

Applied, thanks.

-- PMM
