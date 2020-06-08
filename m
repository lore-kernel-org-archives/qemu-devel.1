Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB9EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41ED0206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NpNnhrhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41ED0206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEo2-0003Q1-HZ
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEmy-0002XY-RH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:13:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEmx-0007EF-DO
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:13:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so16758632wru.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BeI2+wMWGQAJVo6hmb+Ukjf82e/io7AaJut4Bx0xTXI=;
 b=NpNnhrhGi8/Q06xuvo/2gr9JHRAK8wq0/U07BILrjmL4lBcigEBD5GMNbVm4xEfZ5U
 AggPN5siqa7apjjpWRNzcB0w7kxQ76DHNAVDDfIpREa+7DvUI21j9p2ePVEp6OIWpLaJ
 lFmLnK9ZpEXFb5nqiI2JvGaZNWa1lCmUVFe7fV0pCxg2Tfrxh5U3+SHdLvyC7HvxIDBz
 ZnZats8S9Iw6Qfro3hR3+OkqTVYjgjEipAfxHvCREPyhYVewuGB33IqfBRTt20DnxFmS
 VwJ5MVts72+nqKltFXrpdrmMjSDZnLxtvTY4/jtqBFP6WCwbVW2TDbnr6P5bNWKDoVnn
 xH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BeI2+wMWGQAJVo6hmb+Ukjf82e/io7AaJut4Bx0xTXI=;
 b=kvX5L/Rcgoz8jdp8O4uSROC2QbpniO3yhVtLlLlViefdRmufal5mYe/Wz5goslDdJk
 e0rmva2GO6QjCmezFVzGA4MjNsPaxrlh3NH5rJS1lGn+uihE8eucLbZONtteNHHgHrYK
 AWFCvzQK1TWxeaLMo+4sH3I7APQLeWsBFoAt9Eyzbcou7zXjsvlawWh0YnO9JmHhPvoA
 OU7ipFoh+uJekSlShzRQMJKN1NPJ80xk5B4SXc74Q0bBkb6+t2u95MGO38bFz2TYbSmp
 UsS0vPr3Fw25ZBxu4qBUbYK9PlLZT7gn8sdD/Qpx02rYDyYH3umX1E0/FHuGFaRomjTZ
 bYAA==
X-Gm-Message-State: AOAM532to7Jt8WLzEoZp6MNwSghzu016uD+Obit8xiLcYckfT2odGJKT
 RCr3MpBl+qd2UTEYxViwVL0NXNneAIg=
X-Google-Smtp-Source: ABdhPJzIota8plVrII6RDNH/Mgfm8Y/f5agqOh7obb6KZkp0m5zQ+aYprxcqBclNP0pcscmm9rE3oA==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr22907107wru.68.1591611233839; 
 Mon, 08 Jun 2020 03:13:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w15sm22005982wmk.30.2020.06.08.03.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 03:13:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 285D31FF7E;
 Mon,  8 Jun 2020 11:13:52 +0100 (BST)
References: <20200605093256.30351-1-philmd@redhat.com>
 <20200605093256.30351-9-philmd@redhat.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 08/11] accel/Kconfig: Extract accel selectors into
 their own config
In-reply-to: <20200605093256.30351-9-philmd@redhat.com>
Date: Mon, 08 Jun 2020 11:13:52 +0100
Message-ID: <87img17tlr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Move the accel selectors from the global Kconfig.host to their
> own Kconfig file.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

