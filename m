Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4812C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA5120872
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 07:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX+xNiuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA5120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXKnX-0005y8-RR
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 02:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iXKm4-0004vh-7t
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iXKm0-00079D-S6
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:51:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iXKm0-00074n-HL
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 02:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574236295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKZIPCQxEffavc5IoVRA3jGFJAjYQlARPvfC7E20Vo4=;
 b=WX+xNiuNzxC8BjrNmBzvtQtv9XsPJkmNgHh2fdKCi1Swp7jUD+9xn37J7u0Qs+jvIjhylv
 6oDtCi1SGy/SU1Zfkmaxd6BjXXXA2JAJrD0oox35Hck1KbSFE/EcgubbpcIkwPg7QVHQ3t
 K8O/3/neyEi0QlAfmq7jwp9vH2wx0fU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-umds_Om6PdWLEfi1fzN3cw-1; Wed, 20 Nov 2019 02:51:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6D37107AD48;
 Wed, 20 Nov 2019 07:51:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72C7D60FC4;
 Wed, 20 Nov 2019 07:51:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 90D3E16E05; Wed, 20 Nov 2019 08:51:29 +0100 (CET)
Date: Wed, 20 Nov 2019 08:51:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Kevin O'Connor <kevin@koconnor.net>
Subject: Re: [SeaBIOS] Re: 1.13 release?
Message-ID: <20191120075129.h6khddpakvnomz4b@sirius.home.kraxel.org>
References: <20191016104412.ut3jxjwjf64qsjbk@sirius.home.kraxel.org>
 <20191106111255.aladyvsumr2kw47b@sirius.home.kraxel.org>
 <20191106162918.GC19095@morn.lan> <20191118180839.GA17869@morn.lan>
MIME-Version: 1.0
In-Reply-To: <20191118180839.GA17869@morn.lan>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: umds_Om6PdWLEfi1fzN3cw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: seabios@seabios.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 18, 2019 at 01:08:39PM -0500, Kevin O'Connor wrote:
> On Wed, Nov 06, 2019 at 11:29:18AM -0500, Kevin O'Connor wrote:
> > On Wed, Nov 06, 2019 at 12:12:55PM +0100, Gerd Hoffmann wrote:
> > > On Wed, Oct 16, 2019 at 12:44:12PM +0200, Gerd Hoffmann wrote:
> > > >   Hi,
> > > >=20
> > > > Almost a year since 1.12.0 was tagged (Nov 17th to be exact),
> > > > time to plan the 1.13 release I think ...
> > > >=20
> > > > How about freeze in a week or two, release by mid-november?
> > > >=20
> > > > Pending stuff I'm aware of is the disk geometry patch series.
> > > > The corresponding qemu series is still waiting to be merged.
> > >=20
> > > It's finally merged in qemu now.  Going to push the seabios
> > > series and prepare a seabios update for qemu, so upcoming
> > > seabios release gets some more test coverage.
> >=20
> > Okay, thanks.
> >=20
> > If we're going to update that in SeaBIOS, then we may wish to push
> > back the SeaBIOS release by a few weeks.
>=20
> At this point, I'm targeting early December for the release.  Let me
> know if there are any concerns with that.

Hmm, that is a bit late for the final qemu 4.2 release (see
https://wiki.qemu.org/Planning/4.2).  But seabios 1.13 in qemu hasn't
seen any real testing so far: the update landed in -rc2 (tagged
yesterday) not -rc0 due to the lchs patch series issues (late merge of
the qemu patches and ahci test failure).  So having a tested 1.13-final
in -rc3 is pretty much impossible, even -rc4 is ambitious and requires
tagging the seabios release on Dec 1st or 2nd (less than two weeks from
now).  Which would be nice from qemu point of view, but if this doesn't
work out sky isn't falling either.  We can also release qemu 4.2 with
the snapshot and update to 1.13-final in 4.2.1 ...

cheers,
  Gerd


