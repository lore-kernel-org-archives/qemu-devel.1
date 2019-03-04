Received: from eggs.gnu.org ([209.51.188.92]:52969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0kh3-0005mD-Pp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0kh3-0004Fz-5I
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:19:33 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0kh2-0004Fa-VX
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:19:33 -0500
Received: by mail-oi1-x241.google.com with SMTP id b4so3423068oif.6
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 02:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20190214220453.15858-1-svens@stackframe.org>
	<65d59485-9973-4ed1-b08f-084ed4db7ef1@redhat.com>
In-Reply-To: <65d59485-9973-4ed1-b08f-084ed4db7ef1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 10:19:20 +0000
Message-ID: <CAFEAcA-autqypsBsOkKjkKNuRd1tVW9dOLrdswA-HGUfgLNA1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] lsi: implement basic SBCL functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sven Schnelle <svens@stackframe.org>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>

On Fri, 15 Feb 2019 at 09:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 14/02/19 23:04, Sven Schnelle wrote:
> > @@ -2202,6 +2224,7 @@ static const VMStateDescription vmstate_lsi_scsi = {
> >          VMSTATE_UINT8(stime0, LSIState),
> >          VMSTATE_UINT8(respid0, LSIState),
> >          VMSTATE_UINT8(respid1, LSIState),
> > +        VMSTATE_UINT8(sbcl, LSIState),
>
> This breaks live migration.  You need to bump the version number higher
> in vmstate_lsi_scsi and use "VMSTATE_UINT8_V(sbcl, LSIState, 1)" so that
> the field is only marshalled/unmarshalled for version 1 of the migration
> state.

I thought we preferred to do this with migration subsections
rather than versioning fields these days ? In this case I
think a subsection that says "needed if sbcl is non-zero" would
do the right thing.

thanks
-- PMM
