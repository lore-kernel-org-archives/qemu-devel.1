Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60005C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29981208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwQBEO6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29981208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqJB-0005rD-PY
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iopL2-0000fg-3g
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iopL0-0003rq-0u
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:56:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37822
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iopKz-0003rM-Sl
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578405361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MI7Lxmg8no2HXeqhClaxscebjE/j8XvsCkkSPA8C4o=;
 b=NwQBEO6cgSF3kFp1DD9gvT1iM7brBApC/EpayLeSSOPAvP6NCeAhK3ZkEEaJi0HMwQfqHp
 HVzw4SUDHUJ8lb9H15itB0jL3fAPLXZwu2g6KG9j5abTX0X2NmvOcp+KQIa3ZZKYg+IOWG
 xs73h3FyRHQTf6utUhEQClKAZ/EgZjA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-MxMa9e7RMVmmzinFNFQknw-1; Tue, 07 Jan 2020 08:55:58 -0500
Received: by mail-wr1-f70.google.com with SMTP id y7so28770094wrm.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Pyh8yFqLK644qpz9EflJPGt6BofuTw8JlPFAd1ZqhTw=;
 b=P2F//1ThxTuLQhLE/jyclsoaZUflXFhWBdJanvu0faDCI2176lUrciGT2gNPSKsGU6
 VO7NtIg+Ht+NcHalQhUUTAH/qCQJrznXCYlZYnHo/+/1RO/rMnIfwEReyQt6X67xW6al
 vYyJSQ2EpiYC9fBQ7oTbvP492ERymgvr6TpHrRgTXjBb/PYNhDA+LONfaaTNxvxEfKC8
 UbGo57++3i8UJx96IQ6OwP1rrCySpTzuhv2F7jg6Fm9m3HcEZnWR383uEwo3bOHQcJws
 3a+2Sp2+LH16Gi0L5Qqyl1As0SSdvc5Bgs5wocBtCFvnzEILT2JsSShwz81YCb1qsbl9
 H+Ug==
X-Gm-Message-State: APjAAAUU3ZMHqPBN2qoCmMrbxYBvpYpgb8src0izVgeFMaaB3mQop1hW
 zDQl1R7SqbP50MNPg97fxOu8AfjGIisEKC0puAnfQ4GomEY4ZmfNfrKXUEY8MvSMwpOdsRh20t6
 5WtBYBf77a7qPvWQ=
X-Received: by 2002:adf:e641:: with SMTP id b1mr108603390wrn.34.1578405357031; 
 Tue, 07 Jan 2020 05:55:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzkG9hviFFPPqmQzJYYcYCiwKL7K1J8UONm/g5vt2bwX+8v+gpsrtu8W2yHY0aDrGGb8E/okA==
X-Received: by 2002:adf:e641:: with SMTP id b1mr108603373wrn.34.1578405356793; 
 Tue, 07 Jan 2020 05:55:56 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:8d4b:4003:dcb:4c70?
 ([2a01:e0a:466:71c0:8d4b:4003:dcb:4c70])
 by smtp.gmail.com with ESMTPSA id n3sm75470686wrs.8.2020.01.07.05.55.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jan 2020 05:55:56 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
Date: Tue, 7 Jan 2020 14:55:55 +0100
Message-Id: <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: MxMa9e7RMVmmzinFNFQknw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 7 Jan 2020, at 11:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 07/01/20 11:03, Thomas Huth wrote:
>>>=20
>>> vm =3D QEMUMachine(iotests.qemu_prog)
>>> -vm.add_args('-machine', 'accel=3Dkvm:tcg')
>>> +vm.add_args('-accel', 'kvm', '-accel', 'tcg')
>> Looking at this, I wonder whether we really want the "-accel" option to
>> prioritize the accelerators in the order of appearance? A lot of other
>> CLI tools give the highest priority to the last parameter instead, e.g.
>> "gcc -O3 -O1" compiles with -O1, and not with -O3.
>>=20
>> Also I think it might be quite common that there are shell scripts which
>> call "qemu-system-xxx -accel xyz $*" ... and if we don't invert the
>> priorities of -accel, it will be impossible to override -accel in that
>> case...
>=20
> Hmm, it does match "-machine accel=3Dkvm:tcg" and in general I think it's
> more self-explanatory.  However, it is indeed less friendly to scripts.
> On one hand those could be changed to place "-accel xyz" after $* (or
> better "$@"), on the other hand we could also add a priority option to
> "-accel".  What do you think?

I tend to agree with Thomas=E2=80=99 assessment that in general, later opti=
ons
tend to override earlier ones, if only because that=E2=80=99s typically how=
 getopt
works with the typical usage of setting global variables.

I also agree that when it=E2=80=99s a single list given to an option, then =
it
generally makes more sense to interpret the later ones as a =E2=80=9Cfallba=
ck=E2=80=9D
if you could not get the previous ones. Which I believe gives me a
hint of what the intent of specifying multiple options would be=E2=80=A6

So what about ranking the accelerators, so that all combinaisons
-accel=3Dkvm:tcg, -accel=3Dtcg:kvm, -accel kvm -accel tcg, etc would
all pickup kvm if available, and tcg as a fallback? Implementation-wise,
it would simply mean ranking the accelerators and updating the accelerator
only if it=E2=80=99s available and better.

To allow full override, we might add something like -accel reset
to reset to the default, i.e. as if no option had been given.

I personally don=E2=80=99t like =E2=80=9Cpriority=3Dn=E2=80=9D being explic=
it on the command-line
because that IMO pushes the problem of ranking the accelerators
to the user, without guidance on how to do that. For example, if I
have a script that reliably overrode before, then it might stop
overriding because the inner script has set priority=3D2, so I put
priority=3D3, not knowing that the maintainer thinks my override
broke something, so the inner script maintainers escalates to
priority=3D4 to =E2=80=9Cfix=E2=80=9D my priority=3D3. In the end, the whol=
e universe
crumbles or something equally unpredictable.


Cheers,
Christophe

>=20
> Paolo
>=20
>=20


