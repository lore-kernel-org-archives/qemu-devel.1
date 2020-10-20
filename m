Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB99AC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D3A02098B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 18:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WreR+Cbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3A02098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUw9o-0007bZ-LA
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 14:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kUw8n-00070f-9I
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50080)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kUw8k-0006Dp-AD
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 14:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603217620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDdhKEWowdgVvU9ZFBpy1PyIDnUyRMq4KxgvLENluLc=;
 b=WreR+CburvxRmQDKU8DPlyMZx9CvMffYNY8bpC3KS+Ziaw6q5/WBc99bz0zex3w5zsqlSE
 f/ROSpCtn6T0/wO+y7hWGQWcLwxxJPPaJxc7i8HZhi3ZfuL7JdBrFvFoYfhUzBnTdmKEG/
 fv4aEbDAi1IF4wL9rddXHEPer29njNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-7REh9noONyWpp2Pb0477Xg-1; Tue, 20 Oct 2020 14:13:38 -0400
X-MC-Unique: 7REh9noONyWpp2Pb0477Xg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7534D10866A1;
 Tue, 20 Oct 2020 18:13:37 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.195.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26C1C5C1C2;
 Tue, 20 Oct 2020 18:13:28 +0000 (UTC)
Message-ID: <3c24ba93db0c0b0c371e2e345cf8b2a5c180d185.camel@redhat.com>
Subject: Re: [PATCH v4 3/4] Jobs based on custom runners: docs and
 gitlab-runner setup playbook
From: Andrea Bolognani <abologna@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Erik
 Skultety <eskultet@redhat.com>
Date: Tue, 20 Oct 2020 20:13:26 +0200
In-Reply-To: <20201020082911.GB287149@redhat.com>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-4-crosa@redhat.com>
 <20201019102610.GB495479@nautilus>
 <20201019204138.GC1617151@localhost.localdomain>
 <20201020065839.GE495479@nautilus> <20201020082911.GB287149@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-10-20 at 09:29 +0100, Daniel P. Berrangé wrote:
> I think the obvious and easy place is start using lcitool is for the
> tests/docker/dockerfiles/*.  All that's required is to add mappings
> to lcitool for the various deps that QEMU has which libvirt does not
> already have. Then we should be able to start auto-generating the
> dockerfiles without too much difficulty. This will be a significant
> step forward because it will help us keep te package lists in sync
> across all the dockerfiles which is a major fail in QEMU right now.

I took a quick look at the contents of those dockerfiles and while I
agree that it's the obvious place to start, I'm not sure I would say
that generating them using lcitool is going to be easy :)

Basically there seem to be a number of assumptions both in lcitool
and in the QEMU dockerfiles, and getting the two to agree on those
will require quite some work from what I can tell.

But again, I agree it's something that should be worked on.

> Dealing with tests/vm replacement or these ansible recipes is likely
> to be a significantly more challenging proposition. Perhaps we can
> again start by just automating creation of the package lists that
> the tests/vm and ansibile recipes need, as again those are all
> inconsistent.

Perhaps 'lcitool variables' could be of use here.

-- 
Andrea Bolognani / Red Hat / Virtualization


