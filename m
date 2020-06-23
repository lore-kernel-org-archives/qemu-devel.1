Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6022920716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsusJR9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6022920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnidt-0004Eg-MT
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 09:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnidG-0003oy-TB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:06:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45479
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnidE-0004g0-VM
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592917591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9AyIZYxqVh6ZGmmxCcEC0ZfEXaJoEdOKhh+Zece7bsY=;
 b=HsusJR9rb1oiwj/10LLAPM4gKRO9l3x9QYxVav5dWg1QKoaMJ12q4F5Vms3i4EDg2SU7ee
 j7IsLSYmdulxZCKOnYmcdEc0hhZUObOJMXanxrYNCfkO3GO7Z5szRod1u6J52d2RQFMt/p
 ZD5hXtbqlE2/Iw+/hIfweyIfebBajwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138--9DzI9mqPJunI3wrZYRTOQ-1; Tue, 23 Jun 2020 09:06:29 -0400
X-MC-Unique: -9DzI9mqPJunI3wrZYRTOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F0A9107ACF5;
 Tue, 23 Jun 2020 13:06:28 +0000 (UTC)
Received: from localhost (unknown [10.40.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F245C60CD3;
 Tue, 23 Jun 2020 13:06:13 +0000 (UTC)
Date: Tue, 23 Jun 2020 15:06:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 6/8] tests: Add updated DSDT
Message-ID: <20200623150612.49a6c097@redhat.com>
In-Reply-To: <20200617142305.1198672-7-stefanb@linux.vnet.ibm.com>
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
 <20200617142305.1198672-7-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 eric.auger@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com, mkedzier@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 10:23:03 -0400
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> Add the updated DSDT following the interrupt enablement.
>=20
> @@ -5,13 +5,13 @@
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of tests/data/acpi/q35/DSDT.tis, Mon Jun 15 09:57:05 2020
> + * Disassembly of /tmp/aml-Y77YL0, Mon Jun 15 09:57:05 2020
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x000020A5 (8357)
> + *     Length           0x000020A8 (8360)
>   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math supp=
ort
> - *     Checksum         0xAD
> + *     Checksum         0x77
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPCDSDT"
>   *     OEM Revision     0x00000001 (1)
> @@ -3162,6 +3162,8 @@
>                          0xFED40000,         // Address Base
>                          0x00005000,         // Address Length
>                          )
> +                    IRQNoFlags ()
> +                        {13}
>                  })
>                  OperationRegion (TPP2, SystemMemory, 0xFED45100, 0x5A)
>                  Field (TPP2, AnyAcc, NoLock, Preserve)
> **
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-id: 20200616205721.1191408-7-stefanb@linux.vnet.ibm.com
> CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/q35/DSDT.tis                | Bin 8357 -> 8360 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
>=20
> diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
> index 56b6fb0c3298517d080e38fea05a748b9f1dba54..3f9db960aa05d399fa7f8449e=
6db688788211832 100644
> GIT binary patch
> delta 64
> zcmZ4LxWbXkCD<iog#rTuWBEp|KeC)oS~2m#PVoX>llkS`nVeK7N60A%iEs(FaWXJ6
> UFkJb^5Wv8o#GtUbT~3Y(068!Z;Q#;t
>=20
> delta 61
> zcmZ4CxYUu$CD<iosR9E7<Jyf}e`GoRHDls~o#F-DC-cj>Gx@7bj*wH}7v$n=3D<78lD
> RV7T&+A%KBlbC;YP695=3D#58(g+
>=20
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index bb4ce8967b..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/q35/DSDT.tis",


