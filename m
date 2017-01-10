Received: from eggs.gnu.org ([2001:4830:134:3::10]:58840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQtwr-00023r-AK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQtwq-0007af-FA
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:46:37 -0500
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:33721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQtwq-0007aZ-9u
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 05:46:36 -0500
Received: by mail-vk0-x233.google.com with SMTP id 137so357219002vkl.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 02:46:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-O6HDYeVcTX4=ntso56Bs4o+w1RAO1Z_-KFrHZo3DRpA@mail.gmail.com>
References: <20170109190217.16301-1-rth@twiddle.net>
	<CAFEAcA-O6HDYeVcTX4=ntso56Bs4o+w1RAO1Z_-KFrHZo3DRpA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jan 2017 10:46:05 +0000
Message-ID: <CAFEAcA-bM3UGq_SBkW3vTRnwMqpczwhQRSwyFZJHMYPB0fag7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/11] tcg host mips64 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 January 2017 at 19:08, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 9 January 2017 at 19:02, Richard Henderson <rth@twiddle.net> wrote:
>> [Bah.  This time with actual request-pull info.]
>>
>> This is v6 of Jin Guojie's patch set, as tested by Aurelien Jarno,
>> James Hogan, and Yun Qiang Su.  Plus one more patch from me to fix
>> a trival Werror in mips specific code with gcc 5.3.
>>
>>
>> r~
>>
>>
>> The following changes since commit f0d703314ecb0415d51425727ed73ad2c6e3238a:
>>
>>   tcg-mips: Adjust qemu_ld/st for mips64 (2017-01-06 10:09:10 -0800)
>>
>> are available in the git repository at:
>>
>>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170108
>>
>> for you to fetch changes up to f68808c7494b38764e1895a9852b994638b86536:
>>
>>   translate-all: Avoid -Werror=switch-bool (2017-01-08 09:48:34 -0800)
>>
>> ----------------------------------------------------------------
>> TCG host support for mips64
>>
>> ----------------------------------------------------------------
>> Richard Henderson (1):
>>       translate-all: Avoid -Werror=switch-bool
>>
>>  translate-all.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Your pullreq has more stuff in it than the above diffstat and
> patchlist say :-)
>
> tcg/mips/tcg-target.h     | 60 ++-
> tcg/mips/tcg-target.inc.c | 1170
> ++++++++++++++++++++++++++++++++++++++++-----------
> translate-all.c           | 2 +-
>  3 files changed, 978 insertions(+), 254 deletions(-)
>
> I'm processing it anyway.

Applied, thanks.

-- PMM
