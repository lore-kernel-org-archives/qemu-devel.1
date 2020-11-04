Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD785C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248E9221F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iz+mUWeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248E9221F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGFJ-000442-4x
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kaG43-0002c1-EG
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kaG3y-0003RL-QT
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604485845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UnQ+maGyV3+le3JYWcBzeCWKWRpKpQLbwWCWpbDjuKY=;
 b=Iz+mUWePdrVumaUB8zlmQmKorkPUfawdu9xW0xZSdVXL4K1T+4whhiPa8v3Q1hcWt8AYBz
 Dqk/Pt3m/snR4bk5ddlLXTDPZmOUR2xdEoY9e4n1fHqB3nqFE5MfDHu8qiV4N3TvTSxvr9
 p/Xm0DqkA7+/x6Dh/4IqUcxrGviCjS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-VkMpwwROMqmc9RToaGrMiA-1; Wed, 04 Nov 2020 05:30:42 -0500
X-MC-Unique: VkMpwwROMqmc9RToaGrMiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A4A11084D66;
 Wed,  4 Nov 2020 10:30:40 +0000 (UTC)
Received: from kaapi (ovpn-112-138.phx2.redhat.com [10.3.112.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6AC65B4DF;
 Wed,  4 Nov 2020 10:30:18 +0000 (UTC)
Date: Wed, 4 Nov 2020 16:00:15 +0530 (IST)
From: P J P <ppandit@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: Ramping up Continuous Fuzzing of Virtual Devices in QEMU
In-Reply-To: <20201022163925.GE428835@redhat.com>
Message-ID: <p2qq7p64-r88p-s228-133q-n770po2ssonp@erqung.pbz>
References: <20201022161938.7clfymu6a3zl46s2@mozz.bu.edu>
 <20201022162416.iccjosbeg753qbzc@mozz.bu.edu>
 <20201022163925.GE428835@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 BOUNDARY="-1463810047-2047417173-1604484976=:1954039"
Content-ID: <33qr3p10-5nn0-s8r6-9221-snq0p86n9os8@erqung.pbz>
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: peter.maydell@linaro.org, thuth@redhat.com,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 rjones@redhat.com, 0ops@0ops.net, liq3ea@gmail.com, qemu-devel@nongnu.org,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, andrey.shinkevich@virtuozzo.com, ppandit@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-2047417173-1604484976=:1954039
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <654787qn-o9po-30q9-2p2-q4n2q6q1o40@erqung.pbz>

+-- On Thu, 22 Oct 2020, Daniel P. Berrangé wrote --+
| On Thu, Oct 22, 2020 at 12:24:16PM -0400, Alexander Bulekov wrote:
| > > Once [2] lands upstream, we should see a significant uptick in oss-fuzz 
| > > reports, and I hope that we can develop a process to ensure these bugs 
| > > are properly dealt with. One option we have is to make the reports 
| > > public immediately and send notifications to qemu-devel. This is the 
| > > approach taken by some other projects on oss-fuzz, such as LLVM. Though 
| > > its not on oss-fuzz, bugs found by syzkaller in the kernel, are also 
| > > automatically sent to a public list. The question is:
| > > 
| > > What approach should we take for dealing with bugs found on oss-fuzz?
| 
| If we assume that a non-negligible number of fuzz bugs will be exploitable
| by a malicious guest OS to break out into the host, then I think it is
| likely undesirable to make them public immediately without at least a basic
| human triage step to catch possibly serious security issues.

* Maybe the proposed 'qemu-security' list can receive such issue reports.  It 
  is more close than qemu-devel.

  But it also depends on the quantum of traffic oss-fuzz generates. We don't 
  want to flood/overwhelm qemu-security list or any other list for that 
  matter.

* Human triage is required to know potential impact of an issue before it is 
  sent to a public list. It would not be good to send guest-to-host-escape
  type issues directly to a public list.

* Ideally preliminary human triage should be done on the fuzzers' side.  
  After it hits an issue, someone should have a look at it before sending an 
  email to a list OR maintainer(s).

  Ex. TCG issues are generally not considered for CVE. They need not go to a
  security list.



Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-2047417173-1604484976=:1954039--


