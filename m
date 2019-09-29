Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47EEC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 18:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4272086A
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 18:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4272086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEe13-00027U-MQ
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 14:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEdzn-0001Ps-DV
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 14:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEdzm-0002es-DE
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 14:32:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEdzi-0002dj-5S; Sun, 29 Sep 2019 14:32:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A62F36955;
 Sun, 29 Sep 2019 18:32:28 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8844600F8;
 Sun, 29 Sep 2019 18:32:26 +0000 (UTC)
Message-ID: <b80eaa54fba414c26f329b1021aae1b231ba77a6.camel@redhat.com>
Subject: Re: [PATCH] tests: fix I/O test for hosts defaulting to LUKSv2
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Eric
 Blake <eblake@redhat.com>
Date: Sun, 29 Sep 2019 21:32:25 +0300
In-Reply-To: <20190927165153.GO20911@redhat.com>
References: <20190927101155.25896-1-berrange@redhat.com>
 <666c1338-e5c4-3cba-cb89-651755baa065@redhat.com>
 <20190927165153.GO20911@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Sun, 29 Sep 2019 18:32:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-27 at 17:51 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Sep 27, 2019 at 10:26:27AM -0500, Eric Blake wrote:
> > On 9/27/19 5:11 AM, Daniel P. Berrang=C3=A9 wrote:
> > > Some distros are now defaulting to LUKS version 2 which QEMU cannot
> > > process. For our I/O test that validates interoperability between t=
he
> > > kernel/cryptsetup and QEMU, we need to explicitly ask for version 1
> > > of the LUKS format.
> > >=20
> >=20
> > Ultimately, it would be nice to get LUKS 2 support in qemu too, but t=
hat's a
> > much bigger job.  This is fine for now.
If there is need, I volunteer to research the area and if this is feasibl=
e,
add support for LUKSv2.
I haven't yet had looked at the spec.

Best regards,
	Maxim Levitsky


