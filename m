Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C4C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACD224182
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 08:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVQjfkXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACD224182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVsi3-0005wU-TF
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 04:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVshD-0005Pt-2s
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVshA-00038K-K0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 04:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603442706;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qTH4mGEoGJRfzbADZcudTatJ0fyMMp8EX/OBk48jXYw=;
 b=IVQjfkXpwlW3BERGqlwhH0K8WR8c9+lhf49okCbgVvqoYUZx7VhV0zXY/GU6USRguQgzNJ
 s38EY8Hwzj95Khr1ikcm9aIFZ+JGcfLWMNwtF83tnHimTlHtUHJ+i2cPLkIApn3kjgvxaV
 oUOMri7HzXOuFGqY5Qz1f5j8vkKTdHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-tAggXtyuPmWSW4jhT-AUBQ-1; Fri, 23 Oct 2020 04:44:59 -0400
X-MC-Unique: tAggXtyuPmWSW4jhT-AUBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9FE3804B7C;
 Fri, 23 Oct 2020 08:44:57 +0000 (UTC)
Received: from redhat.com (ovpn-114-187.ams2.redhat.com [10.36.114.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50AF97D4E1;
 Fri, 23 Oct 2020 08:44:54 +0000 (UTC)
Date: Fri, 23 Oct 2020 09:44:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] Using gitlab for upstream qemu repo?
Message-ID: <20201023084451.GB445638@redhat.com>
References: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 06:47:55PM +0200, Paolo Bonzini wrote:
> Hi all,
> 
> now that Gitlab is the primary CI infrastructure for QEMU, and that all
> QEMU git repositories (including mirrors) are available on Gitlab, I
> would like to propose that committers use Gitlab when merging commits to
> QEMU repositories.
> 
> There are four reasons for this:
> 
> - this would be a step towards ensuring that all commits go through the
> CI process, and it would also provide a way to run the deployment of the
> web site via .gitlab-ci.yml.
> 
> - right now Gitlab pulls from upstream repos and qemu.org pulls from
> gitlab, but this is not true for the qemu, qemu-web and openbios
> repositories where Gitlab pulls from qemu.org and qemu.org is the main
> repository.  With this switch, all the main repositories would be on
> Gitlab and then mirrored to both qemu.org and GitHub.  Having a
> homogeneous configuration makes it easier to document what's going on.

I think it makes sense to make GitLab be the canonical location for
all the GIT repos that QEMU project hosts, and everything else be a
read-only mirror.

With the current mixed setup both qemu.org and gitlab.com are failure
points which impact us. This is bad because while gitlab.com has
scalable redundant hardware with dedicated sysadmins, qemu.org is a
single VM, with part time sysadmins, and no failover facility if the
VM fails.

By making gitlab.com primary, any problems with qemu.org no longer
have a blocking impact on us.

> - it would limit the number of people with access to qemu.org, since
> committers would no longer need an account on the machine.
> 
> - by treating gitlab as authoritative, we could include it in the
> .gitmodules file and remove load on the qemu.org server

Yes makes sense,

> Nothing would change for developers, who would still have access to all
> three sets of repositories (git.qemu.org, gitlab.com and github.com).
> Committers however would need to have an account on the
> https://gitlab.com/qemu-project organization with access to the
> repositories they care about.  They would also lose write access to
> /srv/git on qemu.org.
> 
> Of course this is just starting a discussion, so I'm not even proposing
> a date for the switch.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


