Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F9ACA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 14:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48F72085B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 14:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veEV7dX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48F72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQY5I-0006sD-0P
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 10:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jordipujolp@gmail.com>) id 1iQY4T-0006Qt-Cb
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jordipujolp@gmail.com>) id 1iQY4O-0004DV-0t
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:38:37 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jordipujolp@gmail.com>)
 id 1iQY4N-00047q-Gm
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:38:31 -0400
Received: by mail-oi1-x243.google.com with SMTP id y194so8339024oie.4
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fefJfXFhFLaG37CEwHJiIKqpnv0OOQJoiAIWRwxIAVQ=;
 b=veEV7dX+2zQQmTVVYrN+YYIJOm962cbxbrgHCUiotySPgQ0aWUmqSBkT9v9bBvib+2
 hRQWQoChQE3V5ypq68H6evb/urAqjAL3d0bht7WapfVsxdF884Ab7eItlMvrHYTTrO+k
 snT5KBTkHMX9+pupUlBzRwWo3SZJlK28GH1+OiFAjHNYcPzbz/Mz5JZY37/Zw1C0g9l9
 +j2/DwMFEHrhZ1KB3ifo+fTIiw5t/e8gM/LZDH5grMMy7/9pVh0MLujXOoqpW75DaEwp
 1VdpCscBzo95DrUJ5A59AdNqMY77fAbDEUwV2youHml5OUFp6L/8DqGkudDX71jwPzda
 y1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fefJfXFhFLaG37CEwHJiIKqpnv0OOQJoiAIWRwxIAVQ=;
 b=nI4BTUScvawirTLsK7OuwqKuFqml5zHJOXTkcqfvF2Ular3gx3vpKxsSSsdlDtKdci
 iO7NONTwNi5iPJYNrUxUUYk1u7JCd8qX2oEHQd5xTkgaCOJDU3go8k+d2bHaI35sdBRQ
 SFyTVot93HjIdO5VlcDIKKm9eqA/Bag+K41eBFeC2STb+Fu0cmG8JVjdxwqh9hREFEME
 4FaImh+Hv/pfnHV3ooMPhuNxpa4CcdGOU0ZoBg+DJJwNP4mSoGZznWDH4H3ALS/3Uwqb
 52VW3XUqdGVLBxlR4ih1kaXqQuozuclJYVDsKTFk6+7BSbY6lMKRYzhetaki74gmyXKR
 TnCg==
X-Gm-Message-State: APjAAAVx3zOKD4U1goMF2tPPatZ1DLeZ61DVEfjdpUn2oLBMxguvVmGy
 k58TJJOx8/6TMfOfR0BtO1Gnk3sUaP8cm/ISWSY=
X-Google-Smtp-Source: APXvYqwjlhguZ9wGI85hFUFr7EeErbcZDQ6uuGc8DRw7dq7PyPt4j92cAfWgFbjx6gVqUFSKDM0QVkqylSMx0dEAPvw=
X-Received: by 2002:aca:b909:: with SMTP id j9mr5255590oif.121.1572619110281; 
 Fri, 01 Nov 2019 07:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <CACTE=gpFbUSxXeTwu6_tzSeoh_9Yp905aMdzCPCUz3h7kcgeyw@mail.gmail.com>
 <144c1b0a-5cd4-b657-025b-f44d5e812e06@vivier.eu>
 <CACTE=goN=Nw8b5RN8sWhX9mRNWEU0fhuc=HnD3MJW59BET=hkA@mail.gmail.com>
 <20191031161547.pipit5hxzjnf6jmt@function>
In-Reply-To: <20191031161547.pipit5hxzjnf6jmt@function>
From: Jordi Pujol <jordipujolp@gmail.com>
Date: Fri, 1 Nov 2019 15:38:19 +0100
Message-ID: <CACTE=godCrD7GiPbOnds3uRgrVhrZYBY+Ojsa85EVd31pd6h1A@mail.gmail.com>
Subject: Re: [PATCH v3] smb daemon get additional command line parameters from
 env variable
To: Samuel Thibault <samuel.thibault@gnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Thu, Oct 31, 2019 at 11:50 PM Samuel Thibault
<samuel.thibault@gnu.org> wrote:
> Why strduping it? you can just use g_getenv.

ACK, I have also placed the variable declaration after the others.
Here is the v3 of this patch.

******************************************************************
From: Jordi Pujol Palomer <jordipujolp@gmail.com>
Date: Fri, 1 Nov 2019 10:54:14 +0200
Subject: [PATCH v3] QEMU samba daemon: additional command line options

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
+    }
+    g_free(options);
+
     if (slirp_add_exec(s->slirp, smb_cmdline, &vserver_addr, 139) < 0 ||
         slirp_add_exec(s->slirp, smb_cmdline, &vserver_addr, 445) < 0) {
         slirp_smb_cleanup(s);
******************************************************************

>
> Please submit this part to https://gitlab.freedesktop.org/slirp/libslirp/

I have forked the libslirp project and created a merge request,

Thanks,

Jordi Pujol

