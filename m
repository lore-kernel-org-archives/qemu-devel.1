Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E33BC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897E9222D9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvIzo/GG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897E9222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopsG-0001KZ-BM
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iooOA-0004WE-GG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iooO9-0001A5-1b
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:55:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iooO8-00019j-SV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578401712;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qttufoECSLSKdnfLADfyVG7ycmdttEFt6/MGHWuVi8Y=;
 b=cvIzo/GGBGgRRzeDlMo6bIul/T9/nRUnPgb+wt5pyndisJk4OP2Vt5puu3JqV21cw8ouuY
 U3nen/DhspuatWTAwo12a8/q9I0V4kk8CGLdb5fXzKS3gf1+xTbI4Wcen9V6SJHhspmDvL
 SGuyKxOFkh8b7Dq0CGQF3d4j0cL3Upw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-91aqR_DXO02GGVTn5W-TwQ-1; Tue, 07 Jan 2020 07:55:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20353DB62;
 Tue,  7 Jan 2020 12:55:10 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1344260BE2;
 Tue,  7 Jan 2020 12:54:54 +0000 (UTC)
Date: Tue, 7 Jan 2020 12:54:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update
 tests to recent desugarized -accel option)
Message-ID: <20200107125451.GL3368802@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
MIME-Version: 1.0
In-Reply-To: <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 91aqR_DXO02GGVTn5W-TwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 07, 2020 at 01:23:18PM +0100, Paolo Bonzini wrote:
> On 07/01/20 13:18, Thomas Huth wrote:
> > I don't think we need a separate priority parameter here. But IMHO it's
> >  really rather common practice to prioritize the last option. So while
> > it might be more "self-explanatory" to a CLI newbie if the first
> > occurrence got the highest priority, it might be rather confusing
> > instead for a CLI veteran...?
>=20
> Prioritising the last certainly makes sense for a choose-one-only
> option, but I'm not sure it's the same for a choose-best option.  After
> all it was -machine accel=3Dkvm:tcg, not -machine accel=3Dtcg:kvm...

IIUC, the main use case for specifying multiple accelerators is
so that lazy invokations can ask for a hardware virt, but then get
fallback to TCG if not available. For things that should be platform
portabile, there's more than just kvm to consider though, as we have
many accelerators.  Listing all possible accelerators is kind of
crazy though no matter what the syntax is.

How about taking a completely different approach, inspired by the
-cpu arg and implement:

    -machine accel=3Dbest

which will just "do the right thing(tm)", picking the best available
option for the current host.

Then declare the use of mulitple -machine args is unsupported
or undefined semantics, and ignore this priority question entirely
thus avoid making QEMU's CLI even more complex than it already is

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


