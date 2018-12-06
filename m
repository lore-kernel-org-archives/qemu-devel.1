Received: from eggs.gnu.org ([2001:4830:134:3::10]:56673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUrgl-00024k-6B
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:19:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUrgg-0000wL-Pu
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:19:27 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUrgg-0000w4-JI
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:19:22 -0500
Received: by mail-oi1-x241.google.com with SMTP id a77so58596oii.5
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 03:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20181206084816.30485-1-ppandit@redhat.com>
	<20181206105830.43eb1d05@redhat.com>
	<nycvar.YSQ.7.76.1812061637070.2113@xnncv>
In-Reply-To: <nycvar.YSQ.7.76.1812061637070.2113@xnncv>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 11:19:10 +0000
Message-ID: <CAFEAcA90U=8s=f-pcFS+8VF3GZby__GnwXy_van=FxiE7fK7gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
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
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, public@hansmi.ch, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 6 Dec 2018 at 11:10, P J P <ppandit@redhat.com> wrote:
>
> +-- On Thu, 6 Dec 2018, Igor Mammedov wrote --+
> | > From: Prasad J Pandit <pjp@fedoraproject.org>
> | >
> | > While performing block transfer write in smb_ioport_writeb(),
> | > 'smb_index' is incremented and used to index smb_data[] array.
> | > Check 'smb_index' value to avoid OOB access.
> | >
> | > Reported-by: Michael Hanselmann <public@hansmi.ch>
> | > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> | pls squash in:
> |
> | Fixes: 38ad4fae43 i2c: pm_smbus: Add block transfer capability
>
> Do we need patch v2, or it can be done while merging it?

I can add in the Fixes line when I apply the patch to master.

It would be good if we could get some Reviewed-by: tags as well.

I think my current view is that we should apply this today,
and tag rc5 this afternoon (or maybe tomorrow?), and do the
final release on schedule on Tuesday.

Is there anything else in the pipeline that should go in rc5?

thanks
-- PMM
