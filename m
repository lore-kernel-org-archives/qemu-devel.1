Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFD4C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 09:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A42920850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 09:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDGYA9Ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A42920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFFG7-0002Zj-IQ
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 05:47:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <icarus19971031@gmail.com>) id 1hFDpX-0003sg-KX
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <icarus19971031@gmail.com>) id 1hFDpW-0000Hc-Kv
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:16:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:34178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <icarus19971031@gmail.com>)
	id 1hFDpW-0000G7-7f
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:16:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id p10so14904671wrq.1
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to;
	bh=Z3fsu5j20XwEQh2B5p1tR6F61TNo+5Wzwdar5pHXNwU=;
	b=LDGYA9UlrQtfAuSrNPZLj8ZfBp/pnNHLEc8bgHn8WTm8XkaFAsbuP+fLhwdibsjN3+
	8qkYyCuqgBAKv2vmMaDuceFXuNkGEWVouuq1gBRNDXr+vg3shjAHk8utlVfSbDoY/84G
	OnHKjg5+ntBd/ZpK7ZAHV+fVsJRZkQ4QbFYoUNMnONt7VxSuXq1vW+F6xCSMjtLDAEa3
	99FdC2JTk8qHbYI3CdHHDdHr02Q5o9w7Rv/duCQAxyVgjuGCmt51IakQA3dF/ew4MBKM
	o9wYeAv3GHxhalNp5ysAOUQ5Z48r7LeMoDB9boNNowMDUH7ugkvt9XYFoCANNQ1QeLg6
	xK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=Z3fsu5j20XwEQh2B5p1tR6F61TNo+5Wzwdar5pHXNwU=;
	b=t+20zAPuku9TSxwYOc/WTF1c7TwbmhFWDzGYvtcVkfUeYQbK2x9RCMN2jipncachKT
	WhMwLWGguueoEsfNEZGvdc4U0CYGrqYRl1enPMxdUXTi5hgvfpVK2q1NU4R3KcP7hUg3
	Zh2r8b+Yr0tWQECBoiBD4V3RChgaW7RdfpWgvingtkm8BulNYa8IJGdTWzoccJgqnadW
	nph/9hkn7y8gRonOqmCkTaAsBj2sQV7bpzp1K0QYDpqxm3af6q0mS+9Cm/5AI6b37doB
	gPRbIPZfDQ1zhbPm5+uKjHQhoc45B8N1frQ5POZx0HJEqTl5ZWWpapdWiKe/jdVWidrr
	bH4Q==
X-Gm-Message-State: APjAAAUmGKlpwXRoJCGo/pfYS1gp36IQnNl4cgOcaSTG+XgEF09YKpDX
	WMUtdTQ/7qG1Cqr9p1B0T8tuaZdMzZZVXjpefJx98oRBQm4=
X-Google-Smtp-Source: APXvYqxv9D9DKSv1w0ySerQl2unRbIu5jm08RebvLZWpU6zIz2pTtCyaWA+zBZ9FyEoRaFVyrXge3FTX+hjoT5dYWCo=
X-Received: by 2002:adf:dc4a:: with SMTP id m10mr38339212wrj.0.1555143363651; 
	Sat, 13 Apr 2019 01:16:03 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5a6L5bu25p2w?= <icarus19971031@gmail.com>
Date: Sat, 13 Apr 2019 16:15:52 +0800
Message-ID:
 <CA+7cjLHg8+X0GDGLbk=Dvo=Hjo_LpECa-bPzMO-higpnKoo8LA@mail.gmail.com>
To: qemu-devel@nongnu.org
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::433
X-Mailman-Approved-At: Sat, 13 Apr 2019 05:46:38 -0400
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] How to use QEMU's "cpu_physical_memory_" functions?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413081552.INl6-BkrBHyOz9tvGJDxshHmfp1_e_qjKOsekolZe3k@z>

Hello all,

I have started a project which requires the host to continuously write to
VM's memory. VM reads its memory and performs some operations.
I've found in this thread
<https://lists.gnu.org/archive/html/qemu-devel/2014-11/msg03166.html> that
I can use QEMU's "cpu_physical_memory_" functions. And I have found their
definitions in "include/exec/cpu-common.h" in the source code of QEMU.
However, in the package distributed by the distro (Arch Linux), I cannot
find the corresponding headers. So I just want to know how can I use these
functions.
