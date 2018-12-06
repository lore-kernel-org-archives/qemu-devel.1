Received: from eggs.gnu.org ([2001:4830:134:3::10]:48102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUwnf-0003zS-7F
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUwnb-0004s8-2T
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:46:55 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUwna-0004qs-Pg
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:46:50 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so976944otm.13
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 08:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20181206121830.6177-1-ppandit@redhat.com>
In-Reply-To: <20181206121830.6177-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 16:46:37 +0000
Message-ID: <CAFEAcA8dCgrDGPLpeLUKxK14yHDs3puB_ybWcH8JdSEFsbCKHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, public@hansmi.ch, Igor Mammedov <imammedo@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Thu, 6 Dec 2018 at 12:20, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> While performing block transfer write in smb_ioport_writeb(),
> 'smb_index' is incremented and used to index smb_data[] array.
> Check 'smb_index' value to avoid OOB access.
>
> Note that this bug is exploitable by a guest to escape
> from the virtual machine. However the commit which
> introduced the bug was only made after the 3.0 release,
> and so it is not present in any released QEMU versions.
>
> Fixes: 38ad4fae43 i2c: pm_smbus: Add block transfer capability
> Reported-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/i2c/pm_smbus.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> Update v1: add note about issue being introduced after 3.0 release
>   -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01115.html

Applied, thanks.

-- PMM
