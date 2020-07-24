Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA29BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9322067D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQJwPOsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9322067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0vT-0006Yz-Ur
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jz0uU-0005sp-AP
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:51:02 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jz0uR-0003pC-RC
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:51:01 -0400
Received: by mail-ot1-x343.google.com with SMTP id d4so7495383otk.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mEK9pVtn8OTnRqFPVulGsiQgPRl3WH4pHNYEMgTfTKE=;
 b=MQJwPOsrufS9q/1K3Uac4aG8ZTVY3wRpdXM6nKH7XpWzLqJA0SGq0ih4xK18TsMied
 w2dwsXNwahMggxeTfFyuf7bmePHa8oaNWnK2ycJXadYt4+p20isi+ORSh2/32n9dCYPK
 4AqsWJfyyCXkSyvVyDoPYyMlMLqYly18Hm46qMV48YeqHhfnc8eSwdWYfTwsXpba/lXI
 +yCL5FBNVSkt6xnLZMxb4eK+s+uOXOn2ZGCL9JXTaQcaYQ35z1HM8uR6GMOYCO4gbekz
 iKPXuc6q5gHeGSE2shGfe6KBClDm+sWRmPnU9g7TucoV8YP6s3BfsjXWtCrV+XfPgpqQ
 24fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mEK9pVtn8OTnRqFPVulGsiQgPRl3WH4pHNYEMgTfTKE=;
 b=Q5EH7RbknmPl3BuYbcHjWtHO2t1hozFMBKBo7lCfN2EjJBkDD/b8Z/j9eZK8kguGJX
 2dX/ZYLgb/mSP0Rzh9nnaDofMUJGjTTbhpp+r8gr+uFPOm03g1oVczHMBx2bhIK5pQpg
 NQrDmjcP1dNr+udPQKmR1J4oG7PBKt7y18JzbpBzGAKfvmmJnyMpUP4FYqVQtfAhAgGY
 hQtKoOqeMOTnFGLVDLNWc+llCodNMqeD9CS/0ekCfM2+f/rR9YOwaSFdwu1s2jjxfHfF
 KRUc0lSqFW4dxh+ei98+V87NBXM0GBzq1NJQ+wiu22D4LiBdg7qIjN8JtsVxo0E6oBX+
 Hejg==
X-Gm-Message-State: AOAM5324FfPDx7+WSyqiXIA9FxDFgtZGi3wlKe7kBwj8ZrKp/VPZrtBz
 OECavwKWy0VQpM2nr/Z4hgjNi+f5fy9onxpg1Pkcmg==
X-Google-Smtp-Source: ABdhPJy9gGeJVfVamCiyC940n6fEz9fE4Dt7WoYy6OJybe2UuvMXikCE3ba9ZT5wYH+pmP0+mYr2h46qX/OkyL9Z46E=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr9915971oto.135.1595609458228; 
 Fri, 24 Jul 2020 09:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200724143220.32751-1-thuth@redhat.com>
 <20200724143220.32751-3-thuth@redhat.com>
 <20200724144651.GG3146350@redhat.com>
 <506e2579-410e-8553-6cbf-508793bb35a0@redhat.com>
In-Reply-To: <506e2579-410e-8553-6cbf-508793bb35a0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2020 17:50:47 +0100
Message-ID: <CAFEAcA9C9V_sJT15jkny+zDzZgGDpuQSkuU6XjEDp1i7J0r8CA@mail.gmail.com>
Subject: Re: [PATCH 2/3] cirrus.yml: Compile macOS and FreeBSD with -Werror
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 at 17:46, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> I guess we were expecting the distrib to update the pkg.

Apple's view is that you shouldn't be using the sasl header
at all but instead their proprietary crypto library APIs, so
I wouldn't expect them to ever ship something without the
deprecation warnings.

thanks
-- PMM

