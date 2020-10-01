Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAD5C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B5B20796
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 10:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCtvYWo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B5B20796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNvyQ-00069K-8i
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 06:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kNvwc-0004iJ-7X
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21495)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1kNvwa-00025E-5m
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 06:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601548571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RONad66YFubEde4kMJc4uadHjj5bOkynC0Yws+S/TSg=;
 b=fCtvYWo7FsFArDWGE5f0L0q31riZ8RrSmTkbRUdyVt5e10rCQ85HW+JJdvWHZtnAS5Nun/
 pyOLLohxHK5gwmPQuropSECy1bdbwGT3/94Gx3xuhBpnV8AikoUyeKSIu9Z64nQfks3VG3
 FNS0C43K9L4axxh3Y8QmQA/JLapChT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-6E3NhKLwNu-zvSUsebVSZg-1; Thu, 01 Oct 2020 06:36:06 -0400
X-MC-Unique: 6E3NhKLwNu-zvSUsebVSZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C45D4801AAC;
 Thu,  1 Oct 2020 10:36:04 +0000 (UTC)
Received: from kaapi (unknown [10.40.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD91C7838A;
 Thu,  1 Oct 2020 10:36:01 +0000 (UTC)
Date: Thu, 1 Oct 2020 16:05:58 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: About 'qemu-security' mailing list
In-Reply-To: <m2362z8dvx.fsf@oracle.com>
Message-ID: <nycvar.YSQ.7.78.906.2010011502290.830962@xnncv>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009181031500.10832@xnncv> <m2362z8dvx.fsf@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello Darren,

+-- On Wed, 30 Sep 2020, Darren Kenny wrote --+
| While that is true, some aliases have managed to do something here by having 
| a single key for the alias, and behind the scenes that re-encrypts the 
| e-mail for each member of that alias (trying to avoid the 'list' term a 
| little here)
| 
| An example of this is the 'distro's list, e.g.: 
| - https://oss-security.openwall.org/wiki/mailing-lists/distros

* Yes, true. But it accepts non-encrypted reports too IIUC.

* I'm not sure how is the 'behind the scenes re-encryption' workflow for 
  non-member reporters.
 
  - Ex. say 2-3 non-member reporter(s) send an encrypted report with their 
    public keys.

  - A list member triaging such issue, would have to select their individual 
    keys for each reply.


| If you're looking to announce before a security issue is fixed, it may just 
| be better to keep it to the qemu-security members, which should try to 
| include at least 1, if not more, members from interested distros.

* No, I didn't mean an '-announce' list for non-security members. I was more 
  wondering about how to handle reproducers and other artefacts sent to the
  list.

* Proposed 'qemu-security' list is meant to have representatives from 
  downstream QEMU user communities.


| I know from past kernel security issues, it is still important to a distro 
| to be able to reproduce any issues if a PoC is provided.

* Yes, that's true. It should be okay in that case to keep the reproducers and 
  such artefacts on the list then.
 

| There are some existing mechanisms for announcing security issues once 
| found, e.g. oss-security:
| 
| - https://oss-security.openwall.org/wiki/mailing-lists/oss-security
| 
| A lot of distros have people on this list already monitoring it and many OSS 
| projects do send announcements of CVEs and security issues to this, once 
| resolved and an embargo period has expired - including Qemu, as I'm sure 
| that you know, given I've seen postings from you (Prasad) there.
| 
| Why would this not be enough for that?

* Yes, that is a fine, working means of public announcements. We currently use 
  the same.


| > * These representatives then decide if an issue can be readily disclosed and 
| >   discussed on the public 'qemu-devel' list OR needs to go through an embargo 
| >   process.
| 
| These are all very important points - and the need for an embargo period
| can be vital where Qemu/KVM is being widely deployed in a company.
... 
| | * Between LaunchPad and GitLab, I think GitLab is preferable.

| I would agree that Gitlab may be better here, if it would work - Gitlab
| can certainly be configured to restrict access to specific projects, but
| I'm not sure how that would play into logging an issue if you can't even
| see the project in question as a non-member of the security team.

* True. Reporters may need to open/create GitLab account to report issues.


To summarise:
=============
  - Bugzilla or GitLab issues would entail reporters create an account there 
    to report issues.

  - On a moderated 'qemu-security' list, even a non-member shall be able to 
    report issues via email.

  - Many voices have said 'Yes' for a moderated 'qemu-security' list.

  - Whether to have an encrypted list or otherwise, is an open question.
 
    + Encrypted list(ex. -distros) is possible. But it accepts non-encrypted 
      mails too IIUC.

    + Mandatory encryption would entail reporters create/share their keys.  
      It may become tricky, if reporters are non-members.

  - It should be okay to keep reproducers etc. artefacts on the list..?
    List archives shall not be publicly accessible.


Maybe we could start with a moderated list and improvise as we go forward?


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D


