Received: from eggs.gnu.org ([2001:4830:134:3::10]:57111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQuc6-0003M1-0Y
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQuc5-0004Z7-8E
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:33:46 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eQuc5-0004Ye-3T
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:33:45 -0500
Received: by mail-ot0-x241.google.com with SMTP id v40so2532795ote.13
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 04:33:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8520cb93-2dce-7b51-87a1-834652890751@redhat.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAFEAcA96q6RGAmWJj=jYgYBC_yrP-NcZ6A4_w=S7vgn=-pL3Jw@mail.gmail.com>
	<35bf84c9-271d-5ded-0876-0edb9304b2fc@redhat.com>
	<8520cb93-2dce-7b51-87a1-834652890751@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2017 12:33:24 +0000
Message-ID: <CAFEAcA_BM52zFPBT5oTLqWN=tF+b=WyA13zT3VUfcR02Q_idsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 00/32] Merge tpm 2017/12/15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On 18 December 2017 at 11:50, Thomas Huth <thuth@redhat.com> wrote:
> On 18.12.2017 12:18, Thomas Huth wrote:
>> This apparently broke compilation on non-x86 architectures:
>>
>>   LINK    s390x-softmmu/qemu-system-s390x
>> ../hw/core/qdev-properties-system.o: In function `release_tpm':
>> /home/thuth/devel/qemu/hw/core/qdev-properties-system.c:291: undefined reference to `tpm_backend_reset'
>> ../hw/core/qdev-properties-system.o: In function `set_tpm':
>> /home/thuth/devel/qemu/hw/core/qdev-properties-system.c:274: undefined reference to `qemu_find_tpm_be'
>> /home/thuth/devel/qemu/hw/core/qdev-properties-system.c:278: undefined reference to `tpm_backend_init'
>> collect2: error: ld returned 1 exit status
>> make: Leaving directory `/home/thuth/s390x/qemu'
>> make[1]: *** [qemu-system-s390x] Error 1
>> make: *** [subdir-s390x-softmmu] Error 2
>>
>> Could you please fix this ASAP?
>
> FWIW, looks like there was a "--disable-tpm" in my config.status file,
> not sure why. So that's likely causing the issue here, not the non-x86
> system.

Yeah, I build on non-x86 but I don't have --disable-tpm in
any of the build configs. That should definitely work though :-)

thanks
-- PMM
