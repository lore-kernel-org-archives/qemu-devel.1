Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62034C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE0520740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1eJNpA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE0520740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEvp-0007G3-B6
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iZEtg-00068m-P4
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iZEte-0005Ac-Qb
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:59:24 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:45481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iZEte-0005AC-Lf
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:59:22 -0500
Received: by mail-io1-xd43.google.com with SMTP id i11so5393910ioi.12
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 05:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P0AMPLvtMfcdWzpcPeC2TXAksX6PF12yufW6/akfvdM=;
 b=n1eJNpA9U2Byx1QJp1PICHJun2dLhZrJ7OFot58Od8OuxvekBvbQRwhoC4UZNMZAD4
 jc6fjfMOyJJt16qwxwwJwvBwDnf0aGdwHL39xnubl2u+txECRjGiuOG0el81z/Gorsoe
 8UmkfgUrRpPYMGqxSAxKUw1fNqbhu6qsIlpHddiZ/IzFS4bXR/GXpmZYIdjlS9pjIdwG
 Wf62FXgrmJLE544S94/xnMB3fxJNBNeE0HWnGC2ah8HKKucsfpIw6BfKO1KxVWVxsusx
 9peax1C1AgR+W1aQVjP7sfwzebN0WyGjG5i7Xn3KMYt1/A3trQP9xpsdCNvYUPuf4jBY
 xFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P0AMPLvtMfcdWzpcPeC2TXAksX6PF12yufW6/akfvdM=;
 b=ZnKK2i28a/R87hVTtDL8E8bOlPM5zYYJ/7Pi3NmsLg5UTA9d3em9055jOyQ+I8FbVe
 CUTQhrPjkpBiKInWlvdDUSIWTXu5gXEVUvFzTJztQES2DCgfliMzUlEo5HiNBrmJJeRF
 1YaDN8nWHJRmRm73fP+btnfJfA9XRXp85T5pvn6lT/ZOJ/LUtDQqu7W/M0RWE1wRZVbZ
 sLA0f7yvq2vAkThV1mhB1azhH0dnpk8/6BMbQIqk3cGrSpBHjcbjQJv/ZFkvO8oLNR2t
 HeKjYYlv9Zp+bG949F73teuskGHB5u/u6LveWdCPDXMW9FFPcvb9kZL6LPWFSMU3vyke
 Qsog==
X-Gm-Message-State: APjAAAVqBJDUV1FttC2q3IJcTFmlxlM2qn09W1UV7jyhcJbVUlXt9v1n
 mPnXFLFF8dBd0kKZDW41h3Y0NGfaZ1XLFiZgQzyg6A==
X-Google-Smtp-Source: APXvYqzhpFzVwtzm0DmShcsv98JOv7EXHJb7RwcOgBSe4Zl0VG3Mdp6sDqEpQJF7cfc64i6jr9P9yfjVrcJSuxDjwdI=
X-Received: by 2002:a02:880c:: with SMTP id r12mr27571528jai.100.1574690360667; 
 Mon, 25 Nov 2019 05:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-15-its@irrelevant.dk>
 <CADSWDzvEdK1MXXNeF6bFiyC0UDY-wTp7_ZdeV-i_Ys5YdGoyqg@mail.gmail.com>
 <20191121115751.GB1211716@apples.localdomain>
In-Reply-To: <20191121115751.GB1211716@apples.localdomain>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Mon, 25 Nov 2019 13:59:09 +0000
Message-ID: <CADSWDzthZt-tH=oKZuXO=SisXOe67pUwnZZCqWhK8syuS0F-EQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/20] nvme: allow multiple aios per command
To: Klaus Birkelund <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 at 11:57, Klaus Birkelund <its@irrelevant.dk> wrote:
>
> On Tue, Nov 12, 2019 at 03:25:06PM +0000, Beata Michalska wrote:
> > Hi Klaus,
> >
> > On Tue, 15 Oct 2019 at 11:55, Klaus Jensen <its@irrelevant.dk> wrote:
> > > @@ -341,19 +344,18 @@ static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > Any reason why the nvme_dma_write_prp is missing the changes applied
> > to nvme_dma_read_prp ?
> >
>
> This was adressed by proxy through changes to the previous patch
> (by combining the read/write functions).
>
> > > +    case NVME_AIO_OPC_WRITE_ZEROES:
> > > +        block_acct_start(stats, acct, aio->iov.size, BLOCK_ACCT_WRITE);
> > > +        aio->aiocb = blk_aio_pwrite_zeroes(aio->blk, aio->offset,
> > > +            aio->iov.size, BDRV_REQ_MAY_UNMAP, nvme_aio_cb, aio);
> > Minor: aio->blk  => blk
> >
>
> Thanks. Fixed this in a couple of other places as well.
>
> > > @@ -621,8 +880,11 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
> > >      sq = n->sq[qid];
> > >      while (!QTAILQ_EMPTY(&sq->out_req_list)) {
> > >          req = QTAILQ_FIRST(&sq->out_req_list);
> > > -        assert(req->aiocb);
> > > -        blk_aio_cancel(req->aiocb);
> > > +        while (!QTAILQ_EMPTY(&req->aio_tailq)) {
> > > +            aio = QTAILQ_FIRST(&req->aio_tailq);
> > > +            assert(aio->aiocb);
> > > +            blk_aio_cancel(aio->aiocb);
> > What about releasing memory associated with given aio ?
>
> I believe the callback is still called when cancelled? That should take
> care of it. Or have I misunderstood that? At least for the DMAAIOCBs it
> is.
>
It seems that the completion callback is supposed to be called.
My bad.

BR
Beata
> > > +struct NvmeAIO {
> > > +    NvmeRequest *req;
> > > +
> > > +    NvmeAIOOp       opc;
> > > +    int64_t         offset;
> > > +    BlockBackend    *blk;
> > > +    BlockAIOCB      *aiocb;
> > > +    BlockAcctCookie acct;
> > > +
> > > +    NvmeAIOCompletionFunc *cb;
> > > +    void                  *cb_arg;
> > > +
> > > +    QEMUSGList   *qsg;
> > > +    QEMUIOVector iov;
> >
> > There is a bit of inconsistency on the ownership of IOVs and SGLs.
> > SGLs now seem to be owned by request whereas IOVs by the aio.
> > WOuld be good to have that unified or documented at least.
> >
>
> Fixed this. The NvmeAIO only holds pointers now.
>
> > > +#define NVME_REQ_TRANSFER_DMA  0x1
> > This one does not seem to be used ....
> >
>
> I have dropped the flags and reverted to a simple req->is_cmb as that is
> all that is really needed.
>

