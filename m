Received: from eggs.gnu.org ([2001:4830:134:3::10]:36758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0Shv-0008NW-HH
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0Shp-00026V-IO
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:30:27 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:43694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0Shp-00025t-9c
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:30:21 -0400
Received: by mail-wr0-x229.google.com with SMTP id p46so10583266wrb.0
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:30:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 14:29:59 +0100
Message-ID: <CAFEAcA8sL6T2bGELtx_-i33mSOFYD4Wdq3mNjsf5Rw=BTarZ-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 00/20] ARM v8M: exception entry,
 exit and security
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>

On 22 September 2017 at 15:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> Another week, another set of v8M patches.
> This lot adds:
>  * v8M and security extension changes in exception entry and exit
>  * the Security Attribution Unit
>  * SG and BLXNS instructions
>  * secure function return
>  * and a couple of fixes for bugs in already-in-master changes

Thanks to Richard and Philippe for review. I'm going to queue
patches 1-16 and 20 in target-arm.next, with the minor tweaks
suggested for patches 2 and 8.

17 needs more significant rework so I'll resend 17-19 in
the next patchset (there are a few more patches cooking
which make a coherent set with those anyway).

thanks
-- PMM
