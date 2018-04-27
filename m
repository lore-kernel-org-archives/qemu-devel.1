Received: from eggs.gnu.org ([2001:4830:134:3::10]:53378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBrLw-0000bQ-6V
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fBrLv-0007gE-GF
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:35:08 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fBrLv-0007fz-9z
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 20:35:07 -0400
Received: by mail-pg0-x242.google.com with SMTP id n9-v6so163153pgq.5
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 17:35:07 -0700 (PDT)
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<CAHNT7NsVNohpxfic=A30oAufaygPWFp1BoT+PUTcgPyhaVif6g@mail.gmail.com>
	<CAHNT7NtRi4qwqpR+SuU-ANXHEAAkp6TitkWFroJ54GsJowTXNg@mail.gmail.com>
	<CAKmqyKMtO5JQ7GnpKU9E_MGeDRGHsb=c0ra0CnGX8vxKtKsunQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4e30b71b-7007-d879-d1c4-12eeb94ed6c5@linaro.org>
Date: Thu, 26 Apr 2018 14:35:02 -1000
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMtO5JQ7GnpKU9E_MGeDRGHsb=c0ra0CnGX8vxKtKsunQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 00/35] QEMU 2.13 Privileged ISA
 emulation updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>, Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, suhang16@mails.ucas.ac.cn, msuozzo@google.com, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, palmer@sifive.com, "Emilio G. Cota" <cota@braap.org>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On 04/26/2018 08:22 AM, Alistair Francis wrote:
> On Wed, Apr 25, 2018 at 7:01 PM Michael Clark <mjc@sifive.com> wrote:
>> We can make a PR for the first 9 patches as they are already reviewed,
>> however, the with this series is to gather review for the new baseline we
>> have in the riscv repo.
> 
> I think it is worth sending a PR for the first 9 patches. The current
> master doesn't boot the sifive_u board and those patches will fix that.
> That also helps create a smaller patch series which is easier to review.

FYI, for patches that affect usability like this, you should also Cc:
qemu-stable@nongnu.org in your pull request.  That way they should be
cherry-picked from master into the 2.12.1 release.


r~
