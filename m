Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5107C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF2D20738
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJNcOSlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF2D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxfY-0005DA-Oe
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxel-0004le-H4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:48:11 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:37469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxek-00011I-0C
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:48:11 -0400
Received: by mail-lj1-x243.google.com with SMTP id w14so2933178ljj.4
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=n9PTmV/H5DukNEHTnBQAOuMM+S05/TWkCCbgYEA5dMU=;
 b=YJNcOSlOgpMHk+snLqOEHFZQnEro3DxgtODNGIdMhE80Ydeu/jzf0Crxp5PqyPbWU/
 zl1E/q7lifnVUEdsfuAwEWkjPC0Yf+nShxnYpm9aH3+k7tDBSCi+w48mCPA2vCQHxK3q
 NyF+JCtXEZuiXtwyTXWSJvcTKOsXkEjaUWUD62NwZiwlybi+LV+j3/mzR8kI4ByzA4K9
 pLrdLwwXBpXG9KJ1FIH19uig3hakL+qpX+dE7W50OzI53mnAYs7YoP8VlMHa8QNlnf/R
 pgJfT5PUpAj3/PVKzHjVxnpMp0V3r4whBjQb7TOSNAicrfYNxq+0JulIHprpbuBC3lIz
 dU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=n9PTmV/H5DukNEHTnBQAOuMM+S05/TWkCCbgYEA5dMU=;
 b=ucblYsG+Ah7NHAm+8QoVs/vmeeCcFTTwJQmBNw7O2AEmIQS7MsdRriDraCzXZju4de
 q4uhgih+6Piiz+3oHFq8ALHAZO5DSqHfEghVrDQlhT2BJgKVjGH/loH8kPRoMwlepQMG
 jjjQfC9xSptPV4Wtifk38tSoVuR5BuTzrntckyqwv+FDX+1t2T0I5DwR3uFUZu5FPz9R
 qdOXFvXQ1v9U5IeWP6CM+3AjguZY2hAbDRtEuGqVOw6LoZIeyOPSd3a4kWGWGZ9SFsxF
 RJciIV8adAVdZnYTjtehz74nECMGFLRAFXSAILOO7RzMU83Dec2Cw5JFWnoeEukflO93
 a8dw==
X-Gm-Message-State: AOAM531RNziGYSa6HhWjiuleoMZ+JRUWyjHm4v7X1YEFxVCFltwgAkMo
 CKp6+WE7WunfKdSSCnO28To8Nl3oUouTU9/4vp8=
X-Google-Smtp-Source: ABdhPJziXEUr5L1U/0HecSPzePYxsIwbiiZd8arfUUfrwCpGhjvUFRMRipfORpcX9F7qUL8GqzFX+oydQARRYw9d4mM=
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr7621876ljj.171.1598456888411; 
 Wed, 26 Aug 2020 08:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <CABgObfYdjLouNp8ZvqHmB-xsOJdUgxv3zJL4A1GKuWggh7fnbA@mail.gmail.com>
 <CAE2XoE-JKpqQj7H3wMt0+WNTBR1JS6ZyiLOhqOYkaVj5Zzgp5A@mail.gmail.com>
 <CABgObfYk8zG3TBB3UZhvmZLGqLO+bZF+AmL6hSQkCgiCKKW4ug@mail.gmail.com>
 <CAE2XoE-U6Ls9gMSSDB4Qajn-m0vrBBP-+C0K4tncvzzr3Nwq9w@mail.gmail.com>
 <CABgObfaByaW9jqRZkV3BGONmqFaYwnQDREemYit8s+qYTAeP4g@mail.gmail.com>
In-Reply-To: <CABgObfaByaW9jqRZkV3BGONmqFaYwnQDREemYit8s+qYTAeP4g@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 26 Aug 2020 23:47:57 +0800
Message-ID: <CAE2XoE8LDYbGkJXQBorg9=R632PNtZ_onawrm=jsJQ_+gAA1rA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000005cd7905adc9bfa7"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000005cd7905adc9bfa7
Content-Type: text/plain; charset="UTF-8"

How about enabling github actions to enable MSYS2 builds in CI.
So we won't break msys2 silently.

--00000000000005cd7905adc9bfa7
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div class="gmail_signature">How about enabling github actions to enable MSYS2 builds in CI.</div><div class="gmail_signature">So we won&#39;t break msys2 silently.</div></div>

--00000000000005cd7905adc9bfa7--

