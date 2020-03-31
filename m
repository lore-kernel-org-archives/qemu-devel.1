Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06631C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C515D20714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Im8OBFhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C515D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFp0-0002Q7-Ur
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJFnd-0000fL-WC
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJFnc-0004qR-OH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:15:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39255
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJFnc-0004q1-KN
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585656920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uy5+UlzuL4o4hq6Hdifmq5GfP6QnsvMSV+EWFw8ZuIs=;
 b=Im8OBFhnKJ5XUpPJ1/p/H9kT6O8MUhk/usKJlESRMso6dUgu2Ic5MMbxemb3KHaLFBQfjd
 kmpginNCh8p8BZygYOF0tRSXW93zgYyXX7NOTgo2e78MarQBbdi2sA1Ym/+Sek6Th1H3jQ
 Bp1xGDoVy6hg6LpozjSZhCK04PI7hIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-29LPcGf3NAGHTcqI71-LHw-1; Tue, 31 Mar 2020 08:15:16 -0400
X-MC-Unique: 29LPcGf3NAGHTcqI71-LHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91993DBA6;
 Tue, 31 Mar 2020 12:15:15 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA4435D9CA;
 Tue, 31 Mar 2020 12:15:13 +0000 (UTC)
Date: Tue, 31 Mar 2020 14:15:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v9 00/14] iotests: use python logging
Message-ID: <20200331121512.GC7030@linux.fritz.box>
References: <20200324232103.4195-1-jsnow@redhat.com>
 <9e1cf69f-5aa1-eee2-d550-85dd85b7049f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9e1cf69f-5aa1-eee2-d550-85dd85b7049f@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 philmd@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.03.2020 um 21:03 hat John Snow geschrieben:
>=20
>=20
> On 3/24/20 7:20 PM, John Snow wrote:
> > This series uses python logging to enable output conditionally on
> > iotests.log(). We unify an initialization call (which also enables
> > debugging output for those tests with -d) and then make the switch
> > inside of iotests.
> >=20
> > It will help alleviate the need to create logged/unlogged versions
> > of all the various helpers we have made.
> >=20
> > Also, I got lost and accidentally delinted iotests while I was here.
> > Sorry about that. By version 9, it's now the overwhelming focus of
> > this series. No good deed, etc.
>=20
>=20
> Version requirements, as discovered by Kevin's Python Museum:
>=20
> mypy >=3D 0.620
> pylint >=3D 2.2.0
> astroid =3D=3D 2.1.0 (or >=3D 2.2.0 if using pylint >=3D 2.3.0)
>=20
>=20
> Hm, though ... pylint does not like 'Collection' very much:
>=20
> iotests.py:1139:41: E1136: Value 'Collection' is unsubscriptable
> (unsubscriptable-object)
>=20
> It works OK for the same pylint versions under 3.7, but it's busted a
> bit under 3.6. See https://github.com/PyCQA/pylint/issues/2377
>=20
> Well. Collection is indeed the actual type we want (we need Iterable and
> Container properties; i.e. supports 'for' and 'in'). There's no reason
> to require a Sequence (adds Reversible and some notion of a fixed
> ordering) -- but it will fix the typing problems in 3.6, so I'm going to
> do that.

I wouldn't actually worry about Python museums much as far as pylint and
mypy are concerned. 3.6 compatibility is important for actually running
the code, but if older mypy/pylint versions get false positives, I would
consider that acceptable.

Kevin


