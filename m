Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CE9C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878682087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsWi7Llb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878682087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUsx-00040c-J0
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isUoS-0008J9-HN
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isUoR-0007Zg-CX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:49:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41176
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isUoR-0007Ys-8d
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579279774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1i0TrjmZWk4Y8+IXwLsz469Jrb/ujIx/jGF3WThVvY=;
 b=AsWi7Llb2saT0rfJLL6ktDIsImsXzijwDY8GRtT3UpyPKtZ57X2vtpMWhSt5GL6cwVcPH4
 OFXdRyuy06DkHLukClxCWhlG4aLfYyUvsJwMfPXY2heIB7qDRPVF7cRpS8hCglt5wQ25Zi
 iyL33dmgbRprsXR/xPjiRP7i/l4jbWc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-DO4ne7EONTO9hgyUbeJGIw-1; Fri, 17 Jan 2020 11:49:32 -0500
Received: by mail-wr1-f69.google.com with SMTP id 90so10651403wrq.6
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 08:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uwsWBP5APVkiEkZvoVPfakLlRO+TI3JrF1L3Mfoehg4=;
 b=PCsHn8uzS/turyWEnX8KkmwxN94m2sfMJYvwIAZCBJ4vd6eV1mUonODm0LmbGlyBre
 P3gV8uouz4F3qaq7hdtYTmrZJqdXwOq+OIDgUGJdvlkyAN3kOpwdDEztsU08Ilw8MpCE
 OqdZPCKPQJ1nfoIMtEvkvDZkcpA8h7+PUDE0tQ6PtJ0okqOQSqiWejA5EAtxWlraXC/x
 /qRkBhMo+n3tuoaC7/F4PmspWWJbeQGOJ5p9fZ2YDgyAg3P/4ekKJz3qsiEKqgSgIeKh
 aKky/5KSL9gRt2Jpy/rPgUfJZRUKRE0grth++wUVma5AWkpaIzM/csR3HRAjuaJ8qCzS
 khMQ==
X-Gm-Message-State: APjAAAVUZp3F+30eHaAN1tpAW7WIYrYDqshnaJMp/BZ4QI2WwYBqm6rU
 6wuua15e8aIIHebV9Mhxrb7Ozi4rZYPcSV8/tJ7CGkwF5Qet3wgkB3aZAxcaiyAOwY0FzsUiFA0
 1kQ72sMkaev7F6IU=
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr5972714wmg.16.1579279771240; 
 Fri, 17 Jan 2020 08:49:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwe9UwVgBBb4fRK/BZi3d5YJLNGONFcl+o8Wy2obWPTPHnGB5gT16iBiMz9Jir/+oiaUNxUdw==
X-Received: by 2002:a1c:dc85:: with SMTP id t127mr5972693wmg.16.1579279771023; 
 Fri, 17 Jan 2020 08:49:31 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id q6sm36303363wrx.72.2020.01.17.08.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 08:49:30 -0800 (PST)
Subject: Re: [PATCH v2 00/86] refactor main RAM allocation to use hostmem
 backend
To: Igor Mammedov <imammedo@redhat.com>
References: <157912207219.8290.12574147223674937177@37313f22b938>
 <b81ad35f-73d0-a333-d0fe-758e64242ca2@redhat.com>
 <20200117170340.7e91ff8c@redhat.com>
 <8ca4cae4-8399-73df-c3f3-78ee857ec954@redhat.com>
 <20200117174021.7a2d4cc8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5b8f3fd-7071-2140-23db-43f0f9d98d01@redhat.com>
Date: Fri, 17 Jan 2020 17:49:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117174021.7a2d4cc8@redhat.com>
Content-Language: en-US
X-MC-Unique: DO4ne7EONTO9hgyUbeJGIw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: no-reply@patchew.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 5:40 PM, Igor Mammedov wrote:
> On Fri, 17 Jan 2020 17:19:26 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/17/20 5:03 PM, Igor Mammedov wrote:
>>> On Thu, 16 Jan 2020 16:43:07 +0100
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>>   =20
>>>> On 1/15/20 10:01 PM, no-reply@patchew.org wrote:
>>>>> Patchew URL: https://patchew.org/QEMU/1579100861-73692-1-git-send-ema=
il-imammedo@redhat.com/
>>>>>
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> This series failed the docker-quick@centos7 build test. Please find t=
he testing commands and
>>>>> their output below. If you have Docker installed, you can probably re=
produce it
>>>>> locally.
>>>>>
>>>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>>>>> #!/bin/bash
>>>>> make docker-image-centos7 V=3D1 NETWORK=3D1
>>>>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>>>
>>> it doesn't work on my host, since it tries to use /tmp for building an =
image
>>> and fails with no space.
>>> is there any way to point it to some other place?
>>
>> What is failing? Building the docker image, or building QEMU withing the
>> docker container?
>=20
> docker image

Odd. I thought image was built in default storage dir: /var/lib/docker

# docker system info | fgrep /
Docker Root Dir: /var/lib/docker

The default might be distrib dependent, my workstation is on Fedora.

Maybe while building a tmpfs is mount as /tmp within the temp container,=20
and your ram is limited so it gets full while downloading packages to=20
install? Sincerely I have no clue. Docker is not your friend :/

Here they say you can change the docker dir with '-g'
https://forums.docker.com/t/how-do-i-change-the-docker-image-installation-d=
irectory/1169/4

Can you paste the error context?


