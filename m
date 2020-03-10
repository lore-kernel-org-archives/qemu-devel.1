Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1FFC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A22E32467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddL23onR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22E32467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdmG-0007YL-Ux
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBdlJ-0006lF-GV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBdlH-0002Tn-Op
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:13:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34695
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBdlH-0002Qs-JZ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583842407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5e4dm9JGEb1gLn58jo0w8NAGmGhiBxtT0bFdbomXmtg=;
 b=ddL23onRy+DrbMcvGONUqWNwJyIOsllrb7QnLP9+iBerasbf0lRA4Xcpsc25PXztTKJ9qB
 O4qpbqrcPqONT2rYv9O2lrEhq3VeykqbOv3sMRHectzGGITnpzQhL4ZCgJvOpnBWKoBu9S
 xGgakpxcbkFmZT1PxPdoxK37OQ1tbx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-88uzqd-0PRiOlb_KsMq-jQ-1; Tue, 10 Mar 2020 08:13:23 -0400
X-MC-Unique: 88uzqd-0PRiOlb_KsMq-jQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86C901B18BEC;
 Tue, 10 Mar 2020 12:13:20 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F2639296E;
 Tue, 10 Mar 2020 12:13:02 +0000 (UTC)
Date: Tue, 10 Mar 2020 13:13:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL 00/33] Trivial branch patches
Message-ID: <20200310121300.GD6926@linux.fritz.box>
References: <20200309150837.3193387-1-laurent@vivier.eu>
 <20200309151621-mutt-send-email-mst@kernel.org>
 <8db36062-b45d-6c2e-c7d8-98dd2b9db06f@redhat.com>
 <0bb2eac1-74ab-bee8-e8d0-bac542562cdd@vivier.eu>
 <20200310114548.GA6926@linux.fritz.box>
 <ced636a7-dbda-9247-5dd7-37e8c2ccabce@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ced636a7-dbda-9247-5dd7-37e8c2ccabce@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.03.2020 um 13:00 hat Philippe Mathieu-Daud=E9 geschrieben:
> On 3/10/20 12:45 PM, Kevin Wolf wrote:
> > Am 10.03.2020 um 09:02 hat Laurent Vivier geschrieben:
> > > Le 09/03/2020 =E0 20:30, Philippe Mathieu-Daud=E9 a =E9crit=A0:
> > > > On 3/9/20 8:17 PM, Michael S. Tsirkin wrote:
> > > > > On Mon, Mar 09, 2020 at 04:08:04PM +0100, Laurent Vivier wrote:
> > > > > > The following changes since commit
> > > > > > 7a5853cec479a448edae0fb2aaf4e2f78c9c774d:
> > > > > >=20
> > > > > >  =A0=A0 Merge remote-tracking branch 'remotes/mst/tags/for_upst=
ream' into
> > > > > > staging (2020-03-09 10:32:53 +0000)
> > > > > >=20
> > > > > > are available in the Git repository at:
> > > > > >=20
> > > > > >  =A0=A0 git://github.com/vivier/qemu.git tags/trivial-branch-pu=
ll-request
> > > > > >=20
> > > > > > for you to fetch changes up to 916c92503bd5348a33e561db600d8894=
bde636bb:
> > > > > >=20
> > > > > >  =A0=A0 monitor/hmp-cmds: Remove redundant statement in
> > > > > > hmp_rocker_of_dpa_groups() (2020-03-09 15:59:31 +0100)
> > > > >=20
> > > > >=20
> > > > > Could you avoid CC everyone involved on the whole PULL req?
> > > > > I was involved in a patch or two and don't really need to see
> > > > > the whole series. Just the cover and the relevant patches
> > > > > would be enough - if I do want it there's always lore.
> > > >=20
> > > > I suppose Laurent used git-publish, which has this limitation.
> > > >=20
> > >=20
> > > Yes, I use git publish and CC are automatically added.
> > >=20
> > > Philippe, you told me some time ago you have a patch to fix this
> > > behaviour and only CC people on a patch base. Is it available?
>=20
> I guess you mean https://github.com/philmd/git-publish/commit/5bab6e2cc77=
, I
> haven't improved it but plan to spend time on it during my next holidays.
>=20
> > Actually, I don't think it's even necessary to CC anyone at all (except
> > the relevant lists) for pull requests. These patches were already
> > reviewed.
>=20
> Well as a contributor I find useful to get notified when patches are merg=
ed.

Hm, I guess a matter of different preferences then.

> I guess remember some time ago patchew (or another bot?) was sending a
> notification on pull request merged, this was even more useful than Cc'in=
g
> ppl on pull-req. It is also helpful when you track someone else patch on =
the
> list.
> Since most of the maintainers now include the patch RFC822 Message-Id, it=
 is
> now easy for a bot to reply to patch taken from the last.

I don't remember anything like this, but having an automatic reply to
the email thread of each merged patch series might be a good idea.

Kevin


