Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0A0C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C1C20719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezWbrztF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C1C20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLjvd-0007Hn-0M
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 04:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jLjty-0006Y0-Sf
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jLjtw-0003lT-Hj
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:48:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34377
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jLjtw-0003l3-E6
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586249287;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NEeCmpFWZON6zqcoO/MDThiNTP5iA2JeJ9SJRXI7jnY=;
 b=ezWbrztFfplSW8BRznkAvV3A2hHCwagEmMMbVoNZyzqsdwNNP8eoREoZ1GLYn7rSBZlF1J
 2dgQEk81aBBPv1J1m3ru/eWhFpTUNNValfiKkd1Fwau/qE3RTBEDWAd5nBCCxKzFbQnPxS
 nZ7kdjvb+r1fC3dN2lQT5QxDX0/hVLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-eI_S0gbZNFa-YyPW95bJ3A-1; Tue, 07 Apr 2020 04:47:58 -0400
X-MC-Unique: eI_S0gbZNFa-YyPW95bJ3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA32B1400
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 08:47:57 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C870DB19C8;
 Tue,  7 Apr 2020 08:47:56 +0000 (UTC)
Date: Tue, 7 Apr 2020 09:47:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: FYI GitHub pull request / issue tracker lockdown bot
Message-ID: <20200407084753.GA843246@redhat.com>
References: <20200403142213.GO559148@redhat.com>
 <b321b36e-d18f-623b-f8a1-93bd4b3fb779@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b321b36e-d18f-623b-f8a1-93bd4b3fb779@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 06, 2020 at 03:51:52PM -0400, John Snow wrote:
>=20
>=20
> On 4/3/20 10:22 AM, Daniel P. Berrang=C3=A9 wrote:
> > QEMU, like libvirt, has a github.com project which contains automated
> > read-only mirrors of QEMU repositories.
> >=20
> >   https://github.com/qemu/
> >=20
> > An unfortunate side effect of this is that some users will try to open
> > pull requests against these mirrors. These get ignored until eventually
> > someone notices and closes the request. QEMU has had about 90 prs opene=
d
> > over the years.
> >=20
> >   https://github.com/qemu/qemu/pulls
> >=20
> > The same applies to the issue tracker, but fortunately github lets
> > projects disable this feature, which QEMU has done.
> >=20
> > I have recently discovered that there is a nice 3rd party bot for githu=
b
> > which can autorespond to pull requests with a friendly comment, close t=
he
> > request, and then lock it to prevent further comments.
> >=20
> >   https://github.com/apps/repo-lockdown
> >=20
> > I'm setting this up for libvirt and it was suggested QEMU can probably
> > benefit from it too as an example see:
> >=20
> >   https://github.com/libvirt/test/issues/2
> >   https://github.com/libvirt/test/pull/3
> >=20
> >=20
> > Configuration just requires creation of a ".github/lockdown.yml" file
> > which provides the friendly message to add to the merge requests. This
> > can be either done per-repository, or a special repo can be created
> > called ".github" and this will apply to all repos within the project.
> >=20
> > Ideally each repo would have a CONTRIBUTING.md file created too, since
> > both GitHub and GitLab will direct users to this file for guidelines
> > on how to contribute.
> >=20
> > I don't have time right now to do this for QEMU, so consider this email
> > a friendly suggestion for some other interested person to do for QEMU..=
.
> >=20
> > Regards,
> > Daniel
> >=20
>=20
> This looks cool. Who has access to our github to request it start
> scanning our repo to look for said .github/lockdown.yml file?

https://wiki.qemu.org/AdminContacts

Says afaerber, aliguori, paolo, stsquad - that probably needs updating
since two of those people aren't usually involved in QEMU anymore.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


