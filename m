Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5DFC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3B824724
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOpsmGKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3B824724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXlju-00077V-QI
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 09:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXlif-0006eW-W0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXlie-0001iw-55
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603892546;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Mve/mvA78tTdSlvz0v2Vsycit248Tgl5Ga0xQSVBqtU=;
 b=UOpsmGKZmwK3dzBOcvOiUKCenM6AU4kLRgxjNV/H4mvR7oUdz3LJQcGmTAv+fsg/qOpVoP
 LAmfeEn7+fbx4ICJ7LxiKcaLxUmVBE+5TcbjIudGzRhdDberJTxx7RYPLFP+AzzCgoiyYO
 UCzno3TlA7cdSp+0E+SjyEmeKSWE97E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-URBG3r4WNW-SzAkuadlhiA-1; Wed, 28 Oct 2020 09:42:12 -0400
X-MC-Unique: URBG3r4WNW-SzAkuadlhiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C773664160;
 Wed, 28 Oct 2020 13:42:10 +0000 (UTC)
Received: from redhat.com (ovpn-113-216.ams2.redhat.com [10.36.113.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83E015D9F3;
 Wed, 28 Oct 2020 13:41:59 +0000 (UTC)
Date: Wed, 28 Oct 2020 13:41:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 4/5] python: add .gitignore
Message-ID: <20201028134155.GA683482@redhat.com>
References: <20201027223815.159802-1-jsnow@redhat.com>
 <20201027223815.159802-5-jsnow@redhat.com>
 <f9ea6ce1-f464-0376-29ac-6071f680e63b@redhat.com>
 <871rhi1zim.fsf@dusky.pond.sub.org>
 <3c86b845-31ad-0956-d095-6a6323679a90@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3c86b845-31ad-0956-d095-6a6323679a90@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 09:39:07AM -0400, John Snow wrote:
> On 10/28/20 5:16 AM, Markus Armbruster wrote:
> > Thomas Huth <thuth@redhat.com> writes:
> > 
> > > On 27/10/2020 23.38, John Snow wrote:
> > > > Ignore build and package output (build, dist, qemu.egg-info);
> > > > effectively these are "in-tree" builds of a kind.
> > > 
> > > Since we recently moved away from in-tree builds, could these also be made
> > > out-of-tree only?
> > 
> > The build should only write to the per-build spaces: the build tree,
> > per-build scratch in /tmp, ...  Writing to shared space such as the
> > source tree can break parallel independent builds.  I consider that a
> > bug.
> > 
> 
> It's not really a "build" in that traditional sense, but if you were to
> execute "make venv-check" in parallel, I'm not confident it would work
> right. Don't do that, I guess.
> 
> This has nothing to do with QEMU's build step. We don't need to "build" or
> "install" this package to use it during QEMU builds or (most) testing. We
> *do* need to install it to a virtual environment to test it with an explicit
> set of linter packages, though.
> 
> See also: why do we ignore *.pyc and __pycache__ files in the whole tree?
> These are in effect build artifacts too. I'm not sure I would know how to
> avoid those being created. Maybe it's possible? but... I don't think this is
> a problem that we have to solve, actually.

You can disable pyc files with

  export PYTHONDONTWRITEBYTECODE=dontmesswithmysourcedir

https://docs.python.org/3/using/cmdline.html#envvar-PYTHONDONTWRITEBYTECODE


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


