Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F093721582
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiQrLe46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F093721582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSZVZ-0004GB-QR
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 01:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSZTl-0003JK-R2; Wed, 14 Oct 2020 01:37:37 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:33189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSZTj-0008CG-9N; Wed, 14 Oct 2020 01:37:37 -0400
Received: by mail-yb1-xb42.google.com with SMTP id c3so1683356ybl.0;
 Tue, 13 Oct 2020 22:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XYDAjCI45fqxxjzCvT4OvrOZ8AvkuvssIrevL5fp27c=;
 b=ZiQrLe46QxkTWJ+pa8doY6Q6bEASYe6xSchOw+MnvkJfMfs7lYIZvW3Qb6gChWNCok
 CUqfIA22lEC5e3yBCu5FhuPF9Q30afPL+8n6EpLdAJHRa9Ct3RvI5+QDPG67+oMpo/Zk
 R1qNnw9ErEVlxkvuFg80zuoMD64Qt+2THBkWRzFhcDTTVJ48uNZfm/dp9uzwYAIZ14/v
 fjCXS1arEwo88KVXTjDm6UhE5LCi0kpDDqpu/YTLQOeBMf9iVLO4sGpt4fiCbak3rRxY
 OdcNc6lB8W42219ESM+wni36dYKNzKj4kFWCLWyfPJlbqXL1rIxbVzIXQVlqHh0IwtLf
 aupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XYDAjCI45fqxxjzCvT4OvrOZ8AvkuvssIrevL5fp27c=;
 b=rDt3D6zSpBvKYvN0ZV5XGz6U55+X4oJ0jyxEHpXKVdAsKCx5AvIfb657K0EsJ6B19O
 AlzekXflHaI/019dekUfsOqQxP4g8NIXytMTHE30yFHwrwpCvQ9MXWqxVMcPEm3jy1mq
 BuFPcjpLjDXuo9Tj5lOYiNKnhVwtPOVMXSlCdwW0CoQVlKgI7MDrN/i/Ze49FAXPSJ8J
 bhHrSXPwrvE/R36evof7Euq5ny4kEL15UVZZ38OTKg9ZX/KpSN3olCCS3TxoBSGpWu7z
 mO/uij7INI353FYT4j8TtAnA+G+b3zzkkHuhgZA4hQiMKLJYbn7BztnmzI+cZidYRQMW
 km2A==
X-Gm-Message-State: AOAM530p4kt9BkXOfJIx2p2poOqat/8b+bFYYxo4wR6Enf8fhWQT+NwF
 iC0eky3DyWeZMB3TZomahpCi7jVoOTmMGlDc6CM=
X-Google-Smtp-Source: ABdhPJxlh//mCh3TS18wZjry2iE471CUAT0ITxWmeV77nNwQxIXrLHFpJR546OqU+juR9GMNhBb8yszxJnPUnPV5rag=
X-Received: by 2002:a25:c1c1:: with SMTP id r184mr266486ybf.517.1602653853939; 
 Tue, 13 Oct 2020 22:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200928101146.12786-1-green.wan@sifive.com>
 <20200928101146.12786-2-green.wan@sifive.com>
In-Reply-To: <20200928101146.12786-2-green.wan@sifive.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 14 Oct 2020 13:37:22 +0800
Message-ID: <CAEUhbmWxPmhZhEFECXO5oLTbf+r1E-rBuFQrC_e+D6YbmMDmag@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/2] hw/misc/sifive_u_otp: Add write function and
 write-once protection
To: Green Wan <green.wan@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <alistair23@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Green,

On Mon, Sep 28, 2020 at 6:12 PM Green Wan <green.wan@sifive.com> wrote:
>
>  - Add write operation to update fuse data bit when PWE bit is on.
>  - Add array, fuse_wo, to store the 'written' status for all bits
>    of OTP to block the write operation.
>
> Signed-off-by: Green Wan <green.wan@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/misc/sifive_u_otp.c         | 30 +++++++++++++++++++++++++++++-
>  include/hw/misc/sifive_u_otp.h |  3 +++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>

I am not sure how you tested this. I wrote a simple U-Boot command to
call U-Boot sifive-otp driver to test the write functionality, but it
failed.

=> misc write otp@10070000 0 80200000 10
=> misc read  otp@10070000 0 80400000 10
=> md 80400000
80400000: ffffffff ffffffff ffffffff ffffffff    ................
80400010: 00000000 00000000 00000000 00000000    ................
80400020: 00000000 00000000 00000000 00000000    ................
80400030: 00000000 00000000 00000000 00000000    ................
80400040: 00000000 00000000 00000000 00000000    ................
80400050: 00000000 00000000 00000000 00000000    ................
80400060: 00000000 00000000 00000000 00000000    ................
80400070: 00000000 00000000 00000000 00000000    ................
80400080: 00000000 00000000 00000000 00000000    ................
80400090: 00000000 00000000 00000000 00000000    ................
804000a0: 00000000 00000000 00000000 00000000    ................
804000b0: 00000000 00000000 00000000 00000000    ................
804000c0: 00000000 00000000 00000000 00000000    ................
804000d0: 00000000 00000000 00000000 00000000    ................
804000e0: 00000000 00000000 00000000 00000000    ................
804000f0: 00000000 00000000 00000000 00000000    ................
=> misc write otp@10070000 0 80200010 10
=> misc read  otp@10070000 0 80400010 10
=> md 80400000
80400000: ffffffff ffffffff ffffffff ffffffff    ................
80400010: ffffffff ffffffff ffffffff ffffffff    ................
80400020: 00000000 00000000 00000000 00000000    ................
80400030: 00000000 00000000 00000000 00000000    ................
80400040: 00000000 00000000 00000000 00000000    ................
80400050: 00000000 00000000 00000000 00000000    ................
80400060: 00000000 00000000 00000000 00000000    ................
80400070: 00000000 00000000 00000000 00000000    ................
80400080: 00000000 00000000 00000000 00000000    ................
80400090: 00000000 00000000 00000000 00000000    ................
804000a0: 00000000 00000000 00000000 00000000    ................
804000b0: 00000000 00000000 00000000 00000000    ................
804000c0: 00000000 00000000 00000000 00000000    ................
804000d0: 00000000 00000000 00000000 00000000    ................
804000e0: 00000000 00000000 00000000 00000000    ................
804000f0: 00000000 00000000 00000000 00000000    ................

But it can read the serial number at offset 0x3f0

=> misc read  otp@10070000 3f0 80400010 10
=> md 80400000
80400000: ffffffff ffffffff ffffffff ffffffff    ................
80400010: 00000001 fffffffe ffffffff ffffffff    ................
80400020: 00000000 00000000 00000000 00000000    ................
80400030: 00000000 00000000 00000000 00000000    ................
80400040: 00000000 00000000 00000000 00000000    ................
80400050: 00000000 00000000 00000000 00000000    ................
80400060: 00000000 00000000 00000000 00000000    ................
80400070: 00000000 00000000 00000000 00000000    ................
80400080: 00000000 00000000 00000000 00000000    ................
80400090: 00000000 00000000 00000000 00000000    ................
804000a0: 00000000 00000000 00000000 00000000    ................
804000b0: 00000000 00000000 00000000 00000000    ................
804000c0: 00000000 00000000 00000000 00000000    ................
804000d0: 00000000 00000000 00000000 00000000    ................
804000e0: 00000000 00000000 00000000 00000000    ................
804000f0: 00000000 00000000 00000000 00000000    ................

Regards,
Bin

