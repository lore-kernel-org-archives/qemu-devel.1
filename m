Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D3AC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30622075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bl4jBYmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30622075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNaZd-0006R1-4F
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kNaYq-0005zi-8z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kNaYo-0004vs-8l
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601466373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MzDWrCUJ33HE1T3j+W7rSk3D2mR6AZY/aAO27j2wiI=;
 b=Bl4jBYmr7mJXSXemmO00GL1FRwRQndpmbI+HBCMTM0TOrcMG088LCjJ7Qz9ugh4ET1sZXm
 NLo0s3rHw8isA8kL4k0JrHBAPVCSl5WMbtZ/MMBK6gY20XUAP+y2MGus10EMRYDIDDvWu5
 2PgVZwdQyRkqWSyzZ9DnNQgT9N140ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-FhqjB6MBNjaZ3wNeaQN5nw-1; Wed, 30 Sep 2020 07:46:11 -0400
X-MC-Unique: FhqjB6MBNjaZ3wNeaQN5nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7356010BBEC3;
 Wed, 30 Sep 2020 11:46:10 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4159710013D0;
 Wed, 30 Sep 2020 11:46:07 +0000 (UTC)
Date: Wed, 30 Sep 2020 17:16:05 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv>
Message-ID: <nycvar.YSQ.7.78.906.2009301712150.699166@xnncv>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: peter.maydell@linaro.org,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Fri, 18 Sep 2020, P J P wrote --+
| +-- On Wed, 16 Sep 2020, Stefan Hajnoczi wrote --+
| | Do downstream maintainers want to know about potential security bug reports 
| | that have not been triaged yet?
| | 
| | Maybe there should there be a pre-announce list for bugs that have been 
| | triaged? That saves downstream from being spammed with confidential info 
| | that they probably can't use.
| 
| * I was thinking about that, an '-announce' list could be better. Because 
|   issue reports may come with reproducers (code/scripts/packet dump). And 
|   sharing such reproducers with wide-rs recipients seems risky, not right.
| 
| * Such reproducers shall stay in the list archives forever. It may have some 
|   legal IP related concerns. I'm not sure.
...
|  
| | Anyway, it's unclear to me what the motivation for creating a list and
| | changing the process is. Please share your goals and reasoning in more
| | detail.
| 
| * Primary motivation is to address the concern that current process limits 
|   community participation.
| 
| * Representatives from downstream QEMU user communities shall be notified 
|   about security issues as and when they come in.
| 
| * These representatives then decide if an issue can be readily disclosed and 
|   discussed on the public 'qemu-devel' list OR needs to go through an embargo 
|   process.
|
| 
| | I think it's worth investigating whether GitLab Issues can be configured in 
| | a secure-enough way for security bug reporting. That way HTTPS is used and 
| | only GitLab stores the confidential information (this isn't end-to-end 
| | encryption but seems better than unencrypted SMTP and plaintext emails 
| | copied across machines).
| 
| +-- On Wed, 16 Sep 2020, Peter Maydell wrote --+
| | Given that we currently use launchpad for bugs we should also look at 
| | whether launchpad's "private security" bug classification would be useful 
| | for us (currently such bug reports effectively go to /dev/null but this can 
| | be fixed).
| 
| 
| * Bug trackers would entail that reporters must have an account there. They 
|   may create account also, but if/when they become inactive, they'll continue
|   to  receive emails or have access to security bugs.
| 
|   A mailing list works more on invite-only basis that way.
| 
| * Bug trackers may also face the current limitation of community participants 
|   not knowing about the issues as and when they come in.
| 
| * So bug trackers need a way to send an email to a -announce/-security list,
|   sans the reproducer code/scripts/packet dump etc. information.
| 
| * Between LaunchPad and GitLab, I think GitLab is preferable.


Ping...!?
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


