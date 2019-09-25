Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93382C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6768421E6F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 12:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6768421E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD67K-00069b-K5
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 08:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tgolembi@redhat.com>) id 1iD66c-0005jI-H6
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1iD66Z-0006Cv-O1
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1iD66Z-0006Cl-IW
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:09:11 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 029EB5859E
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 12:09:10 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id q10so2262126wro.22
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 05:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x7itg78xAgmV9McZqFhl+T/z5pDz39clwKjgo5EJCRU=;
 b=uYLSSz1aGE3Di0Lc50ij5hqlEjNuEjF775GMX0tSFD6wE2ZJhvyU6gAG0nBMwDyTay
 GIV0cdysFve9hAGFty7f4u4WEtnihpBv3qeRmPcLHD90vNwJJN7es0JfwBKmPO3X4658
 4f/0p2knpvxYbJ26ySwSh7xFE5jdLoNtmGCG+mZ9psLbAaNO4axje0INVhAmhflcMJ5p
 5HNSac+1gsxYOd4AVpf7jqCwsXZqUF4MJ1vdwnBKsjcmnV9EXrrh528f+mtCMKmGs+Rr
 7neDTX59ouXXOs7hiDnAERmLHRUwqhtCurZ9kBvmSd+EQPQVNAO9GZbhpoko0Wb+33ms
 m2lw==
X-Gm-Message-State: APjAAAXmYzhXwZEFeDZyEAgXHY2yD9h9HO0LWXo5Spe+eJejuOnGZCB6
 CcKlC4T8RsSOS1liH0TlL2BNM89rLC4FYnCfSqWDhnLY3LdzTLJwdKNolQg7wOHqI4JKKReVSfy
 jUcpUO1Vy3Y01sBY=
X-Received: by 2002:a5d:6302:: with SMTP id i2mr9679632wru.249.1569413348529; 
 Wed, 25 Sep 2019 05:09:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEhorjPlJeRlTy0KTdEfi9cE+CCMN5P64pRLBfePsLOxThewSuzXEs7r0BdzC4c9Sq7FdZuw==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr9679599wru.249.1569413348251; 
 Wed, 25 Sep 2019 05:09:08 -0700 (PDT)
Received: from auriga.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id m18sm8852430wrg.97.2019.09.25.05.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 05:09:07 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH] docker: fix uid maping with podman
Date: Wed, 25 Sep 2019 14:09:06 +0200
Message-Id: <4b9204cc8ade1c965dc5412c53c6f7c5b4f019a2.1569413332.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 71ebbe09 refactored how uid mapping is performed when invoking
container. It however introduced a bug in the flow when podman is used
caused by wrong variable name.

Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
---
 tests/docker/docker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 29613afd48..bc7a470ca2 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -334,7 +334,7 @@ class Docker(object):
             cmd =3D [ "-u", str(uid) ] + cmd
             # podman requires a bit more fiddling
             if self._command[0] =3D=3D "podman":
-                argv.insert(0, '--userns=3Dkeep-id')
+                cmd.insert(0, '--userns=3Dkeep-id')
=20
         ret =3D self._do_check(["run", "--label",
                              "com.qemu.instance.uuid=3D" + label] + cmd,
--=20
2.23.0


