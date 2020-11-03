Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E001EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1394D206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOpTJup1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1394D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZuU4-0003UX-Sn
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuS1-0001tr-WB
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:26:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZuRw-0006Pv-TS
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604402763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w6SR3qexhew8QZIGrvPyTkX19QMU0Fd0kp/bKXuvp+g=;
 b=FOpTJup1zflmdBQ5+mmx807vXQQqdtXWYaQPaRAVDTJ2+DSeoXdDskAQh6CzbbiQtpxaQc
 4pO9npSjI1jTdO0/n0Tdj4tf0ZHQnA0L5AkUgt3UX3CJJqPAK3ze4DgdYynvpYDleK71B6
 yJhVMQ4p9NQ8EUlifPm/1wYKhg/18MU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-PrdSR8boNVyFux6VJo08XA-1; Tue, 03 Nov 2020 06:26:02 -0500
X-MC-Unique: PrdSR8boNVyFux6VJo08XA-1
Received: by mail-wr1-f69.google.com with SMTP id m20so7721157wrb.21
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cOwvaFDpzfqQSMkONe6gZYr5s6qKTKepFSfx14/aQnk=;
 b=HTx9BqtdgWMVovOY+ChC9XmlcYgVrly9XLGIcELDJu3gmgSpwqiJrhUN2uOhh3Gaow
 mdw2767kx75xTfta8RSQZqtirBQtxjOg/Jo4B87vgL0AMVVE7OUD7G5xa1UEloxCCovb
 wAL/3PYCCV6jqYgzACp7JCP6HhZrnqnph80apx8hSMogHvpg71ym+L6up4ImGU3/CXPo
 SL4/eb6GA831b5lMXjZ/SOW8LuNa8uY4/H2D7BtM/YptZlpFeMwHTlQtw9DTZBHWydi9
 PnnfbdUgXDcYU1bpH5hA6Zt764Gtg0SeGHMXqt1RXznHnIjSGIyRmdwj9BS90SvDaWYS
 4QWw==
X-Gm-Message-State: AOAM533cN1yTfugT3rf0ZYEJFN3Wq0jfekLSCgSZQcEsmgbk77RwXDDF
 3fIQJqjMXjycVYljvufdU+b856QhO+3cL7Q4PL9S0zA9t5cGYWkmmgVcANgPwy+HPQBJuAxp/CY
 k9M3M/0S6T3Qpc3g=
X-Received: by 2002:adf:e412:: with SMTP id g18mr25553138wrm.211.1604402761107; 
 Tue, 03 Nov 2020 03:26:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw17AtmRu+w0do51mB9pndzGMRGWZz15JWAOyp8bO7a5U9dwZzSMphQCKJO+S0BoWeykkaiWA==
X-Received: by 2002:adf:e412:: with SMTP id g18mr25553111wrm.211.1604402760885; 
 Tue, 03 Nov 2020 03:26:00 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e2sm27096967wrr.85.2020.11.03.03.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 03:26:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 0/4] misc: Trivial format string fixes
Date: Tue,  3 Nov 2020 12:25:54 +0100
Message-Id: <20201103112558.2554390-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IIUC qemu-trivial@ doesn't queue patches during freeze,=0D
so it might be easier if patches are queued by respective=0D
subsystem maintainers.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (4):=0D
  hw/display/cirrus_vga: Remove debugging code commented out=0D
  hw/display/cirrus_vga: Fix hexadecimal format string specifier=0D
  hw/ppc/spapr_tpm_proxy: Fix hexadecimal format string specifier=0D
  migration/ram: Fix hexadecimal format string specifier=0D
=0D
 hw/display/cirrus_vga.c | 20 +-------------------=0D
 migration/ram.c         |  2 +-=0D
 hw/ppc/trace-events     |  2 +-=0D
 3 files changed, 3 insertions(+), 21 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


