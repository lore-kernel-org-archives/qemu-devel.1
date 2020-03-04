Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8EDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 952F62072D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 09:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/7z9pXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952F62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Q5j-0001xv-RJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 04:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j9Q4w-0001Wd-SX
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j9Q4u-0008Kl-5o
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:12:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j9Q4u-0008JH-1d
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 04:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583313151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=efR1TtkElPczAFiEeoec+SxYuf8yOLcBTIM7KbhzkD0=;
 b=e/7z9pXx1xf/SxEMavjkcJN9j8CS0pb0EaH7gyzqsdJq4SbQnjGaLBNQ2S7bSl7DwxkdfK
 tibEw5EwATgI3xE4N3g91t0kk4SBSOG/BpVJ/ce1Hst5nTRoBpZHOi+r2zJWezlIpBfvg/
 v9Pf9l0I33OyYH22jtjvnO9NqDDJHV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-dILwnJY8Pzi0kdyfn4LAZQ-1; Wed, 04 Mar 2020 04:12:29 -0500
X-MC-Unique: dILwnJY8Pzi0kdyfn4LAZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A44C4DB68;
 Wed,  4 Mar 2020 09:12:28 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 387B28CCE2;
 Wed,  4 Mar 2020 09:12:28 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 632303E04CB; Wed,  4 Mar 2020 10:12:26 +0100 (CET)
Date: Wed, 4 Mar 2020 10:12:26 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 00/33] Convert qemu-doc to rST
Message-ID: <20200304091226.GB16082@paraplu>
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <CAFEAcA8vbqA_4K7dkyOrU_8HDrRo8h5eYESLgNnOzvrp0tVUpQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vbqA_4K7dkyOrU_8HDrRo8h5eYESLgNnOzvrp0tVUpQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 03, 2020 at 05:35:01PM +0000, Peter Maydell wrote:
> On Fri, 28 Feb 2020 at 15:36, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > Hi; this series does a complete conversion of qemu-doc from
> > Texinfo to rST, including the hxtool-generated parts and
> > creation of the qemu.1 manpage from rST.
> >
>=20
> Advance notice: I would like to put these into a pull
> request at the end of this week. This is your opportunity
> to say "that would be a bad idea", "I need X more time
> to review it", etc :-)

I tried to probe some of the generated docs; I couldn't spot something
that is glaring.  (Granted, I didn't spend a _whole_ lot of time.)

And I'm with Paolo =E2=80=94 yes, let's get this merged, and address other
issues as follow-ups :-)

--=20
/kashyap


