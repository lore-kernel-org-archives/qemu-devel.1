Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4843AC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FA2218C3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FA2218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjKrc-0001Pr-E0
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 05:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45347)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjKps-0000Df-Qv
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjKpr-0007tf-9L
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:48:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hjKpq-0007sh-VG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:48:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so9281319wrs.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 02:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=dLmi6jaQ72O2wh/NvFKzSc8JvyUz4kqxHa86vT+K2es=;
 b=VJqh86kmcHSHOfER8xbVcflJT0r/4xzqv/G/DLMYEXEwmBYdmEBUyr/xnXhzWWTJIx
 Z57X5fqME/8QQ4egB8Byh0mKs+ZJwgG5jZ3BZKRmGLQ7L+0BgDLUNYf28fqxpE+gUHfw
 KiSxYFacvkZvcRjQkpVQRqPYPUNE7sV45pGMKrOHhnV713wLSx2oNjzYNX8Et9m4YjHv
 kjTitC7ddvqSzcD90kdU1l0EGZ2xYqHEEd4vwVYTzke7XnzN93vbqMGhiNq6bmQkRPmp
 lj6dsXP2cYTbHcnd28fEm7VeuxYSwL3uGDYm964jls43vxcAl15MW2z5j1I3bwR6lD5t
 Ohbw==
X-Gm-Message-State: APjAAAWV+WBf2x/3QsS/P0EqpCeOhrgc80Zvi1rtVFDukWTZLTuSekq1
 /xexLPULZuaUqVzCezv+eM8JD9rSAsw=
X-Google-Smtp-Source: APXvYqxW7Bj4qPWWMhNryNG+VP0Fy8GqcmAjPwM+jAx4p+Xy+aPCqvEi+eegyD1wqKnkiaJJFmR7uQ==
X-Received: by 2002:a5d:4642:: with SMTP id j2mr3019677wrs.211.1562320133593; 
 Fri, 05 Jul 2019 02:48:53 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id h8sm8081888wmf.12.2019.07.05.02.48.52
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 02:48:52 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190703171005.26231-1-philmd@redhat.com>
 <20190703172501.GI23082@redhat.com>
 <20190704102457.GE1609@stefanha-x1.localdomain>
 <20190704102837.GA24190@redhat.com>
 <20190705080717.GD10995@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8470a203-430b-1814-b2ef-6adf3fa739a6@redhat.com>
Date: Fri, 5 Jul 2019 11:48:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190705080717.GD10995@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aUl22ChN8BpGoc6E1XfyX28NidBumF8lP"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aUl22ChN8BpGoc6E1XfyX28NidBumF8lP
Content-Type: multipart/mixed; boundary="d654zXpQZrOZ7CEE9LiFH0a0KU86smqMv";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <8470a203-430b-1814-b2ef-6adf3fa739a6@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
References: <20190703171005.26231-1-philmd@redhat.com>
 <20190703172501.GI23082@redhat.com>
 <20190704102457.GE1609@stefanha-x1.localdomain>
 <20190704102837.GA24190@redhat.com>
 <20190705080717.GD10995@stefanha-x1.localdomain>
In-Reply-To: <20190705080717.GD10995@stefanha-x1.localdomain>

--d654zXpQZrOZ7CEE9LiFH0a0KU86smqMv
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/5/19 10:07 AM, Stefan Hajnoczi wrote:
> On Thu, Jul 04, 2019 at 11:28:37AM +0100, Daniel P. Berrang=E9 wrote:
>> On Thu, Jul 04, 2019 at 11:24:57AM +0100, Stefan Hajnoczi wrote:
>>> On Wed, Jul 03, 2019 at 06:25:01PM +0100, Daniel P. Berrang=E9 wrote:=

>>>> On Wed, Jul 03, 2019 at 07:10:05PM +0200, Philippe Mathieu-Daud=E9 w=
rote:
>>>>> @@ -306,6 +308,13 @@ bool trace_init_backends(void)
>>>>>      openlog(NULL, LOG_PID, LOG_DAEMON);
>>>>>  #endif
>>>>> =20
>>>>> +    trace_init_file(getenv("QEMU_TRACE_LOGFILE"));
>>>>> +    trace_init_events(getenv("QEMU_TRACE_EVENTFILE"));
>>>>> +    trace_env =3D getenv("QEMU_TRACE_EVENTS");
>>>>> +    if (trace_env) {
>>>>> +        trace_enable_events(trace_env);
>>>>> +    }
>>>>> +
>>>>
>>>> I don't think it is a nice idea to add this via environment variable=
s
>>>> to QEMU itself. Why not modify libqtest qtest_init_without_qmp_hands=
hake
>>>> to read the env vars and then pass a suitable -trace arg when spawni=
ng
>>>> QEMU ?
>>>
>>> What is the concern about adding these environment variables to QEMU?=

