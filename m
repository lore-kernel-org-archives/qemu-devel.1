Received: from eggs.gnu.org ([2001:4830:134:3::10]:50840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvMu5-0005Bn-US
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvMu4-0001iM-Mv
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:45:41 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvMu4-0001i7-Fh
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:45:40 -0400
Received: by mail-wr0-x233.google.com with SMTP id t20so6399138wra.1
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 04:45:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8o15m5PgRPdGtHRgP=t4EZf5EPZKnJ7J=G0dosBHZXBA@mail.gmail.com>
References: <1489414630-21609-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAFEAcA8o15m5PgRPdGtHRgP=t4EZf5EPZKnJ7J=G0dosBHZXBA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 12:45:18 +0100
Message-ID: <CAFEAcA-NxhpE_23Ec=+iWSzPeee6aEvj70dU0G26CETd5bofig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/boot: take Linux/arm64
 TEXT_OFFSET header field into account
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Rutland <mark.rutland@arm.com>

On 20 March 2017 at 11:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 13 March 2017 at 14:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> The arm64 boot protocol stipulates that the kernel must be loaded
>> TEXT_OFFSET bytes beyond a 2 MB aligned base address, where TEXT_OFFSET
>> could be any 4 KB multiple between 0 and 2 MB, and whose value can be
>> found in the header of the Image file.
>>
>> So after attempts to load the arm64 kernel image as an ELF file or as a
>> U-Boot image have failed (both of which have their own way of specifying
>> the load offset), try to determine the TEXT_OFFSET from the image after
>> loading it but before mapping it as a ROM mapping into the guest address
>> space.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>> v2: split off AArch64 specific loader logic regarding gzipped/raw and variable
>>     load offset into a separate helper function, which removes the need for
>>     loading the image twice
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> Since we're due to tag rc1 tomorrow and this is kind of on the
> border between bugfix and new feature, I think I'd rather
> defer it to 2.10, unless you have a strong view that it should
> go into 2.9.

Since we're now at rc3 and I don't expect to need to do another
arm pull request before 2.9, I've put this patch into target-arm.next
for 2.10.

thanks
-- PMM
