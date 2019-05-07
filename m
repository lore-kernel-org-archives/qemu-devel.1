Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3A1C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:14:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F380205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F380205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46656 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNzvi-0000Um-Jv
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 09:14:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNzuy-0000AH-FS
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:14:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hNzuw-0000cX-E2
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:14:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hNzuw-0000cI-8y
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:13:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 772F6821C3;
	Tue,  7 May 2019 13:13:57 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D549460C4D;
	Tue,  7 May 2019 13:13:55 +0000 (UTC)
Date: Tue, 7 May 2019 14:13:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190507131352.GR27205@redhat.com>
References: <cover.1557093245.git.qemu_oss@crudebyte.com>
	<5b5c005fbf4e31c07273468cb022d25a8907bc87.1557093245.git.qemu_oss@crudebyte.com>
	<20190507124247.GN27205@redhat.com> <3809087.3a1rNnKprp@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3809087.3a1rNnKprp@silver>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 07 May 2019 13:13:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/5] 9p: mitigates most QID path
 collisions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>,
	Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 03:11:26PM +0200, Christian Schoenebeck wrote:
> On Dienstag, 7. Mai 2019 13:42:47 CEST Daniel P. Berrang=C3=A9 wrote:
> > > This first patch here is an updated version of Antonios Motakis'
> > > original 4-patch set (using fixed length 16 bit prefixes), merged t=
o one
> > > patch:
> > >=20
> > > https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02283.html
> > >=20
> > > * Updated to latest git master, specifically to new qht interface.
> > >=20
> > > * Merged the original 4 patches to this single patch.
> >=20
> > Why did you merge them all into one ?  The split patches were "best
> > practice" IMHO. The original patch authorship & S-o-B lines could
> > be preserved if you kept them split as before too.
>=20
> Seems I misinterpreted an old comment of Greg that he would like to see=
 them=20
> to be merged into less patches. I think it was this one:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02590.html
>=20
> No problem, I will restore Antonios' original individual 4 patches=20
> appropriately. What about SOB then? Should I just place Antonio's SOB o=
n those=20
> 4 patches or does it need his and mine SOB lines? (I mean I need to reb=
ase=20
> those 4 patches and address the old issues on them)

If the patch is unchanged from Antonio's original then it only needs to
have Antonio's SOB. If you have modified the patch yourself, then you
would add your own SOB, in addition to Antonio's original SOB.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

