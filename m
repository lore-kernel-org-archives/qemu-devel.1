Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC32C33CA8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660EA2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 09:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jyyH06up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660EA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqw2B-0003dw-H0
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 04:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iqw1W-00039d-Mq
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:28:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iqw1U-0002WY-RA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:28:38 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53783)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iqw1U-0002UK-Bh
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 04:28:36 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200113092834euoutp02040a7261c44e2ba6c2087e68259b9514~paDNxzwKP1799117991euoutp02c
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 09:28:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200113092834euoutp02040a7261c44e2ba6c2087e68259b9514~paDNxzwKP1799117991euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1578907714;
 bh=j7MtR4j9In5Q86E7Vo4lOCtWe8g2hggfIunIb5GVIH4=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=jyyH06upHz1bvBnwvlZvtfiIE00/2SVdVJNhw8HSHGFDxlCFPT4g3kxhqoKrfmRSm
 acpmrL/S3Nq3tbL3Jqu74loq9MeIP5sZOG9MAxV6REcD5hwQJCYM6NHFniYBiFgn16
 PBuGU0ZckGyHYY+Yz2fPkCjE8b5DYZPqr5XNkwl8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200113092834eucas1p204e492ce02bf1eec4af69826eae43e46~paDNl-t9e1296712967eucas1p2f;
 Mon, 13 Jan 2020 09:28:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id B1.AF.60679.2483C1E5; Mon, 13
 Jan 2020 09:28:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200113092834eucas1p1a81b40a623a8ee88aed8913f2d4f001e~paDNXh6L10581405814eucas1p1f;
 Mon, 13 Jan 2020 09:28:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200113092834eusmtrp12113be9b81ae1a2b24a83f184d7be40d~paDNW5jz70239002390eusmtrp10;
 Mon, 13 Jan 2020 09:28:34 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-3b-5e1c38420108
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id BB.49.07950.1483C1E5; Mon, 13
 Jan 2020 09:28:34 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200113092833eusmtip192d938772aaacd6139232d3eba0577e2~paDNOA9zK0581005810eusmtip1w;
 Mon, 13 Jan 2020 09:28:33 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (106.1.227.71) by
 CAMSVWEXC01.scsc.local (106.1.227.71) with Microsoft SMTP Server (TLS) id
 15.0.1320.4; Mon, 13 Jan 2020 09:28:33 +0000
Received: from apples.localdomain (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server (TLS) id 15.0.1320.4 via Frontend
 Transport; Mon, 13 Jan 2020 09:28:33 +0000
Date: Mon, 13 Jan 2020 10:28:31 +0100
From: Klaus Birkelund Jensen <k.jensen@samsung.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v4 20/24] nvme: add support for scatter gather lists
Message-ID: <20200113092831.jf7ojroc73fjbb6s@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <CADSWDzuFqk56Y1t_3P5m5Q-DsMaeVok+-+RxRqhuohdRSjRK2g@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeT1nZ2fS5PVo+KB+0IVmkZeyDwtFTIL2IUQJ+hCmTj3N4bxt
 ztQvjiA1b6khrkVhs5yIEM0LomEmtuV1ZmVmZRlaJGbh/RKah1fBb7////n/eZ4XXpbinok8
 WXVGDq/NUGpkjDPdYdscDYySe8eHtFs4eeudYiR/8XJNJK/pm0Dyx294+cOpY3LTYjEjt1d0
 0pFixWinQ6ywNt9mFJ8nnjOK2YlWJ8WfnvdMjOiqc3gKr1Hn8trgiETn1KXu0KzXIXkzo5wB
 NclKkYQFfBa27Ha6FDmzHG5CMLRhExGxgmDqlUMspDi8jGBtMPmg8aTkCyIhC4IZQwtFxF6o
 2j7iRIQVQe23tv26DcFct74UsSyN/aBqNkawGRwKC6UWSmB3HALLjnWx0KXwGoIx4zwSBm5Y
 AfMNjYzAUhwJjvEqirArDNybpQWW4FjYWNhkhDJgqxhaa3rE5NYLMGArogi7wby9bd/3hqG7
 5TQplCGo/LtKEWFEUNe4zginAg6DymGNUKCwGiocb0XEPg+1DglBF5j87UoSLlDTUUcRWwol
 RRzZ5A+dN9sRsb1hrsWHoAJ+LmZVIV/TobeYDm0ifArqu5cY016Dwl5g2WEJnoCnXcH1SNSM
 PHi9Ll3F685k8DeCdMp0nT5DFZScmW5Fex9paMe+0om6/iX1Icwi2RFpb4FXPCdS5ury0/sQ
 sJTMXWod9YznpCnK/AJem5mg1Wt4XR/yYmmZhzTU/Osah1XKHD6N57N47cHUiZV4GlBe7IMt
 SfTR9d7xucvrhebVBNyvyjW37m5PDwR+6Irw91MGSNSPjhuSB79up1yv9hpOzDXd39Qa/T9l
 q8/9iEP6QsNwgEoa1/4uJ3osLMoWnm0117W4JvVsX/LZchLlNfhqYHrDWN7/3b7kTV+8ohjp
 Lks2U2nG5l1Xy63JjzJal6o8fZLS6pT/Ac07SJREAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7pOFjJxBjMbGC0297czWuw/+I3V
 YtKha4wWSy6mWsy7pWwx6107m8Xx3h0sDuwe53acZ/fYtKqTzePOtT1sHk+ubWbyeL/vKlsA
 a5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexoz/
 39kKWvUqTn/4w9bA+E++i5GTQ0LARGJpx13GLkYuDiGBpYwSPbs/skMkZCQ+XYGxhSX+XOti
 gyj6yCix880xFghnE6PE9q/PmSCcY4wSc3ZPBXI4OFgEVCUmPAkA6WYTMJZ407WcGcQWETCQ
 +Hz+OztIPbPAN6D6yZ8YQRLCAh4SrxYvYwOxeQUcJM5fmgDWICTQziSxf44VRFxQ4uTMJywg
 NrOAjsSC3Z/YQHYxC0hLLP/HARLmFAiU+PHmJ9sERqFZSDpmIemYhdCxgJF5FaNIamlxbnpu
 sZFecWJucWleul5yfu4mRmBsbTv2c8sOxq53wYcYBTgYlXh4D1RJxwmxJpYVV+YeYpTgYFYS
 4d10TipOiDclsbIqtSg/vqg0J7X4EKMp0PsTmaVEk/OBcZ9XEm9oamhuYWlobmxubGahJM7b
 IXAwRkggPbEkNTs1tSC1CKaPiYNTqoHxss5etqs5DuIP+d0Udi6SWfiirM9URnfXvka+Zne2
 HwwhzSmG7H+aBD5N2XHTbqu+kOMc64r7c/Za7/29ZXlo69Wrm9bbVjO3dn1XcNkfs2/BGa6S
 8KTmnx/4eRqVs1uOfFk6eeKTuQeqr6hu21l206wg+OaONVOu1y++citB4qWUepPgpbz/SizF
 GYmGWsxFxYkAUnqFOsMCAAA=
