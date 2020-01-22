Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985E1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BCDB2467A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSZ2w7ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BCDB2467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuF8l-0003lU-Ny
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 07:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iuF7i-0002tw-11
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iuF7f-0002BO-5D
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:28:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iuF7e-0002AL-Cq
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579696117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjr/a0mqh3PhBsgxSSarDNAknOqLFru8NAL2OdBSh8w=;
 b=YSZ2w7ldnd9/O+OQNuUvOU1/8D+cxEtfqAIzA+9CgKy5gvxUmsjfAOa57kCoi3CidDeTc8
 nOUWRnOe6scsbrLB0gmWZyXuf31PT8AGw2joUEjjBV2PZ2Zu3LXOiSm96fpOge1ssEufC4
 1tfPhxz9Rf0zmGIDTfJTkrLTi8g4Gvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-wii4i717PYGgbftiwEPhvw-1; Wed, 22 Jan 2020 07:28:34 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C5B6835BE9;
 Wed, 22 Jan 2020 12:28:33 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-57.ams2.redhat.com [10.36.117.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1CDF5C28C;
 Wed, 22 Jan 2020 12:28:32 +0000 (UTC)
Date: Wed, 22 Jan 2020 13:28:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Maintainers, please add Message-Id: when merging patches
Message-ID: <20200122122831.GB13482@linux.fritz.box>
References: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: wii4i717PYGgbftiwEPhvw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.01.2020 um 13:02 hat Stefan Hajnoczi geschrieben:
> Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag.  H=
ooray!
>=20
> Message-Id: references the patch email that a commit was merged from.
> This information is helpful to anyone wishing to refer back to email
> discussions and patch series.
>=20
> Please use git-am(1) -m/--message-id or set am.messageid in your git-conf=
ig(1).

I've had -m in my scripts for a while (last time someone asked me to
make the change, I guess), but it wasn't effective, because my .muttrc
has 'set pipe_decode' enabled, which doesn't only decode the output, but
also throws away most headers.

I seem to remember that this was necessary at some point because
otherwise some mails just wouldn't apply. Maybe 'git am' works better
these days and can actually parse the mails that used to give me
problems. I'll give it a try and disable pipe_decode.

Kevin


