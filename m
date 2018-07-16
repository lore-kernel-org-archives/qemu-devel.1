Received: from eggs.gnu.org ([2001:4830:134:3::10]:60321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff401-0007LS-0p
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff400-0004l1-CQ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:57:13 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff400-0004ko-6g
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:57:12 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so74923845oih.11
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 06:57:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531745974-17187-17-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
	<1531745974-17187-17-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 14:56:50 +0100
Message-ID: <CAFEAcA9=7zpoXDoYY_4gBO=v-APXKunNv=_EhGp8Qu9MBtFphg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 16/17] hw/display/xlnx_dp: Move
 problematic code from instance_init to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On 16 July 2018 at 13:59, Thomas Huth <thuth@redhat.com> wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> aux_create_slave() calls qdev_init_nofail() which in turn "realizes"
> the corresponding object. This is unlike qdev_create(), and it is wrong
> because qdev_init_nofail() must not be called from an instance_init
> function.  Move qdev_init_nofail() and the subsequent aux_map_slave into
> the caller's realize function.
>
> There are two more bugs that needs to be fixed here, too, where the
> objects are created but not added as children.  Therefore when
> you call object_unparent on them, nothing happens.
>
> In particular dpcd and edid give you an infinite loop in bus_unparent,
> because device_unparent is not called and does not remove them from
> the list of devices on the bus.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [thuth: Added Paolo's fixup for the dpcd and edid unparenting]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
