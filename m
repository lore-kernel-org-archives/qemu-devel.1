Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC1CC4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259D521D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDr4SaYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259D521D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rTP-0001o9-9b
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j6rSg-0000r6-AT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:50:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j6rSf-0004CQ-9j
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:50:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43930
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j6rSf-0004Bg-5l
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582703428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tY0oUojW+2EZr6GZQKwp8RRahDHKrA6+NzUrOrkaF4=;
 b=SDr4SaYZf7V9Z2JRlDGKDMwhW1GaugJMI8HbLLq6xyY9axyb3tSo4KxClbrr4I8aO2EfxQ
 ht1NbiymsItljya+COGYXj6fp+nnPKLQg3d+f9H+zRI8A/bb7c5PXpvqf9AY9Us1sMkp3G
 p2T+bKGI3/V4GYh5NPW30sNAanpKQEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-vEMZ8NhEPxCgypuTeI6JMg-1; Wed, 26 Feb 2020 02:50:26 -0500
X-MC-Unique: vEMZ8NhEPxCgypuTeI6JMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54E64189F763;
 Wed, 26 Feb 2020 07:50:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AA378C06A;
 Wed, 26 Feb 2020 07:50:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 01C9F11386A6; Wed, 26 Feb 2020 08:50:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/4] docs: Miscellaneous rST conversions
References: <20200225154121.21116-1-peter.maydell@linaro.org>
 <5a6757cb-fda2-ba3f-6c24-f09829faf4ab@redhat.com>
 <CAFEAcA-C0o_u8VABdRky7GUCvyiWhkn74cT1UYAtEAAFjGBLAA@mail.gmail.com>
 <6ed08bea-4fcb-08dc-417c-a0f534173a31@redhat.com>
 <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
Date: Wed, 26 Feb 2020 08:50:20 +0100
In-Reply-To: <CAFEAcA9KmsHS4fnYWvpMMa5SLLUBjiPcOsfmGOHcWopd11M3+g@mail.gmail.com>
 (Peter Maydell's message of "Tue, 25 Feb 2020 17:59:33 +0000")
Message-ID: <874kvdaitf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 25 Feb 2020 at 17:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 25/02/20 18:11, Peter Maydell wrote:
>> >> I assume these are not meant to be applied now, except patch 2?
>> > No, I intended them to be reviewable and applied now. Why
>> > do you think we should wait?
>>
>> Because they remove information from qemu-doc.texi.  I think it's
>> feasible to do a mass conversion quite soon, within a single pull
>> request, the only important part that is missing is the hxtool conversio=
n.
>
> My assumption was that we would attack this by:
>  * converting chunks of the documentation which are in qemu-doc.texi
>    but which aren't in the qemu.1 manpage (basically in the way this
>    series is doing)
>  * get the qapidoc generation conversion reviewed and into
>    master (since at the moment it outputs into files included
>    from qemu-doc)

Not true.  QAPI doc comments go into *separate* manuals, the "QEMU QMP
reference" (docs/interop/qemu-qmp-ref.*), and the "QEMU Guest Agent
protocol reference" (docs/interop/qemu-ga-ref.*).

In more detail: scripts/qapi-gen.py generates
docs/interop/qemu-qmp-qapi.texi from qapi/qapi-schema.json, and
docs/interop/qemu-ga-qapi.texi from qga/qapi-schema.json.  These are
included into docs/interop/qemu-qmp-ref.texi and
docs/interop/qemu-ga-ref.texi, respectively.

>  * convert the manpage parts; we have the machinery for dealing
>    with the hxtool files, it just needs a little more work
[...]


