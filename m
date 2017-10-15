Received: from eggs.gnu.org ([2001:4830:134:3::10]:37944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3m6p-000337-0E
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e3m6o-0003k4-B8
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:49:51 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:53639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e3m6o-0003jh-54
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 12:49:50 -0400
Received: by mail-wm0-x22f.google.com with SMTP id q132so29959943wmd.2
	for <qemu-devel@nongnu.org>; Sun, 15 Oct 2017 09:49:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d4676b57-0298-a0b4-a116-3d5cd9a38807@linux.vnet.ibm.com>
References: <1507751249-3035-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CK7MW5kY5eaiHGyk7hvxKyOBNJi7MHo9warfXbSp4LzPA@mail.gmail.com>
	<CAFEAcA_V-ZS+O_BsEU6OJuT_hE-RXw0dTaJbZgY-BW8soRv3vA@mail.gmail.com>
	<d4676b57-0298-a0b4-a116-3d5cd9a38807@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 15 Oct 2017 17:49:28 +0100
Message-ID: <CAFEAcA_y_LT-7-ghxSwwVf+3vJ4TFM7Y4GzM2PLW_ruW0RLVhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] tpm: Use EMSGSIZE instead of EBADMSG to
 compile on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>, QEMU <qemu-devel@nongnu.org>

On 13 October 2017 at 17:36, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> This is NOT test code. It's determining whether the external TPM is a TPM
> 1.2 or TPM 2 emulation. This avoids having to start QEMU with a '--tpm2'
> parmeter equivalent as well as the external emulator. Passing this to the
> external emulator is enough.

Sorry -- I was misled by the way the function is named
"tpm_util_test()" and the comment in front of it says
"A basic test of a TPM device".

thanks
-- PMM
