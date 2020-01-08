Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B850C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E55206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZd62MwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E55206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip96Y-0002DA-0P
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ip93D-0007RO-Gj
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ip93C-00037O-B8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:58:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24257
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ip93C-000377-88
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578481137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=kqLzPHnOBz0GvDYzxg1Y0gsqDEBWC/JehSDzf5oZ3+8=;
 b=HZd62MwPUtP3ChqfXgin5fCJolTQ42lv53K9A0YAlc9M+uuecPCp2niAzlPxcnDLasXqD3
 X2pzxs81c28rElUhNIo57GLHrFtibcXLNjYOtjMh1QV/Rucsm3qzYFe2GZF57ufT9yhLlt
 6B9GrBZgda3+RnCTe40twOiSuY3h0o8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-pLEatL-hMMq6KMJr1PYfbw-1; Wed, 08 Jan 2020 05:58:57 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E20C410054E3;
 Wed,  8 Jan 2020 10:58:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-114.ams2.redhat.com [10.36.117.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BB43649C1;
 Wed,  8 Jan 2020 10:58:48 +0000 (UTC)
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com> <87d0bujkpe.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <da2111ee-0644-1d7c-a111-e4209025a1d8@redhat.com>
Date: Wed, 8 Jan 2020 11:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87d0bujkpe.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: pLEatL-hMMq6KMJr1PYfbw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/2020 11.39, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 07/01/2020 13.54, Daniel P. Berrang=C3=A9 wrote:
>>> On Tue, Jan 07, 2020 at 01:23:18PM +0100, Paolo Bonzini wrote:
>>>> On 07/01/20 13:18, Thomas Huth wrote:
>>>>> I don't think we need a separate priority parameter here. But IMHO it=
's
>>>>>  really rather common practice to prioritize the last option. So whil=
e
>>>>> it might be more "self-explanatory" to a CLI newbie if the first
>>>>> occurrence got the highest priority, it might be rather confusing
>>>>> instead for a CLI veteran...?
>>>>
>>>> Prioritising the last certainly makes sense for a choose-one-only
>>>> option, but I'm not sure it's the same for a choose-best option.  Afte=
r
>>>> all it was -machine accel=3Dkvm:tcg, not -machine accel=3Dtcg:kvm...
>>>
>>> IIUC, the main use case for specifying multiple accelerators is
>>> so that lazy invokations can ask for a hardware virt, but then get
>>> fallback to TCG if not available. For things that should be platform
>>> portabile, there's more than just kvm to consider though, as we have
>>> many accelerators.  Listing all possible accelerators is kind of
>>> crazy though no matter what the syntax is.
>>>
>>> How about taking a completely different approach, inspired by the
>>> -cpu arg and implement:
>>>
>>>     -machine accel=3Dbest
>>
>> Something like that sounds like the best solution to me, but I'd maybe
>> rather not call it "best", since the definition of "best" might depend
>> on your use-case (e.g. do you want to use a CPU close to the host or
>> something different which might be better emulated by TCG?).
>=20
> Indeed - you may well want to do TCG on Aarch64 if you want to test new
> instructions.
>=20
>>
>> What about "-accel any" or "-accel fastest" or something similar?
>=20
> "any" is just ambiguous, "fastest" is just begging for me to find a
> micro-benchmark that TCG outperforms on ;-)
>=20
> "-accel default" could be considered to have vibes of Do The Right
> Thing (tm) and could in time actually become so!

"-accel default" sounds like the default behavior that you'd also get if
you don't use this option at all ... what about "-accel auto" to say
that QEMU should pick an accelerator automatically?

 Thomas


