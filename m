Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D5BECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1F120B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ZGuSZt0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1F120B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iII1o-00041T-50
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 15:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msmarduch@digitalocean.com>) id 1iIF5h-0001fX-OU
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msmarduch@digitalocean.com>) id 1iIF5f-0001Zt-8M
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:45:33 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msmarduch@digitalocean.com>)
 id 1iIF5d-0001Vl-8y
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 12:45:31 -0400
Received: by mail-ot1-x343.google.com with SMTP id 41so2275401oti.12
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digitalocean.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=kgU/+2cos2QYBqiW/0hv0nTkJW/Vd88XDAxwpzLIkxo=;
 b=ZGuSZt0zLTvFTkmIuc3frUuyAilrSaKs/9/vLT7LE7tfZ/RpHGV5Df89qflF6YXazA
 ZcJXAurFqregBHEWNr4PSxZmrLBcQAb0If0jLCkj1mVmWJoe3Vbp0pEL088wXSE9sncy
 3gCh0c9SI7Rw0iYQKhy9uDMD/5+uPDAnXpnAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=kgU/+2cos2QYBqiW/0hv0nTkJW/Vd88XDAxwpzLIkxo=;
 b=Tt0+1y9kgqq8m2Xs3UOKqjhHSnE3uv2YssmBx0UYgqUCZ1rgJ8pJo/xCxTixyvWS24
 +1JXJRrynOpL+EHFYbMlS4MW0tFJWifJRPk0egdGUkL7Od/ms94Lz4DgNBdpe1zKLtH/
 QYtmukInIa0SfmzXbMQRWxn3LtDFA0ec7dlBXLAGEF5YzRhIz9O6bQ93+CF5O1zFiSFk
 io/g+bNYnr8IqQzWzj8dl6POlHd6M1N2Nq0YRKYqnDx6D7hOjCgAFGFF1JJlGA3GYvW9
 h3fRyA7JiDgMvhezVKSMq1Et5plrMOvplS4ztz2ZPDHCyRsV1l4I0ikrVR9+J8S94Zny
 Siww==
X-Gm-Message-State: APjAAAXSFOWvgcHlGNC/5q/ih7UXUxcxtgv2aJINb3yDsMgQrFWUAWyE
 tkq+ZX9RJisjlamZQhWeg9lZ+w==
X-Google-Smtp-Source: APXvYqxbc4JgTWnSKGPIgN/wjeGipaxS6apfBoHS/TzEzitt1uzVW4lR51gIC5kLuZ3OyTc2LB3pIA==
X-Received: by 2002:a9d:70d0:: with SMTP id w16mr3617712otj.107.1570639525026; 
 Wed, 09 Oct 2019 09:45:25 -0700 (PDT)
Received: from msmarduch-ThinkPad-T460s.attlocal.net
 ([2600:1700:4a30:84c0:8d5e:794e:8a2e:ee89])
 by smtp.gmail.com with ESMTPSA id q1sm789818otn.8.2019.10.09.09.45.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Oct 2019 09:45:24 -0700 (PDT)
From: Mario Smarduch <msmarduch@digitalocean.com>
To: philmd@redhat.com, mtosatti@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, rth@twiddle.net,
 ehabkost@redhat.com, Mario Smarduch <msmarduch@digitalocean.com>
Subject: [PATCHv2 0/2] log guest name and memory error type AO, AR for MCEs 
Date: Wed,  9 Oct 2019 09:44:57 -0700
Message-Id: <20191009164459.8209-1-msmarduch@digitalocean.com>
X-Mailer: git-send-email 2.9.3
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In a large VPC environment we want to log memory error occurrences
and log them with guest name and type - there are few use cases


- if VM crashes on AR mce inform the user about the reason and resolve the case
- if VM hangs notify the user to reboot and resume processing
- if VM continues to run let the user know, he/she maybe able to correlate
  to vm internal outage
- Rawhammer attacks - isolate/determine the attacker possible migrating it off
  the hypervisor
- In general track memory errors on a hyperviosr over time to determine trends

Monitoring our fleet we come across quite a few of these and been
able to take action where before there were no clues to the causes.

When memory error occurs we get a log entry in qemu log:

Guest [Droplet-12345678] 2019-08-02T05:00:11.940270Z qemu-system-x86_64:
Guest MCE Memory Error at QEMU addr 0x7f3c7622f000 and GUEST 0x78e42f000
addr of type BUS_MCEERR_AR injected

with enterprise logging environment we can to take further actions.

v1 -> v2:
- split into two patches one to get the gustname second to log MCEs 
- addressed comments for MCE logging

Mario Smarduch (2):
  util/qemu-error: add guest name helper with -msg options
  target/i386: log MCE guest and host addresses

 include/qemu/error-report.h |  1 +
 qemu-options.hx             | 10 ++++++----
 target/i386/kvm.c           | 29 ++++++++++++++++++++++++-----
 util/qemu-error.c           | 31 +++++++++++++++++++++++++++++++
 vl.c                        |  5 +++++
 5 files changed, 67 insertions(+), 9 deletions(-)

-- 
2.9.3


