Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DFFC71142
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87D120863
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmGVcfth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87D120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlcmV-0007w8-7u
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60001)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlcm0-0005q5-2q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hlclz-0003jJ-1s
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:22:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hlcly-0003i1-Rd
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:22:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so7167585wrr.4
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RxYfAEyw36ihWSXQYKfqSMDy1K9OXWQsSR7Cb5/oOMk=;
 b=PmGVcfthSxJ+fHCa/bi19s0VtpgRlUtxyC7RLRL1GOu0yffMUyI32MIwnAzKz5FOL7
 99KmcX5Nvcl8n/kuNbgg12N73vApHl7H7h7PYkuLT5p1JkeHGF5AlKhx5TBoCmK8plHO
 ROS4aQK3dsGp85OcNr5OuCP6AbkZasJSffPWKM/PDtk2Utns2V3NWXl8q6/Ygu0nTU+A
 5eS8h85lsavLJnU2OL0+WsE9+hizNirIfUTXfMiTSeEmE/xwHUzKKQZawjQuCaEadLUf
 wXJTE558QiUSwm1LWLPIgGZNvqFrZ1AUStOb46EA1xxEjBdD4GQf2EJe/5ooL6BeDS8/
 wL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=RxYfAEyw36ihWSXQYKfqSMDy1K9OXWQsSR7Cb5/oOMk=;
 b=GuQda7FDJqvrvPFfRgw0j+MEPGlGgL6teWtsuOUi9zR4B3yKbS0KvACUcFxvq0dWPv
 Nrgbp/XPcBR+3KkmBuu9hO4ekx0tcXYmH+2FA3Jgj9iUb6gjAPOsX4bCBhllPuhQeyrn
 8PsHtnH2FAaY5ni62WKMTBVqqHdahSvPOqk702geTyB3rod+odh7b7u/7BlXduYPat0v
 aCPagxHJS22mk7LWKhoXuwBIibjgBxpJ6okbJnSxmNfLqpki/bd2MxZzMzCZM+LUijBM
 Se4Dcug7S9GWtgvVJpRRhL6UV6nlSAaCfrVyj0ik1BVg+kyVZbl2uXe4zJOXx0Cn1fit
 YDFQ==
X-Gm-Message-State: APjAAAWsTvPcHVfIkBGGF6jeVQGX6EHXVldgOQ7DLURywZ4d/n5XHt6U
 kAT1cIHEskHX7+yrzB2+Grd13soQcdU=
X-Google-Smtp-Source: APXvYqzchK2uToAFfTfutp8KJqYHTQciCRLD2h3RWRxRvPbn2xlvFt/6nD1IdosiefQ3ZccRsa5c2g==
X-Received: by 2002:adf:e4c6:: with SMTP id v6mr6004069wrm.315.1562865740294; 
 Thu, 11 Jul 2019 10:22:20 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c11sm8654514wrq.45.2019.07.11.10.22.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 10:22:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 19:22:16 +0200
Message-Id: <1562865736-3546-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562865736-3546-1-git-send-email-pbonzini@redhat.com>
References: <1562865736-3546-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 2/2] create_config: remove $(CONFIG_SOFTMMU)
 hack
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CONFIG_TPM is defined to a rather weird $(CONFIG_SOFTMMU) so that it
expands to the right thing in hw/Makefile.objs.  This however is not
needed anymore and it has a corresponding hack in create_config
to turn it into "#define CONFIG_TPM 1".  Clean up.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure             | 2 +-
 scripts/create_config | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 4983c8b..eb635c3 100755
--- a/configure
+++ b/configure
@@ -7159,7 +7159,7 @@ if test "$live_block_migration" = "yes" ; then
 fi
 
 if test "$tpm" = "yes"; then
-  echo 'CONFIG_TPM=$(CONFIG_SOFTMMU)' >> $config_host_mak
+  echo 'CONFIG_TPM=y' >> $config_host_mak
 fi
 
 echo "TRACE_BACKENDS=$trace_backends" >> $config_host_mak
diff --git a/scripts/create_config b/scripts/create_config
index 00e86c8..6d8f08b 100755
--- a/scripts/create_config
+++ b/scripts/create_config
@@ -54,7 +54,7 @@ case $line in
     done
     echo "    NULL"
     ;;
- CONFIG_*='$(CONFIG_SOFTMMU)'|CONFIG_*=y) # configuration
+ CONFIG_*=y) # configuration
     name=${line%=*}
     echo "#define $name 1"
     ;;
-- 
1.8.3.1


