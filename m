Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F2CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB992251D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9rQaNdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB992251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPY1-000124-NT
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iXPX5-0000EL-Kx
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iXPX4-0007W2-GK
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:56:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32859
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iXPX4-0007Vw-CZ
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574254589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfWlgIu5gOL+k46SUmX+akGx4ostzTVjDNqzMfRx6B0=;
 b=H9rQaNdgleaFRP1c+TxsKd7j3uo1U5RoHJiqjCf/GVnH/U6g53NZole/IJrBMZBaD+UQbJ
 L5UIT7LBryrPH8lgTp0hwS43MSuNekZBvdvev62aMRDM5rWRoiZdQsOV6BtZ0serfmiVeT
 WV/bnQDrtnFg5KD6AVw+27NBiJ8QTd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-EUzZ3v71MTeCnKWgpq2Uzg-1; Wed, 20 Nov 2019 07:56:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA195477;
 Wed, 20 Nov 2019 12:56:24 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A376196BD;
 Wed, 20 Nov 2019 12:56:14 +0000 (UTC)
Date: Wed, 20 Nov 2019 13:56:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v16 08/14] numa: Extend CLI to provide memory latency
 and bandwidth information
Message-ID: <20191120135612.58f3bd01@redhat.com>
In-Reply-To: <f82a9d01-e9cb-902e-34bd-c81fab380995@intel.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
 <20191115075352.17734-9-tao3.xu@intel.com>
 <20191119120302.6ff9e61e@redhat.com>
 <f82a9d01-e9cb-902e-34bd-c81fab380995@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: EUzZ3v71MTeCnKWgpq2Uzg-1
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "Liu, Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 15:55:04 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 11/19/2019 7:03 PM, Igor Mammedov wrote:
> > On Fri, 15 Nov 2019 15:53:46 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >  =20
> >> From: Liu Jingqi <jingqi.liu@intel.com>
> >>
> >> Add -numa hmat-lb option to provide System Locality Latency and
> >> Bandwidth Information. These memory attributes help to build
> >> System Locality Latency and Bandwidth Information Structure(s)
> >> in ACPI Heterogeneous Memory Attribute Table (HMAT).
> >>
> >> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> >> Signed-off-by: Tao Xu <tao3.xu@intel.com> =20
> >=20
> > looks good to me, so
> >=20
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >=20
> >=20
> > PS:
> > also see question below
> >  =20
> [...]
> >> +
> >> +        hmat_lb->range_bitmap |=3D node->bandwidth;
> >> +        first_bit =3D ctz64(hmat_lb->range_bitmap);
> >> +        hmat_lb->base =3D UINT64_C(1) << first_bit;
> >> +        max_entry =3D node->bandwidth / hmat_lb->base;
> >> +        last_bit =3D 64 - clz64(hmat_lb->range_bitmap);
> >> +
> >> +        /*
> >> +         * For bandwidth, first_bit record the base unit of bandwidth=
 bits,
> >> +         * last_bit record the last bit of the max bandwidth. The max=
 compressed
> >> +         * bandwidth should be less than 0xFFFF (UINT16_MAX)
> >> +         */
> >> +        if ((last_bit - first_bit) > UINT16_BITS || max_entry >=3D UI=
NT16_MAX) { =20
> >                                                         ^^^^^^^^^^^^^^^=
^^^^
> > what bandwidth combination is going to trigger above condition?
> >  =20
> Only use (last_bit - first_bit) > UINT16_BITS, we can't trigger error if=
=20
> the max compressed bandwidth is 0xFFFF. Because in that condition,=20
> "last_bit - first_bit =3D=3D UINT16_BITS". So I add "max_entry >=3D=20
> UINT16_MAX" to catch 0xFFFF. For example:
>=20
> Combination 1 (Error):
> bandwidth1   =3D ...0000 1111 1111 1111 1110 0000... (max_entry 32767)
> range_bitmap =3D ...0000 1111 1111 1111 1110 0000... (range is 15 bits)
> bandwidth2   =3D ...0000 1111 1111 1111 1111 0000... (max_entry 65535)
> range_bitmap =3D ...0000 1111 1111 1111 1111 0000... (range is 16 bits)
>=20
> Combination 2 (Error):
> bandwidth1   =3D ...0000 1111 1111 1111 1110 0000... (max_entry 32767)
> range_bitmap =3D ...0000 1111 1111 1111 1110 0000... (range is 15 bits)
> bandwidth2   =3D ...0001 1111 1111 1111 1110 0000... (max_entry 65535)
> range_bitmap =3D ...0001 1111 1111 1111 1110 0000... (range is 16 bits)
>=20
> Combination 3 (OK, because bandwidth1 will be compressed to 65534):
> bandwidth1   =3D ...0000 1111 1111 1111 1110 0000... (max_entry 32767)
> range_bitmap =3D ...0000 1111 1111 1111 1110 0000... (range is 15 bits)
> bandwidth2   =3D ...0000 0111 1111 1111 1111 0000... (max_entry 32767)
> range_bitmap =3D ...0000 1111 1111 1111 1111 0000... (range is 16 bits)
>=20
> Combination 4 (Error):
> bandwidth1   =3D ...0000 1111 1111 1111 1111 0000... (max_entry 65535)
> range_bitmap =3D ...0000 1111 1111 1111 1111 0000... (range is 16 bits)

ok, I'd use in max/min possible values in bios-tables-test,
to make sure that we are testing whole range and would be able
to detect a error in case the valid ranges regressed (shrink)
and x-fail tests I've asked for in QMP test should detect
error other way around.


