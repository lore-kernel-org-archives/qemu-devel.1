Received: from eggs.gnu.org ([2001:4830:134:3::10]:47438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUqgG-0006oq-7s
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUqgF-0002VF-HF
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:14:52 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:34030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUqgD-0002Pi-G4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:14:49 -0500
Received: by mail-ot1-x32c.google.com with SMTP id t5so21560417otk.1
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 02:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20181206084816.30485-1-ppandit@redhat.com>
	<20181206104838.51060074@redhat.com>
In-Reply-To: <20181206104838.51060074@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Dec 2018 10:14:23 +0000
Message-ID: <CAFEAcA_=CGf1hwRhB5=AN8KUB1xnHd9MHmL6G0oKFH+f3NCCBg@mail.gmail.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: P J P <ppandit@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, public@hansmi.ch, Prasad J Pandit <pjp@fedoraproject.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 6 Dec 2018 at 09:48, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu,  6 Dec 2018 14:18:16 +0530
> P J P <ppandit@redhat.com> wrote:
>
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > While performing block transfer write in smb_ioport_writeb(),
> > 'smb_index' is incremented and used to index smb_data[] array.
> > Check 'smb_index' value to avoid OOB access.
> >
> > Reported-by: Michael Hanselmann <public@hansmi.ch>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>
> Peter,
> is it possible for fix to make into 3.1?

This question would have been much better asked on Tuesday...

thanks
-- PMM
