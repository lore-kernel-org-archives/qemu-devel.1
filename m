Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17562C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D614A20772
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQD5mAIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D614A20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUlq-0007tR-3m
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1jtUkf-0007JL-Mu
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:30:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39784
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1jtUkd-000227-Oe
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594294201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPdA4UDiA7K/5OS4U/6wpvL/bm+Ai4kA2FNaMg8lw10=;
 b=KQD5mAIkm+AhmumCEJ0vXSsSaxzgtv0jlkoOGJtns4jZ7L2XPDJFS1qMJegX1ybh9c7NGU
 mUd2QgjD6ReZ6mm5uDCOiP82goZGf+z/QH5m6JBS7J/lMdnkQ5w1BV2/CpmDWDrKEX8tJ3
 DnOs7OLnytjCxyn2CENnz9REBvRHcNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-D4E0W20MP0qjzrQYUJqN-g-1; Thu, 09 Jul 2020 07:28:37 -0400
X-MC-Unique: D4E0W20MP0qjzrQYUJqN-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9477C186A8E0;
 Thu,  9 Jul 2020 11:28:36 +0000 (UTC)
Received: from kinshicho.usersys.redhat.com (unknown [10.40.195.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC7C35D9F3;
 Thu,  9 Jul 2020 11:28:29 +0000 (UTC)
Message-ID: <a462a7e1094fea39e13436a940ef91bec809a8fc.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
From: Andrea Bolognani <abologna@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Cleber
 Rosa <crosa@redhat.com>
Date: Thu, 09 Jul 2020 13:28:27 +0200
In-Reply-To: <20200709103029.GK3753300@redhat.com>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200709103029.GK3753300@redhat.com>
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=abologna@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-07-09 at 11:30 +0100, Daniel P. Berrangé wrote:
> On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> > +- name: Installation of basic packages to build QEMU
> > +  hosts: all
> > +  vars_files:
> > +    - vars.yml
> > +  tasks:
> > +    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
> > +      apt:
> > +        update_cache: yes
> > +        # This matches the packages on tests/docker/Dockerfiles/ubuntu1804.docker
> 
> I'd be inclined to actually use docker on the custom runners.
> 
> eg. instead of having separate physical machines or VMs for each
> (distro, arch) pair, have a single host distro for the arch. Then
> use docker to provide the build environment against each distro.
> 
> IOW, a RHEL-8 aarch64 host, running docker for ubuntu18.04, fedora30
> etc.
> 
> That way we don't end up duplicating all these packages, and instead
> can use  tests/docker/Dockerfiles/ubuntu1804.docker.  This ensures
> that if a user needs to reproduce a build failure on their own local
> aarch64 machine, they can run docker and get the exact same build
> architecture.
> 
> It also has the benefit that we don't need to worry about how to
> setup gitlab runners for every distro we care about. We only need to
> do gitlab runner for the standard host distro, which spawns a pristine
> throwaway docker env.
> 
> I appreciate this is a big change from what you've done in this patch
> though, so don't consider this comment a blocker for initial merge.
> I think we should do this as the long term strategy though. Essentially
> for Linux builds, everything should always be container based.

Agreed. You should be able to set up a fairly minimal environment,
which consists of Docker, gitlab-runner and not much else, using a
long-term supported distro such as CentOS and then just schedule
whatever container build on it. No need to provision a new machine
every time a new Fedora release comes out, just create a container
image for it and add it to the mix.

Additionally, the gitlab-runner Docker executor provides more
isolation than the shell executor, so running untrusted builds
becomes a more reasonable proposition - this is how the shared
runners on gitlab.com work - and you don't have to worry about your
jobs cleaning up properly after themselves nearly as much.

-- 
Andrea Bolognani / Red Hat / Virtualization


