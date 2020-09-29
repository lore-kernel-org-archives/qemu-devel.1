Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C282C47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6322076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7jAaqYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6322076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMCL-00021o-Bj
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6E-0001sf-Ni
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM65-0003V9-Sa
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:46 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3yvUrJZ6eB2FREWIAHx+5JgnVLusjFVDhEfL4cA08Y8=;
 b=H7jAaqYIrW1gpfBClOgmBzozW4aULG6HbVU0+iVVSWilsRddPbdDGqrpRn5oprEFWD8zEC
 RFLuokd3sMs50x8JYy8Dtu6AmIgssCg9K6b7nvm/qeBORXl3rrCvtVl6KTuP0H7oQdjZqW
 D6svDJmL4ltTEpq7XJ2ymmcw9Sb1hdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-O8hJCbMJPyytSdV1sXBL4w-1; Tue, 29 Sep 2020 16:19:32 -0400
X-MC-Unique: O8hJCbMJPyytSdV1sXBL4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADEF5801AE8;
 Tue, 29 Sep 2020 20:19:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80FDE7882E;
 Tue, 29 Sep 2020 20:19:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DFF3011358D4; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/29] meson.build: Make manuals depend on source to Sphinx
 extensions
Date: Tue, 29 Sep 2020 22:19:19 +0200
Message-Id: <20200929201926.2155622-23-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The automatic dependency handling for Sphinx manuals only makes the output
depend on the input documentation files. This means that if you edit
the Python source of an extension then the documentation won't be
rebuilt.

Create a list of all the source files for the extensions and add
it to the dependencies for the manuals. This is similar to how we
handle the qapi_gen_depends list.

Because we don't try to identify which manuals are using which
Sphinx extensions, a change to the source of one extension will
always rebuild the entire manual set, not merely the manuals
which have changed. This is acceptable because we don't change
the extensions all that often.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200925162316.21205-15-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Re rebuilding the enitre manual set being acceptable "because we
don't change the extensions all that often": we also rebuild it when
the QAPI generator code the qapidoc extension depends on changes.
This will inconvenience QAPI developers.  Can't be helped now.]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/meson.build | 1 +
 meson.build      | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/docs/meson.build b/docs/meson.build
index 52e384be17..0340d489ac 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -36,6 +36,7 @@ if build_docs
                 output: [manual + '.stamp'],
                 input: [files('conf.py'), files(manual / 'conf.py')],
                 depfile: manual + '.d',
+                depend_files: sphinx_extn_depends,
                 command: [SPHINX_ARGS, '-Ddepfile=@DEPFILE@',
                           '-Ddepfile_stamp=@OUTPUT0@',
                           '-b', 'html', '-d', private_dir,
diff --git a/meson.build b/meson.build
index 866321462e..6cb8aebd7d 100644
--- a/meson.build
+++ b/meson.build
@@ -680,6 +680,14 @@ if get_option('werror')
   SPHINX_ARGS += [ '-W' ]
 endif
 
+sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
+                        meson.source_root() / 'docs/sphinx/hxtool.py',
+                        meson.source_root() / 'docs/sphinx/kerneldoc.py',
+                        meson.source_root() / 'docs/sphinx/kernellog.py',
+                        meson.source_root() / 'docs/sphinx/qapidoc.py',
+                        meson.source_root() / 'docs/sphinx/qmp_lexer.py',
+                        qapi_gen_depends ]
+
 # Collect sourcesets.
 
 util_ss = ss.source_set()
-- 
2.26.2


