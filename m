Received: from eggs.gnu.org ([2001:4830:134:3::10]:47400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edwXl-0004CL-GS
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edwXk-0005MS-Km
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:15:09 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35891)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edwXk-0005MB-ES
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:15:08 -0500
Received: by mail-oi0-x241.google.com with SMTP id w135so74261oie.3
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 03:15:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAATJJ0+swtq=6Q7U9fShDRvbm13YukdfXqOX0pcvf9=z-KR3ZQ@mail.gmail.com>
References: <20180118020157.25401-1-ehabkost@redhat.com>
	<CAFEAcA_WdJnYnZUoABB1yWZUO81ag2cMMZRAw106VL_GFM6ZcQ@mail.gmail.com>
	<CAATJJ0Kwf=qMQ8Sax8d4ieFXfFrqaisd6wUSLTTLBxvSdgb5Jw@mail.gmail.com>
	<1d3ee391-bbb2-3c49-b3b0-8f189e0fd096@de.ibm.com>
	<CAATJJ0+swtq=6Q7U9fShDRvbm13YukdfXqOX0pcvf9=z-KR3ZQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2018 11:14:47 +0000
Message-ID: <CAFEAcA9RQB7xAzXgKN3E8cL2SauiwOkqFMpmQg43YzD09OF52A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] x86 queue, 2018-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 23 January 2018 at 10:34, Christian Ehrhardt
<christian.ehrhardt@canonical.com> wrote:
> Also adding Suraj for a statement in this regard about his "[QEMU-PPC]
> [PATCH V5 0/7] target/ppc: Rework spapr_caps" series which I think is
> the PPC version of all of this right?
> Not sure who to add for Arm :-/

AIUI for Arm no QEMU changes should be required -- KVM VMs always
use the same CPU type as the host, and the kernel always exposes
the same MIDR (main ID register) value to the guest as the host has,
and the guest kernel fixes will key off the MIDR.

thanks
-- PMM
