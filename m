Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D385C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD8420709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwR7tJZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD8420709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3kd-0008Jc-D8
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iv3jP-0007eO-HT
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iv3jK-00037R-9T
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:30:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iv3jK-00037D-5z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579890653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rcJ3DbQBJGMw4UZcKcJ+5n45fU6MLMU7AEJU6aslpnA=;
 b=bwR7tJZjw6ZzmdaIkWYL7CyptIpW+O9Xm9qAF86Q2HjUx3zV89jqOLlEgU1SBsa99+hxD0
 dY/iWMtoQiIWkwstZb9ql+XRuyrm6+UlKSIfuPPJb1NLkJtVr+hwOGAnpnEzQ2aNMr/ovV
 bIsi0SK1SJ+OUZriYQBDwxqISQ6byNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-B5mw9_xVPMW-Kpb2vaPctQ-1; Fri, 24 Jan 2020 13:30:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 517C58010C9;
 Fri, 24 Jan 2020 18:30:50 +0000 (UTC)
Received: from work-vm (ovpn-117-253.ams2.redhat.com [10.36.117.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99E1786802;
 Fri, 24 Jan 2020 18:30:38 +0000 (UTC)
Date: Fri, 24 Jan 2020 18:30:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200124183036.GD2969@work-vm>
References: <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <c89f4417-ca4e-d365-e795-4570200e9dae@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c89f4417-ca4e-d365-e795-4570200e9dae@redhat.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: B5mw9_xVPMW-Kpb2vaPctQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <cleber@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* John Snow (jsnow@redhat.com) wrote:
>=20
>=20
> On 1/24/20 9:38 AM, Kevin Wolf wrote:
> > Hi! :-)
> >=20
> > Well, not fighting for it to the death and I'm certainly not married to
> > its exact syntax, but I use HMP all the time because it's convenient to
> > use manually and QMP isn't.
> >=20
> > If you want to remove HMP, get us a decent QMP shell first. And ideally
> > a way how to use it without manually configuring a QMP socket and
> > starting up and connecting the shell to it with ten kilometers of
> > command line options on both sides first. HMP is available by default,
> > and so should its replacement be.
>=20
> This is partly why I am asking about what a "qmp-shell" should look like
> to be usable, so we can sunset HMP once and for all.
>=20
> One idea for a qmp-shell is to implement some of the convenience syntax
> in qmp-shell directly to give us some of the same shorthands, and that
> logic lives in the shell now.

I wonder about generating a set of python bindings for the qmp commands,
and generating wrappers for those, and having the qmp-shell be a python
interpreter with all that loaded.
That way it would be very easy to add extra sugar.

However, I caution that too many people think that QMP has all the type
of diagnostic stuff people want - it's just way too hard and beuracratic
to add a simple diagnostic command to QMP, when you just want to add
something to print some diagnostics out for your corner of qemu.

Dave

> --js
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


