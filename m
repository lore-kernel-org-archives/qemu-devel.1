Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C6DC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07EFD22283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVIRrNY2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EFD22283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUncd-0000l8-0Q
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUnbR-0008PT-L5
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:06:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUnbP-0004Dl-HL
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603184801;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7PzXGojwifMHd1k1U6sr8un7jcHcy9dwncL1FMKb54=;
 b=IVIRrNY27eU3H1yI5pcMDnOQCgsldu0dt5yENUwHnc4ha2D5LkIWPdNfqMpz6GEZbfYXFZ
 6K//9UAHF/m6h3+7juc7EFmMsI+Z/H8WmJkaCn3h9cErvdEWjj49xzIJb1pDqptlyvr2kg
 M44hQFuU8wH0dTdI/etmHJ/chjDLJ4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-t7Qy_9ZnOcCZg7VJ8AyHMA-1; Tue, 20 Oct 2020 05:06:37 -0400
X-MC-Unique: t7Qy_9ZnOcCZg7VJ8AyHMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFEA63FD1;
 Tue, 20 Oct 2020 09:06:35 +0000 (UTC)
Received: from redhat.com (ovpn-114-206.ams2.redhat.com [10.36.114.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49FD51000320;
 Tue, 20 Oct 2020 09:06:26 +0000 (UTC)
Date: Tue, 20 Oct 2020 10:06:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
Subject: Re: [PATCH v2 03/15] python: add VERSION file
Message-ID: <20201020090623.GD287149@redhat.com>
References: <20201014142957.763624-1-jsnow@redhat.com>
 <20201014142957.763624-4-jsnow@redhat.com>
 <5d5148df6e51a70b8980945b5259c248c2994969.camel@redhat.com>
 <20201019100207.GD236912@redhat.com>
 <bec8bd228f9d3627cb848241f2df413d917bd500.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bec8bd228f9d3627cb848241f2df413d917bd500.camel@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 10:52:14AM +0200, Andrea Bolognani wrote:
> On Mon, 2020-10-19 at 11:02 +0100, Daniel P. Berrangé wrote:
> > On Mon, Oct 19, 2020 at 11:45:09AM +0200, Andrea Bolognani wrote:
> > > With that in mind, I think it would be unwise for qemu.* not to do
> > > the same; in particular, using a version number that's not <1.0.0 for
> > > a package that is very much in flux will almost certainly break
> > > people's expectations, and is also not something that you can easily
> > > take back at a later time.
> > 
> > I don't think it is that big a deal, and there is clear benefit to
> > having the python code version match the QEMU version that it is
> > the companioon to.
> > 
> > Ultimately the versioning scheme just impacts on the version string
> > conditionals people list for their dependancies. Apps consuming QEMU
> > can handle any of the version schemes without much difference.
> 
> The problem comes from the expectations: a Python programmer, who is
> used to semver due to its prominence on PyPi, when deciding whether
> to move from qemu.core 4.2.0 to 5.0.0 might expect to need code
> changes to cope with API-breaking changes - where in fact there are
> none, and at the same time might expect upgrading to 5.2.0 from 5.0.0
> to be completely straightforward when in reality a feature their
> application depends on might have been removed after the usual
> deprecation period.

The QEMU python modules are not like other python modules though,
precisely because they are talking to QEMU. If we are shipping
QEMU python releases on the same schedule as QEMU, then we can
expect the normal ase to be updating both QEMU & Python together.
So regardless of versioning in the python code, the QMP code they
are talking to is liable to have removed deprecated features they
are using.  IMHO the upgrade issue is largely a problem of docs
and testing, semver is no magic bullet.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


