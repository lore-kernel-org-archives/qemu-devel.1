Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2ED4C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA8E206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQLZZruY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA8E206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLRw-0006us-D3
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGLQn-0005yU-Tt
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGLQm-0000nN-K6
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:39:45 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGLQm-0000mq-Be
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:39:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id m3so14409722wmi.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=t0s19fYs3NgtNjvy7kbbwvd9T89cDqQP/+QBzkrN97I=;
 b=lQLZZruYcz5B3jbIF5SpswWumDcg8xis8rUnHEQVChWrwcte1bJC59OGts4egx0G3Y
 gHCagrZ3PHAkyEEG2ZQkF51Iot1PgmOh2TEEUqBxDHndQ9usl8KfYXEQmrmlKFKzbvMM
 4YIEGjZFHd5yisadtu0vlA4KMOtKA6Zyt2+gMrhPio/ad0fCxMDVpDIlwuZ15b39GXLr
 QCJrBMZZktPJ1vMVuh1nlZrbN/nNgZohbbn3h53a4H2wZM3u/SQNhJ/7A5JEdTb767WE
 SNuGigXijcNOKiYCHyMYw1B7EIJCcA5aCE6rTFxYaQO0+wiL8mzDabKdJFb/aiNq/45a
 12jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=t0s19fYs3NgtNjvy7kbbwvd9T89cDqQP/+QBzkrN97I=;
 b=pEtqF4Y+ySzpAmfzbOcnA9BYIMla4JuiCGJjqYoLmw7AbT5jSQjLuQQA8WohOmnEHf
 52pESocGJzCoIDcx4GpWEIu06eqQB7ToUXhrE87vVtj4ejiK2rwrVLi0Mq9m9XIwt9VY
 cvQksjedbwoplIXOXd6oIWodmXwxpe6TAVBTD4ke8K10shrFzafUIisX5B3dV54pWS1f
 VSf3CQ3UTaW5WMH3h44omWMG5Eg1iEhl097vmHzlK8LeFNh9lBKznh8xBjg55yRMQTyS
 G8ZRzQZDQ6QC1XrYW10JkZe9+1vFnCJo/zDydpsI75Om9/bxKX2hKEgSSia3k1gm2Zdh
 O3Pg==
X-Gm-Message-State: ANhLgQ1nEYecrma7OvIPhYMzEq/f6wOZuiNqFVJROEK6H3yWNbdSlzii
 KsFfytTKXiPVqeMBjail8NzZmw==
X-Google-Smtp-Source: ADFU+vsHRpbl58i4bZNiX3Fh+zT+Azrs9FEpnG/Sd0euNRs7hHprh8HcXkMVzGeJSPJf2r/1jHiOhA==
X-Received: by 2002:a7b:cc72:: with SMTP id n18mr18228292wmj.71.1584963581701; 
 Mon, 23 Mar 2020 04:39:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u5sm16010278wrp.81.2020.03.23.04.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 04:39:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA13B1FF7E;
 Mon, 23 Mar 2020 11:39:39 +0000 (GMT)
References: <20200322171635.678219-1-marcandre.lureau@redhat.com>
 <20200322171635.678219-2-marcandre.lureau@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PULL v3 1/1] slirp: update submodule to v4.2.0+
In-reply-to: <20200322171635.678219-2-marcandre.lureau@redhat.com>
Date: Mon, 23 Mar 2020 11:39:39 +0000
Message-ID: <87h7yfb8qs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 samuel.thibault@ens-lyon.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> git shortlog
> 126c04acbabd7ad32c2b018fe10dfac2a3bc1210..55ab21c9a36852915b81f1b41ebaf3b=
6509dd8ba
>
<snip>
>       build-sys: make libslirp-version.h depend on Makefile

FWIW I ran into a build error when I updated to the latest tree. It was
failing while building version.o. In the end I tracked it down to a
duplicate of slirp/src/libslirp-version.h (one in the build tree and one
in the src tree). I didn't spot it for a while because git was telling
me the tree was clean because of .gitignore:

  /src/libslirp-version.h

Is this stale now? Is slirp always built out of tree?

--=20
Alex Benn=C3=A9e

