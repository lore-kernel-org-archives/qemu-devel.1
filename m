Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CCFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 23:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16D8206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 23:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpv1XzOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16D8206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jindg-00040B-5W
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 19:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jinco-000332-Ah; Tue, 09 Jun 2020 19:25:46 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:41895)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jincn-0007sY-J3; Tue, 09 Jun 2020 19:25:46 -0400
Received: by mail-io1-xd44.google.com with SMTP id o5so101195iow.8;
 Tue, 09 Jun 2020 16:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=llzOn5SXmgPzBWcPwKF+7pAOepMVRqj/eYw9Sc0FgzE=;
 b=Gpv1XzOYjgUVIWR8FDNJNpjvMsHQuf2bIi08heE3slfuDU2b53+Ui4HQ1ywO+FEK8F
 vsPPTfNpehbOj3G4UVrCxrBBcTf5i6FSgnwx8fb2o9fJOQUJjjy8S5PmF6BKdygnrQHB
 LtVHijeGRmpU1Qibvx59+b35eXbQmZOUMSLYdQ5g6stuwoEdc2N3LHuGD30ie7LVWlGs
 0RMbCwywZF72wOPX7ZNMuq2FnKOCgXga5WdE4Q1izOFkfuPjkUTX/s1JyZ3e7Ztv8Nle
 OdhcuCbWExmHI7yuL1Joaa+LMekYJW8kWoaWznjpWDjtJG8G4ZvsD5xiwya5lkt8ux1l
 56YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=llzOn5SXmgPzBWcPwKF+7pAOepMVRqj/eYw9Sc0FgzE=;
 b=XHOQhQtYoGfcfWghNSgmluSMhM4QhRMxKxWxa+ttHpX3RGYq6bqrnmh3+IcJbbkaDu
 zbBnf8j+Bh85yraQIDDgn+dvtO+phROIxNWb1bBW2Wrjs89xdqbqgOH6Vo1YYm1pdyGc
 k4vcYY0BTATzaFeDwzaOWvQVAlFd4KQNzZhx64pftWT3Vlsa0tsEGGSb9VPPcVa8FHti
 yEzzR/aJ5BmQyPMEd39WqhE1jgnCymVsv4fYB3qozhoYmD4DZGCzb7AFgFT3UxToJ8Ob
 CnV7zpNHtaMsfZTneMpD3ukLlR8JXn7KtmVmM9J17h+wrWe8Ppdkjf7WRkhzIT0QOVoX
 QsFg==
X-Gm-Message-State: AOAM533scmWKoO4qWP6h0GWxqRr0GEYNncmuDbjlToulrERPgO/YjS6q
 DRVOn1rttBIJq7QgZJVOzU1OuCvrpEsCVImin+4=
X-Google-Smtp-Source: ABdhPJw2pFQR0t/AsXHqvJegq3S5fWIiNjhub20/bp5lyca/B391uU6MEkMjbvWNyZNpHidS4YpS+cMaUCat4WftIcE=
X-Received: by 2002:a6b:6a13:: with SMTP id x19mr494143iog.175.1591745134030; 
 Tue, 09 Jun 2020 16:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200128003707.17028-1-ianjiang.ict@gmail.com>
 <b14a65dd-b565-77ca-d479-f88e53ca0721@linaro.org>
 <CAEiOBXXOA40F5kdttMby6eAfMGYVT0twZOhkojFK9qRDX1Xchw@mail.gmail.com>
In-Reply-To: <CAEiOBXXOA40F5kdttMby6eAfMGYVT0twZOhkojFK9qRDX1Xchw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Jun 2020 16:16:13 -0700
Message-ID: <CAKmqyKN50oAJjqUcXr8ze9zre04irjNxd9OxY5e_q7+r=sdTMw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Add helper to make NaN-boxing for FP register
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ian Jiang <ianjiang.ict@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 9, 2020 at 3:08 AM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
> ping ?  Could this be merged ?

Applied to the RISC-V tree.

Alistair

>
>
> Chih-Min Chao
>
>
>
> On Wed, Jan 29, 2020 at 3:43 AM Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>> On 1/27/20 4:37 PM, Ian Jiang wrote:
>> > The function that makes NaN-boxing when a 32-bit value is assigned
>> > to a 64-bit FP register is split out to a helper gen_nanbox_fpr().
>> > Then it is applied in translating of the FLW instruction.
>> >
>> > Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
>> > ---
>> >  target/riscv/insn_trans/trans_rvf.inc.c | 17 +++++++++++++++--
>> >  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>>
>> r~
>>

