Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8EFC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E080F206F6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIqZVSAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E080F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz2M9-0007F0-7O
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz2LH-0006VA-Ci
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:22:47 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz2LF-0000pR-Ls
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:22:47 -0400
Received: by mail-pf1-x441.google.com with SMTP id 207so5668904pfu.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pyFP+C6Po75g8DzqI9Oqtb0khUzIqh9fT7qaT24cPSc=;
 b=YIqZVSACeJzCiYlpYi6zK1+44BN3AhRhw8s9OPlPbLZIfErXUcSmJ4k1k5z/z7faa8
 38RO2kpk9bNNW6UnEVtDmp4FWwo+WBC+m6fNIyw5nP2aEdU4j7lqbcOvqq7e+IanLDmH
 MXgqhBG8ffkWClTveXvSX95GBgv95KMNn4h/0LuOnCQthyS7lKs26CxHiCNnVHz5Xx8Z
 hI8GPxLuMILPW45Aq6tJIHKfSf4ctSQZPi9IdrcJpDgaGeQS58hOeEt6dVi33tU17TSx
 AIbtwY8RCb93h849aYlnPAdt9Ef8hBbWEa5vApNKt4cH3dds8sHQ5yq37v7jDW121RrS
 ANBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pyFP+C6Po75g8DzqI9Oqtb0khUzIqh9fT7qaT24cPSc=;
 b=UgA4MjnwQFr2cVcWBQDCCKt8lUhpiY2B5C8mfh+zGE4iJQH0iFHHFVXd/rgcDlF7bE
 0WWeEeC+uK4yK78y4wJUR6DIM6RZXD7dpKT3Rc8HlD9dHFPBBtNRo0Z0g2RrtNvIU383
 TlAj6xT5yCOwEVYTyOd2sGxS8+ZiwetrDV9zm36JUyS96BhESCCyK3jjS+VOpt1V1Zp+
 XrJ8vw7hQJuGF9dFD+gMDitiH9giiHWDmZ5Ss8MLszxvmILwDZnESFaJormmde24axem
 DtF93H0P+oWT7C4WZa/6yFjdGLgibdSvd0Mbcgr0eS7u6S1tQ/Y2TauD0B+i1PA9GIDI
 bRAA==
X-Gm-Message-State: AOAM531HIcOaNvMpkj0RoUyJ5c6mCnguCdAjsoHjrJBG35C2+gNievvW
 2yUrYtNLkhwsbVQTubwTQ/rhuA==
X-Google-Smtp-Source: ABdhPJx4SA+ZVPY0r3P3ikjP0+JldG1miWqT1GTwox1gDsDE0R5llz/jIIwioFeB5IU3l5wGWdVkLw==
X-Received: by 2002:a63:3ece:: with SMTP id l197mr9795919pga.313.1595614963885; 
 Fri, 24 Jul 2020 11:22:43 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 k189sm7336762pfd.175.2020.07.24.11.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 11:22:43 -0700 (PDT)
Subject: Re: [PATCH v3 06/16] accel/tcg: better handle memory constrained
 systems
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200724064509.331-1-alex.bennee@linaro.org>
 <20200724064509.331-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1927ea61-184d-59ac-8ce9-1eff32a0638d@linaro.org>
Date: Fri, 24 Jul 2020 11:22:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724064509.331-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, f4bug@amsat.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 11:44 PM, Alex Bennée wrote:
> It turns out there are some 64 bit systems that have relatively low
> amounts of physical memory available to them (typically CI system).
> Even with swapping available a 1GB translation buffer that fills up
> can put the machine under increased memory pressure. Detect these low
> memory situations and reduce tb_size appropriately.
> 
> Fixes: 600e17b2615 ("accel/tcg: increase default code gen buffer size for 64 bit")
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

