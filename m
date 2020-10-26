Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7C8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:23:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D66422263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kg1qMtEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D66422263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6DP-00050q-H0
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX666-0004Lh-HQ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:15:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX664-000824-U8
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:15:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id a72so12457302wme.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1rGfK5KmDVjuMmXxy2nUSwHH6sMFKvTP3cU4+dNKII8=;
 b=Kg1qMtEpRCVQVitELpZFu3wrwTX1cJE/7Ly6Su2bvTmBvD/BCm4ZGMhTtOSkxFUZGq
 EBk4mwjW00CwpGhaUS0IbbUOJQpXBIryGoATdagHY92/hmy34iJgmrEQFKKXCKK3Xtjq
 LmYI4ePVCwLo01Krbi0vvldgShtbLJLDLrbn7eW9rJyhckpLcQnSepp08Kdi7/06k4Hq
 cdp2Vg+tntkdSkMLRYo0M1KzK24NVrqP9+y8adZPz8rH/QPz622mfhrK7UkuLFNSdcSk
 vmmdLVBg9nvWID753NROCAH8gIxPPeR3fKKoA2KpyUwO4nPPmpPnO7u8XiRkOOD64hkr
 M+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1rGfK5KmDVjuMmXxy2nUSwHH6sMFKvTP3cU4+dNKII8=;
 b=lRCsH4pXZotcekO3rLWqjsB27euIWzJOqAtI7NGqrZupArZff+WEJjyOvnANiin+Rx
 vIKnTvWCUgvAqhi9yqh9A3afo7rt0/HHLS8J8HM93TDfVIplJnlQ7gvZt+wp40qiIX0W
 CW4gXvU2UpGHxcbpdTXH2leiN0AEvE+nkg/aygb9ht0Mhcv8W+pgF5dGJQYkC42STU4Y
 bIy0cFe2tYlw2fGnQDkgiB1Kd9V5shWUtuTLfqLrqtJhZt+VbbmpLXJjV7NqW7iipnve
 k57qXcQgGfy27B5Y3mA8jeu/KgaCvRTK7O7T9N7/aFG8xtFHAHauEXMMdnZWiJcodxw0
 4dSw==
X-Gm-Message-State: AOAM531fDtmc6YoenMi2PS2B89zaj0OVVYyn6NoiidJgXndfu8rJI7mG
 3OsDoaAgRnx5VKHrvH8SVGSSSTMS4fCh9Q==
X-Google-Smtp-Source: ABdhPJyew9HBOrOJiDrOS0jRWibgS7lxmgHtGkEPh+xZxZrYRJ7BeDlSlILlbjuI6lYl5Krsg+oJkQ==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr17059611wmj.170.1603732543715; 
 Mon, 26 Oct 2020 10:15:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o186sm22091676wmb.12.2020.10.26.10.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 10:15:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BCAC61FF7E;
 Mon, 26 Oct 2020 17:15:41 +0000 (GMT)
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-7-pbonzini@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 06/15] lm32: remove bios_name
In-reply-to: <20201026143028.3034018-7-pbonzini@redhat.com>
Date: Mon, 26 Oct 2020 17:15:41 +0000
Message-ID: <87zh48gb7m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Michael Walle <michael@walle.cc>, philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

