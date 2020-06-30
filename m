Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21674C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 01:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D0120722
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 01:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOCK0Mx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D0120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq4lH-0004j9-8c
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 21:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jq4kh-00049a-LG; Mon, 29 Jun 2020 21:07:59 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:44900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jq4kf-0004Wy-Ts; Mon, 29 Jun 2020 21:07:59 -0400
Received: by mail-io1-xd43.google.com with SMTP id i4so19220603iov.11;
 Mon, 29 Jun 2020 18:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nun2uaMcMQvAStzkFVl0tUJwb5W1cvk9IIAHhRV9s6s=;
 b=DOCK0Mx3JfvVm6wXwjrNT/8QepqkE6Iul2UZIbBQGvrMb/2tzkAglbXokNZA2esXmN
 qvWSgX9kyCtr3cOvS9qSnt+4YVDxkFQFgib5ouyRZ4pG9mDJd2ODhc1IdhBZio3KRTHi
 H+zfL1mdO2zJ8jxFttA3HnbMp3eKH3iW2E0dSwXLd9IeL/8/qGMkZIyhA4R/HWiM7VGH
 2FrBkBuNYWTzExIREKcgS/MosT3nmh0UOq9futbi05iKVUoyqRHG67NRsSf6/c6+8pVe
 UJW9jLbHWzx0IHo92qOYMHYs4iJsCp5BpWUhdirSJf4wBNaFKe2XEUsFppo1gDaTM17U
 1PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nun2uaMcMQvAStzkFVl0tUJwb5W1cvk9IIAHhRV9s6s=;
 b=m6PPcpD6rS4SkShqX/Oyp5b+SFy6+tE4f1jJTA6SRtVv2iwU0pUYp10wTPmVCo6b5/
 +U7CFQYe4g+TYX0y/oQnxbYfTAEZqBuNz9eMXlC+Z9Cfdj83VvOinNu5Ap/nQPqrI6nz
 vGLb0vRqC8MLqaXgRDkXo5bmAj6QyB9Tgdc6bs2Bz9mo6DMpt987bX53BkXArvcvkYcP
 vmv1YoXbRMZKh1dFM4zerDq0nfxQPMXe+HikeLLef3+ZRkC9wg9T/hM0knmRcgiV+K3F
 ZcC9YDZ4Mks12jni8uMUMu8Ryhvye3wtC6y9MFGfUPZCL1oSXqeVujLYqVJHpVns7HPd
 rSkA==
X-Gm-Message-State: AOAM53382veotACaHkmbF1sGRcsF9cLJw2PoMCvWZwa6mHt4FLJ/pob7
 yGaTqYrUpYg3FVsGq28kx79HIWFxCI2fW5EX3Mo=
X-Google-Smtp-Source: ABdhPJzJIjj2D8/LQIU07uGsziPgblnGp4r7Y7JV+QEWybGdbkLh8zBl62w5PbB4ac9aRmzjJNw6cKXt5+SJgzvkfxY=
X-Received: by 2002:a5d:8407:: with SMTP id i7mr13058319ion.175.1593479276529; 
 Mon, 29 Jun 2020 18:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-3-dmitry.fomichev@wdc.com>
In-Reply-To: <20200617213415.22417-3-dmitry.fomichev@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2020 17:58:14 -0700
Message-ID: <CAKmqyKMAYqqDjGRxdg3-b=yZXyMiZaroYk2mkJ2p5KCEGUT9sA@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] hw/block/nvme: Define 64 bit cqe.result
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 2:44 PM Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:
>
> From: Ajay Joshi <ajay.joshi@wdc.com>
>
> A new write command, Zone Append, is added as a part of Zoned
> Namespace Command Set. Upon successful completion of this command,
> the controller returns the start LBA of the performed write operation
> in cqe.result field. Therefore, the maximum size of this variable
> needs to be changed from 32 to 64 bit, consuming the reserved 32 bit
> field that follows the result in CQE struct. Since the existing
> commands are expected to return a 32 bit LE value, two separate
> variables, result32 and result64, are now kept in a union.
>
> Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  block/nvme.c         | 2 +-
>  block/trace-events   | 2 +-
>  hw/block/nvme.c      | 6 +++---
>  include/block/nvme.h | 6 ++++--
>  4 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/block/nvme.c b/block/nvme.c
> index eb2f54dd9d..ca245ec574 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -287,7 +287,7 @@ static inline int nvme_translate_error(const NvmeCqe *c)
>  {
>      uint16_t status = (le16_to_cpu(c->status) >> 1) & 0xFF;
>      if (status) {
> -        trace_nvme_error(le32_to_cpu(c->result),
> +        trace_nvme_error(le64_to_cpu(c->result64),
>                           le16_to_cpu(c->sq_head),
>                           le16_to_cpu(c->sq_id),
>                           le16_to_cpu(c->cid),
> diff --git a/block/trace-events b/block/trace-events
> index 29dff8881c..05c1393943 100644
> --- a/block/trace-events
> +++ b/block/trace-events
> @@ -156,7 +156,7 @@ vxhs_get_creds(const char *cacert, const char *client_key, const char *client_ce
>  # nvme.c
>  nvme_kick(void *s, int queue) "s %p queue %d"
>  nvme_dma_flush_queue_wait(void *s) "s %p"
> -nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
> +nvme_error(uint64_t cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %ld sq_head %d sqid %d cid %d status 0x%x"
>  nvme_process_completion(void *s, int index, int inflight) "s %p queue %d inflight %d"
>  nvme_process_completion_queue_busy(void *s, int index) "s %p queue %d"
>  nvme_complete_command(void *s, int index, int cid) "s %p queue %d cid %d"
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 3ed9f3d321..a1bbc9acde 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -823,7 +823,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
>
> -    req->cqe.result = result;
> +    req->cqe.result32 = result;
>      return NVME_SUCCESS;
>  }
>
> @@ -859,8 +859,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>                                      ((dw11 >> 16) & 0xFFFF) + 1,
>                                      n->params.max_ioqpairs,
>                                      n->params.max_ioqpairs);
> -        req->cqe.result = cpu_to_le32((n->params.max_ioqpairs - 1) |
> -                                      ((n->params.max_ioqpairs - 1) << 16));
> +        req->cqe.result32 = cpu_to_le32((n->params.max_ioqpairs - 1) |
> +                                        ((n->params.max_ioqpairs - 1) << 16));
>          break;
>      case NVME_TIMESTAMP:
>          return nvme_set_feature_timestamp(n, cmd);
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 1720ee1d51..9c3a04dcd7 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -577,8 +577,10 @@ typedef struct NvmeAerResult {
>  } NvmeAerResult;
>
>  typedef struct NvmeCqe {
> -    uint32_t    result;
> -    uint32_t    rsvd;
> +    union {
> +        uint64_t     result64;
> +        uint32_t     result32;
> +    };
>      uint16_t    sq_head;
>      uint16_t    sq_id;
>      uint16_t    cid;
> --
> 2.21.0
>
>

