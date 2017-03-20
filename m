Received: from eggs.gnu.org ([2001:4830:134:3::10]:44068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cpvHQ-00034V-Hc
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cpvHM-0007lw-JY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:15:16 -0400
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:35911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cpvHM-0007le-Ey
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:15:12 -0400
Received: by mail-it0-x235.google.com with SMTP id w124so84519555itb.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:15:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8o15m5PgRPdGtHRgP=t4EZf5EPZKnJ7J=G0dosBHZXBA@mail.gmail.com>
References: <1489414630-21609-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAFEAcA8o15m5PgRPdGtHRgP=t4EZf5EPZKnJ7J=G0dosBHZXBA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 20 Mar 2017 11:15:11 +0000
Message-ID: <CAKv+Gu_vD43=3JEcEuB2iqw8q58F5GkT=tdak5JaB88RDaQJ6w@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
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

Thanks

> Since we're due to tag rc1 tomorrow and this is kind of on the
> border between bugfix and new feature, I think I'd rather
> defer it to 2.10, unless you have a strong view that it should
> go into 2.9.
>

I will leave that to you to decide, I don't feel strongly either way
