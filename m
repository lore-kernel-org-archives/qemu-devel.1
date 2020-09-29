Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD32C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625D1206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 13:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tGE2JdV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625D1206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNFSX-00081o-4d
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 09:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNFPe-0005bh-PM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:11:22 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNFPY-0005MI-1t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 09:11:22 -0400
Received: by mail-ej1-x641.google.com with SMTP id dd13so2190131ejb.5
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dx1mpqyCOs9x0lMYsS2iP7NJwewXov4FO+WfX5qjdJg=;
 b=tGE2JdV8y5Pue4Rvbv08AdCMzfdXC1947FiUwlpijZbp5MfzA+dZKYcChpbehxaU22
 QqiLmOLpMRjft9sOCgZj5HsDjmi0fsoFPOfDnXQgl0v1Jzi9nNzYiRDoM0Ah4SNw8qLD
 GRWXB7neGfXItHVrfe/R+/ZLF2Uc8QQUuSpkWASpIWuR8BVkUv8Po8gm9PL28iVFEdHM
 O+Hjv/n4qU35ESgRTojkOGuPAibU+/jqa+TykTEik1fRYKo38vgx9sx5w4tUlP8Hmk6a
 mMeB8oaYEITSBBWxjf/mZ873a+ou4zkJoLL7Er6Qg67gVxMR42OEiZtLRBRG6Dh3lLIt
 6TQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dx1mpqyCOs9x0lMYsS2iP7NJwewXov4FO+WfX5qjdJg=;
 b=BZvbpuLee2JAjnCLe2B4DsnvrnnoGMhyyHq3XLCLQ5GsXdCjag5bKlLMQpJmC84Sc3
 RcL1LCMlr7PpA8cdKgWEfOzCBxbyTIvU8nOA6KnYID+hFSJ3XPcDf+COrDMyIZyFNFQ2
 smd716I1qtynBHIL2couzLAXYWtzsHs4h+nWm5ByYEAfdo9h2xDfsIQ3WCZzxOUiMGdU
 GZSjMRgd4VcWykMVPnPEAYEUApIBP8jh7eRcm1NJYCB1zE8ZQigNuLXoVNjE9fFTdicy
 LaINCGnhPykjU9xVBsm6tM0v6nusSPOTdkwa/gmdlGJS0rtLiLXcWu3E0I0ewPCyHh3l
 UqtQ==
X-Gm-Message-State: AOAM531LZcWO16CVPWnN/l0+iE2MC0zRws5MB2DL5q9zxWInzBoR6pvj
 BZs56zf03sfwE6ZVRmS2IX9f25PNZF0YLnOZdSylkw==
X-Google-Smtp-Source: ABdhPJxO4u6X82azA5BzOKBoqjgklWSwMXAKiqo++3Pdob9FHxWSt5L6zTqA56jZFnlIeijAdOljIw9zPDd/DGS/co0=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr3665273ejb.85.1601385074356; 
 Tue, 29 Sep 2020 06:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-8-its@irrelevant.dk>
In-Reply-To: <20200706061303.246057-8-its@irrelevant.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 14:11:03 +0100
Message-ID: <CAFEAcA8dqNBm1YqLPjoJ=79K=6z=SxYHvcvnZiY3MJMvv1n1BQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] hw/block/nvme: add support for the get log page
 command
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jul 2020 at 07:15, Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Add support for the Get Log Page command and basic implementations of
> the mandatory Error Information, SMART / Health Information and Firmware
> Slot Information log pages.
>
> In violation of the specification, the SMART / Health Information log
> page does not persist information over the lifetime of the controller
> because the device has no place to store such persistent state.
>
> Note that the LPA field in the Identify Controller data structure
> intentionally has bit 0 cleared because there is no namespace specific
> information in the SMART / Health information log page.
>
> Required for compliance with NVMe revision 1.3d. See NVM Express 1.3d,
> Section 5.14 ("Get Log Page command").

Hi; Coverity reports a potential issue in this code
(CID 1432413):

> +static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> +                                uint64_t off, NvmeRequest *req)
> +{
> +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> +    uint32_t nsid = le32_to_cpu(cmd->nsid);
> +
> +    uint32_t trans_len;
> +    time_t current_ms;
> +    uint64_t units_read = 0, units_written = 0;
> +    uint64_t read_commands = 0, write_commands = 0;
> +    NvmeSmartLog smart;
> +    BlockAcctStats *s;
> +
> +    if (nsid && nsid != 0xffffffff) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    s = blk_get_stats(n->conf.blk);
> +
> +    units_read = s->nr_bytes[BLOCK_ACCT_READ] >> BDRV_SECTOR_BITS;
> +    units_written = s->nr_bytes[BLOCK_ACCT_WRITE] >> BDRV_SECTOR_BITS;
> +    read_commands = s->nr_ops[BLOCK_ACCT_READ];
> +    write_commands = s->nr_ops[BLOCK_ACCT_WRITE];
> +
> +    if (off > sizeof(smart)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }

Here we check for off > sizeof(smart), which means that we allow
off == sizeof(smart)...

> +
> +    trans_len = MIN(sizeof(smart) - off, buf_len);

> +    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
> +                             prp2);

...in which case the pointer we pass to nvme_dma_read_prp() will
be off the end of the 'smart' object.

Now we are passing 0 as the trans_len, so I *think* this function
will not actually read the buffer (Coverity is not smart
enough to see this); so I could just close the Coverity issue as
a false-positive. But maybe there is a clearer-to-humans as well
as clearer-to-Coverity way to write this. What do you think ?

> +static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
> +                                 uint64_t off, NvmeRequest *req)
> +{
> +    uint32_t trans_len;
> +    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
> +    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
> +    NvmeFwSlotInfoLog fw_log = {
> +        .afi = 0x1,
> +    };
> +
> +    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
> +
> +    if (off > sizeof(fw_log)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
> +    trans_len = MIN(sizeof(fw_log) - off, buf_len);
> +
> +    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
> +                             prp2);

Coverity warns about the same structure here (CID 1432411).

thanks
-- PMM

