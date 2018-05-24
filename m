Received: from eggs.gnu.org ([2001:4830:134:3::10]:42006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLrnP-0002cL-2M
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLrnH-0000VM-Gk
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:04:49 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLrnH-0000Uz-B4
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:04:43 -0400
Received: by mail-oi0-x241.google.com with SMTP id v2-v6so1742793oif.3
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 08:04:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180524005741.1042749-1-stefanb@linux.vnet.ibm.com>
References: <20180524005741.1042749-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 16:04:18 +0100
Message-ID: <CAFEAcA9c6w0GQQYr3GQqzOuea+n5y3muuPy4dE7WZy-UPQM7sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/4] Merge tpm 2018/05/23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 24 May 2018 at 01:57, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> This series of patches adds TPM emulator state migration support and a
> test case for testing (local) migration.
>
>    Stefan
>
> The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd466d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-05-22 09:43:58 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-05-23-1
>
> for you to fetch changes up to 319bb20d1e88ea2e13baeb158a4989eceeee5e86:
>
>   test: Add test cases that use the external swtpm with CRB interface (2018-05-23 20:35:25 -0400)
>
> ----------------------------------------------------------------
> Merge tpm 2018/05/23 v1
>
> ----------------------------------------------------------------
> Stefan Berger (4):
>       tpm: extend TPM emulator with state migration support
>       tpm: extend TPM TIS with state migration support
>       docs: tpm: add VM save/restore example and troubleshooting guide
>       test: Add test cases that use the external swtpm with CRB interface
>

Hi. I'm afraid this fails to build on OpenBSD:

  CC      hw/tpm/tpm_emulator.o
/home/qemu/hw/tpm/tpm_emulator.c: In function 'tpm_emulator_set_state_blobs':
/home/qemu/hw/tpm/tpm_emulator.c:794:17: error: 'EBADMSG' undeclared
(first use in this function)
         return -EBADMSG;
                 ^

thanks
-- PMM
