Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D04C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D7621734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgOqidj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D7621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j29yj-0001s9-Vi
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 03:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j29y3-00015y-5m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:35:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j29xz-0005NQ-Fp
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:35:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54043
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j29xz-0005Mv-4X
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581582921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KDlOlxEsKfxfl7bDGot/HUzfYzAUiYbd3nK8yaZ4scY=;
 b=VgOqidj2sDa40YaAAz6Ji1KBc4d2fiGzdyPpmqcUapuBEB+4mH/UeMKuCRImNcd3JHEspK
 uo77pivJZ1+oN4PBBefl6oADcvgAesxEID2+gf1IILyV8dN7dxMPDvEu3UNpBiAJJnZpT6
 BXCUpfC/ySq0pMRJCN9P6h6PzdMHCzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-tI7MFm2dOeyRv2zeP89FFg-1; Thu, 13 Feb 2020 03:35:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C47F01005514;
 Thu, 13 Feb 2020 08:35:13 +0000 (UTC)
Received: from gondolin (ovpn-117-87.ams2.redhat.com [10.36.117.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CED9460BF1;
 Thu, 13 Feb 2020 08:35:01 +0000 (UTC)
Date: Thu, 13 Feb 2020 09:34:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v1 5/5] travis.yml: Test the s390-ccw build, too
Message-ID: <20200213093458.1c7b4479.cohuck@redhat.com>
In-Reply-To: <6b47f020-fadb-4814-4dc1-37c3cb0b0357@redhat.com>
References: <20200207113939.9247-1-alex.bennee@linaro.org>
 <20200207113939.9247-6-alex.bennee@linaro.org>
 <6b47f020-fadb-4814-4dc1-37c3cb0b0357@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: tI7MFm2dOeyRv2zeP89FFg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, f4bug@amsat.org,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Feb 2020 21:48:42 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 2/7/20 12:39 PM, Alex Benn=C3=A9e wrote:
> > From: Thomas Huth <thuth@redhat.com>
> >=20
> > Since we can now use a s390x host on Travis, we can also build and
> > test the s390-ccw bios images there. For this we have to make sure
> > that roms/SLOF is checked out, too, and then move the generated *.img
> > files to the right location before running the tests.
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Message-Id: <20200206202543.7085-1-thuth@redhat.com>
> > ---
> >   .travis.yml | 10 ++++++++++
> >   1 file changed, 10 insertions(+)

> Already reviewed/tested [*] with comment:
>=20
> Maybe remove the trailing ", too" in subject...
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg677641.html
>=20

Hm, I also gave an

Acked-by: Cornelia Huck <cohuck@redhat.com>


