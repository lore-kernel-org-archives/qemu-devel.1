Received: from eggs.gnu.org ([209.51.188.92]:51070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGhB-0005Jl-RP
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGgs-0004ao-NS
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:04:42 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGgs-0004U8-EB
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:04:34 -0500
Received: by mail-ot1-x344.google.com with SMTP id s5so10316650oth.7
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 05:04:24 -0800 (PST)
MIME-Version: 1.0
References: <1548985244-24523-1-git-send-email-catherine.hecx@gmail.com>
	<eeb0f275-b262-25db-337a-b6c78b29c124@linaro.org>
	<CAFEAcA9u_FYk40QyC=_R-VMVN74A5kTWYKCSgH-Kzya1_Pqzdw@mail.gmail.com>
	<4a7de0ef-8c33-6a14-f937-ab657559daca@linaro.org>
In-Reply-To: <4a7de0ef-8c33-6a14-f937-ab657559daca@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 13:04:12 +0000
Message-ID: <CAFEAcA9kzazJMyiFtMHCdmGPuUxWsmitO9DpXgRgG4-pVrMmLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: Fix int128_make128 lo,
 hi order in paired_cmpxchg64_be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Catherine Ho <catherine.hecx@gmail.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 11 Feb 2019 at 16:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/11/19 8:19 AM, Peter Maydell wrote:
> > Thanks. Richard: is this effectively a bugfix for big-endian guest code ?
>
> Yes.

Thanks, applied to target-arm.next; I've added a line to the commit
message to note that it only affects BE guests.

-- PMM
