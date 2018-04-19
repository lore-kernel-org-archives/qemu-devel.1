Received: from eggs.gnu.org ([2001:4830:134:3::10]:38131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f98QD-0003mH-0t
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f98Q7-0006JS-De
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:12:17 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f98Q7-0006Iw-8J
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:12:11 -0400
Received: by mail-ot0-x241.google.com with SMTP id j27-v6so5403562ota.5
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 05:12:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <403f225f-664b-7ff8-f042-3da56b7812a0@redhat.com>
References: <1524135103-30477-1-git-send-email-frederic.konrad@adacore.com>
	<403f225f-664b-7ff8-f042-3da56b7812a0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Apr 2018 13:11:50 +0100
Message-ID: <CAFEAcA_Kuvy42P3uehAU_WHryZwY6X6E0PXtaaf2zUc9Km5EzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] riscv: requires libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Michael Clark <mjc@sifive.com>

On 19 April 2018 at 13:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 19/04/2018 12:51, KONRAD Frederic wrote:
>> --- a/configure
>> +++ b/configure
>> @@ -3732,7 +3732,7 @@ fi
>>  fdt_required=no
>>  for target in $target_list; do
>>    case $target in
>> -    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu)
>> +    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|riscv64-softmmu)
>>        fdt_required=yes
>>      ;;
>>    esac
>>
>
> Maybe good for 2.12, even though it would make the final rc and final
> release different?

I strongly prefer not to have changes between final rc and actual
release, and I don't think this rises to the level of justifying
another rc, since there is an easy user workaround for it (pass
--enable-fdt to configure).

thanks
-- PMM
