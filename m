Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30922C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051572085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051572085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzfV2-0006Jf-4k
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 07:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1hzfUJ-0005fP-7H
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hzfUH-0006aM-QW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:06:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hzfUH-0006a3-LM
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:06:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B08F86FABA;
 Mon, 19 Aug 2019 11:06:08 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50D52100195C;
 Mon, 19 Aug 2019 11:06:07 +0000 (UTC)
Date: Mon, 19 Aug 2019 12:06:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190819110604.GH12960@redhat.com>
References: <20190814020218.1868-1-quintela@redhat.com>
 <20190814020218.1868-7-quintela@redhat.com>
 <20190819095228.GC12960@redhat.com> <87pnl1301v.fsf@trasno.org>
 <20190819104916.GG12960@redhat.com>
 <CAFEAcA-00fv0q7gg_j0ZZT5cp0sNJVf_yXk174E0svx1e5hdSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-00fv0q7gg_j0ZZT5cp0sNJVf_yXk174E0svx1e5hdSQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 19 Aug 2019 11:06:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/6] RFH: We lost "connect" events
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 12:00:15PM +0100, Peter Maydell wrote:
> On Mon, 19 Aug 2019 at 11:50, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > I don't think we want to expose this in the QAPI schema for the socke=
t
> > address, since the correct value is really something that QEMU should
> > figure out based on usage context.
> >
> > Thus, I think we'll have to make it an explicit parameter to the
> > qio_channel_socket_listen_{sync,async} APIs, and socket_listen()
> > and inet_listen_saddr(), etc. Then the migration code can pass in
> > a sensible value based on multifd usage.
>=20
> How bad would it be if we just passed SOMAXCONN for the backlog
> value always?

I'm not 100% clear to be honest, but my feeling is that this will waste
resources for much of QEMU usage where we only ever accept a single
client connection on an incoming socket.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

