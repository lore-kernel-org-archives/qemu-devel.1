Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557ABC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C5020722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+0P7sGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C5020722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKEA-0001VW-8s
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jGKCi-0000Es-8r
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jGKCg-00014p-Gr
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:21:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58846)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jGKCg-00014Q-D1
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584958865;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jorhJce+FiP825LwjjIBGiw6rtHsJKo2KXPdYeeX2Y=;
 b=Q+0P7sGkZJkrlSuDCc6zIZmHmgyfUJ63hfLPgWsn5BqbV12lzduhZrR+18Fr7dDMUnpIhR
 6Hnp42y/QtTXM3l0Uj/PVkkOOdFriEcXNM+kN9z8TDmlgS2vC8NE/xDTERYwfJmw0dfZKu
 E+DTYPhEUxJwrePtAlM7Rrbn7ZwZYAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-gn33v-YFNy6H-HzHz68wQA-1; Mon, 23 Mar 2020 06:20:57 -0400
X-MC-Unique: gn33v-YFNy6H-HzHz68wQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 005B0A1360;
 Mon, 23 Mar 2020 10:20:56 +0000 (UTC)
Received: from redhat.com (ovpn-112-208.ams2.redhat.com [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A41C5C1B5;
 Mon, 23 Mar 2020 10:20:54 +0000 (UTC)
Date: Mon, 23 Mar 2020 10:20:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200323102050.GC3379720@redhat.com>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <CAL1e-=gKB0qRxGntXrU0im2gjMh1tq_SLGTm+HsmgBRGXQ9+Bg@mail.gmail.com>
 <CAFEAcA-Yn_O=G-63O1Ug9=HYqN0_o_NH_nLpWmBv2bjk2Y_85A@mail.gmail.com>
 <CAHiYmc4Qv4yL8LMp_nFqx20bq-hRO-umh5R899H6hdSyKrpNBA@mail.gmail.com>
 <CAFEAcA_hfhusu8n8OXLg=vjiMSw09HVy2zhVr=R2hmGdEQJtew@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_hfhusu8n8OXLg=vjiMSw09HVy2zhVr=R2hmGdEQJtew@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 08:14:24PM +0000, Peter Maydell wrote:
> To be clear, I'm not saying we should pull the rug out
> from anybody. I'm saying:
>  * we should clearly say what our plans are, with a
>    long warning if we can reasonably give longer warning
>  * if there's anything that we would accidentally
>    be breaking with those plans, we should adjust the
>    plans so we don't break things we didn't mean to break
>=20
> This doesn't seem controversial to me...

IIUC, all of our CI platofrms are testing out of tree builds. This gives us
confidence that all the important aspects of QEMU build process are operati=
ng
as expected. It also means that anyone relying on in-tree builds is already
using a process that is a second-class citizen in terms of supportability.
We've already seen  bit-rot in in-tree builds due to this lack of formal
testing.

If there are things that we discover to be broken with out of tree builds,
this is highlighting gaps in our CI coverage we'll want to address. This
will bring said broken feature into a situation where we have confidence
in its usage going forward.

IOW, I see no downside to deprecating in-tree builds - it is just a
reflection of how we have already considered them to be untested and
undesirable to use.


We still have a few places in docs/  that are illustrating "./configure"
that we should fix too...

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


