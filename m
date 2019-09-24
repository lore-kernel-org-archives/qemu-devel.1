Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34713C432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0215820872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 09:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8H0V7ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0215820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChTw-0002DK-PV
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 05:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iChQN-0000pd-FL
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iChQL-0002IO-MF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:47:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24849
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iChQL-0002IG-GV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 05:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569318476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Sp60zZDeXlC7Exg9yL1M9av0wZWNFurWDK8SFEW9xww=;
 b=Q8H0V7ao8bIBzPy27tA+AdRmIPybIxzsTSZ060tos6AM9TccQ+pPMDT8Q4U/R/qnJ73Ajh
 vPS2wsK1XiOwaGPKqQ7B9ePsSx5Xc7XIBKSIRc7GRset2l6kC4+KWuP76v0YI2NP1icatZ
 lFxYHuXawH49l5/w1UsG39HtOAnU6V0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-AV8NqNd7N4mRRdkJd8-FIQ-1; Tue, 24 Sep 2019 05:47:54 -0400
Received: by mail-wr1-f69.google.com with SMTP id c1so360242wrb.12
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 02:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RlIHR1YO/EP5iYaS1GAVe+HD9e8SiR0ax3eW/72kuio=;
 b=RVFPFEodmQyLS0SwaDmo44w6HyCP+8bJnnMbJcSV1y8Q5tzayJ+vY9Ypn8vIu1iSQF
 yEMDOhDiNy+lNDOw4r1o82Wqc8xceMef3XeYIbh+ZYAgOBOdw+JzJ2pO3sifQ5MoVISf
 030ELREqcSRzGQqLkOJO9ViECJv22AG3HBFiyAOBnFBezXkqwKENiSHuMi5NDrymzkSp
 i8NXVDyH22QZtMTHn807qvPPtrTa1Ptkk9Zp3TsAGWhLL8wro5dAisw78TlQjINiMigR
 GUOIC+XI6+zNcUa1PlBLh7WAFhW0KoTzYWyQxDxDPr2xEN35yFyQzfcPYdtH4QO1fm/5
 SdfA==
X-Gm-Message-State: APjAAAW/QLV9q0DwqKXMcA6XU7ruUHd1w7eH9S/bnBB2IYiddZJZcD9A
 6R3BB0dVqrdUcWoYi6dyFbejkCemheWhIGWRpXU8qImkfQZ/fh1O9idxNOAxpF3a59CU/6anGZP
 jEd7onQgyswxGtio=
X-Received: by 2002:a05:600c:248a:: with SMTP id
 10mr1924642wms.97.1569318472977; 
 Tue, 24 Sep 2019 02:47:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyaqx3aTcLoZB/pQilVsAI7WHgh16VMuB/sAYa3QnLmp/SGRL1nuy+aexv2j9vH8yUCK5m24Q==
X-Received: by 2002:a05:600c:248a:: with SMTP id
 10mr1924628wms.97.1569318472830; 
 Tue, 24 Sep 2019 02:47:52 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id f8sm1431045wmb.37.2019.09.24.02.47.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 02:47:52 -0700 (PDT)
Subject: Re: [PATCH 0/4] xics: Eliminate unnecessary class
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c2efe040-a9f4-8d7f-f1b4-c8ef162c4560@redhat.com>
Date: Tue, 24 Sep 2019 11:47:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924045952.11412-1-david@gibson.dropbear.id.au>
Content-Language: en-US
X-MC-Unique: AV8NqNd7N4mRRdkJd8-FIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: gkurz@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 6:59 AM, David Gibson wrote:
> The XICS interrupt controller device used to have separate subtypes
> for the KVM and non-KVM variant of the device.  That was a bad idea,
> because it leaked information that should be entirely host-side
> implementation specific to the kinda-sorta guest visible QOM class
> names.
>=20
> We eliminated the KVM specific class some time ago, but it's left
> behind a distinction between the TYPE_ICS_BASE abstract class and
> TYPE_ICS_SIMPLE subtype which no longer serves any purpose.
>=20
> This series collapses the two types back into one.
>=20
> David Gibson (4):
>   xics: Eliminate 'reject', 'resend' and 'eoi' class hooks
>   xics: Merge reset and realize hooks
>   xics: Rename misleading ics_simple_*() functions
>   xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes

Please remove the qemu_register_reset() call in hw/intc/xics.c,
then for the series:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


