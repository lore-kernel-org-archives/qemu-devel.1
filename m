Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EDEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7532206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kj2e/FEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7532206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJuZ-0004vf-49
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJtc-00049k-Ck
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:41:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiJtb-0003is-5g
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:41:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id l17so4591274wmj.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6nEqlZeG7TPnc5eDPe+OFyPnSXK4NIzbJ8Scx5YW0SQ=;
 b=Kj2e/FEf+/zby9wxdBxua6S8UGnbIc72r3BIT3zFDMIM0NsT+iHQN5VE3aRQRPsehQ
 Hkyj/lx0bYpi+jDsC0stBhNMFYxlKMMggmnrRwl9ZnwmENqvg9lqEk94vRAh4LyJUm3A
 VjA6ncumSxMEeO5Tg0J3bhXO129BPsu3e9jb85BUbaGbs5/OUiGRs1JRAz9AATtOp320
 LtC55bxyaicDEPQqokOlfv3LwKf2YdWG70WuTbOp8mdEB1jxCEsO8mCxh3Jy3A95nwkh
 AAt40BJTNckfKSv9dcRMeWdYixcJ9lTCxpojPAZA7oNzyPaPFN0Hi3MDLVF1YepMqCCb
 pg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6nEqlZeG7TPnc5eDPe+OFyPnSXK4NIzbJ8Scx5YW0SQ=;
 b=t/0uMW2LuK9NzUN6bGZBW/mb4OILgj2qNbfK3sxZHvi6Toxe+q1mElTkVTA8Fg/xhm
 1slTU5XcNCGtv6XKpLwMWpXsX8ZxA6zjhm8Dn8vuLro1mZSuVe6aPXkagO+xK3i3YhqA
 zRCsUe84q/Vmq38n+ApzXxtG6StTIPJW5wubfFq4CQiKC62c+Eim24me0gil1/vFgq6E
 sa5nIyRVhOexK6p7RWkDCGhLM+8TFCev+cK6xJqSZ+F1/Fh8Lcs9YUm6ue8whLW/yv4X
 DdH/hYtI3SgIbAOkraZ0SfSaQeED2pnD9UtDgyh6v+Jnw6bMFgB4vGpeF5PknXylmw80
 GTbA==
X-Gm-Message-State: AOAM531WZFKuI/x8tfV9H1tHauypS1y6vkO9ysfmH7Yo7Z0J6Ub/bs6W
 MZuTq+3tU8v6NZYQP8GqvyWlyQ==
X-Google-Smtp-Source: ABdhPJy3E4EN0lZRbDYnhszXKmlyj+vPOvv5uTRtlVZ1Q/hJMfjOd6Td8ImN5zH7DVxL1kxSwtWBlA==
X-Received: by 2002:a1c:5683:: with SMTP id k125mr17733667wmb.55.1591630864158; 
 Mon, 08 Jun 2020 08:41:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f9sm100146wrf.74.2020.06.08.08.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:41:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D51721FF7E;
 Mon,  8 Jun 2020 16:41:01 +0100 (BST)
References: <20200605173422.1490-1-robert.foley@linaro.org>
 <20200605173422.1490-14-robert.foley@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 13/13] tests:  Disable select tests under TSan, which
 hit TSan issue.
In-reply-to: <20200605173422.1490-14-robert.foley@linaro.org>
Date: Mon, 08 Jun 2020 16:41:01 +0100
Message-ID: <87o8pt5zw2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Disable a few tests under CONFIG_TSAN, which
> run into a known TSan issue that results in a hang.
> https://github.com/google/sanitizers/issues/1116
>
> The disabled tests under TSan include all the qtests as well as
> the test-char, test-qga, and test-qdev-global-props.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
<snip>
> +ifndef CONFIG_TSAN
> +# Some tests: test-char, test-qdev-global-props, and test-qga,
> +# are not runnable under TSan due to a known issue.
> +# https://github.com/google/sanitizers/issues/1116
> +check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-char$(EXESUF)
> +check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)
>  ifneq (,$(findstring qemu-ga,$(TOOLS)))
>  check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tes=
ts/test-qga$(EXESUF)
>  endif
> +endif

It's a shame we can't do any of the qtests as of yet, but baby steps.

--=20
Alex Benn=C3=A9e

