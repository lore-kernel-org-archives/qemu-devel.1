Received: from eggs.gnu.org ([2001:4830:134:3::10]:47358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOjdn-0001Ka-CM
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOjdm-0000Zk-Lp
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:58:47 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:39896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOjdm-0000Ye-7l
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 08:58:46 -0400
Received: by mail-ot0-x231.google.com with SMTP id l12-v6so29160145oth.6
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 05:58:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180601120832.17299-1-otubo@redhat.com>
References: <20180601120832.17299-1-otubo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 13:58:24 +0100
Message-ID: <CAFEAcA-4o9rDrP+xGNakZ4rdH2pkixFzxOjCNm=5m=HUYg5Y9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/01] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?J=C3=A1n_Tomko?= <jtomko@redhat.com>, John Ferlan <jferlan@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, fiuczy@linux.ibm.com, zyimin@linux.ibm.com

On 1 June 2018 at 13:08, Eduardo Otubo <otubo@redhat.com> wrote:
> The following changes since commit 14fc618461c2756a3f0b16bf6af198c5d7731137:
>
>   Merge remote-tracking branch 'remotes/sstabellini-http/tags/xen-20180531-tag' into staging (2018-06-01 10:16:49 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/otubo/qemu.git tags/pull-seccomp-20180601
>
> for you to fetch changes up to 4e488581de463218be39cff97530294534c9e85b
>
>   seccomp: disable -sandbox if CONFIG_SECCOMP undefined (2018-06-01 13:44:15 +0200)
>
> ----------------------------------------------------------------
> pull-seccomp-20180601
>
> ----------------------------------------------------------------
> Yi Min Zhao (1):
>       seccomp: disable -sandbox if CONFIG_SECCOMP undefined
>
>  include/sysemu/seccomp.h |   3 +-
>  qemu-seccomp.c           | 121 ++++++++++++++++++++++++++++++++++++++++++++-
>  vl.c                     | 124 +++--------------------------------------------
>  3 files changed, 130 insertions(+), 118 deletions(-)
>

Applied, thanks.

-- PMM
