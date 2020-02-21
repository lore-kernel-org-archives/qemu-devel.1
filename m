Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EF6C35669
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 19:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0200D20722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 19:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xh9qQpt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0200D20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5ENj-0000aU-64
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 14:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j5EMs-0008Qm-5R
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j5EMp-0003Hw-MV
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:53:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j5EMp-0003Ho-Hb
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 14:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582314822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zQaoC52Jh5PbjQNX6PR5fhA4oCEfmZhluwE01kKy0M=;
 b=Xh9qQpt/sbRCdU1ObxGp+G2gUF+C5/c973X7VJskyJ+l2cXIMee23O6fLzn1ErFRzcjIUD
 ON1huK39XPbfz+xK9gNkm6W4dcsgHzG6OX5qoKRRwmKuOHEtb5dnBueT3vHGVcUI+DZGT2
 CE6J1l/U06yMz4iZthcCvTif6weaRdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-JYmg8FEWNbaOfpwfaS70CQ-1; Fri, 21 Feb 2020 14:53:38 -0500
X-MC-Unique: JYmg8FEWNbaOfpwfaS70CQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AC92107ACCA;
 Fri, 21 Feb 2020 19:53:37 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6FB45C105;
 Fri, 21 Feb 2020 19:53:34 +0000 (UTC)
Date: Fri, 21 Feb 2020 19:53:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
Message-ID: <20200221195331.GN2931@work-vm>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <LO2P123MB2271B1493AD1B4DC8DDCB97783100@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
 <alpine.BSF.2.22.395.2002191904370.88848@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2002192059340.88848@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2002192059340.88848@zero.eik.bme.hu>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: jsnow@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 atar4qemu@gmail.com, jasper.lowell@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* BALATON Zoltan (balaton@eik.bme.hu) wrote:
> On Wed, 19 Feb 2020, BALATON Zoltan wrote:
> > faster or doing something differently? Does someone know what interrupt=
s
> > are generated on real hardware in DMA mode so we can compare that to
> > what we see with QEMU?
>=20
> The document Programming Interface for Bus Master IDE Controller, Revisio=
n
> 1.0 (5/16/94) has some info on this. AFAIU it says that after DMA operati=
on
> is completed an IRQ should be raised. On page 5, section 3.1. Data
> Synchronization it says:
>=20
> "Another way to view this requirement is that the first read to the
> controller Status register in response to the IDE device interrupt must
> return with the Interrupt bit set and with the guarantee that all buffere=
d
> data has been written to memory."
>=20
> Not sure if this is relevant but how is it handled in QEMU? Is the right
> interrupt bit set after DMA transfer is done? If so is it the one that's
> checked by the OS driver?

One thing to be a little careful of is I remember the 646 was always
known for having a few quirks (I've not got a SPARC64 ith one, but I
think my Alpha has it).  So whether you're chasing a generic IDE BM
problem or a 646 special is fun.

Dave

> Regards,
> BALATON Zoltan
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


