Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE562C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87420205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uc8M2iSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87420205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipB7g-0006sP-Lf
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ipB6X-0005oc-CG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ipB6W-0002yr-4N
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:10:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ipB6W-0002y6-15
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578489031;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V28hfkP8FWtZpX39p6KTIcSPQUmjVvX2NKwSIqkCtYk=;
 b=Uc8M2iSGm3fu4MeItPOqOLgomKPxsxwrt9svlFx6ODBwZcTSw7kTy/vu0nOAzOLHZ58ims
 T2PYx0t+rCOc21LFXveJiXpVHbQeb8ne2N/YDtqq9XdVV0+1+/JPx/3j782HrFjttFdab1
 IyRPJcaPBu027vQBxdYhG8/+jyAA3Uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-jGWAtHskMJGOa3zop3G3Rw-1; Wed, 08 Jan 2020 08:10:25 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE0C018A6EF9;
 Wed,  8 Jan 2020 13:10:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83F8586C5C;
 Wed,  8 Jan 2020 13:10:17 +0000 (UTC)
Date: Wed, 8 Jan 2020 13:10:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update
 tests to recent desugarized -accel option)
Message-ID: <20200108131015.GF3386452@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com>
 <87d0bujkpe.fsf@linaro.org>
 <da2111ee-0644-1d7c-a111-e4209025a1d8@redhat.com>
 <60ecc0ec-d8db-2cf6-b21a-799f4cb9ab71@redhat.com>
MIME-Version: 1.0
In-Reply-To: <60ecc0ec-d8db-2cf6-b21a-799f4cb9ab71@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: jGWAtHskMJGOa3zop3G3Rw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 08, 2020 at 01:41:59PM +0100, Paolo Bonzini wrote:
> On 08/01/20 11:58, Thomas Huth wrote:
> >> "-accel default" could be considered to have vibes of Do The Right
> >> Thing (tm) and could in time actually become so!
> >
> > "-accel default" sounds like the default behavior that you'd also get i=
f
> > you don't use this option at all ... what about "-accel auto" to say
> > that QEMU should pick an accelerator automatically?
>=20
> Questions to answer before thinking about the name: how would it
> co-operate with other "-accel" options?  how would you pass sub-options
> to the accelerators?

If people don't have a preference for a specific accelerator, just need
"a working accelerator", then I think it is reasonable to assume they
won't want/need to pass options to the accelerators either.

"-accel default" is targetting the simple "do the right thing" use
case, so IMHO doesn't need to support per-accelerator options.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


