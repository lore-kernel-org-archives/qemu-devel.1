Received: from eggs.gnu.org ([2001:4830:134:3::10]:60292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej9R0-0004a6-6d
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej9Qz-0002fH-Ev
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:01:42 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:46179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej9Qz-0002f9-9o
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:01:41 -0500
Received: by mail-oi0-x232.google.com with SMTP id x21so2263116oie.13
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 12:01:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_EoqCHKQCWeWD=_34jgRtmKWBfRYM6gKL3X_zXgwQW7A@mail.gmail.com>
References: <20180122172643.29742-1-ard.biesheuvel@linaro.org>
	<20180122172643.29742-2-ard.biesheuvel@linaro.org>
	<CAFEAcA9zA=PTmxQH1W1ht8sj9HFMVKSb12dsm-jX6FQEmQR+FA@mail.gmail.com>
	<CAKv+Gu80ngyOewT-J3sKVV2pn8e7SVspF8py_yiuQzY1KEEE-w@mail.gmail.com>
	<CAKv+Gu8ZnyorvLnSackEyHCd7dRjN-Uh1Ywv_nj7iZwE=8z1og@mail.gmail.com>
	<CAFEAcA_Kkg5HUqK8hT_6JMD9AMrBgD46tHODT8rM9Fp7o8PWBw@mail.gmail.com>
	<CAFEAcA8nStZMnTkOSTdPU2vHVGZegY0tpLv9T+w5BPUUuwzUQQ@mail.gmail.com>
	<CAFEAcA_n23yw65QFUTuikY=0WZeMRySAnngeTBnObPFJPGqUUQ@mail.gmail.com>
	<CAKv+Gu_EoqCHKQCWeWD=_34jgRtmKWBfRYM6gKL3X_zXgwQW7A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 20:01:18 +0000
Message-ID: <CAFEAcA9Y8XokDEn8RiGJH8vmOdPoU=+cEPV1z=yV+AgOXs8g7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/4] target/arm: implement SHA-512
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 February 2018 at 19:59, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Thanks a lot for debugging that. As I said, I don't have test vectors,
> or I would have tested it myself, and most likely would have found
> this as well.

No problem. I spent a surprisingly long time looking at the inside
of the loop trying to check whether it matched the pseudocode and
why the fourth iteration only would misbehave, before I spotted
what was actually happening :-)

-- PMM
