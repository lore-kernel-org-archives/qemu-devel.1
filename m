Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E2AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBAEE23401
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAEE23401
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Aew-0004vm-0z
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5Ae1-0004RV-Ro
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5Adz-000503-Uu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5Adz-0004x5-JB
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:22:55 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A01B13CA04
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 15:22:53 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id v4so4454691wmh.9
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hlocbJydmXzABs787wRVmXJbj/WGxNwRyjtCBjOT8wg=;
 b=lr+EfdyWQszy8WVQ/41LSizExsjH2du1+FvsFIFcQOjyl0LVbjH/WEBa2eFCQxcYZE
 NxQ8aNxWi6rB70X9WOkmn+VPZN4sAkpqSD51hH4wqNXW1+PnAjcgQNqk1pnKro4aTJiR
 /m1Bxdx2PlO90HxkT5vIX3OfZFlrT0Vy7PWN9I79UT7+zPWXqz1Xh1qOLvuzguNVHno2
 jwuhKpxPjwpIH89JvYDGkatoFCeuew8JSzbXHAF6dogwEjhz7+Dis6Kmv7se8JL3Rb58
 PIlFEYuBK6shTBnZdveya0nPcFpiGcfwbyCg7vDLctlWiDi+OdqopHxleZTOvbXmYF3S
 daaQ==
X-Gm-Message-State: APjAAAUPFF6Eh0bVDNe6SD0liG7c1Z8Oxaq3Pu+XFGIsZA9jU/atAMjk
 FmmY1auvMOIB77FtUl7OnDWNK3VFj6ycrpHYfhL0gTWjRWYGlvhbvYcnVFNTWReragzhlEvI9LD
 AGWhrQzJNK1cF7rA=
X-Received: by 2002:a05:6000:128d:: with SMTP id
 f13mr45010845wrx.241.1567524172109; 
 Tue, 03 Sep 2019 08:22:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx/4S5cfLFpihLPZGqZNKXpCIADT5yOG4sgK0lbKVpTConVx0o9+dCVZmtrrgX03+02w+Rkwg==
X-Received: by 2002:a05:6000:128d:: with SMTP id
 f13mr45010677wrx.241.1567524171099; 
 Tue, 03 Sep 2019 08:22:51 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id u17sm19254405wru.25.2019.09.03.08.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2019 08:22:50 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190829015117.GH16342@umbus.fritz.box>
 <20190829032746.GA488@localhost.localdomain>
 <24d0d5be-d206-33a0-cd8c-29825e2f8516@redhat.com>
 <ecfc63f3-d208-4a79-c26c-3d8fa031b3d3@redhat.com>
 <20190903150824.GA14836@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <db34f470-5983-7965-c5b4-2b624fbe8e1b@redhat.com>
Date: Tue, 3 Sep 2019 17:22:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190903150824.GA14836@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: ldoktor@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/19 5:08 PM, Cleber Rosa wrote:
> On Thu, Aug 29, 2019 at 11:46:15AM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>>
>> class avocado.utils.ssh.Session(address, credentials)
>>
>>   Parameters:=09
>>
>>     credentials (tuple)
>>          username and path to a key for authentication purposes
>>
>> The current test uses username + password.
>> Can we use this credentials with the Avocado module?
>> (The image used is prebuilt).
>>
>=20
> I'm working on adding password based authentication.  To keep the API
> the same, I'm thinking of checking if the second credential item is an
> existing file, if it is, assume one containing a key.  If not, assume
> it's a password.

Why not use a dictionary? Keys would be explicit.

> This should make the use simple in the case of keys:
>=20
>   with Session(('hostname', port),
>                ('username', '/path/to/key')) as session:
>       session.cmd('cmd')
>=20
> And passwords:
>=20
>   with Session(('hostname', port),
>                ('username', 'p@ssw0rD')) as session:
>       session.cmd('cmd')
>=20
> It's being tracked here:
>   https://trello.com/c/uetpIgML/1517-avocadoutilssh-implement-password-=
based-auth
>=20
> I'll try to have it in Avocado's 72.0 release due next week.
>=20
> Let me know how that sounds, and thanks for the feedback.
> - Cleber.
>=20

