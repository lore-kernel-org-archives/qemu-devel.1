Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A711320757
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oP/RMUsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A711320757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6nR-0007kY-Rb
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jg6mk-0006yy-J3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:16:54 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32]:35450)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jg6mj-0007ij-VF
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:16:54 -0400
Received: by mail-io1-xd32.google.com with SMTP id s18so10780605ioe.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=huxvR/r7B4qGPFFpKOBTb/KqPC2+aqDXrIqqp/dmwUg=;
 b=oP/RMUsXRsOewuaqjUqJTjMHuYpeZSbHVaNCHBPjNRIQFZ2QZjohWR11iWD1irJsVH
 DHZMM3ZNq8DdWsH32GudqxrIVquj4W8xqiXpocMNVTg7HDvs8XzjLxTp+p3+UJoZj1TH
 P0CjL6aKMNzsF7wH29WvqT5o1pkyV4dWcPBXnggG9N+8GyDqTzbRRy43TxbjOr23rrns
 DPSpJvgntAXTNlQ7Dg9yExsP26Nn0ZFrGMQWsAmu369V6nVXjYP3act8SvXwbW9Ajk6d
 ITjXJfn/v0/CQv2sgJs/mhE6lybqUtLPSqUrCO7NLGh+ksJogQ8eCqMuU6EhXM+Rjk2r
 j7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=huxvR/r7B4qGPFFpKOBTb/KqPC2+aqDXrIqqp/dmwUg=;
 b=fddKOc/cZGCqRifwexYc2l0Vzw2cayGdMiya3TKuMv++RZeJDtYrdiNMZ4EKm6wCIn
 s+B2WgsOim5Z7bsU3/PzLJghvimu1x9snNcTB8E3BIHPxE+2vhczILkO9NOOTpAikG0Y
 Y6VwQt5RxAuHomPpHrnma75KufPU5MMApjgqmhtr2HpglCjYOa4+2wKxJghwyDJ7i2v3
 5NZeqQVmTD5rltM5eHiQUBXgzyXKGCU2MAb+Ki8D4+qhdIPkyLAcsUiGkI3xwJKpqzB4
 ESV/Vo3ZSlsNV8wZFQsmBn92L1CPhZz5cJlOoTvO0GjnOLxpzCtpZJc0jGHFYJomXUMv
 1bLw==
X-Gm-Message-State: AOAM532Ho2eyGOkleVLKeszhpyJpJjqAIyzUmxQF3a3VhzvkhYDpYTzW
 FV8YfoAsJBvd+SyBf7MoR2c9rCW3PnOCL9a/MX8=
X-Google-Smtp-Source: ABdhPJw/jtJDb93PRltl4zZ5REWnj2ZgCs5BvWQc6qCV7KegxH1UhkTgcxkBEwf5uVkqKQQG3CmUKqWtqInaTF1FdIU=
X-Received: by 2002:a5e:9705:: with SMTP id w5mr22653992ioj.86.1591103812362; 
 Tue, 02 Jun 2020 06:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <7056187f.8098.1727522108f.Coremail.13824125580@163.com>
In-Reply-To: <7056187f.8098.1727522108f.Coremail.13824125580@163.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Tue, 2 Jun 2020 15:16:41 +0200
Message-ID: <CABoDooN5D2uTC4eLiXL7r0uSfn7k_2c628vGSrE5Xw5BdXCVJQ@mail.gmail.com>
Subject: Re: what is the symbole "leul" mean on this code?
To: tugouxp <13824125580@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=laurent.desnogues@gmail.com; helo=mail-io1-xd32.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 2, 2020 at 3:13 PM tugouxp <13824125580@163.com> wrote:
>
> HI guys:
>    i am stucked by the following code,and i can find document illustratio=
ns this nowhere.
>    what does the "leul" stands for? and the postfix 10 means what=EF=BC=
=9F

That should be little-endian unsigned long (where long is 32-bit).


Laurent

> thank you!
>
> 10  ---- 60010000 00000000 00000000
>
>     11  movi_i32 tmp3,$0x60010020                pref=3Dall
>
>     12  mov_i32 tmp5,tmp3                        dead: 1  pref=3Dall
>
>     13  qemu_ld_i32 tmp4,tmp5,leul,10            dead: 1  pref=3Dall
>
>     14  movi_i32 tmp3,$0xfffffffffffffffe        pref=3Dall
>
>     15  and_i32 pc,tmp4,tmp3                     sync: 0  dead: 0 2  pref=
=3Dall
>
>     16  movi_i32 tmp3,$0x1                       pref=3Dall
>
>     17  and_i32 tmp4,tmp4,tmp3                   dead: 1 2  pref=3Dall
>
>     18  st_i32 tmp4,env,$0x220                   dead: 0 1
>
>     19  exit_tb $0x0
>
>     20  set_label $L0
>
>     21  exit_tb $0x7f0d0223c003
>
>
>
>
>
>

