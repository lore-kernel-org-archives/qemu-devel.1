Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE3AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0AC20735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESON4CAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0AC20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzSv-0002sl-5B
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzRm-0001Jg-TG
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZzRl-0002f0-73
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604421971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NSwSP5/EfwYUeVDkqz5A19OUJDGOoWcrxFHY8fiOR6U=;
 b=ESON4CAAhBfnXug5lBNEjgHUgo81fvVJNTj+zs1O81QgbCbBgEBquTDM9aNJiPEecW7NUT
 UugQvldywoXnzKg4pxhbefz/600N8hNhHatXq5nSZ+DPm8fVMyaESCCkdC5Gq68OzHW3Qf
 k9dBeePqxapWJA1h4wvmBRKhRidV6/Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-PbdoCcPRMN6WYYrlJXdiiA-1; Tue, 03 Nov 2020 11:46:08 -0500
X-MC-Unique: PbdoCcPRMN6WYYrlJXdiiA-1
Received: by mail-wr1-f70.google.com with SMTP id p12so513187wrx.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wY/++0DU6bRHPHPjwERfNPBvmLRbiuld7zaCTtw2voE=;
 b=KwvwG7AVGkfRfUv38I0VHgpQeALiRfQpiSgi2fOa4SHVbXlseVNddnACOYS7gjpopM
 27jHpYAtvBWC2xnnAUo4fWJkE9QphrZU96JkeUEDNLEA7oARD7r8hG00FtPnIpX2v11w
 aZX1wOhFBYuzSqRyurJEHndcw1ss1IMZ88IjS6/OxnRHdVYv9wn1RBJvQ1lewjGZAJpA
 Mt/7pgi58Dpkx265BFKZ8BLEMi1GqdYZMDHqOC4+MYIjje812e/kcSZ1WbxHy7QC1JEP
 WmbIzfIfqN21yTRPTTGgt8gqu112CqXNZsDvp/dlOD1Jp8xCMxYOD4gURB3cguM9m43q
 9vEQ==
X-Gm-Message-State: AOAM531tPSbocCNwg0jwtSJtz/VYBQNoaz5YBrRCHb1lmWdAqNUqAaKs
 DRMFTnnXhlU8wE+SWqV3RqcocwAeiJRklhC0TaSdTi3dWjRiODIu6s1FbjEh8QXLG3Vz4+ichxH
 u8dWMLHPtDlvhRew=
X-Received: by 2002:a5d:5387:: with SMTP id d7mr26862987wrv.224.1604421967159; 
 Tue, 03 Nov 2020 08:46:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7JwfeiUIkiy9w7JVvj7+mqixthyJ2ytbVLV/1X7tdufnIYfDexz6QXmrgF3ZzBZ7gOeK0AA==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr26862956wrv.224.1604421966966; 
 Tue, 03 Nov 2020 08:46:06 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 130sm3839061wmd.18.2020.11.03.08.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 08:46:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 0/3] ci: Move --without-default-devices job from
 Travis to GitLab
Date: Tue,  3 Nov 2020 17:46:01 +0100
Message-Id: <20201103164604.2692357-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a job covering the --without-default-devices configure=0D
option on Travis-CI, but recommend the community to use GitLab,=0D
so build failures are missed.=0D
=0D
We need help to move the jobs to GitLab (we will keep the s390x=0D
and ppc64 containerized jobs on Travis as there is no similar=0D
offer on GitLab). Start with this single job.=0D
=0D
Cornelia Huck (1):=0D
  s390x: fix build for --without-default-devices=0D
=0D
Philippe Mathieu-Daud=C3=A9 (2):=0D
  gitlab-ci: Add a job to cover the --without-default-devices config=0D
  travis-ci: Remove the --without-default-devices job=0D
=0D
 include/hw/s390x/s390-pci-vfio.h |  3 ++-=0D
 .gitlab-ci.yml                   | 11 +++++++++++=0D
 .travis.yml                      |  8 --------=0D
 hw/s390x/meson.build             |  2 +-=0D
 4 files changed, 14 insertions(+), 10 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


