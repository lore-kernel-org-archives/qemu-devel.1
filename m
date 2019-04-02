Received: from eggs.gnu.org ([209.51.188.92]:38205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBEIv-00029e-EC
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBECP-0000dc-Mh
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:51:14 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBECP-0000cP-7T
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 03:51:13 -0400
Received: by mail-oi1-x244.google.com with SMTP id v7so9657137oie.8
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 00:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <1553010562-13561-1-git-send-email-catherine.hecx@gmail.com>
	<20190320050735.GB8956@xz-x1>
	<CAEn6zmEzwQD_Ot8sttJj0KwML3Zkhfg9+QBxbOLn6bUsDpVn7w@mail.gmail.com>
	<20190321061024.GB9149@xz-x1>
	<CAEn6zmGFv+UbhyriwakFKB=UhnC6=thhybDF9D1E9JzoYL-1oA@mail.gmail.com>
	<CAFEAcA8q0c5BFh-11KNRJWCi6+Yer_5peekmQptmaw8Ag3SNhw@mail.gmail.com>
	<20190322101211.GA2703@work-vm> <20190325033948.GG9149@xz-x1>
	<CAEn6zmF0DRqqUxjKpdxWYdb_ofGXV_wACfELA991qLfvo9N6vA@mail.gmail.com>
	<CAEn6zmEzcNJGQWrkbP2_v3aidj5o=S39pQgm8kPHqSn8Os=J+g@mail.gmail.com>
	<CAFEAcA_=7E9nrFLLmhXBwk5k10ufhKQKX+ZCttfWOxOYt=hZog@mail.gmail.com>
	<CAEn6zmGmNLp5dF-1ViQn_HFnim9+FuGSXAptrReouQCQbsa=KQ@mail.gmail.com>
In-Reply-To: <CAEn6zmGmNLp5dF-1ViQn_HFnim9+FuGSXAptrReouQCQbsa=KQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 07:51:00 +0000
Message-ID: <CAFEAcA97Q+Ymxqc7qhim+gN-sNu4XFQNR=O8PTxA=A2-RgbKLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: avoid copying ignore-shared
 ramblock when in incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Catherine Ho <catherine.hecx@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Yury Kotov <yury-kotov@yandex-team.ru>

On Tue, 2 Apr 2019 at 14:47, Catherine Ho <catherine.hecx@gmail.com> wrote:
>
> Here  is my step:
> 1. start guest normal by qemu with shared memory-backend file
> 2. stop the vm. save the device state to another file via monitor migrate "exec: cat>..."
> 3. quit the vm
> 4. retore the vm by qemu -incoming "exec:cat ..."
> 5. continue the vm via monito, the 1st incoming works fine
> 6. quit the vm
> 7. retore the vm by qemu -incoming "exec:cat ..." for 2nd time
> 8. continue   -> error happened

I think I'm confused. If you're killing the QEMU process
and then running qemu again, then we must have done a
full system reset as part of the work we do creating the VM
for the second time we start the qemu binary.

thanks
-- PMM
