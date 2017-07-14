Received: from eggs.gnu.org ([2001:4830:134:3::10]:45570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVw3v-0003bF-6u
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVw3u-000840-Is
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:34:59 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVw3u-00083e-Bq
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:34:58 -0400
Received: by mail-wr0-x233.google.com with SMTP id 48so3143167wrz.0
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 01:34:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499965423-13517-1-git-send-email-peter.maydell@linaro.org>
References: <1499965423-13517-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 09:34:35 +0100
Message-ID: <CAFEAcA8Akw3tjANvtoMBwC3OWtya5cjvddEAzptCkRLK6jJQuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix NetBSD build (don't build ivshmem
 tools)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kamil Rytarowski <n54@gmx.com>, Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 13 July 2017 at 18:03, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset fixes the build on NetBSD by making sure we only
> build the ivshmem-client and ivshmem-server tools if the host OS
> actually supports ivshmem. (Previously we were only gating building
> of the within-QEMU ivshmem PCI device.)

Markus pointed out that I'd accidentally only sent out the
cover letter -- I've just resent the whole set.

thanks
-- PMM
