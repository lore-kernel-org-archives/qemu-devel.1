Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D546C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605C5206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzgLdivP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605C5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBry-0003Jw-3g
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kYBrI-0002rs-4P
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1kYBrF-0005yY-MR
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603993023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bzgQvHTqjBtzU/oR7oiDOEnORlzk2rRYO7GDe7sOJU=;
 b=ZzgLdivPBxNkMwmX0FMi1x2lSMrHGMvMmjHVytqnlh/VWLgUyYwQbxrQssG91JP/5loAT2
 laJOUovZeLv0VnEY33z8loeG5V9MoTt1rh5ErNj6wEq5PjB1AnQSqfSEQUUxjeTOhyMpon
 zDwtbLK80otBmFZga5a53WLcfgBz0Ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-zE3kzTEjME6JBGWowy0k9Q-1; Thu, 29 Oct 2020 13:37:00 -0400
X-MC-Unique: zE3kzTEjME6JBGWowy0k9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74CD41882FB7;
 Thu, 29 Oct 2020 17:36:59 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-114-128.ams2.redhat.com
 [10.36.114.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C8035D98F;
 Thu, 29 Oct 2020 17:36:59 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 781123E047D; Thu, 29 Oct 2020 18:36:57 +0100 (CET)
Date: Thu, 29 Oct 2020 18:36:57 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Migrating to the gitlab issue tracker
Message-ID: <20201029173657.7bar7sq6zzkeee2g@paraplu>
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201029174114.47e2b351.cohuck@redhat.com>
 <CAKmqyKOY+5WcxUg3Rvq2t3vYWOHrHQdhcv8PkiqZX2zVMdqJ3Q@mail.gmail.com>
 <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kchamart@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
Cc: Alistair Francis <alistair23@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 01:12:22PM -0400, John Snow wrote:

Hi,

[...]

> Mostly I was looking for any hard objections over the idea of issues not
> necessarily being sent to the list anymore, if there were any.

Not an objection, but I would miss discovering "interesting" issues by
virtue of bug emails sent to the list.  Several times I've "stumbled
into" bugs on 'qemu-devel' that affect upper layers, or just Damn
Interesting QEMU Bugs™ (especially in the Block Layer) that helped me
gain better understanding, or something is already a "known issue".

That said, the reactions so far seem to be positive for moving to GitLab
Issues.  

Maybe there are some acceptable workarounds.  It looks like there's a
way to subscribe to GitLab issues via email[1]; and I can triage that
maildir as part of my regular email workflow.

https://docs.gitlab.com/ee/administration/incoming_email.html

[...]

-- 
/kashyap


