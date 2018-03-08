Received: from eggs.gnu.org ([2001:4830:134:3::10]:55811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etsSb-0000xK-Al
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etsSa-0000DY-5w
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:07:41 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etsSa-0000D2-0M
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 05:07:40 -0500
Received: by mail-oi0-x243.google.com with SMTP id t185so3947109oif.6
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 02:07:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <950d4782-e1ca-816a-f13c-3dade56a7e7f@redhat.com>
References: <1520413694-1271-1-git-send-email-thuth@redhat.com>
	<3aaac650-2934-c4ab-3f58-c022b1510e81@reactos.org>
	<950d4782-e1ca-816a-f13c-3dade56a7e7f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 10:07:19 +0000
Message-ID: <CAFEAcA-bXBfc44y5FV9BOB14KMsJGNj3YEYSDxyAfVGpQooWjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/prep: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 8 March 2018 at 07:09, Thomas Huth <thuth@redhat.com> wrote:
> It's the third case. The "generic" code was just removed with commit
> 1454509726719e0933 since it was considered as a big hack. The generic
> code should not have to guess to which SCSI adapter a SCSI drive should
> be attached to. That's the job of the board init code, and this is what
> this patch is doing now for the 40p machine.
>
> Other boards like the "pseries" machine were doing this since a long
> time already (see the spapr_vscsi_create() function in
> hw/scsi/spapr_vscsi.c for example).
>
>> You just fixed 40p and MIPS Jazz machines, but sparc/SS-10 (and other)
>> also have the same problem...
>
> I also posted a patch for the Sparc machines, you can find it here:
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01830.html

Are we sure this is the entire list of machines that use this?

Can we in general try to avoid removing generic code features
until we've checked and fixed everything that relies on them? x86 pc
is not the only system we support...

thanks
-- PMM
