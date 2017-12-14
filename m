Received: from eggs.gnu.org ([2001:4830:134:3::10]:42951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ePT6q-0000C2-Eb
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ePT6p-00018g-Jg
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:59:32 -0500
Received: from mail-it0-x22a.google.com ([2607:f8b0:4001:c0b::22a]:46799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ePT6p-00017i-EE
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:59:31 -0500
Received: by mail-it0-x22a.google.com with SMTP id t1so11081934ite.5
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 04:59:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8HswEKDPpj=cM711rNU2zwPuDXW7886=Oa2HBDmZxdCg@mail.gmail.com>
References: <1513183941-24300-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA8HswEKDPpj=cM711rNU2zwPuDXW7886=Oa2HBDmZxdCg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 14 Dec 2017 13:59:30 +0100
Message-ID: <CAKv+Gu970cDwifDV1kz=kBWTWzxJyuT+QUAVNkFawun5psgYVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/2] GICv2 & GICv3: RAZ/WI
 reserved addresses rather than aborting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, "patches@linaro.org" <patches@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 13 December 2017 at 16:54, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 13 December 2017 at 16:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>> The GICv2 and GICv3 specifications say that reserved register
>> addresses should RAZ/WI.  This means we need to return MEMTX_OK, not
>> MEMTX_ERROR, because now that we support generating external aborts
>> the latter will cause an abort on new board models.
>>
>> In particular, at least some versions of UEFI try to
>> access a reserved address in the GICv3 redistributor
>> (at SGI_base + 0x184) and fail to boot on the virt board
>> without this.
>>

Could this commit

https://github.com/tianocore/edk2/commit/28f8d28faabf50a82ef8d137308592c64ea9e2b6

have anything to do with that?
