Received: from eggs.gnu.org ([2001:4830:134:3::10]:58850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eECtF-0002u7-Hb
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eECtE-0003N9-KR
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:26:57 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:53207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eECtE-0003Km-83
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:26:56 -0500
Received: by mail-wr0-x231.google.com with SMTP id j23so14093748wra.9
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 03:26:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <49151b79-7ec4-b728-1ea9-d5c393a5bada@amsat.org>
References: <1510087611-1851-1-git-send-email-cota@braap.org>
	<49151b79-7ec4-b728-1ea9-d5c393a5bada@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 11:26:34 +0000
Message-ID: <CAFEAcA-pwxfR-+XSu+q117Po=Lh2aRDGtW9jNAEZuPZNjbFC_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] arm/translate-a64: mark path as
 unreachable to eliminate warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 8 November 2017 at 12:37, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> On 11/07/2017 05:46 PM, Emilio G. Cota wrote:
>> Fixes the following warning when compiling with gcc 5.4.0 with -O1
>> optimizations and --enable-debug:
>>
>> target/arm/translate-a64.c: In function =E2=80=98aarch64_tr_translate_in=
sn=E2=80=99:
>> target/arm/translate-a64.c:2361:8: error: =E2=80=98post_index=E2=80=99 m=
ay be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>>      if (!post_index) {
>>         ^
>> target/arm/translate-a64.c:2307:10: note: =E2=80=98post_index=E2=80=99 w=
as declared here
>>      bool post_index;
>>           ^
>> target/arm/translate-a64.c:2386:8: error: =E2=80=98writeback=E2=80=99 ma=
y be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>>      if (writeback) {
>>         ^
>> target/arm/translate-a64.c:2308:10: note: =E2=80=98writeback=E2=80=99 wa=
s declared here
>>      bool writeback;
>>           ^
>>
>> Note that idx comes from selecting 2 bits, and therefore its value
>> can be at most 3.
>>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>

Applied to target-arm.next, thanks. (It's a bit sad that
gcc can't figure out that the result of x & 3 is constrained
to [0,3], but there you go.)

> Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

By the way, Philippe, what are you intending to convey with
an acked-by tag? Usually "acked-by" means "I'm the maintainer
for this area and I haven't actually reviewed this but I don't
object to it"...

thanks
-- PMM
