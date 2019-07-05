Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F79CC4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4C9218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4C9218CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjMnX-00035S-Sc
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 07:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hjMml-0002Uu-W6
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hjMmk-0000JN-TH
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>)
 id 1hjMmf-0008I6-R1; Fri, 05 Jul 2019 07:53:45 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 539F359451;
 Fri,  5 Jul 2019 11:53:34 +0000 (UTC)
Received: from kaapi (unknown [10.65.150.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB3F76961E;
 Fri,  5 Jul 2019 11:53:28 +0000 (UTC)
Date: Fri, 5 Jul 2019 17:23:26 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
In-Reply-To: <20190705104255.24027-1-philmd@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1907051714200.15068@xnncv>
References: <20190705104255.24027-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 05 Jul 2019 11:53:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v2] hw/ssi/xilinx_spips: Avoid AXI
 writes to the LQSPI linear memory
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Lei Sun <slei.casper@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Fri, 5 Jul 2019, Philippe Mathieu-Daud=C3=A9 wrote --+
| +static bool lqspi_accepts(void *opaque, hwaddr addr,
| +                          unsigned size, bool is_write,
| +                          MemTxAttrs attrs)
| +{
| +    /*
| +     * From UG1085, Chapter 24 (Quad-SPI controllers):
| +     * - Writes are ignored
| +     * - AXI writes generate an external AXI slave error (SLVERR)
| +     */
| +    return !is_write;
| +}
| +
|  static uint64_t
|  lqspi_read(void *opaque, hwaddr addr, unsigned int size)
|  {
| @@ -1225,6 +1237,7 @@ static const MemoryRegionOps lqspi_ops =3D {
|      .read =3D lqspi_read,
|      .endianness =3D DEVICE_NATIVE_ENDIAN,
|      .valid =3D {
| +        .accepts =3D lqspi_accepts,
|          .min_access_size =3D 1,
|          .max_access_size =3D 4
|      }

Looks okay.

To confirm,
  When lqspi_accepts() returns false, guest will see an error/exception?


Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
