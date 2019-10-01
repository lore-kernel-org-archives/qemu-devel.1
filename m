Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEE9ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB2E21906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB2E21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIze-0001YV-Dt
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iFIyY-00017H-Aa
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:18:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iFIyX-0002CD-9Y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:18:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iFIyX-0002Ar-3h
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:18:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5700910C0944;
 Tue,  1 Oct 2019 14:18:00 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CC3C5D9CC;
 Tue,  1 Oct 2019 14:17:59 +0000 (UTC)
Date: Tue, 1 Oct 2019 16:17:56 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/2] qapi: Add feature flags to commands in qapi
 introspection
Message-ID: <20191001141756.GA6129@angien.pipo.sk>
References: <cover.1568989362.git.pkrempa@redhat.com>
 <96cc954e1cba111a4565123badb42c36e534a5d3.1568989362.git.pkrempa@redhat.com>
 <87r23x55pm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87r23x55pm.fsf@dusky.pond.sub.org>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 01 Oct 2019 14:18:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 08:40:21 +0200, Markus Armbruster wrote:
> Peter Krempa <pkrempa@redhat.com> writes:
>=20
> > Similarly to features for struct types introduce the feature flags also
> > for commands. This will allow notifying management layers of fixes and
> > compatible changes in the behaviour of a command which may not be
> > detectable any other way.
> >
> > The changes were heavily inspired by commit 6a8c0b51025.
> >
> > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
>=20
> +1 on adding features to commands.
>=20
> Patch conflicts with the technical debt payback work I posted before and
> after this series, although not nearly as badly as I expected.  It'll
> conflict some more with the parts I haven't flushed.  The funny bit: I
> went on that rampage in preparation of QAPI language extensions
> including "features everywhere, not just structs".
>=20
> I'll look into how to best fit your work into mine.

Thanks. I have patches ready which depend on this to enable blockdev so
please let me know if the design changes somehow.

