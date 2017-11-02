Received: from eggs.gnu.org ([2001:4830:134:3::10]:45342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAIXH-0004e6-Mv
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAIXB-0005Hp-SI
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:40:07 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:48096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAIXB-0005GV-LN
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:40:01 -0400
Received: by mail-wm0-x243.google.com with SMTP id r196so199081wmf.2
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 09:40:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <150964073694.216.3626923485460882393@bafd83ae6430>
References: <1509640536-32160-1-git-send-email-peter.maydell@linaro.org>
	<150964073694.216.3626923485460882393@bafd83ae6430>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 16:39:39 +0000
Message-ID: <CAFEAcA-P8pFR8LWLADYXMWQ8VR=zaGK4GT_o04pK1OgmUUpR_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] cpu-exec: Exit exclusive region on
 longjmp from step_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 2 November 2017 at 16:38,  <no-reply@patchew.org> wrote:
> Checking PATCH 1/1: cpu-exec: Exit exclusive region on longjmp from step_atomic...
> ERROR: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
> #37: FILE: accel/tcg/cpu-exec.c:237:
> +    volatile bool in_exclusive_region = false;

Usually, but not in this case :-)

-- PMM
