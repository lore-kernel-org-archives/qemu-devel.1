Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A73C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF67206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnXVEDPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF67206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cwD-0003t4-Qi
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3cvQ-0002Qg-R2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3cvP-00042G-Oi
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3cvP-00040M-L1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581932566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=avE5b+uApkPkVbTUzQsA+6m2Hgms1wpG9iE4nWPQ6Mk=;
 b=KnXVEDPsRRcNi2CcyXhK3Vo3Nro0+AuPpQoCgPDgyWplU5nMCiDaLD4xxN82NmmL8LgFSu
 e+1mBrLgK5lFRLHvjsIAq6P/FEHQKshPs/Qr1DmXkYeubCABYJ8VfDvDoOz18JhIUSsDRf
 idqC1lZjtag8ngT3djbMRtpzQLop7CA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-P6vLjSAIN--A7xFH6i1jFw-1; Mon, 17 Feb 2020 04:42:43 -0500
Received: by mail-wm1-f69.google.com with SMTP id q125so6785345wme.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MuHBnO/NSlxD8zkdzf5GhFmsSxlbSVesttlYvmiRJb4=;
 b=bGiMQGhogpRoWgCWnJ5Kj5CSr9OSiBOdLT6K8FYe/deIJC0p0jNmejqb3AYs59nsHC
 jkvnhQwTZJyl4LZY6UVMQkByV5N4p/6KB6ZFBnhDZOe255/H2Tshk5LIxYTN23ANLTWv
 ZwAor8e7FJRDztHk3XJZ3MPqTPqxNt2yFIJz/br25c/eNhY4bj6RzcSD5uggDpSdzBV+
 KbKdctyc4bmeTnTUMvU8Z3wrCnLRS4jIW0jMoL3PDwu09AJAKoNqha8tcQfNonwkfadm
 Nib5qmBrl8vJbjf1Wi4fr+j11dX7kCvNzkTSw5jnfcDw++xxW/UWakZW2mN5yZy9rvJf
 UFNQ==
X-Gm-Message-State: APjAAAXkPCIDIlekW2lZ8rqkAU6C0NNkcFzHMKnJGMEUQUHFfCM1Vtm+
 YKjqc/+Z5RLPcqcnaSuDfRx0GZy3aBkPJGmCZkMx/dQTnY1YcNQ94PwfGo2ukxuPlSUbfwZZdkQ
 BIY34aNJSn+vVk7E=
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr21732969wrk.101.1581932562383; 
 Mon, 17 Feb 2020 01:42:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVtCPu0jQWBqlkTSzKF9Ji1DtCyd1xey70jOD41D0fCfpO3v+e3JeBvzB1cG9+KpeRTw9lVg==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr21732951wrk.101.1581932562205; 
 Mon, 17 Feb 2020 01:42:42 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t187sm17789442wmt.25.2020.02.17.01.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 01:42:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] tools/virtiofsd: Fix warning reported by Clang static
 code analyzer
Date: Mon, 17 Feb 2020 10:42:37 +0100
Message-Id: <20200217094240.9927-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: P6vLjSAIN--A7xFH6i1jFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?J=C3=A1n=20Tomko?= <jtomko@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1:
- Addressed J=C3=A1n Tomko review comment
- Added J=C3=A1n Tomko R-b tag

Philippe Mathieu-Daud=C3=A9 (3):
  tools/virtiofsd/passthrough_ll: Remove unneeded variable assignment
  tools/virtiofsd/passthrough_ll: Remove unneeded variable assignment
  tools/virtiofsd/fuse_lowlevel: Fix fuse_out_header::error value

 tools/virtiofsd/fuse_lowlevel.c  | 2 +-
 tools/virtiofsd/passthrough_ll.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

--=20
2.21.1


