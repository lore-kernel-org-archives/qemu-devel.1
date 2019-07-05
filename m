Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFFCC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5A82133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI2Ot1p3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5A82133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVNN-0007AQ-1r
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 17:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34278)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkS-0004Ym-TT
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkR-00035B-Kb
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:24:00 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35763)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUkR-0002jZ-D4
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id y4so2426024wrm.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=hD3kbFvZZ3EzTHJ9PgPfFOKh05+UxEjCQiiQlxvG2pQ=;
 b=XI2Ot1p3X5O4fSY6kYJrE+TCrJsD8KMdN5VRt1udLR5VDZnx3fV+FxzV0z/BChWu5L
 ZTrD+0YInLxXEFF8rwhguU0ZfxiRHr9I2ulKnf/rsGsn52LF55PpT7wMKq872vtyc5cg
 KUpxdD27ntw0B2zUrTNzCPBpp+SXStuR9ulz+y2ClKJwMTTBljRvi7xLSN8ulJrITnQR
 cX5KE9Y/a0hUhAiXZ6VCD5D7q8onXkwW3iVFpUXflbdTjy7H6z0HcrnFr5VKm3cXTub7
 1216L3DwjxX+9I/a6Fbnz0DpoYWZ7/+dfMsh4CV7lphzl37YLpLjAnhvpahUoXResCQf
 50DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=hD3kbFvZZ3EzTHJ9PgPfFOKh05+UxEjCQiiQlxvG2pQ=;
 b=MBYdLT9Mj0nX4JqF444c2PyVcjrVAToZLifOBOAY1+spst3MB6dUIRif6eQ+wsiPTw
 Fhsb86d2814zHEtOMA87Gb3dpwDm0qburCK9UHuIW1VEZFm594tW9od47qnjF7V0nFN4
 1U2Hn9LGEOY3llxvwGKKXGCDqB84X1QkUu8fUufIOrNI/OrvFrimvvUL/mVlHwx4nxRA
 lCsyIj3aU71HNL8ZCGd3GidXVgxlcQ4nLksCRfiCC1ZCq5N9YOIgA1oMulkZHW6F1jKJ
 9uosbqZfNJjt67RHa/zZw9d1LNCyrbZNo0uKbib66DkuMTxc4E1BjhVG0cYRwhaS9wfj
 XzBw==
X-Gm-Message-State: APjAAAU9jpFswj/4Fp/c8gnFmDKwYT8cc0/jR+S1Q/askktuGCXnDvAh
 0z6VRi+F/XQOzjT6CKKgoB+oiYgXgwg=
X-Google-Smtp-Source: APXvYqzqm1houuww+bAm7PX0GEX6RseXx03Chv+McT1mPi0w6SJpApxC2gP4meq+WacpZCt4+m2tVA==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr5165090wrm.100.1562358210913; 
 Fri, 05 Jul 2019 13:23:30 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:18 +0200
Message-Id: <1562358202-28008-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 08/12] minikconf: do not include variables from
 MINIKCONF_ARGS in config-all-devices.mak
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When minikconf writes config-devices.mak, it includes all variables including
those from MINIKCONF_ARGS.  This causes values from config-host.mak to "stick" to
the ones used in generating config-devices.mak, because config-devices.mak is
included after config-host.mak.  Avoid this by omitting assignments coming
from the command line in the output of minikconf.

Reported-by: Christophe de Dinechin <dinechin@redhat.com>
Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>
Tested-by: Christophe de Dinechin <dinechin@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 0ffc6c3..3109a81 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -688,11 +688,13 @@ if __name__ == '__main__':
 
     data = KconfigData(mode)
     parser = KconfigParser(data)
+    external_vars = set()
     for arg in argv[3:]:
         m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([yn]?)$', arg)
         if m is not None:
             name, value = m.groups()
             parser.do_assignment(name, value == 'y')
+            external_vars.add(name[7:])
         else:
             fp = open(arg, 'r')
             parser.parse_file(fp)
@@ -700,7 +702,8 @@ if __name__ == '__main__':
 
     config = data.compute_config()
     for key in sorted(config.keys()):
-        print ('CONFIG_%s=%s' % (key, ('y' if config[key] else 'n')))
+        if key not in external_vars:
+            print ('CONFIG_%s=%s' % (key, ('y' if config[key] else 'n')))
 
     deps = open(argv[2], 'w')
     for fname in data.previously_included:
-- 
1.8.3.1



