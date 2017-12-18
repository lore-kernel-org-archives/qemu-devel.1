Received: from eggs.gnu.org ([2001:4830:134:3::10]:54520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQyvV-0002jk-Ry
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQyvB-0004Uz-Uw
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:10:05 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQyvB-0004TX-O5
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:09:45 -0500
Received: by mail-it0-x243.google.com with SMTP id m11so5828234iti.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:09:45 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <151361408724.51.11858806436841676646@5adcb62bf0d6>
References: <20171218153552.18140-1-f4bug@amsat.org>
	<151361408724.51.11858806436841676646@5adcb62bf0d6>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 18 Dec 2017 14:09:44 -0300
Message-ID: <CAAdtpL7PCU2v-3VE67Qv2BCctz2aE1T-hRPwOjvjkrNvaiyepw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] travis: add no-TPM build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hi Cornelia, here appears the second failure you noticed recently.

On Mon, Dec 18, 2017 at 1:21 PM,  <no-reply@patchew.org> wrote:
> Hi,
>
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
>
[...]
> === OUTPUT BEGIN ===
[...]
>   GEN     trace/generated-helpers.c
>   CC      aarch64-softmmu/trace/control-target.o
>   CC      aarch64-softmmu/gdbstub-xml.o
> ../hw/tpm/tpm_tis.o:tpm_tis.c:(.data+0x50): undefined reference to `qdev_prop_tpm'
> collect2: error: ld returned 1 exit status
> Makefile:193: recipe for target 'qemu-system-x86_64w.exe' failed
> make[1]: *** [qemu-system-x86_64w.exe] Error 1
> Makefile:384: recipe for target 'subdir-x86_64-softmmu' failed
> make: *** [subdir-x86_64-softmmu] Error 2
