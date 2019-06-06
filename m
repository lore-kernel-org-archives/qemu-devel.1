Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38534C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E10920693
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E10920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35246 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvcd-0000qM-KI
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 12:52:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYvbU-0008U5-3k
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hYvbS-0003eL-1N
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hYvbQ-0003VA-5C
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 35C0930C31A7;
	Thu,  6 Jun 2019 16:50:50 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 10F182B587;
	Thu,  6 Jun 2019 16:50:44 +0000 (UTC)
Date: Thu, 6 Jun 2019 18:50:40 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190606185040.7eb6c32e@redhat.com>
In-Reply-To: <c802e812-dabb-0ec6-4458-71f0379856c7@redhat.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
	<20190508061726.27631-9-tao3.xu@intel.com>
	<20190605164045.12bf194c@redhat.com>
	<58e8adc3-18f1-04a6-2c92-baa234293a6f@intel.com>
	<c802e812-dabb-0ec6-4458-71f0379856c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Thu, 06 Jun 2019 16:50:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 08/11] numa: Extend the command-line to
 provide memory latency and bandwidth information
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com,
	Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com,
	rth@twiddle.net, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Jun 2019 08:23:47 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 6/6/19 2:47 AM, Tao Xu wrote:
> > On 6/5/2019 10:40 PM, Igor Mammedov wrote: =20
> >> On Wed,=C2=A0 8 May 2019 14:17:23 +0800
> >> Tao Xu <tao3.xu@intel.com> wrote:
> >> =20
> >>> From: Liu Jingqi <jingqi.liu@intel.com>
> >>>
> >>> Add -numa hmat-lb option to provide System Locality Latency and
> >>> Bandwidth Information. These memory attributes help to build
> >>> System Locality Latency and Bandwidth Information Structure(s)
> >>> in ACPI Heterogeneous Memory Attribute Table (HMAT).
> >>>
> >>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> >>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >>> --- =20
> > ... =20
> >>> +##
> >>> +{ 'struct': 'NumaHmatLBOptions',
> >>> +=C2=A0 'data': {
> >>> +=C2=A0=C2=A0 'initiator': 'uint16',
> >>> +=C2=A0=C2=A0 'target': 'uint16',
> >>> +=C2=A0=C2=A0 'hierarchy': 'HmatLBMemoryHierarchy',
> >>> +=C2=A0=C2=A0 'data-type': 'HmatLBDataType', =20
> >> I think union will be better here with data-type used as discriminator,
> >> on top of that you'll be able to drop a bit of error checking above si=
nce
> >> QAPI's union will not allow user to mix latency and bandwidth.
> >> =20
> > Hi Igor,
> >=20
> > I have quesion here, the 'hmat-lb' is a member of a union 'NumaOptions',
> > it seems can' use a union as a member of union. =20
>=20
> It should be technically possible to expand the QAPI generators to allow
> one union as a branch within another union, so long as there are no
> collisions in identifiers, if that makes for the smartest on-the-wire
> representation.

It would save quite a bit of boiler plate error checking in numa code,
but since I don't know much about QAPI to make meaningful suggestion
how to implement it, I won't insist on using union.

