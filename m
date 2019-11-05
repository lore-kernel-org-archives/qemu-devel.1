Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF84C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BABFB21929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmG+nICN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABFB21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS5MV-0001jf-Tw
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iS5Lu-0001Kp-7p
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iS5Lr-0004GS-Ga
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:22:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21845
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iS5Lr-0004GA-4K
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572985374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6W6Ts7WpqrGnJ+hYtsabZ6FXx3w02Wuv0mi/u88HkPk=;
 b=MmG+nICNOIvGwUKdKQ8R1lf/T5qgTlTFYjg4ZcbreUyd46aSZsnldneVAMaljsrD1FA8ZW
 o5uQrtDRbT/X5+jMXyrYcIk0pJymNWPPQVbrDGKGLJeglPkhs5MWW5V1TcKRlTBha++RWd
 2yd2K/dzhXsZlGu0ezM+R94JemC+1Jc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-HsQbshH-OnGQd5kkQIsXDA-1; Tue, 05 Nov 2019 15:22:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3B691005500;
 Tue,  5 Nov 2019 20:22:49 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6528360BF4;
 Tue,  5 Nov 2019 20:22:44 +0000 (UTC)
Date: Tue, 5 Nov 2019 17:22:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: git-publish, --pull-request and --signoff (was: Re: [PULL 0/9]
 Ide patches)
Message-ID: <20191105202242.GI3812@habkost.net>
References: <20191031105904.12194-1-jsnow@redhat.com>
 <CAFEAcA964ibGcb02kTC_bTcX5xLu5r-=NJMz5Kykct0t7CVwnw@mail.gmail.com>
 <13430122-c3b2-b68e-8cc8-59e2cb864add@redhat.com>
 <CAJSP0QVmL_JTZOo=opN6Z6kgpwJaY780YocSteC1z48kpCac5Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVmL_JTZOo=opN6Z6kgpwJaY780YocSteC1z48kpCac5Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: HsQbshH-OnGQd5kkQIsXDA-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 05, 2019 at 09:17:42PM +0100, Stefan Hajnoczi wrote:
> On Thu, Oct 31, 2019 at 5:07 PM John Snow <jsnow@redhat.com> wrote:
> > On 10/31/19 11:02 AM, Peter Maydell wrote:
> > > On Thu, 31 Oct 2019 at 10:59, John Snow <jsnow@redhat.com> wrote:
> > >>
> > >> The following changes since commit 68d8ef4ec540682c3538d4963e836e43a=
211dd17:
> > >>
> > >>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-tcg-plugin=
s-281019-4' into staging (2019-10-30 14:10:32 +0000)
> > >>
> > >> are available in the Git repository at:
> > >>
> > >>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
> > >>
> > >> for you to fetch changes up to c35564caf20e8d3431786dddf0fa513daa7d7=
f3c:
> > >>
> > >>   hd-geo-test: Add tests for lchs override (2019-10-31 06:11:34 -040=
0)
> > >>
> > >> ----------------------------------------------------------------
> > >> Pull request
> > >>
> > >
> > > Hi -- this passed the merge tests but it looks like you forgot
> > > to add your signed-off by line as the submaintainer to Sam's
> > > patches. Could you fix that up and resend, please?
> > >
> > > thanks
> > > -- PMM
> > >
> >
> > I bit myself twice with this now: adding --signoff to a pull request
> > signs the messages that get sent to list, but not the ones that get sta=
ged.
> >
> > Could always be a bug in my local copy, but I'm documenting it on the
> > list, in case I don't get time to look at this in the next 24h.
>=20
> Do you mean Signed-off-by is only added to emails that are sent and
> not to the actual commits in your repo?
>=20
> This is how git-format-patch(1) --signoff works.  git-publish does not
> modify local commits either.
>=20
> Some people would probably be surprised if git-publish modified their
> commit history.
>=20
> I'm not sure what the best solution here is, aside from introducing a
> separate signoff option called --apply-signoff or similar so there is
> no confusion.

I would make git-publish error out if --signoff and
--pull-request are used simultaneously.  I can't think of a
justification for having the email contents not match the git tag
contents in a pull request.

--=20
Eduardo