X-CMS-MailID: 20200113092834eucas1p1a81b40a623a8ee88aed8913f2d4f001e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cc31a_"
X-RootMTR: 20191219130948eucas1p27bdef1318a097df34396a2a18b318064
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191219130948eucas1p27bdef1318a097df34396a2a18b318064
References: <CGME20191219130948eucas1p27bdef1318a097df34396a2a18b318064@eucas1p2.samsung.com>
 <20191219130921.309264-1-k.jensen@samsung.com>
 <20191219130921.309264-21-k.jensen@samsung.com>
 <CADSWDzuFqk56Y1t_3P5m5Q-DsMaeVok+-+RxRqhuohdRSjRK2g@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.118.77.12
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cc31a_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Jan  9 11:44, Beata Michalska wrote:
> Hi Klaus,
> 
> On Thu, 19 Dec 2019 at 13:09, Klaus Jensen <k.jensen@samsung.com> wrote:
> > @@ -73,7 +73,12 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
> >
> >  static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
> >  {
> > -    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
> > +    hwaddr hi = addr + size;
> > +    if (hi < addr) {
> 
> What is the actual use case for that ?

This was for detecting wrap around in the unsigned addition. I found
that nvme_map_sgl does not check if addr + size is out of bounds (which
it should). With that in place this check is belt and braces, so I might
remove it.

> > +static uint16_t nvme_map_sgl_data(NvmeCtrl *n, QEMUSGList *qsg,
> > +    QEMUIOVector *iov, NvmeSglDescriptor *segment, uint64_t nsgld,
> > +    uint32_t *len, bool is_cmb, NvmeRequest *req)
> > +{
> > +    dma_addr_t addr, trans_len;
> > +    uint16_t status;
> > +
> > +    for (int i = 0; i < nsgld; i++) {
> > +        if (NVME_SGL_TYPE(segment[i].type) != SGL_DESCR_TYPE_DATA_BLOCK) {
> > +            trace_nvme_dev_err_invalid_sgl_descriptor(nvme_cid(req),
> > +                NVME_SGL_TYPE(segment[i].type));
> > +            return NVME_SGL_DESCRIPTOR_TYPE_INVALID | NVME_DNR;
> > +        }
> > +
> > +        if (*len == 0) {
> > +            if (!NVME_CTRL_SGLS_EXCESS_LENGTH(n->id_ctrl.sgls)) {
> > +                trace_nvme_dev_err_invalid_sgl_excess_length(nvme_cid(req));
> > +                return NVME_DATA_SGL_LENGTH_INVALID | NVME_DNR;
> > +            }
> > +
> > +            break;
> > +        }
> > +
> > +        addr = le64_to_cpu(segment[i].addr);
> > +        trans_len = MIN(*len, le64_to_cpu(segment[i].len));
> > +
> > +        if (nvme_addr_is_cmb(n, addr)) {
> > +            /*
> > +             * All data and metadata, if any, associated with a particular
> > +             * command shall be located in either the CMB or host memory. Thus,
> > +             * if an address if found to be in the CMB and we have already
> 
> s/address if/address is ?

Fixed, thanks.

> > +static uint16_t nvme_map_sgl(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
> > +    NvmeSglDescriptor sgl, uint32_t len, NvmeRequest *req)
> > +{
> > +    const int MAX_NSGLD = 256;
> > +
> > +    NvmeSglDescriptor segment[MAX_NSGLD];
> > +    uint64_t nsgld;
> > +    uint16_t status;
> > +    bool is_cmb = false;
> > +    bool sgl_in_cmb = false;
> > +    hwaddr addr = le64_to_cpu(sgl.addr);
> > +
> > +    trace_nvme_dev_map_sgl(nvme_cid(req), NVME_SGL_TYPE(sgl.type), req->nlb, len);
> > +
> > +    if (nvme_addr_is_cmb(n, addr)) {
> > +        is_cmb = true;
> > +
> > +        qemu_iovec_init(iov, 1);
> > +    } else {
> > +        pci_dma_sglist_init(qsg, &n->parent_obj, 1);
> > +    }
> > +
> > +    /*
> > +     * If the entire transfer can be described with a single data block it can
> > +     * be mapped directly.
> > +     */
> > +    if (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_DATA_BLOCK) {
> > +        status = nvme_map_sgl_data(n, qsg, iov, &sgl, 1, &len, is_cmb, req);
> > +        if (status) {
> > +            goto unmap;
> > +        }
> > +
> > +        goto out;
> > +    }
> > +
> > +    /*
> > +     * If the segment is located in the CMB, the submission queue of the
> > +     * request must also reside there.
> > +     */
> > +    if (nvme_addr_is_cmb(n, addr)) {
> > +        if (!nvme_addr_is_cmb(n, req->sq->dma_addr)) {
> > +            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
> > +        }
> > +
> > +        sgl_in_cmb = true;
> 
> Why not combining this with the condition few lines above
> for the nvme_addr_is_cmb ? Also is the sgl_in_cmb really needed ?
> If the address is from CMB, that  implies the queue is also there,
> otherwise we wouldn't progress beyond this point. Isn't is_cmb sufficient ?
> 

You are right, there is no need for sgl_in_cmb.

But checking if the queue is in the cmb only needs to be done if the
descriptor in DPTR is *not* a "singleton" data block. But I think I can
refactor it to be slightly nicer, or at least be more specific in the
comments.

> > +    }
> > +
> > +    while (NVME_SGL_TYPE(sgl.type) == SGL_DESCR_TYPE_SEGMENT) {
> > +        bool addr_is_cmb;
> > +
> > +        nsgld = le64_to_cpu(sgl.len) / sizeof(NvmeSglDescriptor);
> > +
> > +        /* read the segment in chunks of 256 descriptors (4k) */
> > +        while (nsgld > MAX_NSGLD) {
> > +            if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
> > +                trace_nvme_dev_err_addr_read(addr);
> > +                status = NVME_DATA_TRANSFER_ERROR;
> > +                goto unmap;
> > +            }
> > +
> > +            status = nvme_map_sgl_data(n, qsg, iov, segment, MAX_NSGLD, &len,
> > +                is_cmb, req);
> 
> This will probably fail if there is a BitBucket Descriptor on the way (?)
> 

nvme_map_sgl_data will error out on any descriptors different from
"DATA_BLOCK". So I think we are good.

> > +    while (nsgld > MAX_NSGLD) {
> > +        if (nvme_addr_read(n, addr, segment, sizeof(segment))) {
> > +            trace_nvme_dev_err_addr_read(addr);
> > +            status = NVME_DATA_TRANSFER_ERROR;
> > +            goto unmap;
> > +        }
> > +
> > +        status = nvme_map_sgl_data(n, qsg, iov, segment, MAX_NSGLD, &len,
> > +            is_cmb, req);
> > +        if (status) {
> > +            goto unmap;
> > +        }
> > +
> > +        nsgld -= MAX_NSGLD;
> > +        addr += MAX_NSGLD * sizeof(NvmeSglDescriptor);
> > +    }
> > +
> 
> This seems to be the same as the while loop above. Why not making it common ?
> 

Yeah, this should probably be refactored.


Thanks again for your reviews!
Klaus

------wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cc31a_
Content-Type: text/plain; charset="utf-8"


------wuEC8jduJpGPgLKK9WIRscW_csS_daTJEwiPQviyXYkcG3WR=_1cc31a_--

