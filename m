Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBF3C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B8E20838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 08:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSbwd1q5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B8E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU4zP-0008W3-NV
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 04:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU4yi-0007kA-2w
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jU4yh-0005Q8-8v
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:55:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49365
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jU4yg-0005MQ-Qy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 04:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588236929;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1m+ksxvSQJKZSszbR0dPI+xJje2iQNz51NCLOPfMV0=;
 b=hSbwd1q5AnPjuR2mZNAxUo+sDRvuYVjMzH4sXYkID6EwtwZKxO2xepr6vm/Y5TmZfk5Nuo
 lG3lcdgDzEDY0Hhg/ls56BbPnyx9RxtmKr59XCnCcsC+RaWeGddD+GPdfW/U1oX/yDbF6O
 UVSh/763qOMjS3XuxCI7FGBzLhPlTD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-gQPrA1y1MpiepvAk9Tldmg-1; Thu, 30 Apr 2020 04:55:22 -0400
X-MC-Unique: gQPrA1y1MpiepvAk9Tldmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D3158014D6;
 Thu, 30 Apr 2020 08:55:21 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BEF2060E1C;
 Thu, 30 Apr 2020 08:55:18 +0000 (UTC)
Date: Thu, 30 Apr 2020 09:55:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] tests: add a "check-flake8" test for validating python
 code style
Message-ID: <20200430085515.GE2084570@redhat.com>
References: <20200429153621.1694266-1-berrange@redhat.com>
 <874kt1im1c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <874kt1im1c.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 07:23:59AM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> > +check-flake8:
> > +=09$(call quiet-command,flake8 --ignore=3D$(FLAKE8_IGNORE) $(PYTHON_FI=
LES))
> > +else
> > +check-flake8:
> > +endif
> > +
> > +check: check-block check-qapi-schema check-unit check-softfloat check-=
qtest check-decodetree check-flake8
> >  check-clean:
> >  =09rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS=
-y)
> >  =09rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest=
-$(target)-y:%=3Dtests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=3Dtests=
/qtest/%$(EXESUF)))
>=20
> The QAPI generator is already clean except for
> F403,F405,E241,W503,W504,E226,E501,E261.  The new automated cleanliness
> test is next to useless for keeping it that way.  How could we tailor it
> to solve that?

We would have to run flake8 multiple times, passing different exclusions
for different sets of files.  This wouldn't be too bad as long as we don't
get too many different sets of files. We could split it into iotests,
qapi and misc for example.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


