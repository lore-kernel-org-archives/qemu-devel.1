Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19744C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB9922244
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3p8pm+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB9922244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUlew-0007LS-0m
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 03:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1kUldo-0006re-Rc
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1kUldl-0001HJ-GF
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603177256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6xgNERydfaLL1nocgKowyrHqvkfpSAw9mELZflJHHKI=;
 b=h3p8pm+oV72uBk3xfgHbx/Gb3Q+u0WIPnSQI1yAH2Q0Uj2jcbm3KlF4l0Slh9QCUKBqeaM
 eQOTIWJOiEl5cVkm0RVaco15/Y3TaVKKbGQO6ioYWrzJn+abZPcHFYh9juq8LaQrmrujuy
 psjzngTltmrr9vzvIjpv7aozoJJvJSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-342Lj5fBPF61JrCDuER38Q-1; Tue, 20 Oct 2020 03:00:52 -0400
X-MC-Unique: 342Lj5fBPF61JrCDuER38Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 266958030BD;
 Tue, 20 Oct 2020 07:00:51 +0000 (UTC)
Received: from nautilus (unknown [10.40.192.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB7361A92D;
 Tue, 20 Oct 2020 07:00:44 +0000 (UTC)
Date: Tue, 20 Oct 2020 09:00:42 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v4 3/4] Jobs based on custom runners: docs and
 gitlab-runner setup playbook
Message-ID: <20201020070042.GF495479@nautilus>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-4-crosa@redhat.com>
 <20201019102610.GB495479@nautilus>
 <20201019205450.GD1617151@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201019205450.GD1617151@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eskultet@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eskultet@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 04:54:50PM -0400, Cleber Rosa wrote:
> On Mon, Oct 19, 2020 at 12:26:10PM +0200, Erik Skultety wrote:
> > On Sun, Oct 18, 2020 at 09:50:02PM -0400, Cleber Rosa wrote:
> > > +
> > > +    - name: Checks the availability of official gitlab-runner builds in the archive
> > > +      uri:
> > > +        url: https://s3.amazonaws.com/gitlab-runner-downloads/v{{ gitlab_runner_version  }}/binaries/gitlab-runner-linux-386
> > > +        method: HEAD
> > > +        status_code:
> > > +          - 200
> > > +          - 403
> > 
> > Why is 403 an acceptable success status code?
> >
> 
> I missed this question in my last reply, sorry.
> 
> s3 will throw a 403 if the URI doesn't exist... and we don't want to fail
> the playbook because of that, given that we'll attempt the fallback
> repo defined in vars.yml{,.template}.

Right, forgot about the repo in vars.yml fallback, thanks for explaining.

Regards,
Erik


