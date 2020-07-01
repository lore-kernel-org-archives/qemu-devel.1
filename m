Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A596C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70263207F5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iN2ZAaqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70263207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeUL-0006v3-Lz
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeSS-0004cM-I4
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:15:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeSQ-0002tI-PE
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593616530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tl2XnPJhS4+sRYXg4BsVbGG87M/IQqFEuKR51vK0lWY=;
 b=iN2ZAaqhf+QSt/QgtngZMlJPXdU+Rk5k2hZ9Jt6rZQIZG0R3bGWb52mXnPDxK1FgEarcN5
 AEjg6cm1SSbbvabVYahNUzuGDJwj6N6Na3n1lRYsNL1/n4XqSNf5+9w4Sa3JkUcrHjT2WE
 R+GAYZQnM9PUz5RWVTcfqwae7CVWge8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-DwMczyXOPxyt0U8eAXwVXw-1; Wed, 01 Jul 2020 11:15:28 -0400
X-MC-Unique: DwMczyXOPxyt0U8eAXwVXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 171FD18FE86F;
 Wed,  1 Jul 2020 15:15:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B289773FCF;
 Wed,  1 Jul 2020 15:15:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9BC1A16E16; Wed,  1 Jul 2020 17:15:24 +0200 (CEST)
Date: Wed, 1 Jul 2020 17:15:24 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATC 7/9] Skipping drm build, unsupported
Message-ID: <20200701151524.wogl4ihbdevgf4bt@sirius.home.kraxel.org>
References: <CA+XhMqzjjrfxXeSENBQuHzTe4TRMWV5GOdqPkD3bo17T3ufR1A@mail.gmail.com>
 <1058ccbd-b4bb-9413-abc5-ae89076a58e1@redhat.com>
 <20200630082301.6vybzwmg4pviuwob@sirius.home.kraxel.org>
 <CAFEAcA8jkzf8+d5AyAVH2HJ544TyHsM4xP5tpWsKiJbJtWMjKw@mail.gmail.com>
 <20200630165356.2ka2ltwmrfjb5msn@sirius.home.kraxel.org>
 <3eb3c266-1a83-9f40-4760-1ab2578ae5d6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3eb3c266-1a83-9f40-4760-1ab2578ae5d6@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, David CARLIER <devnexen@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > Ah, that is the problem.  Yes, DT_CHR is an non-posix optimization which
> > allows to get the file type directly, without another round-trip to the
> > kernel.  If that isn't available you can stat() the file and check
> > ((st_mode & S_IFMT) == S_IFCHR) instead.
> 
> Even when d_type and DT_CHR is available, there are filesystems where the
> Linux kernel reports d_type of DT_UNKNOWN, and where you are best having
> that code also falling back to an fstat().

Given this isn't perforance critical at all it is probably simplest to
avoid non-portable d_type altogether and just to the fstat
unconditionally.

David, does that work for haiku?

take care,
  Gerd

diff --git a/util/drm.c b/util/drm.c
index a23ff2453826..a1d3520d00f2 100644
--- a/util/drm.c
+++ b/util/drm.c
@@ -24,6 +24,7 @@ int qemu_drm_rendernode_open(const char *rendernode)
 {
     DIR *dir;
     struct dirent *e;
+    struct stat st;
     int r, fd;
     char *p;
 
@@ -38,10 +39,6 @@ int qemu_drm_rendernode_open(const char *rendernode)
 
     fd = -1;
     while ((e = readdir(dir))) {
-        if (e->d_type != DT_CHR) {
-            continue;
-        }
-
         if (strncmp(e->d_name, "renderD", 7)) {
             continue;
         }
@@ -53,6 +50,12 @@ int qemu_drm_rendernode_open(const char *rendernode)
             g_free(p);
             continue;
         }
+        fstat(r, &st);
+        if ((st.st_mode & S_IFMT) != S_IFCHR) {
+            close(r);
+            g_free(p);
+            continue;
+        }
         fd = r;
         g_free(p);
         break;


