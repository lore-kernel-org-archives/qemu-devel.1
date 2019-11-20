Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD37C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:38:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F35223D1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="acZbrmFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F35223D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXMR9-0007CO-FY
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iXMOx-00054w-VS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iXMOw-0003wV-Os
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:35:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34481
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iXMOw-0003wC-Ln
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574242554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6vVt8ow8OQ427gF4o7aPOEiOT4tfvcNkbcvv3zXqAo=;
 b=acZbrmFwtXki0bC27P+VKVuC9aJguUd/LUxNKAhdSgkRsv8Y7TfW8ULQZhVsySd9EF1buH
 UJYNJcvfPcJ54/HheWZizaDFlO7hSj49bzIawvW9pf0vWeoUv7Wn3a2J6/XtJMOh/vy/mH
 4yuMGp0ueJRePQii1h1qFbMVidWtn9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-ZaZ4KHQjO3GZlHwQod5f2g-1; Wed, 20 Nov 2019 04:35:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF7FB1852E2E;
 Wed, 20 Nov 2019 09:35:46 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F4871036C78;
 Wed, 20 Nov 2019 09:35:42 +0000 (UTC)
Date: Wed, 20 Nov 2019 10:35:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] mem: move nvdimm_device_list to utilities
Message-ID: <20191120103540.617b8c9a@redhat.com>
In-Reply-To: <b32efc6c-e71d-b5cd-b2df-32c684ab834e@linux.ibm.com>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107825148.27733.10924648339824665145.stgit@lep8c.aus.stglabs.ibm.com>
 <20191119081326.275531af@redhat.com>
 <b32efc6c-e71d-b5cd-b2df-32c684ab834e@linux.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ZaZ4KHQjO3GZlHwQod5f2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, sbhat@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 13:31:34 +0530
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> Hi Igor,
>=20
>=20
> On 11/19/2019 12:43 PM, Igor Mammedov wrote:
> > On Mon, 14 Oct 2019 13:37:37 -0500
> > Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:
> > =20
> >> nvdimm_device_list is required for parsing the list for devices
> >> in subsequent patches. Move it to common utility area.
> >>
> >> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> >> ---
> >>   hw/acpi/nvdimm.c            |   28 +---------------------------
> >>   include/qemu/nvdimm-utils.h |    7 +++++++
> >>   util/Makefile.objs          |    1 +
> >>   util/nvdimm-utils.c         |   29 +++++++++++++++++++++++++++++ =20
> > instead of creating new file, why not to move it to existing hw/mem/nvd=
imm.c? =20
>=20
> That would break the build for mips-softmmu. The mips has=20
> CONFIG_ACPI_NVDIMM=3Dy
> and not CONFIG_NVDIMM. So, the build would break failing to fetch the=20
> definition from
> hw/mem/nvdimm.c.

Yes, I forgot that mips doesn't really use any acpi stuff, but it
still pulls in files as dependency via piix4 and trying to decouple
it is not worth effort.

So lets go ahead with your variant using util/nvdimm-utils.c

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> I have the patch here from v2 of the series,
> https://github.com/ShivaprasadGBhat/qemu/commit/00512a25e4852f174fe6c07bc=
5acb5ee7027e3de
>
>=20
> Thanks,
> Shivaprasad
>=20
>=20


