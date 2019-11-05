Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE8C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2566B21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjnZ1Cmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2566B21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS4gL-0003Rh-Dz
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 14:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iS4ex-0002jc-2Z
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iS4ev-0005vp-FE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:38:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iS4ev-0005rc-BL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572982712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzO4j/XzwyMd3UN+v1A0F8Xm1dlMok+K8uZAWMs2K9Q=;
 b=EjnZ1CmjmIwD+h/ryWd2ynmmBwbBNcJMZEFoMdWZMEv4HvlIVEF7P6zJLGaFdvXzeArgoP
 r1BASQkODJo7XXUKAlTrmYByT0yKHPGwUTVSV1rAtIAmChVSv5+RLDoWbYf1buHHkxOW0d
 eo1h96MwMV+CO9VCHRLe/vbhWNAWBjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-WyH_U4cjPECfB2MQOpiNLQ-1; Tue, 05 Nov 2019 14:38:29 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69998477;
 Tue,  5 Nov 2019 19:38:28 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3335F1001B11;
 Tue,  5 Nov 2019 19:38:22 +0000 (UTC)
Date: Tue, 5 Nov 2019 16:38:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: git-publish, --pull-request and --signoff (was: Re: [PULL 0/9]
 Ide patches)
Message-ID: <20191105193820.GF3812@habkost.net>
References: <20191031105904.12194-1-jsnow@redhat.com>
 <CAFEAcA964ibGcb02kTC_bTcX5xLu5r-=NJMz5Kykct0t7CVwnw@mail.gmail.com>
 <13430122-c3b2-b68e-8cc8-59e2cb864add@redhat.com>
MIME-Version: 1.0
In-Reply-To: <13430122-c3b2-b68e-8cc8-59e2cb864add@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: WyH_U4cjPECfB2MQOpiNLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 31, 2019 at 11:54:42AM -0400, John Snow wrote:
> On 10/31/19 11:02 AM, Peter Maydell wrote:
> > On Thu, 31 Oct 2019 at 10:59, John Snow <jsnow@redhat.com> wrote:
> >>
> >> The following changes since commit 68d8ef4ec540682c3538d4963e836e43a21=
1dd17:
> >>
> >>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-tcg-plugins-=
281019-4' into staging (2019-10-30 14:10:32 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
> >>
> >> for you to fetch changes up to c35564caf20e8d3431786dddf0fa513daa7d7f3=
c:
> >>
> >>   hd-geo-test: Add tests for lchs override (2019-10-31 06:11:34 -0400)
> >>
> >> ----------------------------------------------------------------
> >> Pull request
> >>
> >=20
> > Hi -- this passed the merge tests but it looks like you forgot
> > to add your signed-off by line as the submaintainer to Sam's
> > patches. Could you fix that up and resend, please?
> >=20
> > thanks
> > -- PMM
> >=20
>=20
> I bit myself twice with this now: adding --signoff to a pull request
> signs the messages that get sent to list, but not the ones that get stage=
d.
>=20
> Could always be a bug in my local copy, but I'm documenting it on the
> list, in case I don't get time to look at this in the next 24h.

Reported on GitHub, so we don't forget to look at it:
https://github.com/stefanha/git-publish/issues/76

--=20
Eduardo


