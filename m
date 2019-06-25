Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F4EC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322352080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322352080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34486 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfpww-0001Yt-CL
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 14:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47068)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfpvJ-0000Ul-UW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfpvI-0003i5-TS
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:12:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hfpvI-0003gz-JT
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:12:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E0BEC1EB201;
 Tue, 25 Jun 2019 18:11:58 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A16E15D70D;
 Tue, 25 Jun 2019 18:11:57 +0000 (UTC)
Date: Tue, 25 Jun 2019 15:11:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190625181156.GW1862@habkost.net>
References: <20190625050008.12789-1-ehabkost@redhat.com>
 <20190625050008.12789-5-ehabkost@redhat.com>
 <20190625180825.GM3139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190625180825.GM3139@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 25 Jun 2019 18:11:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/6] i386: Infrastructure for versioned CPU
 models
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 07:08:25PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Jun 25, 2019 at 02:00:06AM -0300, Eduardo Habkost wrote:
> > Base code for versioned CPU models.  This will register a "-4.1"
> > version of all existing CPU models, and make the unversioned CPU
> > models be an alias for the -4.1 versions on the pc-*-4.1 machine
> > types.
>=20
> Currently we have some CPUs that I'd consider historical "mistakes"
> due to fact that versioning didn't previously exist.
>=20
> eg
>=20
>    Haswell
>    Haswell-noTSX
>    Haswell-noTSX-IBRS
>=20
> IIUC this patch adds
>=20
>   Haswell            alias-of Haswell-4.1
>   Haswell-noTSX      alias-of Haswell-noTSX-4.1
>   Haswell-noTSX-IBRS alias-of Haswell-noTSX-IBRS-4.1
>=20
> I'm thinking we should instead be merging all these haswell variants
>=20
>=20
>   Haswell            alias-of Haswell-4.1.1
>   Haswell-noTSX      alias-of Haswell-4.1.2
>   Haswell-noTSX-IBRS alias-of Haswell-4.1.3
>=20
> Or if we used the simple counter versioning
>=20
>   Haswell            alias-of Haswell-1
>   Haswell-noTSX      alias-of Haswell-2
>   Haswell-noTSX-IBRS alias-of Haswell-3
>=20
> Likewise for the other named CPUs with wierd variants.
>=20
> This would effectively be "deprecating" the noTSX and IBRS variants
> in favour of using the versioning approach

Sounds good.  I will do it.

--=20
Eduardo

