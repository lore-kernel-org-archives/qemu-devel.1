Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE077C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DC92063A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1UuS0jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DC92063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsp9W-0000vA-Qq
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsp88-0007mu-3i
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:03:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jsp81-0002QD-Nw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:03:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id f7so42495047wrw.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=h4YqerX3Uo7XdkoV1Gl/3raSws0pGDHNr9inDmTIZKY=;
 b=I1UuS0jypPUSMQF5dzDJcTecdzKl2Hjop8GloGMBWwz4Yerc87+RgBWdv/7XuXexfp
 ff8Z0YZx22tPaIEohcwujE+Muud76RohEGE8RkAtokpo4COiwW/mlU8y69jYi70jJ2MY
 wNrSJK7C1YBbUV4uGVfHDSM0jgAvuZQqGcKMvYIw99g2nPn2UmAzpJHtyKRZonFGqynU
 nQN5rTW8Z5RIjajr8PVMj0iRJrjBpLfsVpU32FMG55NU0SnuFzdxNjRnEaf7CLCc4Aft
 b+tXgZcNnOfKFRogvQCGy3XAbEAjpWrP0VdA4t5dAmeNTX3tSGpNuWL7oa0N3YraE6Km
 Whxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=h4YqerX3Uo7XdkoV1Gl/3raSws0pGDHNr9inDmTIZKY=;
 b=IKT8cYPtCMSjv3bgRNq8aG4bAm1Mbin+b0X36lkOvEobMsa3K881EIX9nqP20DUfFs
 NGsknB+VrSMSW2/jmutxpdUf2mL7RzcQ3sL06yaG4zDdnKo7vcGjBUF7SOJzumkCC+r3
 wgKXO60BNtFBIITtr3Sj4K4gg5MWKce9i9GH/jYUY4fOaLMGbaVfGujJ7tkD0YjGL0Ax
 Z80n2Ia2KRDUpFhvavenb5fqu/wUPmTAvnEfPNXvPhJSXfSLZdoLSnensjLLsJvzcMHA
 Ob4WFVL6xjmfilL6tErmT+fPB253hIpovQNG/Y8Tf2tKUpDJE2f2cyrN4Mwr16d8/1c4
 0VRQ==
X-Gm-Message-State: AOAM532r6ARTZM9G/YKRNAyEg9Kdon/lU+/jzpjCSKA0kjszctBhCaHW
 /syhAGAp6OZby5e+OFxChi2xVQ==
X-Google-Smtp-Source: ABdhPJwjJ6pkrMPkUPG8bU3Ta1/Vj6tpKvAGHLeQ4oa0YRkX4VYqZVMcVWS0RdS2AezjuxuTV1kv3w==
X-Received: by 2002:adf:f8cb:: with SMTP id f11mr57312726wrq.358.1594134202072; 
 Tue, 07 Jul 2020 08:03:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k126sm1537530wmf.3.2020.07.07.08.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 08:03:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4C1E81FF7E;
 Tue,  7 Jul 2020 16:03:19 +0100 (BST)
References: <20200707135808.9241-1-cfontana@suse.de>
 <20200707135808.9241-7-cfontana@suse.de>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v2 6/6] cpus: extract out hvf-specific code to
 target/i386/hvf/
In-reply-to: <20200707135808.9241-7-cfontana@suse.de>
Date: Tue, 07 Jul 2020 16:03:19 +0100
Message-ID: <87k0zfnz9k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, haxm-team@intel.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> register a "CpusAccel" interface for HVF as well.
>
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  softmmu/cpus.c                |  75 ----------------------
>  target/i386/hvf/Makefile.objs |   2 +-
>  target/i386/hvf/hvf-cpus.c    | 141 ++++++++++++++++++++++++++++++++++++=
++++++
>  target/i386/hvf/hvf-cpus.h    |  17 +++++
>  target/i386/hvf/hvf.c         |   3 +

Given the recent Apple announcement we might want to consider making HVF
more architecture agnostic - or at least the main loop bits of it.

--=20
Alex Benn=C3=A9e

