Received: from eggs.gnu.org ([209.51.188.92]:51901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtEmN-0007mJ-A4
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:49:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtEmM-0000Qg-6V
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:49:59 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtEmK-00007I-Rf
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:49:58 -0500
Received: by mail-pg1-x544.google.com with SMTP id w7so5180790pgp.13
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 08:49:32 -0800 (PST)
References: <1548985244-24523-1-git-send-email-catherine.hecx@gmail.com>
	<eeb0f275-b262-25db-337a-b6c78b29c124@linaro.org>
	<CAFEAcA9u_FYk40QyC=_R-VMVN74A5kTWYKCSgH-Kzya1_Pqzdw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a7de0ef-8c33-6a14-f937-ab657559daca@linaro.org>
Date: Mon, 11 Feb 2019 08:49:28 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9u_FYk40QyC=_R-VMVN74A5kTWYKCSgH-Kzya1_Pqzdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Catherine Ho <catherine.hecx@gmail.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 2/11/19 8:19 AM, Peter Maydell wrote:
> Thanks. Richard: is this effectively a bugfix for big-endian guest code ?

Yes.


r~
