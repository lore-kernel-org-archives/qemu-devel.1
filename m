Received: from eggs.gnu.org ([2001:4830:134:3::10]:60094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnsEc-0007ih-V5
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnsEc-0006oV-43
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:35:55 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:35743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnsEb-0006nn-EG
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 15:35:53 -0400
Received: by mail-wr0-x231.google.com with SMTP id g10so130856382wrg.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 12:35:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c3cddc59-619f-90bd-5521-fd139c865680@redhat.com>
References: <1476275861-27613-1-git-send-email-ppandit@redhat.com>
	<33183CC9F5247A488A2544077AF19020B0429759@SZXEMA503-MBS.china.huawei.com>
	<9d8d6a84-1220-2e61-dbdc-b86d5e348bef@redhat.com>
	<292d3a97-4dc9-6678-6a4f-acb5856e91f7@reactos.org>
	<c3cddc59-619f-90bd-5521-fd139c865680@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 19:35:31 +0000
Message-ID: <CAFEAcA9DSeCmymAYeJE4RbdtBwGp_DVQGDHS+Cn16bOSKYX+yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] dma: rc4030: limit interval timer reload
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Huawei PSIRT <PSIRT@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>, Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>

On 14 March 2017 at 19:17, Cole Robinson <crobinso@redhat.com> wrote:
> I'm coming to this thread from the Fedora bug for this CVE,
> https://bugzilla.redhat.com/show_bug.cgi?id=1384876

FWIW this isn't a CVE issue from the point of view of upstream
QEMU, because it only affects the MIPS Jazz board, which
(if I'm reading the source correctly) you can't use with KVM.

Still, we should fix the bug...

> I don't see this patch in qemu.git yet, can someone pick it up
> for a pull request?

Ccing the MIPS maintainer may help in achieving this :-)

thanks
-- PMM
