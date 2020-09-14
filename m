Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6A4C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CF7216C4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZw/tmMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CF7216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHq97-00056Y-Ul
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kHq6L-0001br-J3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:09:05 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kHq6J-0000So-Sh
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:09:05 -0400
Received: by mail-ot1-x341.google.com with SMTP id 60so246377otw.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9sxn8FHUchRCvqEV7Ls5tgQdDoJmRMBPrkoOw3WHDjo=;
 b=kZw/tmMbcofYHpiI5AWAEEWcE0YusIQS9rIeY19gavO96SHqwq/pEcGKYpXwrD2iS8
 utJWH2VUxYfvkugVSiUBkGzo+MgH+n5JK/opd+92DHRKT281zbZWf1b96IocMA4zgwhT
 TfRrZzGJsEBrS8bfInXqJgz012OlKGoyuxCly8jdS9v7Ql3Dg4Ijvhj/wyf1bJAfdZTn
 d63aWZnkZ3f2q8AR3bxMvvjmCeKMe0rEsysDNGdpFg9bJAFABUL2UCkzSNWWWEa7dd95
 rMgQTiprkbTJ6VwxX1NsKNXN5UZ7dTDJNPVFaZTMv50pI5swB42vQ9BdtiUK7PcAGEQ7
 JknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9sxn8FHUchRCvqEV7Ls5tgQdDoJmRMBPrkoOw3WHDjo=;
 b=HfLvu2JAksU8RmaLizOCuBpf24B3P5fIDmsnUQnNNxjRUJFLCWZIhuNB9zf4XISuL4
 Mjdic9VQWXTgDIHpOPSdaPzRMGQjOoLa3cObqG7/xWf9TCd/BRpFG+TWqSmcfe9Q32jK
 DHNyR+E9+xl4qFDq+/OY0DTbUczrHzbIE0oHNjWARiFIXA+Hr7O9tuOmpV76jy5ZGzrs
 A8YzhtwjjkBq3yHPONs6CJQf/dlrbFuS636yVDneelPol3mTn5cdtkzDe4wLTL2gVZ5k
 IFRjwRbpuPsmbVl9uyj634eb2umxd12juT9x4CeKXUuAui5YGqE83nNHWlMlnxmwQCUQ
 x13A==
X-Gm-Message-State: AOAM530e8W29ylTXNJ6yRdZpQwOB6hUEzajjitlIkIywF2Ogzg0PPd7Z
 Fq8+MdqbDylJOFzkeIEAX8rPmxPWiUzyD+ESRRI=
X-Google-Smtp-Source: ABdhPJyAz3aCHCl1V+3IeBobblo8zZiKYQjwa4FD/GrOT9HIDwdwsE5sHrop70ZOfBwT9ZmKBf2WVzDvuLt2Ky1CIRI=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr9221979oti.333.1600096142619; 
 Mon, 14 Sep 2020 08:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <1600074185-91624-1-git-send-email-zhengchuan@huawei.com>
 <1600074185-91624-11-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600074185-91624-11-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 14 Sep 2020 23:08:26 +0800
Message-ID: <CAKXe6S+h=zT-Z2fW+YOnuAvpC3yJgraT+N3d3eP9bs=_FN1KTg@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] migration/dirtyrate: Implement
 calculate_dirtyrate() function
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, yuxiating@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Implement calculate_dirtyrate() function.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/dirtyrate.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 6add846..cc31bd1 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -162,6 +162,21 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>      strcpy(info->idstr, qemu_ram_get_idstr(block));
>  }
>
> +static void free_ramblock_dirty_info(struct RamblockDirtyInfo *infos, in=
t count)
> +{
> +    int i;
> +
> +    if (!infos) {
> +        return;
> +    }
> +
> +    for (i =3D 0; i < count; i++) {
> +        g_free(infos[i].sample_page_vfn);
> +        g_free(infos[i].hash_result);
> +    }
> +    g_free(infos);
> +}
> +
>  static bool skip_sample_ramblock(RAMBlock *block)
>  {
>      /*
> @@ -289,8 +304,34 @@ static int compare_page_hash_info(struct RamblockDir=
tyInfo *info,
>
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
> -    /* todo */
> -    return;
> +    struct RamblockDirtyInfo *block_dinfo =3D NULL;
> +    int block_index =3D 0;

Does this 'block_index' mean the success allocated count of 'block_dinfo'.
Then I think 'block_count' is more meaningful

> +    int64_t msec =3D 0;
> +    int64_t initial_time;
> +
> +    rcu_register_thread();
> +    reset_dirtyrate_stat();
> +    rcu_read_lock();
> +    initial_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if (!record_ramblock_hash_info(&block_dinfo, config, &block_index)) =
{
> +        goto out;
> +    }
> +    rcu_read_unlock();
> +
> +    msec =3D config.sample_period_seconds * 1000;
> +    msec =3D set_sample_page_period(msec, initial_time);
> +
> +    rcu_read_lock();
> +    if (compare_page_hash_info(block_dinfo, block_index) < 0) {
> +        goto out;
> +    }
> +
> +    update_dirtyrate(msec);
> +
> +out:
> +    rcu_read_unlock();
> +    free_ramblock_dirty_info(block_dinfo, block_index);
> +    rcu_unregister_thread();
>  }
>
>  void *get_dirtyrate_thread(void *arg)
> --
> 1.8.3.1
>

