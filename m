Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4A2C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528D72073A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVqOWzir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528D72073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfkf-0001N4-7D
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKfhX-00057r-Sn
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:39:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKfhW-0007E6-6g
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:39:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so16515239wrm.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B8H6V4e1XVYdAFgV1s6ziK1FXTeikntdsLjCrxk5xU4=;
 b=KVqOWzirecUTbIcMppRpPRvky5bRm1FVMVuN+Z0IlnOO7aVu3XRc7JiQB0NolJtK7M
 lawuqWULH2t4ygeRSXLy163HI5uQSmZj72X7LIyKZetuQ0pp1WNHEi2do9N1elOLGXk1
 k3j8hyY3tOxA8GcjW+lWoCBxTvdo+sS5E4J0mxRg+XI8zDfVVrm+6XdF03meDKlCfL0z
 ezgLj1vWt+I+B/LK8mUWqOmGPQ3JRp6Pw/LvASpMRmuCnWgvVQfKKaIyU9nWaqm4Ited
 lVf8a4Hs6L/brg4hEp6jChXnBFVXxKItL4Dx16IZRQ+tt4vnbsk5fFyqtOlQ19SCxAE/
 Yiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B8H6V4e1XVYdAFgV1s6ziK1FXTeikntdsLjCrxk5xU4=;
 b=jgzoa26++KAtZ5cUYVGL4ENq6CI/SKv5te7PKkUm/b9y4sqK14Wo9p+56Lw0DWCGuW
 FHPDxFiQqZmyh88f9d0FTJjdHWVjd9ilBw+RV1lE4thvR/7cAFZ05qUTUXG6qWF8tYp+
 pmLdNIA01mEhexaiiolIsDP/S07tOpvFpzGWTz0/g+yQi/kO64/1OBS6OFyAmjuMGI6C
 h6GlbULcFZJNDCEh0wWGnbc1j4EsSsD0UAz89TbpvtFWBpQqoyQSCllcg1c3YC3gYDon
 U/MpWYsDXYURBc+ktp7SCL5ygYkIzJcWmCw7Ra8jCoG+4HvVDr/Q2y8HSLANO7Ep3KcC
 E+Pg==
X-Gm-Message-State: AOAM532h8bCdb3xRRgm+Ruz+c9uat7Pehsay0zIDJn6CieA96AHh6ef2
 KbiiS/l1jZiJ5Uyhil39tUk=
X-Google-Smtp-Source: ABdhPJwZqoCz1B2h3MHIyN3076iHKrVD6D4zs13B/Oh+UGKRUMvEx1o6lPFxjmDKnA7CFDrwnNr3Tg==
X-Received: by 2002:adf:fc4e:: with SMTP id e14mr1393229wrs.329.1600771148631; 
 Tue, 22 Sep 2020 03:39:08 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f14sm25487226wrv.72.2020.09.22.03.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 03:39:07 -0700 (PDT)
Subject: Re: [PATCH 5/7] tests/docker: Remove old Debian 9 containers
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200921174320.46062-1-thuth@redhat.com>
 <20200921174320.46062-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9385bd6d-8959-2cc8-259b-01cd40011d3e@amsat.org>
Date: Tue, 22 Sep 2020 12:39:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921174320.46062-6-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 7:43 PM, Thomas Huth wrote:
> We do not support Debian 9 in QEMU anymore, and the Debian 9 containers
> are now no longer used in the gitlab-CI. Time to remove them.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.d/containers.yml                   | 12 -----
>  .../dockerfiles/debian-win32-cross.docker     | 38 ----------------
>  .../dockerfiles/debian-win64-cross.docker     | 45 -------------------
>  tests/docker/dockerfiles/debian9-mxe.docker   | 21 ---------
>  tests/docker/dockerfiles/debian9.docker       | 32 -------------
>  5 files changed, 148 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-win32-cross.docker
>  delete mode 100644 tests/docker/dockerfiles/debian-win64-cross.docker
>  delete mode 100644 tests/docker/dockerfiles/debian9-mxe.docker
>  delete mode 100644 tests/docker/dockerfiles/debian9.docker

Yay \o/

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

