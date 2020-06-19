Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE9DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD432080C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gntZBWzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD432080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGgC-0008OQ-Te
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmGew-0006Gs-26
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:02:18 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmGer-0000U1-7d
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:02:17 -0400
Received: by mail-oi1-x243.google.com with SMTP id a137so8373755oii.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 06:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a4ZPCKWcd03mGNtA2A2LOtfqG3ks8ZHk2GPwtxYrW8M=;
 b=gntZBWzOzFDVKk5Zq5+NdIZXZHocKvHUkFc+gYoJIGEgXbCihLkxwQ0cXeEEh8JUw9
 UJKqI+XLKwalP3APxu3sa1ySOqxfxhKi5NuSvEhKvfSBcn2R8aSenWVmEa5gy5n67/jN
 NfJRVktPJcekd8nzXa0sfexY8qaIaS3VNDLlgPqvkMNghnKMD/jtylb/7Ohw3BgS25hf
 f1s5oZuPLOksfStxScxza2woDETjQv2e76tnnEWD/Nor7/rQafKb83JJ6yp4lvJrpIxq
 5SJds0W8wL5DMYwkn9zYSicjDBkoh7NzaAnIhtc07mZS+pU3qvLcvogj03cVcYP1LdE+
 OOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a4ZPCKWcd03mGNtA2A2LOtfqG3ks8ZHk2GPwtxYrW8M=;
 b=R/I4QDtQtl3kz1PKtVlmbiM7klTYVWwTZQbAD3wI1JJKgL5CdA/lzdfHbjiftPx/Sk
 5GnLu5eqYr2AsjREWMkRA2/5OgtWlAS79iHm0b2hpbNvaepj7KbnQ07i8pyJy204CS7i
 MnKrlXMCVOUOh7glQK++OGtYAp/kwMZB5HGcpp3o8Zt/G8NABdXmnwcfybM3a3dRpDIx
 BSl0nYMQFb/KnSwy5jhtYz25q0I8C9yI38su8P2npMQbr+HftbO80WcvGg0IPgPP9Ury
 sVBR0i8+4ec/Wb4WoOSnVQrXPQzAcgnFoyI0hXj7oQ65j8bHDUBNDwO54mqt+P5z5ZqT
 7sDg==
X-Gm-Message-State: AOAM532qgL//pKU3OkYF8gVaozQKfS5ifGOsJuO2o62pofPUEzeZDc4n
 z5BX6BMtqwdkbq1r05cYo0tls2RBlcetEB0pDLIONp4KAP8=
X-Google-Smtp-Source: ABdhPJxNRi0O4uNT5v63BFdrx4yH+QHoE01LM9h+DqV0ZBqF9PHWdFLOSzCkfSVaMuMZ7LMdIwUHOUL7iN8nWdgQI7s=
X-Received: by 2002:aca:5152:: with SMTP id f79mr2820396oib.146.1592571731826; 
 Fri, 19 Jun 2020 06:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200612141917.9446-1-mst@redhat.com>
 <20200612141917.9446-40-mst@redhat.com>
In-Reply-To: <20200612141917.9446-40-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 14:02:01 +0100
Message-ID: <CAFEAcA9aoOXR4L_0KHAvjodhoBtKF4g8vhOb9gntcdWDNxijDg@mail.gmail.com>
Subject: Re: [PULL v2 39/58] Transmit vhost-user memory regions individually
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Mike Cui <cui@nutanix.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jun 2020 at 15:52, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Raphael Norwitz <raphael.norwitz@nutanix.com>
>
> With this change, when the VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS
> protocol feature has been negotiated, Qemu no longer sends the backend
> all the memory regions in a single message. Rather, when the memory
> tables are set or updated, a series of VHOST_USER_ADD_MEM_REG and
> VHOST_USER_REM_MEM_REG messages are sent to transmit the regions to map
> and/or unmap instead of sending send all the regions in one fixed size
> VHOST_USER_SET_MEM_TABLE message.

