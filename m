Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFE9C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B8820674
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbF3SZ7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B8820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEVGk-0002mv-Gr
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jEVFg-0001RR-8e
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jEVFf-0004Ti-4J
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:44:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jEVFf-0004Sm-08
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584524678;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lj1mo1zyE3Ly1aSWRYbjsfTRbPOrg6rENnfBzMNA7lo=;
 b=WbF3SZ7ypJiSt4+DD7KSAMNNOXvB3DRWR3cf3bjS4cClnRe+DGjLj61efuDQwnxF/OWDIl
 pq1AdK0rRNrsnt/olSAmdh4LC8eEWw86o2HEjsEoJBCV7rF8CTzw3HRhde/rg7XO2mw+lM
 m7pHKOn4Idukf8PaE6AU4XWrZiYa21o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-IspgdT20NKGh6VCmLg1axQ-1; Wed, 18 Mar 2020 05:44:35 -0400
X-MC-Unique: IspgdT20NKGh6VCmLg1axQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4B031005509;
 Wed, 18 Mar 2020 09:44:33 +0000 (UTC)
Received: from redhat.com (ovpn-115-92.ams2.redhat.com [10.36.115.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26A605C1BB;
 Wed, 18 Mar 2020 09:44:26 +0000 (UTC)
Date: Wed, 18 Mar 2020 09:44:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/4] tests/test-util-filemonitor: Fix Travis-CI $ARCH env
 variable name
Message-ID: <20200318094422.GC2173309@redhat.com>
References: <20200317200541.6246-1-philmd@redhat.com>
 <20200317200541.6246-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200317200541.6246-2-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 09:05:38PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> While we can find reference of a 'TRAVIS_ARCH' variable in
> the environment and source [1], per the Travis-CI multi-arch
> documentation [2] the variable is named TRAVIS_CPU_ARCH.
>=20
> [1] https://github.com/travis-ci/travis-build/blob/v10.0.0/lib/travis/bui=
ld/bash/travis_setup_env.bash#L39
> [2] https://docs.travis-ci.com/user/multi-cpu-architectures/#identifying-=
cpu-architecture-of-build-jobs
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/test-util-filemonitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


