Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C10AC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 18:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABEC2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 18:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="I1sGa7W9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABEC2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEzao-0007W2-29
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 14:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <r.bolshakov@yadro.com>) id 1jEzaF-00077N-3Z
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <r.bolshakov@yadro.com>) id 1jEzaD-0000im-VW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:07:54 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:56034 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
 id 1jEzaD-0000c7-N8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:07:53 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id DCF78412E1;
 Thu, 19 Mar 2020 18:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1584641269; x=1586455670; bh=8yO0uXTYQvfeZiD83jWJcj
 S2eY0cX2cPaSdzC06Y8PY=; b=I1sGa7W95ecEj/ArCUD/CSTyfifAA57JwTars1
 z8s3t0OtexW5By4cgdX6tbNtGUSneqvoLjcQev3nKEhD5RjEXmSOwkDXjJAhMf6o
 dTG95BCvitT2q9g0WwUiB8oPq9Y4lFkAPYWgWVLR//xIZI49BUWLYZdH354pf9iY
 nVN1A=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f_byYY8CjY8S; Thu, 19 Mar 2020 21:07:49 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id CE01C41259;
 Thu, 19 Mar 2020 21:07:48 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 19
 Mar 2020 21:07:49 +0300
Date: Thu, 19 Mar 2020 21:07:48 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] MAINTAINERS: Add an entry for the HVF accelerator
Message-ID: <20200319180748.GC77771@SPB-NB-133.local>
References: <20200319135520.80901-1-r.bolshakov@yadro.com>
 <70dac67d-8cb1-466f-fe1f-6be4af7c8aca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <70dac67d-8cb1-466f-fe1f-6be4af7c8aca@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 89.207.88.252
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Patrick Colp <patrick.colp@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 19, 2020 at 06:06:15PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 3/19/20 2:55 PM, Roman Bolshakov wrote:
> > Cameron signed up for taking HVF ownership.
> >=20
> > Cc: Cameron Esfahani <dirty@apple.com>
> > Cc: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> > Cc: Patrick Colp <patrick.colp@oracle.com>
> > Cc: Liran Alon <liran.alon@oracle.com>
> > Cc: Heiher <r@hev.cc>
> >=20
> > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > ---
> > Changes since v2:
> >    Removed myself from the list of maintainers, added Cameron from Ap=
ple.
> >    Status is changed to Supported again.
> > Changes since v1:
> >    Status is changed to Maintained instead of Supported.
> >=20
> >   MAINTAINERS | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7364af0d8b..ab4dc2816c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -406,6 +406,13 @@ S: Supported
> >   F: target/i386/kvm.c
> >   F: scripts/kvm/vmxcap
> > +X86 HVF CPUs
> > +M: Cameron Esfahani <dirty@apple.com>
>=20
> From the other thread discussions, I'd keep you at least listed as
> designated reviewer:
>=20
> R: Roman Bolshakov <r.bolshakov@yadro.com>
>=20

Sounds good to me, thanks.

Roman

