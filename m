Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923A2C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E572087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMp8T/SF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E572087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopye-0001ym-Nw
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iopx3-0008DC-Dz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iopx2-0002E4-7q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:35:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53155
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iopx2-0002Da-4W
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578407719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=XufDugD6uYUlfBGd82PuKlgRYcjdnsQKOQ7nhUL8Mgc=;
 b=fMp8T/SFONMTS1Hwn4IQhEeL/mABrwdmSHM/CE9Auq9wj8fpXIfisZCeaY8EuMHdwXzWtS
 InMYHhtchooQtmG2Qv2uMJppFf8bUmZCHhI+tlj838wJLFmxLoSrrb7bThdpxD0z0aiAtF
 e1sxZXlbRAWbAs7tdZORq/4d4UGmuDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-2JdSoVrhPn-gRS9nxHzlnw-1; Tue, 07 Jan 2020 09:35:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5102F802CA6;
 Tue,  7 Jan 2020 14:35:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E13E7DB3E;
 Tue,  7 Jan 2020 14:35:08 +0000 (UTC)
Subject: Re: Priority of -accel
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com>
 <2ae2dee3-cd16-a247-971b-4b3482e596a5@redhat.com>
 <20200107142735.GC3368802@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fb83df0a-da82-f981-fbda-d5c74e87cf5c@redhat.com>
Date: Tue, 7 Jan 2020 15:35:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107142735.GC3368802@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2JdSoVrhPn-gRS9nxHzlnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/2020 15.27, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jan 07, 2020 at 03:20:40PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 1/7/20 3:14 PM, Thomas Huth wrote:
>>> On 07/01/2020 13.54, Daniel P. Berrang=C3=A9 wrote:
>>>> On Tue, Jan 07, 2020 at 01:23:18PM +0100, Paolo Bonzini wrote:
>>>>> On 07/01/20 13:18, Thomas Huth wrote:
>>>>>> I don't think we need a separate priority parameter here. But IMHO i=
t's
>>>>>>   really rather common practice to prioritize the last option. So wh=
ile
>>>>>> it might be more "self-explanatory" to a CLI newbie if the first
>>>>>> occurrence got the highest priority, it might be rather confusing
>>>>>> instead for a CLI veteran...?
>>>>>
>>>>> Prioritising the last certainly makes sense for a choose-one-only
>>>>> option, but I'm not sure it's the same for a choose-best option.  Aft=
er
>>>>> all it was -machine accel=3Dkvm:tcg, not -machine accel=3Dtcg:kvm...
>>>>
>>>> IIUC, the main use case for specifying multiple accelerators is
>>>> so that lazy invokations can ask for a hardware virt, but then get
>>>> fallback to TCG if not available. For things that should be platform
>>>> portabile, there's more than just kvm to consider though, as we have
>>>> many accelerators.  Listing all possible accelerators is kind of
>>>> crazy though no matter what the syntax is.
>>>>
>>>> How about taking a completely different approach, inspired by the
>>>> -cpu arg and implement:
>>>>
>>>>      -machine accel=3Dbest
>>>
>>> Something like that sounds like the best solution to me, but I'd maybe
>>> rather not call it "best", since the definition of "best" might depend
>>> on your use-case (e.g. do you want to use a CPU close to the host or
>>> something different which might be better emulated by TCG?).
>>>
>>> What about "-accel any" or "-accel fastest" or something similar?
>>
>> 'any' is a russian roulette, you don't want it to return 'qtest' ;)
>=20
> We could make it return "qtest" only on April 1st ;-P

... or we finally dare to let QEMU chose the "best" accelerator by
default if no "-accel" option has been specified...

Thus if no "-accel" has been specified, then use kvm/haxm/whpv if
possible or TCG otherwise. And if "-accel" has been specified, then only
use that accelerator and don't allow a second "-accel" to be specified.

 Thomas


