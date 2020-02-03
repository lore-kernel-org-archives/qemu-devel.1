Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C703C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0D520721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqFnc4+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0D520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyaKl-0002hJ-0H
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyaJs-0001iX-Hh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyaJm-0001GB-R0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:55:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39587)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyaJl-0001FS-Sw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580730905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=4lTyewF0SMvgkXFycYsZtV/tkZVfn8qw4zSsWzUPHXw=;
 b=XqFnc4+NKs1caiNFuQtkm2WS7gzMXR2IH50T3z5geteJH3rLGYdrCDgSpe0IOt28NR6kHH
 19BQUkaQAXQixulHpoCbdz9nR8gx3aRJ9tQ3PYdFX1IiIiEu/bZ+OS9ZsakrNPvL+XQYkQ
 vRzskI/BThs3eaet1xjmG12TbVC/Inw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-IKsg2VDnMyiPX2_nK-wCYg-1; Mon, 03 Feb 2020 06:54:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A69F0107ACC7;
 Mon,  3 Feb 2020 11:54:52 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FD178EA0A;
 Mon,  3 Feb 2020 11:54:48 +0000 (UTC)
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
 <CAFEAcA9Q5nsD5iTPwsVVx73HPUD6aGKd0Sf2FUkAFqjAZhGMGw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <82f0aa8e-b445-ad7f-1b17-03f4bb180a85@redhat.com>
Date: Mon, 3 Feb 2020 12:54:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Q5nsD5iTPwsVVx73HPUD6aGKd0Sf2FUkAFqjAZhGMGw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: IKsg2VDnMyiPX2_nK-wCYg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/2020 12.46, Peter Maydell wrote:
> On Wed, 15 Jan 2020 at 11:11, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>> The qemu.git/master docs are built nightly here (index.html is now
>> visible!):
>> https://www.qemu.org/docs/master/
>>
>> qemu.org's docs are more useful at the moment since they include the
>> user documentation in addition to the developer documentation.
>=20
> Our top-level documentation page https://www.qemu.org/documentation/
> still points to https://qemu.weilnetz.de/qemu-doc.html -- should
> we update that now to link to https://www.qemu.org/docs/master/
> instead ?

Sure, but I'm still waiting for someone to suggest a final patch here.

Open questions:

- Do we also want to link to readthedocs as suggested by Alex, or is our
  own docs on www.qemu.org enough?

- Do we still want to link to weilnetz.de (as it was the case with
  StefanH's original patch https://patchwork.kernel.org/patch/11234545/)
  or should that link be removed?

- Do we only link to https://www.qemu.org/docs/master/ or shall we
  link to the individual docs (qemu-doc, qemu-qmp-ref, ...) ?

 Thomas


