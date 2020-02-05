Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB29C35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 06:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560F72082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 06:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYYESufT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560F72082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izEKv-0003Y0-Gv
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 01:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1izEKF-00036W-8U
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:38:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1izEKD-0004aF-NI
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:38:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29643
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1izEKD-0004R4-Ip
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580884692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCFdKfXbcgLJ5uDaR2+wNe5h4vwq355GPSjURHsMFW4=;
 b=OYYESufTdeRI53vnLmVsCr+0XU9EiM2Lan0xQfLpnFZnHJbmbSlaXtE4JATWnwumA0RT5l
 0EosZCTT0H/Ks+8ZTgg9siRQIfW9Fj2pxeGPDeqs7kJrSRqyVPO3eG3qzVnsw9l+GS9OSZ
 gWf1DQAq9m1a+SV9MWpnaMvYN4lGzes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-4WjWf7OtOISPyeRGsEAzKw-1; Wed, 05 Feb 2020 01:38:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ED191137842;
 Wed,  5 Feb 2020 06:38:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CB2485785;
 Wed,  5 Feb 2020 06:38:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03A0C11386A7; Wed,  5 Feb 2020 07:38:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Summary of Re: Making QEMU easier for management tools and
 applications
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <875zgm2vqv.fsf@dusky.pond.sub.org>
Date: Wed, 05 Feb 2020 07:38:00 +0100
In-Reply-To: <875zgm2vqv.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Tue, 04 Feb 2020 16:54:48 +0100")
Message-ID: <871rr91quv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4WjWf7OtOISPyeRGsEAzKw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

[...]
> =3D Ways to provide machine-friendly initial configuration =3D
>
> Two ways to provide machine-friendly initial configuration on par with
> QMP have been proposed:
>
> 1. Extend QMP
>
>    Machines use the CLI only to configure a QMP socket.  The remainder
>    of the CLI becomes human-only, with much relaxed compatibility rules.
>
> 2. QAPIfy the CLI
>
>    Provide a machine-friendly CLI based on QAPI and JSON.  The current
>    CLI becomes human-only, with much relaxed compatibility rules.
>
>    Aside: I looked into cleaning up the human-only CLI at the same time,
>    but the need to maintain compatibility until the transition to the
>    machine-friendly CLI is complete makes this hard.  It needs to be
>    cleaned up, though.  More on that below.

Forgot to write down: we're talking not just about qemu-system-FOO, but
any executable with a non-trivial command line for use by machines.
This includes qemu-img, future qemu-storage-daemon, possibly qemu-nbd
and more.  Of these, qemu-storage-daemon will have a QMP monitor.  The
others don't have one so far.

[...]


