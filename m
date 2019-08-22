Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1E6C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9788121848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Px2TRvma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9788121848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oul-0002CB-RT
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43641)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3bLFeXQYKCjspXjbfadlldib.Zljnbjr-absbiklkdkr.lod@flex--sameid.bounces.google.com>)
 id 1i0onf-0005AO-St
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3bLFeXQYKCjspXjbfadlldib.Zljnbjr-absbiklkdkr.lod@flex--sameid.bounces.google.com>)
 id 1i0one-0006NS-TD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:14:55 -0400
Received: from mail-yw1-xc49.google.com ([2607:f8b0:4864:20::c49]:51984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3bLFeXQYKCjspXjbfadlldib.Zljnbjr-absbiklkdkr.lod@flex--sameid.bounces.google.com>)
 id 1i0one-0006JF-Ot
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:14:54 -0400
Received: by mail-yw1-xc49.google.com with SMTP id k191so4171555ywe.18
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=wlvDxBQ972exh1gGCGmWB631I1DcazNGMFBKHGlswO0=;
 b=Px2TRvmazu2AtBt3h/bnP0Ns7fe3hle5QzoUw4vsZjnUFpyNV/bSSJnILTagkJFTpA
 AEo1OL1GOONzgDNpBu+kmXXgi0CXtEOlyjMFRDcXz6kKmyG6QjromfRlJrv3yh9k3CJo
 kuF58uJO1jGL/v7KSQCIbACEz1bkNyYNeiHihuRN1w/9wNB6XQYWnXuMjrUjpMUdbX9w
 xss4Y7BKlsh4FGJjmMGYYP5trr3gOBp7kwFR65KnpXQYjX699Ynk9E7HBrZMWk/xSaDV
 531E7SJObIsq0xb/F42O30LL9dzcgEKVgXG95l0X5yErfA6WILCMV3f9iP9ZGo1dEdqQ
 E5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
 :from:to:cc:content-transfer-encoding;
 bh=wlvDxBQ972exh1gGCGmWB631I1DcazNGMFBKHGlswO0=;
 b=tnOgy42+NDbUPfqBaNXgsqIX7BZQK6TwBTKTylxykQp4MsPbK72Dzy6PP52DYGatch
 YSZTiAutrup1BHUPw4+HTsGyAJL/Fz9yAoj6I0FmAWuhWBbAggSvW2f8YvtCj7B/oML4
 eqjDdtoaoWcGJxyHminhY6teZRfKz3lHOc0B7c+wzha/VUpwYIYhXAHpnVzkFyIG0YLn
 FY0O92erFeRbsCG2w/itzXPjy/Ming5o3WVYQf2Jm0t2FCvPNI4w1iGkEGTSblVeytvM
 iO86/LNOioM9nGUBKOmQi8jciCeErQ7hCIn3eMrcAjlA/RysunEY1EM6km9diIkoyvjp
 OtxA==
X-Gm-Message-State: APjAAAWzPWPyOne1sqllKDYiQcQQkK3WI7oihyGZqfqOX1+ppx2Nm6m5
 3659l3EuAHqozUBwSwfrWPAcwLB+GUQ=
X-Google-Smtp-Source: APXvYqyHRaPqf9uGyVFJL6EMn7LqDbxl5LBmkYC3fZCFyK63/pwem3XUXbkB/E9Jxt6m8cqjTBQuIsG6vj4=
X-Received: by 2002:a81:7045:: with SMTP id l66mr25009244ywc.284.1566486892251; 
 Thu, 22 Aug 2019 08:14:52 -0700 (PDT)
Date: Thu, 22 Aug 2019 18:13:58 +0300
In-Reply-To: <a4e72a67-4107-4cbb-10e6-6a77011f34ce@redhat.com>
Message-Id: <20190822151358.6094-1-sameid@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
To: Sam Eiderman <sameid@google.com>, kwolf@redhat.com, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, seabios@seabios.org, kraxel@redhat.com, 
 kevin@koconnor.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c49
X-Mailman-Approved-At: Thu, 22 Aug 2019 11:19:00 -0400
Subject: Re: [Qemu-devel] [QEMU] [PATCH v5 3/8] bootdevice: Add interface to
 gather LCHS
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
From: Sam Eiderman via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Sam Eiderman <sameid@google.com>
Cc: liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> I=E2=80=99ve got a couple of =E2=80=9Cundelivered mail returned to sender=
=E2=80=9D mails for Sam
> recently, but anyway...

- shmuel.eiderman@oracle.com
+ sameid@google.com

> It doesn=E2=80=99t look like any caller actually passes a NULL @dev, so w=
hy not
> drop the @suffix part?

Just copied it from the bootindex implementation.
I think the suffix part there was implemented specifically for fdc since
the same device can have two suffixes (A and B).
This is not relavant here, but I think we still need the suffix to
create the device name for seabios to find.

Sam


