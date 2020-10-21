Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56703C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBCA222E9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ww9SUwIY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBCA222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVILf-0000KY-JL
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVI3z-0006kR-LD
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVI3u-0006Ud-7G
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603301888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8FHdCr9ud0R7GrcxJ2jjx4dLL/9v3p41PCfQyp3MRA8=;
 b=Ww9SUwIYdkMtCuQS6W4FqTT4brQzqXQAJ4esF5CSCdHoX3Pei3O03rRpoEz2HdYIt6Epdc
 UO1DWIB0tSTf/T8tyDkD2dAwQ1wYPyOPiOWXnZYT5bQWKnbjegA6t8omlTb/27lAfrokTX
 Ri9y3jWaHp6YdAydkD3YLw0treT5mww=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-CES3ViPQOOiI88m1yO85ew-1; Wed, 21 Oct 2020 13:38:06 -0400
X-MC-Unique: CES3ViPQOOiI88m1yO85ew-1
Received: by mail-wm1-f72.google.com with SMTP id r7so1816105wmr.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BdY5+cEywpA1c1J3NT7Mr7RHwPmtZc+GMm+breuacYg=;
 b=YymGpLTzN4kFTv8SsmXYoUoUEmCKzJcZnW+8p5AHO1bTlE2blndVZIpc/9iqODuaNN
 TYRBo3Jtb+jngQBYSEgz0iPJlv6rTX/Kemj4RWvtPyAcJTjt6ssifej3jmjf3UiCzTEW
 1HSSei38n83XRZjpbhaxT7DTEtlrFkPt0NsVI/RNFvIOmPoBeQgvmdsnEbGn1AGNCxeL
 TAdZC+mP4Lgrv3zNRLCWdSfZql5vNlEcWlcLrRCzhZCpuBa9Zp2wdIRWRYDf80/9+KBz
 FkqKhlCcuDlF6cu5VZJjgfxOP9rKZ3UEL7OQ3YO9vY17vqM98PzUlE+3LiQ2rFqwHipx
 Xzwg==
X-Gm-Message-State: AOAM530EuFsfryph34MUsCyRBcFGD26tnphnuDk4r1OLwfM7To3esCPa
 T1ZXHEYrhot9WmfzRgn4hWhmJENsNs7jB8IljD/DUxc04P/qCXf+XzT6ugO/rLE0cs1X3N+kcD6
 fM7VhTGOSNurnftw=
X-Received: by 2002:a1c:2302:: with SMTP id j2mr3671517wmj.100.1603301885790; 
 Wed, 21 Oct 2020 10:38:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNXrNhzGHx0nqeZ/xZbGxmW+C5bgoLyJmRB52wlWdmdjs0Ibf1XJIiTdZZMbk2GVpxwVF+fw==
X-Received: by 2002:a1c:2302:: with SMTP id j2mr3671505wmj.100.1603301885658; 
 Wed, 21 Oct 2020 10:38:05 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x81sm4606503wmb.11.2020.10.21.10.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:38:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 0/2] util/oslib: qemu_try_memalign() improvements
Date: Wed, 21 Oct 2020 19:38:01 +0200
Message-Id: <20201021173803.2619054-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Use _aligned_malloc for qemu_try_memalign on win32=0D
- Assert qemu_try_memalign() alignment is a power of 2=0D
=0D
Since v4:=0D
- Drop superfluous assert (Richard)=0D
=0D
Philippe Mathieu-Daud=C3=A9 (1):=0D
  util/oslib: Assert qemu_try_memalign() alignment is a power of 2=0D
=0D
Richard Henderson (1):=0D
  util/oslib-win32: Use _aligned_malloc for qemu_try_memalign=0D
=0D
 util/oslib-posix.c |  2 ++=0D
 util/oslib-win32.c | 12 +++++-------=0D
 2 files changed, 7 insertions(+), 7 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


