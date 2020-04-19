Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021C0C2BA19
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 02:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D8F21D7E
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 02:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="XKwewYTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D8F21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPzzu-0002bR-RX
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 22:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@mail.ru>) id 1jPzzJ-0002CE-0v
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 22:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jusual@mail.ru>) id 1jPzzI-0005wS-AX
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 22:47:16 -0400
Received: from smtp57.i.mail.ru ([217.69.128.37]:49388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jusual@mail.ru>) id 1jPzzH-0005tL-At
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 22:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version;
 bh=d9HMw6jHdz/EQE3BU+oMEsWKdsIFCXGsPtnejs7u49Y=; 
 b=XKwewYTfMGs4uA/pceG1dr7mnBhSUy1C8fiN2fz2HXLI1F7h6+WAcC0N7NdQLlnMrKD0CN333fzVi86Dq2n9w5qmDosLIGFUAgiWP+jsUch7WOvMZaPxCGNtQ0k2rqLuGj6jqf6QEdqn07OH7lGIIXucblAZX246T+iTErsYAic=;
Received: by smtp57.i.mail.ru with esmtpa (envelope-from <jusual@mail.ru>)
 id 1jPzzC-0004Co-Fe
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 05:47:10 +0300
Received: by mail-lj1-f177.google.com with SMTP id q22so6236460ljg.0
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 19:47:10 -0700 (PDT)
X-Gm-Message-State: AGi0PualeJyyOUdKTmmTF6wIbIKUJSo2OaiK0deewwSeNxUCEvWCwMjA
 OYBORfkGnWz87ISR1xkbHqbDMlJ/FqO3vaCpYLBhuA==
X-Google-Smtp-Source: APiQypK5UohU6SPgL1wkp3maL9ZM2MzM/H6skLfXDxUcGpPJqFIAK1iJ+iKVjYkTYRTaHDgWQH5mzF2yCkz6RL37aaQ=
X-Received: by 2002:a05:651c:515:: with SMTP id
 o21mr6291850ljp.91.1587264430014; 
 Sat, 18 Apr 2020 19:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200402065035.GA15477@simran-Inspiron-5558>
 <f0eec74a-387d-79ce-b23f-d7f16747f9ad@gmail.com>
In-Reply-To: <f0eec74a-387d-79ce-b23f-d7f16747f9ad@gmail.com>
From: Julia Suvorova <jusual@mail.ru>
Date: Sun, 19 Apr 2020 04:46:59 +0200
X-Gmail-Original-Message-ID: <CAMDeoFVipYBYCE_GTjytpXT_PvKt6xjTdtPyv=HyLYf4FkCDUQ@mail.gmail.com>
Message-ID: <CAMDeoFVipYBYCE_GTjytpXT_PvKt6xjTdtPyv=HyLYf4FkCDUQ@mail.gmail.com>
Subject: Re: [PATCH v2] lockable: Replace locks with lock guard macros
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Simran Singhal <singhalsimran0@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 rkagan@virtuozzo.com, Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: smtp57.i.mail.ru; auth=pass smtp.auth=jusual@mail.ru
 smtp.mailfrom=jusual@mail.ru
X-7564579A: 78E4E2B564C1792B
X-77F55803: 0A44E481635329DB0E1AA8A03B392317D32E5E48865217369133EF8E375211088EB211710A2F872DF688BCB05C26794DDACC537B7083D38DB5B1C2081BA68ADBBC90E9F57D15F35F44991F226FA649A4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F65C230EDDCD559EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637560334CFC131571A8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC5652AC20C12CBE68FCF726063EA1334428C18608FBBA3BF1389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C06030C3405640F6718941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C390D92131081DE748117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947CA2475C18617057EEBA3038C0950A5D36C8A9BA7A39EFB7668729DE7A884B61D1BA3038C0950A5D36D5E8D9A59859A8B634143DAF28A1E3E73AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C3A1C30C8AFC676C8B35872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DF33B08B2BB81206574AF45C6390F7469DAA53EE0834AAEE
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi1xwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSrDH5DzFnuN67JdENjvzQK2
X-Mailru-Sender: 4C235FE2E5D2D89006A073D5FD45C5B4F54DDE0A1ABD91FF6A15BCA84B42FB17976AF1CB91E6FA81342D7E53901C55FD6F53C80213D1719C4487B406A59785443329DBF425CF03A167EA787935ED9F1B
X-Mras: Ok
Received-SPF: pass client-ip=217.69.128.37; envelope-from=jusual@mail.ru;
 helo=smtp57.i.mail.ru
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 217.69.128.37
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Apr 18, 2020 at 2:03 PM Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> Hi Simran,
>
> On 4/2/20 9:50 AM, Simran Singhal wrote:
> > Replace manual lock()/unlock() calls with lock guard macros
> > (QEMU_LOCK_GUARD/WITH_QEMU_LOCK_GUARD).
> >
> > Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> > ---
> > Changes in v2:
> >          -Drop changes in file hw/rdma/rdma_utils.c
> >
> >   hw/hyperv/hyperv.c     | 15 ++++++-------
> >   hw/rdma/rdma_backend.c | 50 +++++++++++++++++++++---------------------
> >   hw/rdma/rdma_rm.c      |  3 +--
> >   3 files changed, 33 insertions(+), 35 deletions(-)
> >
> > diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> > index 8ca3706f5b..4ddafe1de1 100644
> > --- a/hw/hyperv/hyperv.c
> > +++ b/hw/hyperv/hyperv.c
> > @@ -15,6 +15,7 @@
> >   #include "sysemu/kvm.h"
> >   #include "qemu/bitops.h"
> >   #include "qemu/error-report.h"
> > +#include "qemu/lockable.h"
> >   #include "qemu/queue.h"
> >   #include "qemu/rcu.h"
> >   #include "qemu/rcu_queue.h"
> > @@ -491,7 +492,7 @@ int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
> >       int ret;
> >       MsgHandler *mh;
> >
> > -    qemu_mutex_lock(&handlers_mutex);
> > +    QEMU_LOCK_GUARD(&handlers_mutex);
>
> It does not passes compilation:
>      export ARCH=x86_64
>      make docker-image-fedora V=1 NETWORK=1
>      make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu NETWORK=1

This is a problem with the macros themselves, not with this patch.
This is fixed (concat '##' problem and warnings) in
  [PATCH v5 0/2] Replaced locks with lock guard macros
and the patch should be based on it.

Best regards, Julia Suvorova.

