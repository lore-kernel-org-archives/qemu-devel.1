Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE26BC43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 15:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22E220675
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 15:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWdUnqa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22E220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hehhq-0006Ro-Ot
	for qemu-devel@archiver.kernel.org; Sat, 22 Jun 2019 11:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35059)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hehev-0005N3-OT
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hehes-0005bL-KT
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:10:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hehep-0005No-Tf; Sat, 22 Jun 2019 11:10:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id h19so11059582wme.0;
 Sat, 22 Jun 2019 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ND/OsQPN7u2KNGhtkciq7m7WDTyA+2D2PkEjrRmSADU=;
 b=OWdUnqa1VKU/Ftan1ZjHrpYfZm5n9WIkvOxsRKXyrjkP7R287GJ2fW0sgh28YQaQi3
 HsCSCZ1KCC+NEIFHbDxrcpL3Xdn6QXwWpfdOCN83je87zCGKKcbFbj0Q903Hn/ZOgUcg
 NTFD4+xM2G7nSdvJE1BJCAVQM9acQUtb20iv6R2XBfMpx8KI21KPNszn6jYe1rZi17te
 y43t1kCjek3xwfDhSWUbo68iGZ3sICHjqknPkeS6J3QnJf8KZv7mBY28pl60BF5DoCUQ
 7rTes26gbiq237Mrx5owM/u2salsJ+ELV5e0CodpWdHcp+uBR67EFjm2VTyNs1tR+li5
 MNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ND/OsQPN7u2KNGhtkciq7m7WDTyA+2D2PkEjrRmSADU=;
 b=U+SzvhQQ0duyUkgVmnOH0bYcO61nXcutvX0QfSSBDMMoS5SfvAb1z9e7TWHbgNQdhZ
 ODT7VLZSPFNKDf5YWxXWsyf5sDrybAGGPyrnXEeMHM0ZUVN54H7yhUxjx+WHzd23a0Gv
 2YElRZJHUuHw2D5uAEg+3FRG2Zs/b0TspEoPIW/KgR7/+8XT0d7xk1xXgCjj2O7nlnus
 IRrXhavekqXUIQr2LKCo3fUaB6Oc6rjgPax4icJPYTSKqBjuXiM80B9ORHr9E3hDGWCv
 UIHOgEtNXEzJS3ZypfWiSl7h1/6020R4edFt5LmHTfZxjqbt7yWAocxtpv7E1JXfV8WE
 P3vA==
X-Gm-Message-State: APjAAAVn8NgZxHrTB9cxpNNFEvoMNUxxff+1SjbPFkc4/2S2zjXsleey
 Zc9kohEHko+pPPc3ey5t7xmUWVm0MymKic6KRSo=
X-Google-Smtp-Source: APXvYqxnssGuHnkYyk0wzN3jN/nGnwCz+l/GFjy8I/csoxkx23XEJJBpoAr7gs6X2edPwofkA10c+A828Lcmv/kdQ8o=
X-Received: by 2002:a7b:c7d7:: with SMTP id z23mr8688335wmk.46.1561216218596; 
 Sat, 22 Jun 2019 08:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-5-mehta.aaru20@gmail.com>
 <81e4ab9b07d5678a3a28e1314c07ee0224e4d9ed.camel@redhat.com>
In-Reply-To: <81e4ab9b07d5678a3a28e1314c07ee0224e4d9ed.camel@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 22 Jun 2019 16:10:07 +0100
Message-ID: <CAJSP0QVXFF+OPJpw8QpNkPfOnEoYbDKawtx4gG-nfZqRaveMhA@mail.gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 04/12] block/io_uring:
 implements interfaces for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, saket.sinha89@gmail.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 1:27 PM Maxim Levitsky <mlevitsk@redhat.com> wrote:
> On Mon, 2019-06-10 at 19:18 +0530, Aarushi Mehta wrote:
> > +        if (!cqes) {
> > +            break;
> > +        }
> > +        LuringAIOCB *luringcb = io_uring_cqe_get_data(cqes);
> > +        ret = cqes->res;
> > +
> > +        if (ret == luringcb->qiov->size) {
> > +            ret = 0;
> > +        } else if (ret >= 0) {
>
>
> You should very carefully check the allowed return values here.
>
> It looks like you can get '-EINTR' here, which would ask you to rerun the read operation, and otherwise
> you will get the number of bytes read, which might be less that what was asked for, which implies that you
> need to retry the read operation with the remainder of the buffer rather that zero the end of the buffer IMHO
>
> (0 is returned on EOF according to 'read' semantics, which I think are used here, thus a short read might not be an EOF)
>
>
> Looking at linux-aio.c though I do see that it just passes through the returned value with no special treatments.
> including lack of check for -EINTR.
>
> I assume that since aio is linux specific, and it only supports direct IO, it happens
> to have assumption of no short reads/-EINTR (but since libaio has very sparse documentation I can't verify this)
>
> On the other hand the aio=threads implementation actually does everything as specified on the 'write' manpage,
> retrying the reads on -EINTR, and doing additional reads if less that required number of bytes were read.
>
> Looking at io_uring implementation in the kernel I see that it does support synchronous (non O_DIRECT mode),
> and in this case, it goes through the same ->read_iter which is pretty much the same path that
> regular read() takes and so it might return short reads and or -EINTR.

Thanks, Maxim.  I've confirmed that -EINTR needs to be handled based
on fs/io_uring.c.  We need to get a new sqe (since the old one is no
longer usable) and submit the request again.  There are no ordering
guarantees between pending requests so doing this is permissible.

Stefan

