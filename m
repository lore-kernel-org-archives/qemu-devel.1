Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCECFC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98D7920644
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 15:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pp92MxNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D7920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlasM-0002Q3-Id
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 11:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49357)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlarp-0001gL-N6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlarn-0004Kn-Ni
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:20:17 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:34007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlarl-0004EQ-8V
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 11:20:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id w9so7220728wmd.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mC4yKMF4gve9tIITKvkpYtbq1oCTPM8ghSoRbyrzX+w=;
 b=pp92MxNjsE8TZ8DvEv4vd0Bx0t/tWpGC/jbpD26mfsD35Jvss8BkgQlgfGvamMeUql
 Y/+IlN9VULY4kFIPy6QzAAymj1z25/elty615nA+qjBQ9Iy8lMZXQcNUM48R7G2VdBe2
 ThD3GMpBI2xqXeN5oVcOwODVoQ7EIBiLu/fEn4DeScOzZStfZB8KDCjLy26Fn4IPmLS7
 +6qFGKd+E3btgLwEeTyJaYLl+EXnL/EvdlqDB717hSf8RMxdetU7297WTVT+wwaeGhPe
 7TmYmr2+EkMU3XB+ZFSzH0oNGSO5YEwrQAAeec6UtVE2vNXzWou3V5r6acjdOHH5W6Aq
 3IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mC4yKMF4gve9tIITKvkpYtbq1oCTPM8ghSoRbyrzX+w=;
 b=fP9VcIzTDj60xaj+DQ6b9hl8oReBirSJbmdTkpFYFIwpw87WHiAKi1KkFS+BGE511S
 IQ3Y3ikI0eV9TYjSCIzr/8emW2AXrtf8YxkAs1JPGtqGTujAimTvERUzuVJ83x7RyeDX
 CAzbvKnem3u7pAG7pnn+EcQfWuBUIZFHzgs8Mgxgsq68P/E0W/D8atoRtUGp8zt8PIz1
 ue/66Oa/qvugs0G/WmW3Sl3yfVE4l1byuPW1RvKKunlk/Mng39HFrqDbY87bvViQu4hu
 keIJVuXEkUVG2OT8O215VJK/tMSAddG6/5+xCOLj/FSsjhxrOknafPesRuosWlZWp2ri
 orBA==
X-Gm-Message-State: APjAAAWVoC1lxYYvMITSMQpCJkDWxzdXCI2LV8JTKStfs5Lcni5W8MNz
 5jTi2sZM12SVJI+y1zDaT3HMYQ==
X-Google-Smtp-Source: APXvYqymvcUcNq4nyquuqkrqtiUV+KmfTMLhrEfYdDAtCn+4KHkb/JX6A1QOk1AN8dZgHQtWkPWUGw==
X-Received: by 2002:a05:600c:303:: with SMTP id
 q3mr4917237wmd.130.1562858411120; 
 Thu, 11 Jul 2019 08:20:11 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c30sm8160081wrb.15.2019.07.11.08.20.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 08:20:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1577F1FF87;
 Thu, 11 Jul 2019 16:20:10 +0100 (BST)
References: <20190711124805.26476-1-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190711124805.26476-1-philmd@redhat.com>
Date: Thu, 11 Jul 2019 16:20:10 +0100
Message-ID: <878st4egyd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: Re: [Qemu-devel] [PATCH-for-4.1] tests/docker: Install Ubuntu
 images noninteractively
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> We correctly use the DEBIAN_FRONTEND environment variable on
> the Debian images, but forgot the Ubuntu ones are based on it.
>
> Since building docker images is not interactive, we need to
> inform the APT tools about it using the DEBIAN_FRONTEND
> environment variable (we already use it on our Debian images).

I've queued this and the other docker patches into testing/next

--
Alex Benn=C3=A9e

