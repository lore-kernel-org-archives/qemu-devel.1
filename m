Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C48C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EF92074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EF92074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE71S-0001pv-Ap
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 04:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kE70v-0001Hj-9l
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:24:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59327
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kE70s-0003pj-RF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:24:04 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-yJt2Ld3LOdC4ZW8JJrWkkw-1; Fri, 04 Sep 2020 04:23:57 -0400
X-MC-Unique: yJt2Ld3LOdC4ZW8JJrWkkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39F3A6408E;
 Fri,  4 Sep 2020 08:23:56 +0000 (UTC)
Received: from redhat.com (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E9125C1C2;
 Fri,  4 Sep 2020 08:23:50 +0000 (UTC)
Date: Fri, 4 Sep 2020 09:23:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200904082347.GC721059@redhat.com>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200709103029.GK3753300@redhat.com>
 <a462a7e1094fea39e13436a940ef91bec809a8fc.camel@redhat.com>
 <20200904001817.GF55646@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200904001817.GF55646@localhost.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 08:18:17PM -0400, Cleber Rosa wrote:
> On Thu, Jul 09, 2020 at 01:28:27PM +0200, Andrea Bolognani wrote:
> > On Thu, 2020-07-09 at 11:30 +0100, Daniel P. Berrangé wrote:
> > > On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> > > > +- name: Installation of basic packages to build QEMU
> > > > +  hosts: all
> > > > +  vars_files:
> > > > +    - vars.yml
> > > > +  tasks:
> > > > +    - name: Install basic packages to build QEMU on Ubuntu 18.04/20.04
> > > > +      apt:
> > > > +        update_cache: yes
> > > > +        # This matches the packages on tests/docker/Dockerfiles/ubuntu1804.docker
> > > 
> > > I'd be inclined to actually use docker on the custom runners.
> > > 
> > > eg. instead of having separate physical machines or VMs for each
> > > (distro, arch) pair, have a single host distro for the arch. Then
> > > use docker to provide the build environment against each distro.
> > > 
> > > IOW, a RHEL-8 aarch64 host, running docker for ubuntu18.04, fedora30
> > > etc.
> > > 
> > > That way we don't end up duplicating all these packages, and instead
> > > can use  tests/docker/Dockerfiles/ubuntu1804.docker.  This ensures
> > > that if a user needs to reproduce a build failure on their own local
> > > aarch64 machine, they can run docker and get the exact same build
> > > architecture.
> > > 
> > > It also has the benefit that we don't need to worry about how to
> > > setup gitlab runners for every distro we care about. We only need to
> > > do gitlab runner for the standard host distro, which spawns a pristine
> > > throwaway docker env.
> > > 
> > > I appreciate this is a big change from what you've done in this patch
> > > though, so don't consider this comment a blocker for initial merge.
> > > I think we should do this as the long term strategy though. Essentially
> > > for Linux builds, everything should always be container based.
> > 
> > Agreed. You should be able to set up a fairly minimal environment,
> > which consists of Docker, gitlab-runner and not much else, using a
> > long-term supported distro such as CentOS and then just schedule
> > whatever container build on it. No need to provision a new machine
> > every time a new Fedora release comes out, just create a container
> > image for it and add it to the mix.
> >
> 
> Hi Andrea,
> 
> There's nothing preventing this from happening, but limiting the
> runners to this configuration, prevents a lot more from happening.
> 
> > Additionally, the gitlab-runner Docker executor provides more
> > isolation than the shell executor, so running untrusted builds
> > becomes a more reasonable proposition - this is how the shared
> > runners on gitlab.com work - and you don't have to worry about your
> > jobs cleaning up properly after themselves nearly as much.
> >
> 
> I understand and agree to the the benefits of using the gitlab-runner
> Docker executor... until you want to run tests on non-Docker
> environments :).
> 
> Hopefully the explanation on my previous reply to Daniel will also
> serve for the points you raised here.  I would have loved to have
> worked on a more abstract, container only environments, but that
> proved to be unrealistic.

For Linux targets, it should be possible to have exclusively container
based testing environments. At worst you can run a privileged container
and expose arbitrary host resources to it, so you can do anything in
the container that you would otherwise do in bare metal. For non-Linux,
we should be able to satisfy our needs with VMs, and indeed VMs can
be used for Linux too if we want to emulate some specific hardware for
testing that we don't have accessible to containers on bare metal.
IOW, the testing environment can be entirely defined by the recipes
we have in tests/docker and tests/vm. Bare metal hosts are simply a
way to host the containers or vms.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


