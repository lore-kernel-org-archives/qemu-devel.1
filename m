Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3AC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF482464B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxWbQQcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF482464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdd8-0000mn-99
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jBdb7-0006Xl-5Q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jBdb1-0004kf-Bl
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:02:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jBdb1-0004h3-5q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583841770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7QC8ny7o4ttNAREpaFiYyzrI+P6ql4Te+gVdc/5ZfY=;
 b=TxWbQQcA0ZQspBRma3kg8LzqAXv96/YNsnL45lfah8KBMVZNl7Y7/ipu/ApjusFecCl6my
 dzIBAk8qrsZRHoHF7VqhlhmTEg5BFkK6jdLhvAyMFb1w44uIhtvrGTnq7t1SW1oCoY574p
 ZnQtft5dQhIJWm6mZYC6Knr64xaM2Nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-679WWxbYPd6UJRPLoVHoow-1; Tue, 10 Mar 2020 08:02:35 -0400
X-MC-Unique: 679WWxbYPd6UJRPLoVHoow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01010800D55;
 Tue, 10 Mar 2020 12:02:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CB3A5DA83;
 Tue, 10 Mar 2020 12:02:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B90809DB6; Tue, 10 Mar 2020 13:02:32 +0100 (CET)
Date: Tue, 10 Mar 2020 13:02:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/4] tests/vm: update FreeBSD to 12.1
Message-ID: <20200310120232.6lor5opu7iykqgcr@sirius.home.kraxel.org>
References: <20200310083218.26355-1-kraxel@redhat.com>
 <20200310083218.26355-4-kraxel@redhat.com>
 <87lfo8ijfg.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87lfo8ijfg.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > -    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.=
0/FreeBSD-12.0-RELEASE-amd64-disc1.iso.xz"
> > -    csum =3D "1d40015bea89d05b8bd13e2ed80c40b522a9ec1abd8e7c8b80954fb4=
85fb99db"
> > +    link =3D "https://download.freebsd.org/ftp/releases/ISO-IMAGES/12.=
1/FreeBSD-12.1-RELEASE-amd64-disc1.iso.xz"
> > +    csum =3D "7394c3f60a1e236e7bd3a05809cf43ae39a3b8e5d42d782004cf2f26=
b1cfcd88"

> Warning: Permanently added '[127.0.0.1]:39533' (ECDSA) to the list of kno=
wn hosts.
> Bootstrapping pkg from
> pkg+http://pkg.FreeBSD.org/FreeBSD:12:amd64/quarterly, please wait...
> Verifying signature with trusted certificate
> pkg.freebsd.org.2013102301... done
> Installing pkg-1.12.0_1...
> Newer FreeBSD version for package pkg:
> To ignore this error set IGNORE_OSVERSION=3Dyes
> - package: 1201000
             ^^^^
12.1 package

> - running kernel: 1200086
                    ^^^^
12.0 running

I saw that too, but only *without* the patch.  The upgrade to 12.1 fixes
that.

We might consider setting IGNORE_OSVERSION=3Dyes, so this doesn't happen
again after FreeBSD 12.2 release.  Not sure whenever that can have
unwanted side effects though, like packages not working properly.

Any advise from the bsd guys?

cheers,
  Gerd


