Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF831C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27044215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3W+w2pg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27044215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQlnZ-0006X3-3v
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQllt-0005Zg-6J
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:20:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:38585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQllp-0006he-KJ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:20:52 -0400
Received: by mail-wr1-x432.google.com with SMTP id n18so8993341wrs.5
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 23:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qZoJxLRNigJgYIxvp7DL97VQa0qNZ4AhhZcyIGn0nkw=;
 b=f3W+w2pgrY3LSCNZgihkpWxA2aWt1D2rtS0sGeclzkLHXsQ6YdTsvyd1lDzTnRvAoT
 oTiCVGmDBm0V0iqVLIbWrEs5OC4MCbrKK/zQ8KPPmDAf/uXh6f9ZUQvDnTg1Dm88c45Z
 aD/KD3OV/w5GQllCeNdPh7kvwvH1dyHST4aVCaPDAm3miEYxn3bFjHzFcSI3dcMzpaMi
 +BbN7ccnpWitA4yvffFF87t1szIFxMv5flcQxDxHVu8uR8mX77lIj/pxSJKkQxvPDxer
 MZv2dvgbQEq1VfFLdFjIl/EVnwfF5laEw0Y32G1RWHZ+fcZ2eyTw54Gqe8BmaMjFOc54
 DHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qZoJxLRNigJgYIxvp7DL97VQa0qNZ4AhhZcyIGn0nkw=;
 b=bs83lebTQj+I1qN+hlFX9gn2hm+AoEivlNTUZKmFC3l5E+4P+uiyl2d5yEXIQkIgKc
 cYmvkrjOIGcj11Ro0U0Qj7QGeF4anMYUfi9UN7XG1f1bUjIO+qCQlCvkPm1Fqhu6ChGZ
 TVYYdcQVos4mzyOi2AGNJxRrw4gk/lRkv2uD9ko+7/3Z0kj7cw4RQAM83lM12/6lh3Uq
 ozv1qXSggTxPp4/t222KT//cjpprNq1vTVdRa4HybhUF+fvvTPhvFb6BTBl5g2PjLFz3
 I34gvg6XqFI42ff36KeIUx8Been8x6t5TRNL/xkvPEYCDb582Dq8EZP+GO8L23xV6ABr
 kgOQ==
X-Gm-Message-State: AOAM532T0NVv284IosgbD/OTk8siLSMrw4Y5rr/5ond0fND/n6unnNc+
 myU9MY34kQANxGXeTf7ZqXggDg==
X-Google-Smtp-Source: ABdhPJzjVREni5qXLxsTfToputqs7mlBTOzG5fMmJzKGag6XYfgyTXSB7xeLViIn5aYZ8ROWl8eHLg==
X-Received: by 2002:adf:9124:: with SMTP id j33mr12925569wrj.272.1602224445360; 
 Thu, 08 Oct 2020 23:20:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q4sm10087851wru.65.2020.10.08.23.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 23:20:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 69E891FF7E;
 Fri,  9 Oct 2020 07:20:43 +0100 (BST)
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org>
 <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
 <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
 <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com>
 <87362r3cbt.fsf@linaro.org>
 <61c49583-c548-a8b2-7106-59011196f430@gmail.com>
 <CADBGO7-BaTH3MBZa6Dbv2+uxKNbv3ztwQ=iu_FCgrcrKBUzCPw@mail.gmail.com>
 <4da67d13-a774-f62e-ad89-de062cbe81da@gmail.com>
 <87blhe1esd.fsf@linaro.org>
 <f32593d0-e87b-0549-7b59-f58da24c9130@gmail.com>
 <87362q1bxl.fsf@linaro.org>
 <2e3754fb-8b3c-4ef2-989f-a0015ef3a7e8@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas <74cmonty@gmail.com>
Subject: Re: Emulate Rpi with QEMU fails
In-reply-to: <2e3754fb-8b3c-4ef2-989f-a0015ef3a7e8@gmail.com>
Date: Fri, 09 Oct 2020 07:20:43 +0100
Message-ID: <874kn3zzr8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas <74cmonty@gmail.com> writes:

> Interesting enough is: my top figure reported by perf is like yours:
>
> Samples: 6M of event 'cycles:u', Event count (approx.): 1936571734942
> Overhead  Command          Shared Object                  Symbol
>    7,95%  qemu-system-arm  qemu-system-arm                [.]
> helper_lookup_tb_ptr=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> =E2=97=86
>    4,16%  qemu-system-arm  qemu-system-arm                [.]
> cpu_get_tb_cpu_state=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> =E2=96=92

Not quite - cpu_get_tb_state should be a fair bit cheaper now since the
optimisations to hflags where introduced.

>    2,52%  qemu-system-arm  libpthread-2.32.so             [.]
> __pthread_mutex_lock=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> =E2=96=92

This indicated there is some lock contention. The QSP profiler can
help here.

Are you running the latest state of master?

--=20
Alex Benn=C3=A9e

