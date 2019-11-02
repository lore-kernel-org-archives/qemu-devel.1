Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F05BCA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 07:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D707A2085B
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 07:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlBS/4+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D707A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQo3f-0004dG-2j
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 03:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jordipujolp@gmail.com>) id 1iQo2x-00041p-DB
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 03:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jordipujolp@gmail.com>) id 1iQo2w-0005kk-24
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 03:42:07 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37305)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jordipujolp@gmail.com>)
 id 1iQo2v-0005gX-TI
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 03:42:06 -0400
Received: by mail-ot1-x343.google.com with SMTP id 53so10324655otv.4
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 00:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2K/fgGrJ0Fhq68Jt1YEEuMez7LDse87vl9AIAx7ova8=;
 b=tlBS/4+RndWIoLxMzpd6cbUTWsHK1pgzyrZs6OKS0BOaVu8Y4hIXwgun4AxLciJ7an
 ao3q1TvaKcN9tRYFI8PAOdKuN0CYLGnNR07pOL+ZIz+fuTVP4mYlPohmwOb9G4Y2n92j
 RK0Z83As0RwID5Nog3twt/BprAj+wKVYe4zPG3zbJEXoH7Z3kEM68eau+gz7xHJivvzU
 QKq8uP5KY6C+FFQyIsEF9xp191iXfdKKEoKEC5oTbIQqhGxZB7nvQlmyM/eEHCDKcBWA
 sbOkSMLjaCkSYjt2aFyq50XV6CNGeDLJvpmxko6B0ar1JnpFM6aL6sZyueKi7RwJYtCh
 rvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2K/fgGrJ0Fhq68Jt1YEEuMez7LDse87vl9AIAx7ova8=;
 b=Ob1DO2112o6Mf/bf9ux1aS4iMDNgTBFyu7V6DweJZE4Ih7OJmEwHkC1PqL81X+bCnc
 5KEUulbCwsPYgUKAwLrH2QnUBXbQMmQTm0w5PfH+/ZQydeIBIJkNU5hVg5VytLzfhKtb
 yd93pG1CfMlNQuYSVwyT6OWmiR19vn/3a8KfJ1SMBmtXJTYxHaSirGBu7wXtupb8FiOq
 FqVzLTOniSYBa8HO8BCzx0ncGxkCScWyu4nUdmi26KXvgKuMDk0Hr8isMsS0AiDhpTo8
 xoeU/8zDrm2ePeEqYqVguhzie2qMHbfKYZ1Ru9VqKTXI5X2sEchQbkFdebeLz1kZAURL
 GPbA==
X-Gm-Message-State: APjAAAWDp/+mfLMXZL1t5zH5hrXKuQrpoH1I+2M8uy5rnnhxTit72NuH
 v0AlH2NAA+jyNJylDy+wgcGEt27Yot9lljZdnMU=
X-Google-Smtp-Source: APXvYqzV0wA7IleFYZ70GLOKIeV+c/nPg8eRHvIxaK21q8daq22knZgGYYUGC+QVnf18wfbKBi/G5PdSaT14hQGUAqQ=
X-Received: by 2002:a05:6830:1e53:: with SMTP id
 e19mr4109554otj.161.1572680524001; 
 Sat, 02 Nov 2019 00:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACTE=gpFbUSxXeTwu6_tzSeoh_9Yp905aMdzCPCUz3h7kcgeyw@mail.gmail.com>
 <144c1b0a-5cd4-b657-025b-f44d5e812e06@vivier.eu>
 <CACTE=goN=Nw8b5RN8sWhX9mRNWEU0fhuc=HnD3MJW59BET=hkA@mail.gmail.com>
 <20191031161547.pipit5hxzjnf6jmt@function>
 <CACTE=godCrD7GiPbOnds3uRgrVhrZYBY+Ojsa85EVd31pd6h1A@mail.gmail.com>
 <20191101145437.tr4gervnn2m5qvci@function>
In-Reply-To: <20191101145437.tr4gervnn2m5qvci@function>
From: Jordi Pujol <jordipujolp@gmail.com>
Date: Sat, 2 Nov 2019 08:41:52 +0100
Message-ID: <CACTE=grkUZErGiW4=USWPS=Q4kpo1C8QupucnnS8ry3Z00DumQ@mail.gmail.com>
Subject: Re: [PATCH v4] smb daemon get additional command line parameters from
 env variable
To: Samuel Thibault <samuel.thibault@gnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jordi Pujol Palomer <jordipujolp@gmail.com>
Date: Sat, 2 Nov 2019 08:54:14 +0200
Subject: [PATCH v4] QEMU samba daemon: additional command line options

The smbd daemon takes additional command line options
from environment variable SMBDOPTIONS.
Set the environment variable SMBDOPTIONS before executing qemu.

Example:

export SMBDOPTIONS="--option='server min protocol=CORE' -d 4"

Signed-off-by: Jordi Pujol Palomer <jordipujolp@gmail.com>
---
--- qemu-4.1-a/net/slirp.c
+++ qemu_4.1-b/net/slirp.c
@@ -834,6 +834,7 @@ static int slirp_smb(SlirpState* s, cons
     char *smb_cmdline;
     struct passwd *passwd;
     FILE *f;
+    char *options;

     passwd = getpwuid(geteuid());
     if (!passwd) {
@@ -909,6 +910,12 @@ static int slirp_smb(SlirpState* s, cons
              CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);
     g_free(smb_conf);

+    options = g_getenv("SMBDOPTIONS");
+    if (options) {
+        smb_cmdline = g_strdup_printf("%s %s", smb_cmdline, options);
+        g_free(options);
+    }
+
     if (slirp_add_exec(s->slirp, smb_cmdline, &vserver_addr, 139) < 0 ||
         slirp_add_exec(s->slirp, smb_cmdline, &vserver_addr, 445) < 0) {
         slirp_smb_cleanup(s);

