Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B63C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAEEF22318
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ks102XQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEEF22318
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWmWy-000524-SN
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 14:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWmVX-0004P7-Ee
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWmVQ-0001Mc-U3
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:16:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44173
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWmVP-0001Kh-3x
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574104570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uK30JX6Z2udKG/Bv7ELiQEqwyQiQDMXgKoD6lGsidgQ=;
 b=Ks102XQbFPkldIrG3i3C9nWs0BCKYtT7V4R9MgtvfPgJAz6VCNPUDUM6o0HMk6TMPv1ZJ3
 GLpQI+LcI9b6J4Izpfx/x4lkbhMnJCWinUfKr0v7rEIeMjSvDWl0Mdsm/UeFxYm/hrJmXy
 E+BZyQTc0FZLEcJR7uLX8owBk2Uu/oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-qSlJeuxzPrq_6Heez4LfKg-1; Mon, 18 Nov 2019 14:16:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC357802497;
 Mon, 18 Nov 2019 19:16:04 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35CEC60603;
 Mon, 18 Nov 2019 19:15:55 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] hw/mips/gt64xxx: Remove dynamic field width from
 trace events
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191108144042.30245-1-philmd@redhat.com>
 <20191108144042.30245-3-philmd@redhat.com>
 <ead1eb4b-a0e0-edf9-8323-ce9f5a291547@redhat.com>
 <bffde73d-cc1a-dcea-2e5d-7128bda7abf9@redhat.com>
 <0a1b0182-d91e-ac9f-3c4e-aad53ee794b8@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5840cd82-2494-e61b-f61d-4713594e00a9@redhat.com>
Date: Mon, 18 Nov 2019 13:15:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0a1b0182-d91e-ac9f-3c4e-aad53ee794b8@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: qSlJeuxzPrq_6Heez4LfKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 1:10 PM, Philippe Mathieu-Daud=C3=A9 wrote:

>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_gt64120_write("INTRC=
AUSE", size << 1, val);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_gt64120_write("INTRC=
AUSE", size << 3, val);
>>>
>>> Again, this isn't mentioned in the commit message.=C2=A0 Why are you=20
>>> changing parameter values?
>>>
>>>
>>>> +++ b/hw/mips/trace-events
>>>> @@ -1,4 +1,4 @@
>>>> =C2=A0 # gt64xxx.c
>>>> -gt64120_read(const char *regname, int width, uint64_t value)=20
>>>> "gt64120 read %s value:0x%0*" PRIx64
>>>> -gt64120_write(const char *regname, int width, uint64_t value)=20
>>>> "gt64120 write %s value:0x%0*" PRIx64
>>>> +gt64120_read(const char *regname, int width, uint64_t value)=20
>>>> "gt64120 read %s width:%d value:0x%08" PRIx64
>>>> +gt64120_write(const char *regname, int width, uint64_t value)=20
>>>> "gt64120 write %s width:%d value:0x%08" PRIx64
>>>
>>> Huh, we were really broken - the old code (if passed to printf) would=
=20
>>> try to parse 4 parameters, even though it was only passed 3.=C2=A0 But =
it=20
>>> looks like you still need a v3.
>>
>> Oops. I am surprise the compiler doesn't emit a warning here...
>=20
> I'm sorry I can't see the 4th parameter.

My fault for chasing a red herring.  I guess I was mixing the three %=20
post-patch with the two % and one * pre-patch, and somehow mis-counting=20
three % plus one * as four arguments.  But re-reading your confusion,=20
yes, there were only three parameters being consumed.

>=20
> Before: "gt64120 read %s value:0x%0*" PRIx64
>=20
> #1 's' for 'const char *regname'
> #2 '0*' for 'int width'
> #3 'x' for 'uint64_t value'
>=20
> After: "gt64120 read %s width:%d value:0x%08" PRIx64
>=20
> #1 's' for 'const char *regname'
> #2 'd' for 'int width'
> #3 '08x' for 'uint64_t value'
>=20
> Am I missing something?

Rather, I was.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


