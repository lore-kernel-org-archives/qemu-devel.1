Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CABC43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A0B21534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFCGSms6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A0B21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJAQS-0006JE-18
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kJAPk-0005sM-5O
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kJAPg-0000fC-R7
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600412551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDKSRbnjANfAdVP3OMm6Eb4T0QXmTRqiBXBpuhgcgRA=;
 b=RFCGSms6DpBdbXinib68hB4zjAYgxmo3um+CCC86gYLDD35tF8b9COKa4srYJl6gx4xzGk
 JD1fiFG8UR6TjGx9iDoqGUNhntdQKlxbK3yLHkCCMmz+eFwNS/ALQ28gmQXm1Qc5meVHMv
 9jBZ9nYxBVX77UJ1p6/XcK1cWFc9CSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-3MZ3UtWmNvK-R4gvMgcs5w-1; Fri, 18 Sep 2020 03:02:29 -0400
X-MC-Unique: 3MZ3UtWmNvK-R4gvMgcs5w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB3B5873016;
 Fri, 18 Sep 2020 07:02:27 +0000 (UTC)
Received: from kaapi (ovpn-112-187.phx2.redhat.com [10.3.112.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0208C78815;
 Fri, 18 Sep 2020 07:02:25 +0000 (UTC)
Date: Fri, 18 Sep 2020 12:32:23 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <20200916111025.GA756728@stefanha-x1.localdomain>
Message-ID: <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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

  Hello all,

+-- On Wed, 16 Sep 2020, Stefan Hajnoczi wrote --+
| I'm surprised the lack of encryption doesn't bother you. The security bug 
| reporting process should be confidential to prevent disclosure of 0-days.

* I think it'll work only if all issue reports are encrypted. Under current 
  process, we've our GPG keys published, yet majority of the issue reports are 
  unencrypted. CVEs are of more interest/incentive.

* Encrypted email workflow is also not as seamless as unencrypted.


| Triaging and fixing are different things. Where is the bottleneck, triaging 
| or fixing?

* Issue triaging/analysis is lesser time; Patches may take longer, so fixing.

* But having mailing-list isn't going to affect/address either.


| Do downstream maintainers want to know about potential security bug reports 
| that have not been triaged yet?
| 
| Maybe there should there be a pre-announce list for bugs that have been 
| triaged? That saves downstream from being spammed with confidential info 
| that they probably can't use.

* I was thinking about that, an '-announce' list could be better. Because 
  issue reports may come with reproducers (code/scripts/packet dump). And 
  sharing such reproducers with wide-rs recipients seems risky, not right.

* Such reproducers shall stay in the list archives forever. It may have some 
  legal IP related concerns. I'm not sure.


| I don't think a broadcast model works well for assigning responsibility. If 
| maintainers constantly receive security-related emails (most of which don't 
| affect them), they will ignore them. This is what happens with broadcast CI 
| and fuzzing results.
| 
| Instead someone should assign security bug reports to relevant maintainers.
| 
| Another option is to let reporters directly contact the maintainers (e.g. 
| QEMU's MAINTAINERS file), but this is hard to get right and if a maintainer 
| is on vacation the report may go unnoticed.

* True, agree.

 
| Anyway, it's unclear to me what the motivation for creating a list and
| changing the process is. Please share your goals and reasoning in more
| detail.

* Primary motivation is to address the concern that current process limits 
  community participation.

* Representatives from downstream QEMU user communities shall be notified 
  about security issues as and when they come in.

* These representatives then decide if an issue can be readily disclosed and 
  discussed on the public 'qemu-devel' list OR needs to go through an embargo 
  process.


| I think it's worth investigating whether GitLab Issues can be configured in 
| a secure-enough way for security bug reporting. That way HTTPS is used and 
| only GitLab stores the confidential information (this isn't end-to-end 
| encryption but seems better than unencrypted SMTP and plaintext emails 
| copied across machines).

+-- On Wed, 16 Sep 2020, Peter Maydell wrote --+
| Given that we currently use launchpad for bugs we should also look at 
| whether launchpad's "private security" bug classification would be useful 
| for us (currently such bug reports effectively go to /dev/null but this can 
| be fixed).


* Bug trackers would entail that reporters must have an account there. They 
  may create account also, but if/when they become inactive, they'll continue
  to  receive emails or have access to security bugs.

  A mailing list works more on invite-only basis that way.

* Bug trackers may also face the current limitation of community participants 
  not knowing about the issues as and when they come in.

* So bug trackers need a way to send an email to a -announce/-security list,
  sans the reproducer code/scripts/packet dump etc. information.

* Between LaunchPad and GitLab, I think GitLab is preferable.



Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


