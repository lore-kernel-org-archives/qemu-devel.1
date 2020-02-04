Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9787FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625BD21582
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 08:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/6J/ohg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625BD21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iytnz-0002qc-HL
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 03:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iytnL-0002NP-1Z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iytnJ-0005X3-1a
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:42:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iytnI-0005SI-PH
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 03:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580805771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeCiGzmpjDcmLowLHYWjAxqi3vNkM75Mj7CTVaZ0uCk=;
 b=Y/6J/ohgGLLsmJ2Z6WTbuEgy28MJf4NC673j4w3aSf/MTBs+JXFrcs7u/Vsv9vKw9Ie3Xt
 Gpq6H0CmXU75Mk1JQpA0OtR1MLzAPGAHG/i73GJLE9bEmGR5TreNYcTpv/iHZ3DCor6xxT
 q8XTVX9FPqXQed5z23Gxhsz5rX/P+ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-cWSVr3wuOEekTBBmbU7-QA-1; Tue, 04 Feb 2020 03:42:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C089910509A3;
 Tue,  4 Feb 2020 08:42:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0604610DC;
 Tue,  4 Feb 2020 08:42:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5F22011386A7; Tue,  4 Feb 2020 09:42:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
References: <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
 <CAFEAcA-545QS9mnM6hwa6TxUpw_pDQ3Pa8tkf4qtzWS1Zi_fxQ@mail.gmail.com>
 <CABgObfaB=wHXyJbQR163bZdFHhWdCc4D8sWRHzte019_hSTuhA@mail.gmail.com>
 <20200131152243.GA24572@paraplu> <87sgjvbkvj.fsf@dusky.pond.sub.org>
 <b2a329bf-4795-14f0-473c-2a7cdfa4d262@redhat.com>
 <87mua02dyn.fsf@dusky.pond.sub.org>
 <b1e1e489-9db4-383f-9734-a99626a2d548@redhat.com>
Date: Tue, 04 Feb 2020 09:42:19 +0100
In-Reply-To: <b1e1e489-9db4-383f-9734-a99626a2d548@redhat.com> (Paolo
 Bonzini's message of "Mon, 3 Feb 2020 16:21:51 +0100")
Message-ID: <875zgmbv6c.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: cWSVr3wuOEekTBBmbU7-QA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/02/20 10:54, Markus Armbruster wrote:
>>> Types are documented as above; however types other than link<> and=20
>>> child<>, which are QAPI types, can be user-defined types (structs,=20
>>> enums) and this is not included in (1).
>> Specifically, three of four kinds of type names are documented:
>> primitive, child, scalar.  The fourth kind is not, and it can be
>> anything.  It need not be a QAPI type name.  In any case, you just have
>> to know what the type name means.
>
> It is not enforced, but it is supposed to be only QAPI type names
> (primitive or not), child or link.

It's not even documented.

Actual names include "struct tm", "guest statistics", and (my
favourite) "struct".


