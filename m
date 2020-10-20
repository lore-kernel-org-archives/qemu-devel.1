Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD87C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E67C22282
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 06:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH0qFvJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E67C22282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUl0G-0007DL-Fb
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 02:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1kUkzJ-0006nG-0o
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1kUkzG-0003nH-IN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 02:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603174748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4VAb+EjEzON8PgNpxMn6cLylIYUNg16lSbxziOAj6eQ=;
 b=QH0qFvJordx0NrbT2uHCu5amRaVI98CyWypa6saOlajvO1EJEncip6qCxltXga5egh9vDM
 W5gc2xc22JyAbiCx6DnNmm2V9FtU2XayEmNaaIvNKr5JETJcjoMjprPXRf+CgnlEJHTo4a
 nMIPRCFs2cO7/5D2x1X79c9ZfOVRj+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-ezntz6nrOam2mPu4mC6PmA-1; Tue, 20 Oct 2020 02:19:04 -0400
X-MC-Unique: ezntz6nrOam2mPu4mC6PmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47DF01084D61;
 Tue, 20 Oct 2020 06:19:03 +0000 (UTC)
Received: from nautilus (unknown [10.40.192.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F01310013D0;
 Tue, 20 Oct 2020 06:18:57 +0000 (UTC)
Date: Tue, 20 Oct 2020 08:18:54 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v4 2/4] Jobs based on custom runners: build environment
 docs and playbook
Message-ID: <20201020061854.GD495479@nautilus>
References: <20201019015003.1527746-1-crosa@redhat.com>
 <20201019015003.1527746-3-crosa@redhat.com>
 <20201019102741.GC495479@nautilus>
 <20201019202531.GB1617151@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201019202531.GB1617151@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eskultet@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eskultet@redhat.com;
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

On Mon, Oct 19, 2020 at 04:25:31PM -0400, Cleber Rosa wrote:
> On Mon, Oct 19, 2020 at 12:27:41PM +0200, Erik Skultety wrote:
> > ...
> > 
> > > diff --git a/scripts/ci/setup/inventory b/scripts/ci/setup/inventory
> > > new file mode 100644
> > > index 0000000000..8bb7ba6b33
> > > --- /dev/null
> > > +++ b/scripts/ci/setup/inventory
> > > @@ -0,0 +1,2 @@
> > > +[local]
> > 
> > Nit pick, is a group for localhost actually needed?
> >
> 
> You're right, it's not needed... I just thought it gave the
> "localhost" entry some "shelter" and "context". :)
> 
> And, I think a mostly "ini-like" file without a section triggers an OCD
> reaction in me.  I can remove it if it does something similar to you! :)
> 
> Thanks!
> - Cleber.

I understand, but even though it may be an ini-like config, "sections" have a
very distinct meaning in Ansible and that is grouping, so unless there are
hosts to group, I'd keep the inventory in a form of a simple list of individual
hosts.

Regards,
Erik


