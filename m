Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C87DC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73D52231B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehPkGyV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73D52231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZbnV-0007Ex-O3
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 10:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZbml-0006JM-Lm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:30:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kZbmi-0000MY-Qb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 10:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604331014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=arJBmlM6IG2hPcLfZlVzk+v+1cDINlLCFX8vHC17N8U=;
 b=ehPkGyV2f7oD3i0s/tfiTb62LM9HCylYVQvl8TsMWN0pArhA5dE9+i5x9ZSZJVjOu+ESdT
 hZNNCzcvTSLbSsTiElWDO7yD/Of6b80chPK61zYwOItDOCjzhmkbdXk6hTlCLH62Jwx3r2
 PURG8E7h2pnVU+D7+OWg3tSxsyilF3M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-KMRvq6VDMBeeS2FxyACM8w-1; Mon, 02 Nov 2020 10:30:13 -0500
X-MC-Unique: KMRvq6VDMBeeS2FxyACM8w-1
Received: by mail-qv1-f69.google.com with SMTP id k15so8464875qvx.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 07:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CzrdXMkVfNp/VvQS48eADVJT/nqQlaUHIHKtqGjySo8=;
 b=DGP9ZezVYfwQ8kSIGnSDAmL58fc0bCEmzU6QI0ViAXzGbcUZPGD16IUcCESWUvvJtn
 xzElbnqnq9V4rdsjNF7brJyGDNQ6m+MwrWmu4Z+HhVBrVOwnYFjbGyPwbZMdBg/oC8ZE
 9NJicrz5WLEn8M6o+gQYL1FGq66HGy++bEmitaEsuCzkHEuCqg9dQO+5uKtRsGL4X4Rq
 0RorA5nItPZRSMGAnZAUdEv8TWdfG2LcmxrAebjepxJzpNFFCw2yFsewgFu6Er9hivWJ
 AfnTCJihexT8OfJgNuqw3LOwFWIb3fmJ685ylHapezq7BZjV7nqGyEL3a+tDSOhec6a6
 TCww==
X-Gm-Message-State: AOAM531OuciqqAk9/GCf0CCAcTE8sMMe1tlswHZWkUZJLhCtlyXN5LxP
 V6KfqGUJvjnAUXxNMYZcU2cJ+Hc8R0NTVSVpURwUvVgnb4eDYhQ3DYqakvHXsQvns69ksPh5RZy
 W5eNzMnJB1oSG3Fk=
X-Received: by 2002:a37:a00c:: with SMTP id j12mr15804260qke.231.1604331012844; 
 Mon, 02 Nov 2020 07:30:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZEO6q8WtGy5xdbWxUYFi3kJnYPyDtU7bYnKcyYp1YDjtNATubz/YChMU9Hf6w6nX4j1n/fA==
X-Received: by 2002:a37:a00c:: with SMTP id j12mr15804245qke.231.1604331012628; 
 Mon, 02 Nov 2020 07:30:12 -0800 (PST)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
 by smtp.gmail.com with ESMTPSA id z125sm5936184qke.54.2020.11.02.07.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 07:30:11 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] migration: Two extra fixes
Date: Mon,  2 Nov 2020 10:30:08 -0500
Message-Id: <20201102153010.11979-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should fix intermittent hang of migration-test due to the latest updat=
e to=0D
postcopy recovery.=0D
=0D
Thanks,=0D
=0D
Peter Xu (2):=0D
  migration: Unify reset of last_rb on destination node when recover=0D
  migration: Postpone the kick of the fault thread after recover=0D
=0D
 migration/postcopy-ram.c |  2 --=0D
 migration/savevm.c       | 17 ++++++++++++++---=0D
 2 files changed, 14 insertions(+), 5 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


