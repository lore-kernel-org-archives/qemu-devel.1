Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0F5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2910F206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyKTDdAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2910F206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEko-0001FN-FA
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEk0-0000Nh-Cf
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:10:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEjz-0006qj-Hq
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:10:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id y20so8164823wmi.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=awpi/2nm/ig8o95FaaURWEmTZOnOilwQ5zsR94AtALI=;
 b=kyKTDdAjEFMI+Kg1/egIjPjI99LTHpFrU/5TT6jQ0wq8Y9Gx0MZfIearRm5r071eJg
 b1vFUjQhbKJBPGWvfi/rFFV+N5J/YkHHSbjac2mVoMq8DZbgT9tsoS7RV7uZbicIIJ6q
 c4xbippWW5VyZXexNU3Ib7Ishn2/GrJo9gCF59kOfoJ6Vhkvfc94bnd8zzoO3PnYKI2X
 o0KSBuMwVJu831JyBWMU9vG1UL1St4mh6PH8imGbRiCyusPRZMiixcEoXm8gIpxsLsTQ
 YMAZF9A1ntsCscERmTIhdc3q/VH33q2l6YV9qIw+Nn4FKMnO2Em0Y52lP8nWkJ1766pg
 wHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=awpi/2nm/ig8o95FaaURWEmTZOnOilwQ5zsR94AtALI=;
 b=OCQ9bvBqD17eK2JAGO7PF3GWvbyNXEpbQcYmNY4XafiSDZU7dDiDyMvkdhG/AT8Oeq
 C/olx43kjA35dEUcz8j5BRoAVt/wiDXV4Pc8pWYJWvAqs673J6Hwt3BJPHGmOdwekKH2
 QtdF0wlDge6zR4Pf6PwT08YPf5B3Xfzmyvm/Pu1e1Q72LSolSO0tzfNOORUS5uA3e1wt
 qw2ESNJORKoDBf6hRXYHB6ybYLFvrAeYSC2ax7nl8Co2rG7/UzHcrmXf8Oftn0LpFUjl
 kI5no+ut8dVWYeX3wHgoKgmqoHiztWhyOIiyxGxywlZAXV6nVKbFz2GKCp0YwQWjj3eT
 gR5Q==
X-Gm-Message-State: AOAM532JxnII91BOisAjkR8gDh2LrkGIZNA0vbxwjnh8EjdRT/D0wVFa
 r4BkycLW9fggMileBJ+Or5h5RPH33TY=
X-Google-Smtp-Source: ABdhPJyFvawY8tx89xrIU7u6+EnvJYqwNx2yBBzY/XXZDYSPPRlO9PvbPk2b+erV7/Zvi+BXEb2vCQ==
X-Received: by 2002:a1c:8107:: with SMTP id c7mr15696005wmd.20.1591611049449; 
 Mon, 08 Jun 2020 03:10:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d2sm23039413wrs.95.2020.06.08.03.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 03:10:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9BF7D1FF7E;
 Mon,  8 Jun 2020 11:10:47 +0100 (BST)
References: <20200605093256.30351-1-philmd@redhat.com>
 <20200605093256.30351-7-philmd@redhat.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 06/11] Makefile: Remove dangerous EOL trailing backslash
In-reply-to: <20200605093256.30351-7-philmd@redhat.com>
Date: Mon, 08 Jun 2020 11:10:47 +0100
Message-ID: <87o8pt7tqw.fsf@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> One might get caught trying to understand unexpected Makefile
> behavior. Trailing backslash can help to split very long lines,
> but are rather dangerous when nothing follow. Preserve other
> developers debugging time by removing this one.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

