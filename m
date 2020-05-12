Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04375CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C291C206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzgvdPIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C291C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZSY-0000VB-W7
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.goffioul@gmail.com>)
 id 1jYZR2-0007Z4-9R
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:15:20 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:47000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.goffioul@gmail.com>)
 id 1jYZR1-0001vm-2N
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:15:19 -0400
Received: by mail-qk1-x72e.google.com with SMTP id f83so14615382qke.13
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=icufpQkfVx54SdLk06P8ykURpU7I46kjHuzTIKhlG5c=;
 b=hzgvdPIQ0UK+k9PbQNzZlQo66c0AQoP8t9/0TtHmnYWerERq39zM8qeiS3y2GNBQ3+
 HByz6r+sRMUrCcamsKkSgUCwsjR1BlK8G1gbgHrFRTQDQw7xvb3rmXHjZkx6MWkCTEPm
 B8kIvP/z7gurtcrpY9MtmYkrxdKQ2SwEPL3nBtV9tY8GQ2RP/r2KrATjjDE+eAoO25WH
 kdh9qpnhJYPnaAob0skz00b9XXzIJuVwrheB3TLBe4g+4cL6Wcf8GXGcVWsZ96vjuvFH
 t0OhpADVehv/aEvpaQO3w7WpDnouyBJNEFzgK9ZPRrCqlxcS9eIvucrJMEYuy5pB5tNe
 GqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=icufpQkfVx54SdLk06P8ykURpU7I46kjHuzTIKhlG5c=;
 b=UiTmBUr7L55OT5aCeGuHnXlY689C/5g+o15uRJ9KfYIrLAHeUxLVYC9QhPTQRco0Wj
 fURjWuXg1pj4CKf0ocL27MteQbentd0qEOLqjvyGWc5/hYcxJIy5X8ZgmfC1OIISDkqw
 LfZlSUC/ampsh6PKJCs6b71B5dGd8v2XDyBFy9da6xOoNIx7E/kHCvQA+9Xdy89ys3UG
 7451UXOLCeZjHrcOLP5IRtU77i1fMWfzm1iuGw2fc8a0iC8CrBrEGjC3lVmtc0vBY4gI
 7kM4vmkSVf2QYfYVZ6VQgOYCNWVVMVLu8T3GdyziRETp75rxXCNa80ekyp/RWTwTDQx0
 92Ew==
X-Gm-Message-State: AGi0PuYvP14R/AbLpS6fqF28EKoanUQ+eR1+cfXFC5rW7kVGq2VbG+n/
 bCVuZlf9bCEgtw16skgPXpNM3DmTHaiFgfUtbUaY0mP4eio=
X-Google-Smtp-Source: APiQypLnNIUvPm8C0UP4UcmToYHywNviatHJTnNZYF/UzN7fjLFVMb3DD6ChWFTFk9s6yUZkFZrMPc5qmJXVBcoQ3b8=
X-Received: by 2002:a37:a917:: with SMTP id s23mr10523046qke.443.1589307315447; 
 Tue, 12 May 2020 11:15:15 -0700 (PDT)
MIME-Version: 1.0
From: Michael Goffioul <michael.goffioul@gmail.com>
Date: Tue, 12 May 2020 14:15:04 -0400
Message-ID: <CAB-99Lsm1c6i45L2kQX6J6Wa+FJ+aRPhdVK=+zQC2M6K7RdXDg@mail.gmail.com>
Subject: Problem with QEMU usermode + jemalloc
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f9ece405a5777118"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=michael.goffioul@gmail.com; helo=mail-qk1-x72e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f9ece405a5777118
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm running into a problem using QEMU in usermode and jemalloc (this is in
the context of an ARM-to-x86 translation layer for Android). The issue is
discussed here:

https://github.com/jemalloc/jemalloc/issues/1844

In a nutshell, the lack of madvise implementation is making jemalloc return
non-zeroed memory on calloc. This then creates various crashes in the
emulated code.

What would be the QEMU devs point of view on this?

Thanks,
Michael.

--000000000000f9ece405a5777118
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;m running into a problem usin=
g QEMU in usermode and jemalloc (this is in the context of an ARM-to-x86 tr=
anslation layer for Android). The issue is discussed here:</div><div><br></=
div><div><a href=3D"https://github.com/jemalloc/jemalloc/issues/1844">https=
://github.com/jemalloc/jemalloc/issues/1844</a><br></div><div><br></div><di=
v>In a nutshell, the lack of madvise implementation is making jemalloc retu=
rn non-zeroed memory on calloc. This then creates various crashes in the em=
ulated code.</div><div><br></div><div>What would be the QEMU devs point of =
view on this?</div><div><br></div><div>Thanks,</div><div>Michael.</div><div=
><br></div></div>

--000000000000f9ece405a5777118--

