Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC52EC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 22:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB842173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 22:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPCSgXYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB842173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSTR9-0000WA-9C
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 17:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iSTNu-0006nI-O9
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iSTNt-0001aZ-Mg
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:02:38 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iSTNt-0001Xz-Ee
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 17:02:37 -0500
Received: by mail-lj1-x242.google.com with SMTP id e9so14634700ljp.13
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 14:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HkmNPtodl9kIuKaHmLdvJQrAHABZUCv5g1TIeZKwH0A=;
 b=KPCSgXYjUVC2EoEbRoxoxrpoRborzIf+QSyrjcfk9RCRSOFSEdBXr3HqvpHHVgRK0l
 yXnUF/R6fcVBVZmPWBblkrLjgcuuDleCKZEJ8TszeCqRekwAvqCrJF7FxLHSFVwlkken
 A/T7L58TCyWDn0kPYupsXkD69gGuBZZzAWuPmQCgwZ47gSsQU6EgCf5JzZOCNQkN6aGH
 3FcveGydguAPOiYqzmW8jEXDrYtOPrFXgwlqVqseSsXBByBg8AdCGmpb+zH7e47msf5o
 Okj4Dlv0Jbl804jZbQfXj2/thqSxOWspJmsZgukNMwtA9rO+s+yWAt9Uyk2V8JgeIhIT
 DI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HkmNPtodl9kIuKaHmLdvJQrAHABZUCv5g1TIeZKwH0A=;
 b=POh8DCOpXBMp5f3zzcnc2AxC4OOVAlb2vgUd2qK+dVi/IZXVo7ukZDt7S81HhsiiFW
 JYul3etW+PTA12EEVZ0HH94wR2NibVNggziNAHpU8JQPgmEAkNOyy1UnHw+pL/3asQqF
 3z9yjuNuwt7jGjrdyr1CG1FqGe/4WzpV6+4yYipTeCRSN2RmhmNKyZmgFrHVcFoCTiyS
 +76FF5x+S8aZjzHeACjTNn56vNqmiR1TBLB1haIJQNARmLzPxbweRQlWZ0raBr10xdwW
 mwcVRZE2DAubXqX9Pyos0PBuqqgg+vNxUapzv+pnBi6ZkTcKpPAhz1XF93KqtSS3lqpS
 5tkQ==
X-Gm-Message-State: APjAAAV4M+QAycqFCOwgxfPDqkOqMp98hWaCz/feZfk8cM8nnciBbsx4
 HCIJJZMyMWHUcsxLAT9REa7zT0OvMNf1RgVh8Ac=
X-Google-Smtp-Source: APXvYqxASuFsltOFJm+fJcPh2wW14oDU9vcZ7OlviMed0O1NckquZecTao8ImkFH0FRWXQHdmFAksQzIImyCy7MM+nc=
X-Received: by 2002:a2e:94d6:: with SMTP id r22mr3251678ljh.7.1573077754331;
 Wed, 06 Nov 2019 14:02:34 -0800 (PST)
MIME-Version: 1.0
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-3-edgar.iglesias@gmail.com>
In-Reply-To: <20191106141424.27244-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Nov 2019 13:56:53 -0800
Message-ID: <CAKmqyKPypCij5EKvyxDJcasn8tibqoCt_ovn2C52kUskmC=C5g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] target/microblaze: Plug temp leaks with delay slot
 setup
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 6, 2019 at 6:17 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Plug temp leaks with delay slot setup.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/translate.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index ba143ede5f..e9ff9e650d 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1201,6 +1201,17 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i64 pc_false)
>      tcg_temp_free_i64(tmp_zero);
>  }
>
> +static void dec_setup_dslot(DisasContext *dc)
> +{
> +        TCGv_i32 tmp = tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG));
> +
> +        dc->delayed_branch = 2;
> +        dc->tb_flags |= D_FLAG;
> +
> +        tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUMBState, bimm));
> +        tcg_temp_free_i32(tmp);
> +}
> +
>  static void dec_bcc(DisasContext *dc)
>  {
>      unsigned int cc;
> @@ -1212,10 +1223,7 @@ static void dec_bcc(DisasContext *dc)
>
>      dc->delayed_branch = 1;
>      if (dslot) {
> -        dc->delayed_branch = 2;
> -        dc->tb_flags |= D_FLAG;
> -        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
> -                      cpu_env, offsetof(CPUMBState, bimm));
> +        dec_setup_dslot(dc);
>      }
>
>      if (dec_alu_op_b_is_small_imm(dc)) {
> @@ -1274,10 +1282,7 @@ static void dec_br(DisasContext *dc)
>
>      dc->delayed_branch = 1;
>      if (dslot) {
> -        dc->delayed_branch = 2;
> -        dc->tb_flags |= D_FLAG;
> -        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
> -                      cpu_env, offsetof(CPUMBState, bimm));
> +        dec_setup_dslot(dc);
>      }
>      if (link && dc->rd)
>          tcg_gen_movi_i32(cpu_R[dc->rd], dc->pc);
> @@ -1379,10 +1384,7 @@ static void dec_rts(DisasContext *dc)
>          return;
>      }
>
> -    dc->delayed_branch = 2;
> -    dc->tb_flags |= D_FLAG;
> -    tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
> -                  cpu_env, offsetof(CPUMBState, bimm));
> +    dec_setup_dslot(dc);
>
>      if (i_bit) {
>          LOG_DIS("rtid ir=%x\n", dc->ir);
> --
> 2.20.1
>
>

