Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C19C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:13:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD8E20748
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cz5W69Ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD8E20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE7mw-0002WT-MS
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 05:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kE7mL-000265-BR
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 05:13:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45582
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1kE7mI-00017K-R6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 05:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599210781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyMCI9L9ATq2niAmlQw4klUqHAxy3tGe7Wl1XTDegHM=;
 b=cz5W69PsNyHpMMzoVvNrlUMZU3zYHH8C4W8+39CIBLwCOMCYJ52+mUPggcqXYoUr5Tw1zz
 ZGjasK9azYh0NSjoq3vsLrzk+pkFwu/XLn9ByE2LStQ38ny2DZ8BqKbVgwTC+477SU6Nop
 l+NSxk1tbM5BVqhv5Hb2FIudIMDynrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-W9amtR1lO4yrYyk-wDCF8Q-1; Fri, 04 Sep 2020 05:11:36 -0400
X-MC-Unique: W9amtR1lO4yrYyk-wDCF8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EA961009447;
 Fri,  4 Sep 2020 09:11:35 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.40.194.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8E68196FD;
 Fri,  4 Sep 2020 09:11:27 +0000 (UTC)
Message-ID: <547ef390fe84bd919f2601d5a29c98f345c6c881.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
From: Andrea Bolognani <abologna@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, Erik Skultety <eskultet@redhat.com>
Date: Fri, 04 Sep 2020 11:11:25 +0200
In-Reply-To: <20200903211211.GC55646@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200709085507.GA536480@nautilus.usersys.redhat.com>
 <20200903211211.GC55646@localhost.localdomain>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=abologna@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-09-03 at 17:12 -0400, Cleber Rosa wrote:
> On Thu, Jul 09, 2020 at 10:55:07AM +0200, Erik Skultety wrote:
> > On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> > > +.. note:: there are currently limitations to gitlab-runner itself when
> > > +          setting up a service under FreeBSD systems.  You will need to
> > > +          perform steps 4 to 10 manually, as described at
> > > +          https://docs.gitlab.com/runner/install/freebsd.html
> > 
> > What kinds of limitations? Is it architecture constrained maybe? I'm asking
> > because we have all of the steps covered by an Ansible playbook, so I kinda got
> > triggered by the word "manually". Also, the document only mentions 9 steps
> > overall.
> 
> FreeBSD's "service management" (systemd/sys-v like) is not covered by
> the GO library[1] used on gitlab-runner.  It's not ideal, and the
> second best solution would be to script the equivalent handling within
> the playbook, but I remember trying and finding some inconsistencies.
> Then, I had to give it up and defer to whenever a FreeBSD job is
> actually added.
> 
> [1] - https://github.com/ayufan/golang-kardianos-service

Note that this is a fork of

  https://github.com/kardianos/service

where FreeBSD support was added recently with

  https://github.com/kardianos/service/commit/14b2cc59a290407a6f1cb3daba59069429d9665b

I'm not sure why gitlab-runner would use a fork rather than the
primary repository, but perhaps they can be convinced to switch and
gain better FreeBSD support in the process.

-- 
Andrea Bolognani / Red Hat / Virtualization