Hi; Coverity reports some issues with this change, which are
basically the same as the issue I noted in my other email.

> +static int send_remove_regions(struct vhost_dev *dev,
> +                               struct scrub_regions *remove_reg,
> +                               int nr_rem_reg, VhostUserMsg *msg,
> +                               bool reply_supported)
> +{
> +    struct vhost_user *u = dev->opaque;
> +    struct vhost_memory_region *shadow_reg;
> +    int i, fd, shadow_reg_idx, ret;
> +    ram_addr_t offset;
> +    VhostUserMemoryRegion region_buffer;

Here region_buffer is uninitialized...

> +
> +    /*
> +     * The regions in remove_reg appear in the same order they do in the
> +     * shadow table. Therefore we can minimize memory copies by iterating
> +     * through remove_reg backwards.
> +     */
> +    for (i = nr_rem_reg - 1; i >= 0; i--) {
> +        shadow_reg = remove_reg[i].region;
> +        shadow_reg_idx = remove_reg[i].reg_idx;
> +
> +        vhost_user_get_mr_data(shadow_reg->userspace_addr, &offset, &fd);
> +
> +        if (fd > 0) {
> +            msg->hdr.request = VHOST_USER_REM_MEM_REG;
> +            vhost_user_fill_msg_region(&region_buffer, shadow_reg);

...we pass it to vhost_user_fill_msg_region(), but that function
only initializes 3 out of 4 of the struct's fields...

> +            msg->payload.mem_reg.region = region_buffer;

...so here we copy the uninitialized region_buffer.mmap_offset.
(CID 1429803)

I think in this case we are genuinely going to use uninitialized
data, unlike the other two places.

> +static int send_add_regions(struct vhost_dev *dev,
> +                            struct scrub_regions *add_reg, int nr_add_reg,
> +                            VhostUserMsg *msg, uint64_t *shadow_pcb,
> +                            bool reply_supported, bool track_ramblocks)
> +{
> +    struct vhost_user *u = dev->opaque;
> +    int i, fd, ret, reg_idx, reg_fd_idx;
> +    struct vhost_memory_region *reg;
> +    MemoryRegion *mr;
> +    ram_addr_t offset;
> +    VhostUserMsg msg_reply;
> +    VhostUserMemoryRegion region_buffer;

Similarly, here region_buffer is uninitialized...

> +
> +    for (i = 0; i < nr_add_reg; i++) {
> +        reg = add_reg[i].region;
> +        reg_idx = add_reg[i].reg_idx;
> +        reg_fd_idx = add_reg[i].fd_idx;
> +
> +        mr = vhost_user_get_mr_data(reg->userspace_addr, &offset, &fd);
> +
> +        if (fd > 0) {
> +            if (track_ramblocks) {
> +                trace_vhost_user_set_mem_table_withfd(reg_fd_idx, mr->name,
> +                                                      reg->memory_size,
> +                                                      reg->guest_phys_addr,
> +                                                      reg->userspace_addr,
> +                                                      offset);
> +                u->region_rb_offset[reg_idx] = offset;
> +                u->region_rb[reg_idx] = mr->ram_block;
> +            }
> +            msg->hdr.request = VHOST_USER_ADD_MEM_REG;
> +            vhost_user_fill_msg_region(&region_buffer, reg);
> +            msg->payload.mem_reg.region = region_buffer;

...so here we're copying across uninitialized data, which makes
Coverity unhappy (CID 1429802)...

> +            msg->payload.mem_reg.region.mmap_offset = offset;

...even if in this case we end up filling the value in afterwards.

As noted in my other email, I think the best fix for this is to
have vhost_user_fill_msg_region() take an extra mmap_offset
argument to fill in the mmap_offset itself. In this callsite in
send_add_regions() we would pass in 'offset' and delete the manual
assignment to .mmap_offset. I'm not sure about the call in
send_remove_regions() but I guess if the intention is that the
payload field is not relevant then passing in '0' would be right.

thanks
-- PMM

