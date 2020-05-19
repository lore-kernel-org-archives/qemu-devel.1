Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A49C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5587B206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcMQun7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5587B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jay1H-0000GZ-I8
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jay0Q-0008CU-9b
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:53:47 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jay0O-0004Zs-8D
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:53:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id u1so1405747wmn.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GnmJm6QY6uwuwPDS9ZnNIxszLxYl2W7i6Ie1pxmgg7A=;
 b=xcMQun7L6eoJIhYKrFCKjW5sdaz7DW0cqhvXJWP3NEbgM8yV52o0I6MVfwofM04q31
 +Sz4eHzYvJBgVJ5gsjwMdnYSKg65zRwooA404Aj97Xyypx0pmgE7E7Y7q10bjrT78Am6
 pWEtSxIrpBP2nQyAi/qFYe2qN2GmE836Vjqd3pCp3hTQx7qKJviqnEZsRoKKOlzLSYY8
 nItGUwsYmSLWnsVQaelrUig0yB4GlLgLiB25I1itJPjlf9x2vCTX2JSvmtnxWI5K9GvX
 YyAnJb0JDN7+hE3JSN7Cm3nA0zvDTo4a4BAL8R3nA/3kNL6Fvl0mpuNGTd6DnkvSop+S
 xwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GnmJm6QY6uwuwPDS9ZnNIxszLxYl2W7i6Ie1pxmgg7A=;
 b=JpeltRwDeNRUDA7ktadwdffpUqbmthN5H8D5PdNSDKXqSabwTQ+7C/T2s1ZOaAyHwQ
 yE+zTIUZmaV53ZGph/R9y4kZw0S6I0bPpAq+C38f4sYXT8AbJwUAmK0V8F0qyzXQEdvj
 zFPHY3QC43nJjY5XdKAtzAFtSmTBz1u7NCSLoMVc/ezYZIclL/J3IkgHKy49dwBiCXtp
 eUydcCkmG07oyZPQlgcgWWZfapQDy/1YpkwCWDXV1Q+su2rkpQA3qKpq3njKbIljLg2C
 Tu9Q/tpvXGoOdB5/Fm4yaRB6Jiv9BJt87aKAAbrKiZENazIMgpEhpvXR3yX5a7I+arQ8
 AQMA==
X-Gm-Message-State: AOAM532dhxehzlY9+pir9snsb/qt1w6iZ/0ZzF6n5Z/mT88NtthDAoil
 Lg6UJVALoz4QcVCP3E0oZ+CqLg==
X-Google-Smtp-Source: ABdhPJwOeZqPeFCW6QpF7wODOhiG6eJdJD0qvHUESqx68f85BpQsIxc2oV8Ye+rBtCMiTG9rGDd5qQ==
X-Received: by 2002:a1c:545e:: with SMTP id p30mr4119229wmi.20.1589878422671; 
 Tue, 19 May 2020 01:53:42 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e21sm2874695wme.34.2020.05.19.01.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 01:53:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 503CC1FF7E;
 Tue, 19 May 2020 09:53:39 +0100 (BST)
References: <20200515190153.6017-1-richard.henderson@linaro.org>
 <20200515190153.6017-3-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 02/10] softfloat: Replace flag with bool
In-reply-to: <20200515190153.6017-3-richard.henderson@linaro.org>
Date: Tue, 19 May 2020 09:53:39 +0100
Message-ID: <877dx8jofg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We have had this on the to-do list for quite some time.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

