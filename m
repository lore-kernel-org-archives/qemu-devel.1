Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32979C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0049B20801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9ST2gnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0049B20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4izw-0002go-6Y
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j4izG-0002B9-2P
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j4izE-0002dz-Q6
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:23:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53335
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j4izE-0002dc-MB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582194196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Wmjbx/JtQHY3Ipn4LQpP8obTqSJnMmA/1uZE2JmUnQ=;
 b=f9ST2gnj6esj9SSEbSmrZGe0AEvOYCKwcMX90EvbIMwSEEKRTdN03wJr7gtZtZlqBIwxIj
 tvJinnUGcf5Xd/9it882DvpaDT2bKxUADWapWPyNeszaFPQC9YJA27hUoJyvDHPxt7EvK8
 BcRa4fG9Ms5XEsJUI02hy9kEM4rnCCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-MAQePCEMNmm2Y3OdoIbhLQ-1; Thu, 20 Feb 2020 05:23:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8324518C35A0;
 Thu, 20 Feb 2020 10:23:11 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22E1E19757;
 Thu, 20 Feb 2020 10:23:11 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 900303E04FA; Thu, 20 Feb 2020 11:23:08 +0100 (CET)
Date: Thu, 20 Feb 2020 11:23:08 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 1/2] docs: Convert qemu-cpu-models.texi to rST
Message-ID: <20200220102308.GE24572@paraplu>
References: <20200219114607.1855-1-kchamart@redhat.com>
 <20200219114607.1855-2-kchamart@redhat.com>
 <CAFEAcA94A3doGQthOTrPuMadOfqrSLBadUbi+3BpHr1MGp_w1A@mail.gmail.com>
 <20200219164007.GC24572@paraplu>
 <CAFEAcA_M3s7U_Brx4iZcWKbrNesn5z33C2Cz+jr1PxCNGTvaXg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_M3s7U_Brx4iZcWKbrNesn5z33C2Cz+jr1PxCNGTvaXg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: MAQePCEMNmm2Y3OdoIbhLQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: armbru@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 05:57:16PM +0000, Peter Maydell wrote:
> On Wed, 19 Feb 2020 at 16:40, Kashyap Chamarthy <kchamart@redhat.com> wro=
te:
> > Peter, how are you able to generate those *.7 `nroff` man pages?  When =
I
> > do 'make sphinxbuild' from my build dir ($HOME/buld/qemu), I only see:
>=20
> Just run 'make'.=20

I did that, but I was missing the "--enable-docs" with my `configure`
invocation (which I didn't post in full on the list, but only on IRC
yesterday).  Thanks, Markus, for spotting that.

    $> cd ~/build/qemu
    $> ~/src/qemu//configure --target-list=3Dx86_64-softmmu \
        --enable-debug --enable-docs
    $> make -j8

That did the trick:

    # From the build dir
    $> find -name \*.7
    ./docs/interop/qemu-ga-ref.7
    ./docs/interop/qemu-qmp-ref.7
    ./docs/system/qemu-block-drivers.7
    ./docs/system/qemu-cpu-models.7

> As with the existing texinfo manpages, there
> is no specific makefile target for "build the manpages and
> nothing else".

Yeah, noticed that from the Makefile.

All sorted now, thanks!

> thanks
> -- PMM
>=20

--=20
/kashyap


