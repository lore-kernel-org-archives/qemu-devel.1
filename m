Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7CCC432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCAA2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMD11Yof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCAA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFKm-0008PM-RM
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iZFG6-00035k-Vf
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iZF4j-0001l3-T0
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:10:52 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:41294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iZF4j-0001kh-Lq
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:10:49 -0500
Received: by mail-il1-x143.google.com with SMTP id q15so14281134ils.8
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RfqqattjyhfbSeXgSKRldKmC5CVOARy4jdq9VLTs92M=;
 b=TMD11YofeyDdNOdFyh8x9UC/mNAE+BrKhXhhHdWd+tHn+t7vBevqQc01Zkek9ubKcm
 jyJzRVTTctDNFBVCNYHcpLsbT5oGbylV8OUMltiyq5qyUvI1b/XJF8NdoT+jdF2qfGY+
 qKl2RqoGd4RAkvgIgt1i3UFZgPe5Yse/FeOVw8EFXlG35RZSFxOluQCp2Ardb8O4RVOE
 /UFE35BR88YQR7uHsGJ6kCyc++50qsgy/gNsJBlZiwqz7rZcTNq/LHXObG5uM6HeDILv
 jkwrfNY0Ir40ne3H1wnKENKlTuitSfY9cYu6CaeNLU+RoJpA2AWFWJvVWyaafWs7/F/n
 iu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RfqqattjyhfbSeXgSKRldKmC5CVOARy4jdq9VLTs92M=;
 b=duliBNhq2kDElXgronyXb0eo5ka/PuW8yOG2Gv6ykrJ4YhDU75pR0OXH8uJx0jXXOu
 Xyp8PIzLjscXKtdxnRMzFDEvu8XAWncS1m4pk+WImjR5L2V8n3iJWVVTpmocZ618ridc
 GDIHvFa2hlwrZoiSjOJdcaz22+F9PIiSJ7rOKEZW39kQMBvHtO3D0b2G/E8fqEQt7qdr
 9qc2klJBPqFPZutRbILhDSmde0+rZog+Lcp6mgxeVDvUQrROGfENwloN24ndpWVZSX5g
 etL5IWS9c6lcpNvtd8J+fSgVha7j1ABkigxGr9UkIA7K5spUCDUgE+wVTP5UURGC6mmg
 0/YA==
X-Gm-Message-State: APjAAAXo89vqj4tUayRj3dA6zFvyqvGXHpPDm6IBQZKQ/YiL9KkyJo94
 H8AGBYNkTsniyVeHB+mOhwsK+1iEDX8KDLn9MnHDKA==
X-Google-Smtp-Source: APXvYqxBQbnnXL4f7WK1eXiMDCWFUDXFN/x5I0guC6sYX8EHrCBuyHSppGhJ8MMgyp1MjETEXjYNM/JvZinkbx9naMw=
X-Received: by 2002:a92:ad0f:: with SMTP id w15mr11946002ilh.307.1574691048359; 
 Mon, 25 Nov 2019 06:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-16-its@irrelevant.dk>
 <CADSWDzupax=4s4=wb6NOR-imKNc_SkfBf1aDWdS_eN8oynJj6A@mail.gmail.com>
 <20191125062122.GA21341@apples.localdomain>
In-Reply-To: <20191125062122.GA21341@apples.localdomain>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Mon, 25 Nov 2019 14:10:37 +0000
Message-ID: <CADSWDzv3h+VcF9kVDRu2M=9E0Q51k9DRyxNhAxX0JwWNdKazMQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/20] nvme: add support for scatter gather lists
To: Klaus Birkelund <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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

