Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631CE20732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ2zxZxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631CE20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k93my-0006YG-Np
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k93mE-0005jV-Gm
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k93mC-0006Zc-SB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 05:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598003759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyVJYHkoGWs5FmeM66VpThDrNZrxjYpslQvAQRWe4hA=;
 b=gZ2zxZxqlMJJiT3Uklr5FOntOcwW73zyNF1RqEGjeDPQ0Z4Ku+8DhowZwBXC578ShhmkTl
 NPnKTMGL+Wsix7l1RF9k+UmaEAwVJKyrpvAkOL46FytA8fVvuetN9Z5O/KtsiyOdMGchNI
 WKovCsypaFwIFhchN+1jvA6knbMlp7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-PlRmUJUTPJyVKKxZ_ndmvA-1; Fri, 21 Aug 2020 05:55:58 -0400
X-MC-Unique: PlRmUJUTPJyVKKxZ_ndmvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8F09801ABC;
 Fri, 21 Aug 2020 09:55:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 646335DA60;
 Fri, 21 Aug 2020 09:55:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 49BAF97CF; Fri, 21 Aug 2020 11:55:55 +0200 (CEST)
Date: Fri, 21 Aug 2020 11:55:55 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200821095555.e2mbseoyaxhkckvt@sirius.home.kraxel.org>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
 <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
 <20200820105401.GA99531@linux.fritz.box>
 <9bdbb3b9-01df-2a6b-0c82-b58ef6e0edf9@redhat.com>
 <20200820133023.GD99531@linux.fritz.box>
 <80348ec7-4897-a2ab-54a6-2997ee47b598@redhat.com>
 <20200820161456.GG99531@linux.fritz.box>
 <8199df6a-67b4-6dd7-3384-f4e993a42fe7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8199df6a-67b4-6dd7-3384-f4e993a42fe7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> If it's a matter of "I don't want my workflow to change too much", I'm
> not familiar with everybody's setups and requirements and it's not a
> precise-enough requirement for me to write the code (and block the
> inclusion of the pull request).

It's almost zero change to my workflow.  I only had to fix modular
builds (patch below).

I'm doing out-of-tree builds for ages.  First, because I consider it
good practice.  Second, because it allows me to easily test multiple
different configurations (modular vs. non-module, with/without spice,
...) without "make distclean; ./configure $otheropts", by simply having
multiple build trees.  Third, because I can just "rm -rf $builddir" and
start over in case I trap into one of the bugs our Makefiles have (not
rebuilding objects on cflags changes for example).

> What you're asking is not the final 0.1%; it's a completely different
> thing, because it _must_ be by definition half-baked.  For example here
> are all the tradeoffs that come to mind:

[ list snipped ]

> I'm rather happier to spend my time explaining details of the conversion
> if they have to hack on the build system in the near future, than to
> gather a detailed answer to these questions and any other that didn't
> come to mind.

Fully agree.

My personal take on this is we should just have configure catch in-tree
builds, print instructions for out-of-tree builds and throw an error.
Switching from in-tree to out-of-tree builds isn't that much of an issue
after all, and given that our current build system supports it too even
"git bisect" should be painless.

> (as long as you don't touch the build system of course).

And *this* should be easier once the series landed.
Also I'm looking forward to have less build system bugs.

take care,
  Gerd

-------------------------------------------------------------------
diff --git a/util/module.c b/util/module.c
index c956ef096b3b..6e63006a8fb2 100644
--- a/util/module.c
+++ b/util/module.c
@@ -113,7 +113,7 @@ static int module_load_file(const char *fname)
 {
     GModule *g_module;
     void (*sym)(void);
-    const char *dsosuf = HOST_DSOSUF;
+    const char *dsosuf = CONFIG_HOST_DSOSUF;
     int len = strlen(fname);
     int suf_len = strlen(dsosuf);
     ModuleEntry *e, *next;
@@ -221,7 +221,7 @@ bool module_load_one(const char *prefix, const char *lib_name)
 
     for (i = 0; i < n_dirs; i++) {
         fname = g_strdup_printf("%s/%s%s",
-                dirs[i], module_name, HOST_DSOSUF);
+                dirs[i], module_name, CONFIG_HOST_DSOSUF);
         ret = module_load_file(fname);
         g_free(fname);
         fname = NULL;


