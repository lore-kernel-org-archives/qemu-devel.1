Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C764C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463132146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463132146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJHD-0005iK-7Y
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 09:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39520)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hiJGH-0005Gb-2l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hiJGG-00049g-2M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:55:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hiJGF-00048n-SD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 09:55:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 762D9308795E;
 Tue,  2 Jul 2019 13:55:36 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DA7178543;
 Tue,  2 Jul 2019 13:55:31 +0000 (UTC)
Date: Tue, 2 Jul 2019 10:55:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190702135530.GM5198@habkost.net>
References: <20190628002844.24894-1-ehabkost@redhat.com>
 <20190628002844.24894-10-ehabkost@redhat.com>
 <20190702094717.GP21569@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190702094717.GP21569@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 02 Jul 2019 13:55:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 9/9] i386: Add Cascadelake-Server-v2 CPU
 model
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
Cc: jingqi.liu@intel.com, Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Hu,
 Robert" <robert.hu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, "Lai, Paul C" <paul.c.lai@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 10:47:17AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Jun 27, 2019 at 09:28:44PM -0300, Eduardo Habkost wrote:
> > Add new version of Cascadelake-Server CPU model, setting
> > stepping=3D5 and enabling the IA32_ARCH_CAPABILITIES MSR
> > with some flags.
> >=20
> > The new feature will introduce a new host software requirement,
> > breaking our CPU model runnability promises.  This means we can't
> > enable the new CPU model version by default in QEMU 4.1, because
> > management software isn't ready yet to resolve CPU model aliases.
> > This is why "pc-*-4.1" will keep returning Cascadelake-Server-v1
> > if "-cpu Cascadelake-Server" is specified.
>=20
> Hmm, yes, we don't actually need to answer the question I
> raised in the earlier patch for another 2 releases yet,
> as we'll be sticking with v1 for all machines for a while.

After these 2 releases have passed, we'll set default version to
CPU_VERSION_LATEST.  I don't see the need to set per-model
defaults.

--=20
Eduardo

