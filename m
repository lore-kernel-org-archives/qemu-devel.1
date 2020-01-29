Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5CAC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC5A20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJtPGe/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC5A20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhwk-0005qb-Bt
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwhvq-00052B-Qp
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwhvp-00077S-JT
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:38:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52639
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwhvp-00075i-FU
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580283517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=T4pGt8pGq7Kl7bks7o78r5gZDF6rvAKermHfNWw/ozU=;
 b=eJtPGe/Uln72yhnmqayceF2UnC178ca/I5x7Lw5mKaLdDF5DrFNo3pV32mdUtgCHk6FXXD
 mvK5h8BoXlps6H5QeCMnvE2gRtYRMwf+f7OXzjhy7dKdJB5k2DF90HeEoLrob4zcsIi54+
 Rc4jmQiuExyECrGScv54XcB535ODKAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-_K-HbwWaN-uN-tsRZCi0SA-1; Wed, 29 Jan 2020 02:38:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFDC28017CC;
 Wed, 29 Jan 2020 07:38:31 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B1901CB;
 Wed, 29 Jan 2020 07:38:27 +0000 (UTC)
Subject: Re: [PATCH] .travis.yml: Add description to each job
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200125183135.28317-1-f4bug@amsat.org>
 <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com> <874kwfg2qh.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <71ee9c2b-df6b-f82c-83ad-0679de969eba@redhat.com>
Date: Wed, 29 Jan 2020 08:38:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <874kwfg2qh.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: _K-HbwWaN-uN-tsRZCi0SA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/01/2020 13.55, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 25/01/2020 19.31, Philippe Mathieu-Daud=C3=A9 wrote:
>>> The NAME variable can be used to describe nicely a job (see [*]).
>>> As we currently have 32 jobs, use it. This helps for quickly
>>> finding a particular job.
>>>
>>>   before: https://travis-ci.org/qemu/qemu/builds/639887646
>>>   after: https://travis-ci.org/philmd/qemu/builds/641795043
>>
>> Very good idea, correlating a job in the GUI to an entry in the yml file
>> was really a pain, so far.
>>
>>> [*] https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-=
within-matrices
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  .travis.yml | 101 ++++++++++++++++++++++++++++++++++------------------
>>>  1 file changed, 67 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 6c1038a0f1..d68e35a2c5 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -94,24 +94,28 @@ after_script:
>>> =20
>>>  matrix:
>>>    include:
>>> -    - env:
>>> +    - name: "[x86] GCC static (user)"
>>
>> Could you please drop the [x86] and other architectures from the names?
>> Travis already lists the build architecture in the job status page, so
>> this information is redundant.
>=20
> Hmm for me the Travis page mis-renders the architecture (on firefox) so
> I do find the arch in the text fairly handy.

That's really weird, I'm also using Firefox and it looks fine here!

>>>      # Alternate coroutines implementations are only really of interest=
 to KVM users
>>>      # However we can't test against KVM on Travis so we can only run u=
nit tests
>>> -    - env:
>>> +    - name: "[x86] check-unit coroutine=3Ducontext"
>>> +      env:
>>>          - CONFIG=3D"--with-coroutine=3Ducontext --disable-tcg"
>>>          - TEST_CMD=3D"make check-unit -j3 V=3D1"
>>> =20
>>> =20
>>> -    - env:
>>> +    - name: "[x86] check-unit coroutine=3Dsigaltstack"
>>> +      env:
>>>          - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-tcg"
>>>          - TEST_CMD=3D"make check-unit -j3 V=3D1"
>>>
>>
>> Off-topic to your patch, but aren't coroutines something that is only
>> used in the softmmu targets? If so, we could add --disable-user to the
>> above two builds to speed things up a little bit.
>=20
> I think --disable-tcg implies --disable-user as you can't run without
> it.

D'oh, of course you're right, --disable-tcg limits the targets to
*86-softmmu!

 Thomas


