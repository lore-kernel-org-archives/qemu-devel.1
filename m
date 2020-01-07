Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3A8C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0352087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c/sHfPvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0352087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqcU-0004Mg-47
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioqDS-0004sE-8b
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioqDR-0002Vy-C2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:52:18 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:41561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioqDR-0002VD-6b
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:52:17 -0500
Received: by mail-ot1-x331.google.com with SMTP id r27so99456otc.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 06:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=h/jA0lsZC+KHXkwlBnEBjA1xv0an3aPYNKxDK6nX7lE=;
 b=c/sHfPvKHSbznpgO3lZ9XlpWP1eQYX6zNDKAD3OaaRKEx2dp4zFPvHx7drOxSzAz4Y
 lfqRo3TIZua1tqW9uWDCZTd2AgV5010q/sbQ+f5pSaZwMAEvOYfBnZt/TAUFEAr1HJi2
 NBysp6YfOk/s6KnI7nJzr2s6orS1o6WY5Q/E7qKnr0W/4OT1hU0RrrF2jnpZxHsSuBwC
 cMRGcrsHqWhNfgsYI4KTGs5hHHCGwvuCR5+BFHMfulO7W07UGmiz6DpOGnhdb+yx66kN
 G9eBrb9IkrNzc0mhphicH5oaZMyYNsdYpliRC3CiJaH0PK2fISuI1JTmzJBR9hB06uQo
 UW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=h/jA0lsZC+KHXkwlBnEBjA1xv0an3aPYNKxDK6nX7lE=;
 b=cVIn3WA4cmos5R5e58ejdxTRnZvoXPssAOJBm2kfXB30BlPVcNm2Oo8rDGEfEb2IYB
 edToLZrbtEVYVqCT299Z0h2M5ftkAepToGC2/8CzUutItEpLZvV12Xz4PvuRVq+hySbV
 QSeqtz11w6hkM73yT1VP4sxqkc4MvPSadBLznmxA+DIMDW/66t9hBHjjzaQjo631XCjl
 jVYVTNJRqWcylVuL+hfJYqaRmsUPGQOdx7Q/ii250BLABhEN7/lSqMG852uatSy73DV6
 dApSOyxcBD6/jdCGCRqzoIyG5WvqZiAPGxIjnygFumhS5wZ+IgmOeBWdQ8ruhut//ASX
 4buQ==
X-Gm-Message-State: APjAAAVUX6Wfhzts7vZFPIdRikj0NKp3muXzIwibDqcVlyXP3q4KQkIn
 0v2IdOHP4xc4Rd6qZNiKSE6dMqjPOGwsJnhxWJwVU+9rWe4=
X-Google-Smtp-Source: APXvYqxdwrbYdxTm1KMZV4FR2dqov0Aj0LHkFsLKL/5+RzqiwXO9VaD81+Jl4gqScaum3gHzTP6J4dkE4OHLJwTtAMU=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr126309ota.232.1578408736387; 
 Tue, 07 Jan 2020 06:52:16 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 14:52:05 +0000
Message-ID: <CAFEAcA-Q_qprNny1gy1TX=JSrJm3um=6=dQbtrHVry1ODSCc_A@mail.gmail.com>
Subject: kvm_set_user_memory_region() doesn't check ioctl return value
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity has just pointed out (CID 1412229) that the function
kvm_set_user_memory_region() in accel/kvm/kvm-all.c calls
kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, ...) twice, but
it only checks the ioctl return value for failure in the
second case. Shouldn't it be checking both calls?

(This code seems to have been in place for years so I guess
Coverity has only just decided that kvm_vm_ioctl() passes its
'needs return value checking' heuristic...)

thanks
-- PMM

