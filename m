Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8AEC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4712077B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJCEqegG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4712077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if1fM-0001dy-U1
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1if1d2-0007D8-GA
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1if1cy-0005a5-Vw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:02:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58839
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1if1cy-0005Yx-SE
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576069324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=evDjmeB2b7ecqtE6V9yHP0f4z+5bHE6QzpjDDaG6RYE=;
 b=ZJCEqegGjGVuNa2BC++TEDf89/x3Vz+Y6rwMzFRF+Rfby7+tsby5PfttCSjNcuiKxWCUrQ
 08yBnDcCqBcZ+g6Dc4TlrbvmBW8g8mSp4MR2Hk1arco6cUvVorVgsesRlJpN5eb+rcn0d7
 q+8BtzM9ebVNwxTkwqvvCUFPKl/TYC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-rEBksM78MFSUgVGdFm2UoQ-1; Wed, 11 Dec 2019 07:55:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F052764A91;
 Wed, 11 Dec 2019 12:55:52 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B8344100EBA4;
 Wed, 11 Dec 2019 12:55:51 +0000 (UTC)
Date: Wed, 11 Dec 2019 13:55:48 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: Insufficiently documented deprecated command arguments
Message-ID: <20191211125548.GE2441258@angien.pipo.sk>
References: <87tv67wa9y.fsf@dusky.pond.sub.org>
 <20191211093317.GB2441258@angien.pipo.sk>
 <20191211101439.GA6505@linux.fritz.box>
 <20191211105147.GC2441258@angien.pipo.sk>
 <20191211122417.GB6505@linux.fritz.box>
 <20191211123210.GH955178@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211123210.GH955178@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: rEBksM78MFSUgVGdFm2UoQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 12:32:10 +0000, Daniel Berrange wrote:
> On Wed, Dec 11, 2019 at 01:24:17PM +0100, Kevin Wolf wrote:
> > Am 11.12.2019 um 11:51 hat Peter Krempa geschrieben:
> > > On Wed, Dec 11, 2019 at 11:14:39 +0100, Kevin Wolf wrote:

[...]

> > > Well, in some specific cases we could detect the node names
> > > auto-assigned by qemu and use them instead of paths, but in my opinio=
n
> > > it's not worth the effort and extra code.
> >=20
> > Well, the question is what to do on the QEMU side then. Deprecation
> > should mean that we have a plan for removing the feature. If we're
> > planning to keep the feature indefinitely because libvirt needs it, we
> > might want to consider removing the deprecation notice.
>=20
> Ideally libvirt would stop using -drive entirely, as I hate the idea of
> having to keep this around indefinitely in libvirt too. This needs QEMU
> to close the last gaps wrt SD cards

Yes and also give us guidance how to convert it. Looking at the code
didn't help. There's a plethora of controllers and options to configure
without clear indication what is default behaviour expected.

Trying to convert it blindly would end up worse than just ditching
support for sdcards altogehter.