>>>
>>> It is convenient to be able to use tracing even if QEMU is invoked by=

>>> something you cannot modify/control.
>>>
>>> The main issues I see with environment variables are:
>>>
>>> 1. Security.  Is there a scenario where an attacker can use environme=
nt
>>>    variables to influence the behavior of a QEMU process running at a=

>>>    different trust level?
>>>
>>> 2. Name collision.  What is the chance that existing users already
>>>    define environment variables with these names and that unexpected
>>>    behavior could result?
>>
>> One of the biggest problems with QEMU in general has been poorly model=
led
>> & defined interfaces for configuration. At runtime we've solved this w=
ith
>> QMP. At startup we're still fighting the horror of QemuOpts in general=
 and
>> haven't got startup modelling to be on a par with that offered by QEMU=
=2E
>> It was even worse when Audio didn't even use QemuOpts and instead used=

>> an arbitrary set of poorly defined env variables. To me adding yet ano=
ther
>> way to configure QEMU via env vars is moving in the opposite direction=
 to
>> what we want.
>=20
> In this case the environment variables are optional and meant for cases=

> where the user cannot change the QEMU command-line.  I think they serve=

> a different purpose from the audio subsystem environment variables and
> I'd be happy to merge them.
>=20
> Philippe: Have you tried adding the environment variable to libqtest as=

> Dan suggested and did it work for your use case?

Yes, but we loose the ability to use this feature from linux-user and
other tools:

$ git grep trace_opt_parse
bsd-user/main.c:851:            trace_file =3D trace_opt_parse(optarg);
linux-user/main.c:387:    trace_file =3D trace_opt_parse(arg);
qemu-img.c:5063:            trace_file =3D trace_opt_parse(optarg);
qemu-io.c:579:            trace_file =3D trace_opt_parse(optarg);
qemu-nbd.c:862:            trace_file =3D trace_opt_parse(optarg);
scsi/qemu-pr-helper.c:969:            trace_file =3D trace_opt_parse(opta=
rg);
vl.c:3730:                trace_file =3D trace_opt_parse(optarg);

So I'm now mixed about the trade off regarding Daniel worries.


--d654zXpQZrOZ7CEE9LiFH0a0KU86smqMv--

--aUl22ChN8BpGoc6E1XfyX28NidBumF8lP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl0fHQMACgkQoqP9bt6t
wN7urA/+PmSHgC5kPVFIcHLJT9LZqWrk+nNCpbRc1ybpwcTUpmqQEV58yLXzFKKC
deb/Wfbz/FGp/VQPayloLC+s75HDuTojBpbRejZurX4GXqLJDY4QywhnJznXYtx1
LwoGFoPEtAe5BnskUQjln0I5yBE3mxH0PIz/GADzIEsKmWy0lm75D3Q5w9jooJr4
dBChwpKyTm5qeFezeV/epbBTKTtlI640lxCOLc4f0vg7DGKTHHqblafGghQX8KYd
pX+ziHMMJMUQfHZVUN4vUcjRioT6HXj8ZWO8XuCqCQVdc/eGRPlp5NvLUgdT5IP3
t9ezyE5jvhVEnB8532u3FfV0wCZ+VEpPokps8vigmXX+0Z9jyn6p/BnFIq7ZJEv0
ab/nSBgRXUJEmlZL6qvlmtrdcy74SaVK7dpYUEXWY9gHpNpqGkkqLUk4ag/endSI
kJXi8J4aOL6pgEx2a5urXDIGvrhIr8rv70pRVQnabi3USsoCn9WhdH9DxktWtO/f
lxhAXN2BJgZjNfy1FmcOMS8K5Gfz/ffTQI4dZOuTKBCHhL0QPIrlIKZW5XDTtgjq
xsPUR6/f84T0AZ4Mu5kpDG4LFbC7QyXlBHtrOhlnJJC0/6UncdTy1ktNGKZN96RU
D73d5+6vIZ380/AvLfg+qvN9EBo27BqHQiIBk+hcMNC6v4ajyeg=
=rkup
-----END PGP SIGNATURE-----

--aUl22ChN8BpGoc6E1XfyX28NidBumF8lP--