On Mon, 25 Nov 2019 at 06:21, Klaus Birkelund <its@irrelevant.dk> wrote:
>
> On Tue, Nov 12, 2019 at 03:25:18PM +0000, Beata Michalska wrote:
> > Hi Klaus,
> >
> > On Tue, 15 Oct 2019 at 11:57, Klaus Jensen <its@irrelevant.dk> wrote:
> > > +static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg,
> > > +    NvmeSglDescriptor sgl, uint32_t len, NvmeRequest *req)
> > > +{
> > > +    const int MAX_NSGLD = 256;
> > > +
> > > +    NvmeSglDescriptor segment[MAX_NSGLD];
> > > +    uint64_t nsgld;
> > > +    uint16_t status;
> > > +    bool sgl_in_cmb = false;
> > > +    hwaddr addr = le64_to_cpu(sgl.addr);
> > > +
> > > +    trace_nvme_map_sgl(req->cid, NVME_SGL_TYPE(sgl.type), req->nlb, len);
> > > +
> > > +    pci_dma_sglist_init(qsg, &n->parent_obj, 1);
> > > +
> > > +    /*
> > > +     * If the entire transfer can be described with a single data block it can
> > > +     * be mapped directly.
> > > +     */
> > > +    if (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_DATA_BLOCK) {
> > > +        status = nvme_map_sgl_data(n, qsg, &sgl, 1, &len, req);
> > > +        if (status) {
> > > +            goto unmap;
> > > +        }
> > > +
> > > +        goto out;
> > > +    }
> > > +
> > > +    /*
> > > +     * If the segment is located in the CMB, the submission queue of the
> > > +     * request must also reside there.
> > > +     */
> > > +    if (nvme_addr_is_cmb(n, addr)) {
> > > +        if (!nvme_addr_is_cmb(n, req->sq->dma_addr)) {
> > > +            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > > +        }
> > > +
> > > +        sgl_in_cmb = true;
> > > +    }
> > > +
> > > +    while (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_SEGMENT) {
> > > +        bool addr_is_cmb;
> > > +
> > > +        nsgld = le64_to_cpu(sgl.len) / sizeof(NvmeSglDescriptor);
> > > +
> > > +        /* read the segment in chunks of 256 descriptors (4k) */
> > > +        while (nsgld > MAX_NSGLD) {
> > > +            nvme_addr_read(n, addr, segment, sizeof(segment));
> > Is there any chance this will go outside the CMB?
> >
>
> Yes, there certainly was a chance of that. This has been fixed in a
> general way for both nvme_map_sgl and nvme_map_sgl_data.
>
> > > +
> > > +            status = nvme_map_sgl_data(n, qsg, segment, MAX_NSGLD, &len, req);
> > > +            if (status) {
> > > +                goto unmap;
> > > +            }
> > > +
> > > +            nsgld -= MAX_NSGLD;
> > > +            addr += MAX_NSGLD * sizeof(NvmeSglDescriptor);
> > > +        }
> > > +
> > > +        nvme_addr_read(n, addr, segment, nsgld * sizeof(NvmeSglDescriptor));
> > > +
> > > +        sgl = segment[nsgld - 1];
> > > +        addr = le64_to_cpu(sgl.addr);
> > > +
> > > +        /* an SGL is allowed to end with a Data Block in a regular Segment */
> > > +        if (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_DATA_BLOCK) {
> > > +            status = nvme_map_sgl_data(n, qsg, segment, nsgld, &len, req);
> > > +            if (status) {
> > > +                goto unmap;
> > > +            }
> > > +
> > > +            goto out;
> > > +        }
> > > +
> > > +        /* do not map last descriptor */
> > > +        status = nvme_map_sgl_data(n, qsg, segment, nsgld - 1, &len, req);
> > > +        if (status) {
> > > +            goto unmap;
> > > +        }
> > > +
> > > +        /*
> > > +         * If the next segment is in the CMB, make sure that the sgl was
> > > +         * already located there.
> > > +         */
> > > +        addr_is_cmb = nvme_addr_is_cmb(n, addr);
> > > +        if ((sgl_in_cmb && !addr_is_cmb) || (!sgl_in_cmb && addr_is_cmb)) {
> > > +            status = NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > > +            goto unmap;
> > > +        }
> > > +    }
> > > +
> > > +    /*
> > > +     * If the segment did not end with a Data Block or a Segment descriptor, it
> > > +     * must be a Last Segment descriptor.
> > > +     */
> > > +    if (NVME_SGL_TYPE(sgl.type) != SGL_DESCR_TYPE_LAST_SEGMENT) {
> > > +        trace_nvme_err_invalid_sgl_descriptor(req->cid,
> > > +            NVME_SGL_TYPE(sgl.type));
> > > +        return NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
> > Shouldn't we handle a case here that requires calling unmap ?
>
> Woops. Fixed.
>
> > > +static uint16_t nvme_dma_read_sgl(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
> > > +    NvmeSglDescriptor sgl, NvmeCmd *cmd, NvmeRequest *req)
> > > +{
> > > +    QEMUSGList qsg;
> > > +    uint16_t err = NVME_SUCCESS;
> > > +
> > Very minor: Mixing convention: status vs error
> >
>
> Fixed by proxy in another refactor.
>
> > >
> > > +#define NVME_CMD_FLAGS_FUSE(flags) (flags & 0x3)
> > > +#define NVME_CMD_FLAGS_PSDT(flags) ((flags >> 6) & 0x3)
> > Minor: This one is slightly misleading - as per the naming and it's usage:
> > the PSDT is a field name and as such does not imply using SGLs
> > and it is being used to verify if given command is actually using
> > SGLs.
> >
>
> Ah, is this because I do
>
>   if (NVME_CMD_FLAGS_PSDT(cmd->flags)) {
>
> in the code? That is, just checks for it not being zero? The value of
> the PRP or SGL for Data Transfer (PSDT) field *does* specify if the
> command uses SGLs or not. 0x0: PRPs, 0x1 SGL for data, 0x10: SGLs for
> both data and metadata. Would you prefer the condition was more
> explicit?
>
Yeah, it is just not obvious( at least to me)  without referencing the spec
that non-zero value implies SGL usage. Guess a comment would be helpful
but that is not major.

Thanks,

BR
Beata
>
> Thanks!
> Klaus

