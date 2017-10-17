Received: from eggs.gnu.org ([2001:4830:134:3::10]:44996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4TMf-0004rM-7B
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e4TMZ-0001TP-OT
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:01:05 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:55602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e4TMZ-0001T9-IK
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:00:59 -0400
Received: by mail-wm0-x233.google.com with SMTP id u138so4599814wmu.4
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 08:00:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171017145940.GD3676@codeaurora.org>
References: <1506737310-21880-1-git-send-email-alindsay@codeaurora.org>
	<1506737310-21880-3-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA_zwAu4Zt0-2Qy9euBzYQgD19EnnoWwa+ZNzidWwkmEcA@mail.gmail.com>
	<20171017145940.GD3676@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2017 16:00:37 +0100
Message-ID: <CAFEAcA8U72AL=7mMduf2Bqvh9Tq1TnE_GCkrD7R1F5B-R73j=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/13] target/arm: Check PMCNTEN for
 whether PMCCNTR is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Wei Huang <wei@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On 17 October 2017 at 15:59, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> On Oct 17 13:49, Peter Maydell wrote:
>> I keep replying to your v1 patchset by mistake -- can you use
>> the git format-patch options to put make the subject prefix
>> be "[PATCH v3]" for the next round in all the patchmails to
>> help keep the versions distinct, please?
>
> Yes, and I apologize for the nuisance. Also, thanks - I didn't know
> about the `-v, --reroll-count` option and must have gotten distracted
> between updating the subject to be 'v2' for the cover letter and the patches.

There's also --subject-prefix if you need more flexibility than -v.

thanks
-- PMM
