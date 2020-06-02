Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF087C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 10:09:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5F7206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 10:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMIcFvXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5F7206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg3rV-0005CB-TC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 06:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg3qm-0004mX-5i
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 06:08:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jg3qk-0004k7-RO
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 06:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591092529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54R5swCj+3mYxIzGB4uvmvtQ7xJLSGLnNx3oASHSQEM=;
 b=cMIcFvXRozTZS6LmI+/8GLF+miPWXU4kMKRBitx2h3QDyXBA929t7mYAylatzPbaziSXxW
 IlGYNFCJstJPGsBuBAh2P6YclKIouWKomXal5H4BW3T18SXXPbmTNBjEdnfRciqJwWFdw+
 1lSqEJhBTxc5aXG/hq5W3XVNys6Opv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-5wNTxOL6MOyb82-9vp_zbw-1; Tue, 02 Jun 2020 06:08:42 -0400
X-MC-Unique: 5wNTxOL6MOyb82-9vp_zbw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88A7C80058E;
 Tue,  2 Jun 2020 10:08:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-75.ams2.redhat.com [10.36.113.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 341E9610F3;
 Tue,  2 Jun 2020 10:08:39 +0000 (UTC)
Date: Tue, 2 Jun 2020 12:08:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH RFC 01/32] python/qemu: create qemu.lib module
Message-ID: <20200602100837.GA5940@linux.fritz.box>
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 07:53 hat John Snow geschrieben:
> move python/qemu/*.py to python/qemu/lib/*.py.
> 
> To create a namespace package, the 'qemu' directory itself shouldn't
> have module files in it. Thus, these files will go under a 'lib' package
> directory instead.
> 
> Bolster the lib/__init__.py file a little bit, Make the top-level
> classes and functions available directly inside the `qemu.lib`
> namespace, to facilitate a convenient shorthand:
> 
> > from qemu.lib import QEMUQtestMachine, QEMUMonitorProtocol
> 
> Lastly, update all of the existing import directives.
> 
> (Note: these scripts were not necessarily tested to see if they still
> work. Some of these scripts are in obvious states of disrepair and it is
> beyond the scope of this patch to attempt to fix them.)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/__init__.py                   | 11 -----

When trying to reproduce your mypy problem, I was wondering why mypy was
complaining that it couldn't find qemu.lib. The reason is that removing
__init__.py from qemu means it's not a valid module any more. If I
recreate it locally, mypy stops complaining.

So I think we need to leave this file here.

Kevin


