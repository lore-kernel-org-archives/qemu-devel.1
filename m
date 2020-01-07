Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A2C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF6E208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1LPNRgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF6E208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqP2-00056U-Ve
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ioppo-00074X-FA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ioppn-0005mG-5l
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:27:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58089
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ioppm-0005lk-UC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578407270;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ky0xuTdKS0oC7J5xeh4jTsKqem76ETVJ2E83Coo4SEU=;
 b=P1LPNRgZr2xJa/ajtgZZ6+emN4mkT/HBL2YvPSutmshpX3GeSzUIudH89T5RuKQgcCKyhK
 FZx4668wbN+0EwPmgOGIyQmClMnLvQLO/zF5zszqkvdU6fq0aqZjrGIRYHm9uuiljDOkfO
 98EUr6pptJQiJ71HzSdNO0KgAMPHu0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-lUKR1D-cPQCy_VEHW0UhBg-1; Tue, 07 Jan 2020 09:27:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FC7F477;
 Tue,  7 Jan 2020 14:27:46 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 676F1858B0;
 Tue,  7 Jan 2020 14:27:38 +0000 (UTC)
Date: Tue, 7 Jan 2020 14:27:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: Priority of -accel
Message-ID: <20200107142735.GC3368802@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com>
 <2ae2dee3-cd16-a247-971b-4b3482e596a5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2ae2dee3-cd16-a247-971b-4b3482e596a5@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: lUKR1D-cPQCy_VEHW0UhBg-1
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 07, 2020 at 03:20:40PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 1/7/20 3:14 PM, Thomas Huth wrote:
> > On 07/01/2020 13.54, Daniel P. Berrang=C3=A9 wrote:
> > > On Tue, Jan 07, 2020 at 01:23:18PM +0100, Paolo Bonzini wrote:
> > > > On 07/01/20 13:18, Thomas Huth wrote:
> > > > > I don't think we need a separate priority parameter here. But IMH=
O it's
> > > > >   really rather common practice to prioritize the last option. So=
 while
> > > > > it might be more "self-explanatory" to a CLI newbie if the first
> > > > > occurrence got the highest priority, it might be rather confusing
> > > > > instead for a CLI veteran...?
> > > >=20
> > > > Prioritising the last certainly makes sense for a choose-one-only
> > > > option, but I'm not sure it's the same for a choose-best option.  A=
fter
> > > > all it was -machine accel=3Dkvm:tcg, not -machine accel=3Dtcg:kvm..=
.
> > >=20
> > > IIUC, the main use case for specifying multiple accelerators is
> > > so that lazy invokations can ask for a hardware virt, but then get
> > > fallback to TCG if not available. For things that should be platform
> > > portabile, there's more than just kvm to consider though, as we have
> > > many accelerators.  Listing all possible accelerators is kind of
> > > crazy though no matter what the syntax is.
> > >=20
> > > How about taking a completely different approach, inspired by the
> > > -cpu arg and implement:
> > >=20
> > >      -machine accel=3Dbest
> >=20
> > Something like that sounds like the best solution to me, but I'd maybe
> > rather not call it "best", since the definition of "best" might depend
> > on your use-case (e.g. do you want to use a CPU close to the host or
> > something different which might be better emulated by TCG?).
> >=20
> > What about "-accel any" or "-accel fastest" or something similar?
>=20
> 'any' is a russian roulette, you don't want it to return 'qtest' ;)

We could make it return "qtest" only on April 1st ;-P

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


