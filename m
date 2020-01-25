Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13ABC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 17:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDA920716
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 17:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dv48deJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDA920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivOvx-0000OI-Nw
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 12:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ivOvF-0008MI-PO
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ivOvD-00016B-Ll
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:08:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24999
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ivOvD-000142-FD
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579972114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=FbR3LPHiWn+aFeMKpuMdQtQ6RAnrv7lZVcWDgKRKX+U=;
 b=Dv48deJ5bozM9DRhz1DmBTwljtd8t42zIQLw8i8bfFJVQQ7HTW18J49xcVBv7s4Dd3oWHf
 syqaxKN/qpHD1q6cyc7QIPP3ujl3OHrDW9Egmn53RpZ8fmolVUBqOBLgKVF2O9IlHgJBXh
 0d+LU2n1haUuG5ryb6th42M6jP9QIR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-_x4uJA3yPDOCzIuL6TKV_g-1; Sat, 25 Jan 2020 12:08:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0E9A13E2;
 Sat, 25 Jan 2020 17:08:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-42.ams2.redhat.com [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B4485C1D4;
 Sat, 25 Jan 2020 17:08:19 +0000 (UTC)
Subject: Re: [PATCH rc2 01/25] target/avr: Add outward facing interfaces and
 core CPU logic
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-2-f4bug@amsat.org>
 <CAL1e-=irw8HhXyJmdUm_+HXReVtk=SWkSCmPce-7artL6N7oUw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <75c4ac1f-e5cb-1f6c-92d8-2cf5bb0ebea6@redhat.com>
Date: Sat, 25 Jan 2020 18:08:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=irw8HhXyJmdUm_+HXReVtk=SWkSCmPce-7artL6N7oUw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _x4uJA3yPDOCzIuL6TKV_g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 "S.E.Harris@kent.ac.uk" <S.E.Harris@kent.ac.uk>,
 "mrolnik@gmail.com" <mrolnik@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/01/2020 11.48, Aleksandar Markovic wrote:
>=20
> On Friday, January 24, 2020, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
>=20
>     From: Michael Rolnik <mrolnik@gmail.com <mailto:mrolnik@gmail.com>>
>=20
>     This includes:
>     - CPU data structures
>     - object model classes and functions
>     - migration functions
>     - GDB hooks
>=20
> I have an objection over this patch.
>=20
> It contains many diverse logical units squashed into a patch, and
> therefore is not in accordance to our submission giidelines.

I think you have to decide on a case by case basis. This is a new target
for a hobbyist board ... so I think you don't have to thaaat strict here.

> If we accept this patch, we will be setting a bad precedent, that may
> misled future platform contributors. additionally, this patch may be
> singled out in our countribution guidelines as the example how not to do
> a parch, which is probably not what Michael want to be exposed to.

Honestly, I'd leave that decision to the person who picks up the patch
and sends a pull request, i.e. Richard in this case, I assume.

> Splitting patches is tedius, but overall not that difficult or time
> consuming task.

OTOH hand, we've seen more than 40 iterations of the patch series
already. Michael invested a lot of time into this series, so if you make
him respin forever, he'll certainly rather lose interest at one point in
time. So I'd say if Richard is fine with the series, I'd rather not like
to see yet another iteration on the mailing list again and rather see a
pull request for these patches instead.

 Thomas


