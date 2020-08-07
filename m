Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10B9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1CB20855
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsHgcjXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1CB20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zda-0003Qn-T4
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3zce-0002Ks-T8
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:29:12 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3zcd-0001L5-5o
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:29:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id q76so1351919wme.4
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oDPPWD43QNHAcNhfmDN2U/IINdLcOKtQ5ou3QyOd3ew=;
 b=FsHgcjXOX5I/HC5bMQGxvJ/+0EV1MdAJ8mDT160b1z/qj/pkkxHX/r6UXUgRnYQb5P
 aw19JW/UCqQo9nn9pjPGq8keoA60gdANq0ywslfP7Q3DLkqwwcMyakeBaCamrcF6lcbX
 bOJjMZ0xkNtVHGbnjbpzHR8Dv6mrFMurt5nBdsn+rWVvc56BOJ0QYZLc3N1AA9cMP+gB
 AisgnIdpcSETBWdBUg9qG1TCs9NQERRAY4tt3iFJYBCwpceOyOXCJtwQgNkk+a/qi7G4
 QZ/FiBJ1M4JBmU8g0owHBf40CScny5aSAyyVyTPqaiH765oMF1lNxAJPGKbkMF/WF55W
 9iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oDPPWD43QNHAcNhfmDN2U/IINdLcOKtQ5ou3QyOd3ew=;
 b=UqPuq1Z/WFvwMlKc4+iL+praSKJxLI/6wbKiyrGY7ABBA8kev+OffVZSvngZ7ZCJnr
 zSEW7pjtRo7m3MEkvVpRrOsWOGs7nuZ+97yxBiMIDCZS6KSzp9m+1YmS70ab2ix+CXCF
 5jvuXejggAGh9lKE2iRwwhKN1HGQrXjC+LZlE7bEz0KC7MDnE9hC/+ieJdJ8AnYOHZxw
 EWPJ6GXXSf6HUH9O1oHjvk3sevAGzVwrNGy+OH094RYjIRa8BV+MXVSNMk3kAqf3aM6x
 e3FjlBEeqVHwLKeIErvAoxFwXC+XyhZKxuhRgTQjom6xSsvb7cpIJ/EeH9w7/Vd+q8zb
 dDbQ==
X-Gm-Message-State: AOAM532Jsh4mpa/fjbKSVzVzm4wPd7VTsTWO/d7Oq3Ons4o7CpbjEH0z
 Xdtjm/jebRLSSbcDagUAXpXrfA==
X-Google-Smtp-Source: ABdhPJzfvK5iFWVJYWkf9YPa+TSd6m3/l//h4Xi7YPJHZxyB0FLHIGEb9DzvVWpJR9nqKmmJLEumrw==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr12526624wmi.85.1596796148851; 
 Fri, 07 Aug 2020 03:29:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o124sm10067924wmb.2.2020.08.07.03.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 03:29:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 89A921FF7E;
 Fri,  7 Aug 2020 11:29:06 +0100 (BST)
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807085302.7d7616df.cohuck@redhat.com>
 <CAE2XoE_eMv_=zoEe-v1HiqcKX+FNobKSKzV=9eLkJNivnuYg-A@mail.gmail.com>
 <4e8addca-7400-f1a1-ee56-991def2959ae@redhat.com>
 <CAE2XoE9HzvHOQ8odXwiOw+nsYOkwTK+jue1i-mQ6Mo29T+9Rog@mail.gmail.com>
 <c6059e0c-ed50-399f-111b-4d4b96c80e85@redhat.com>
 <874kpelqjy.fsf@linaro.org>
 <13b9e7e7-c86c-35fe-cdb5-002c93e73448@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
In-reply-to: <13b9e7e7-c86c-35fe-cdb5-002c93e73448@redhat.com>
Date: Fri, 07 Aug 2020 11:29:06 +0100
Message-ID: <87y2mqkavh.fsf@linaro.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, jsnow@redhat.com,
 Cornelia Huck <cohuck@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 armbru@redhat.com, luoyonggang@gmail.com, stefanha@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 07/08/20 12:05, Alex Benn=C3=A9e wrote:
>>> On 07/08/20 10:31, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>>>> Any IDE works with meson properly? Does meson have vs code plugin?
>>> I'm not sure what the plugin would do.  However note that even with
>>> Meson, QEMU would be built with "./configure && make".
>> One the subject of IDE's my Emacs tooling (counsel-compile) uses a
>> mixture of "make -nqp" and "make help" to probe for potential make
>> targets. I assume these are still probable with the meson generated
>> files?
>
> With the generated files yes, I have no idea how counsel-compile would
> deal with ninja.

It's probing for top-level targets. So if there is a way to query ninja
for that it's easy enough to write a probe to collect them. The make
-nqp stuff is a little janky but basically greps for .PHONY patterns and
assumes a .PHONY target is a top level target. The help parsing is pure
regexery:

  (defvar counsel-compile-phony-pattern "^\\.PHONY:[\t ]+\\(.+\\)$"
    "Regexp for extracting phony targets from Makefiles.")

  (defvar counsel-compile-help-pattern
    "\\(?:^\\(\\*\\)?[[:space:]]+\\([^[:space:]]+\\)[[:space:]]+-\\)"
    "Regexp for extracting help targets from a make help call.")

I guess I'll have to see what:

  ninja -t targets all

lists.

--=20
Alex Benn=C3=A9e

