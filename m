Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D661C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19ED2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19ED2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Pdu-000083-2E
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3Pcq-00083l-Vr
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3Pco-0004zz-TQ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:58:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3Pcm-0004xV-Uw
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:58:25 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69002806CE
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:58:23 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id n6so687538wrm.20
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B5J5Q6h/5C0M8D+pa+BJrlSf2L9EE990l86u2lww1yY=;
 b=DDPn/fqmuUn+Nz5kP7jh+qXFlJG4BhyUmHZdQnh+roofifAcn34MUcEK/w8RyPyBH+
 IAbXSNW45qoHDYLgDZ9oOIomo5v0FmNzJSd9xXgUz4W6pEyYkxi0SNcifMdtMyS+4HeB
 GXBfj5gONMriXtaTsY3ecl329QOHN4MpuPDx3JfD5DSj7TMhvU9YqVSxngkN4WXK9ixB
 9kkVHPvlF9RGwjXldFkCxtpffqIVSgjCjCuleKY9vnEtEX9OCq+Gx/inaZiQxMWi0axN
 QUqPsswZzZQ3YeGFYxYHTc+ot50duesFDZ9N9t3N7c5jfJdsW5ONgQnoi7io68HQYUkx
 ymcw==
X-Gm-Message-State: APjAAAXM5ujr8luzVROn/0FOD+rsJMe2fkUQRsACGl9CoYtrNqLCpiyj
 Cl3z171iN2iWk0FpAx9PvHYcUex6GR4cZi8T0LyVwGSYdZi1ShbN4GH+drOH/HW2pyW6PoJ56ZA
 CGA8YiMq9TSP3Kh8=
X-Received: by 2002:a5d:4950:: with SMTP id r16mr13286784wrs.347.1567105102240; 
 Thu, 29 Aug 2019 11:58:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQ3vXuOyp0TG8F9iJDGfwTT51wBg0KtK/KP94PVGtZoa2hX+ZTz2jaC6f2J8sMX4t+z9xtQg==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr13286779wrs.347.1567105102076; 
 Thu, 29 Aug 2019 11:58:22 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id d17sm5271153wrm.52.2019.08.29.11.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 11:58:21 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190820235243.26092-1-jsnow@redhat.com>
 <20190820235243.26092-2-jsnow@redhat.com>
 <5c7555f2-fba0-29fc-8bcd-bc68e5b42c63@redhat.com>
 <41d1edcf-ed61-6287-1019-4f779ffa3c79@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <98ac0bd1-6c36-b053-916d-17cd65a446d1@redhat.com>
Date: Thu, 29 Aug 2019 20:58:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <41d1edcf-ed61-6287-1019-4f779ffa3c79@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/4] iotests: add script_initialize
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 8:43 PM, John Snow wrote:
> On 8/29/19 2:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> This restrict test 208 to the Linux platform, is this OK?
>>
>> The rest looks good.
>=20
> I forgot about that, so good catch.
>=20
> I don't know. We seem to already restrict a LOT of tests to the Linux
> platform. Does this one actually work on other platforms?
>=20
> Actually, I can't see any other supported oses/supported platforms call=
s
> anywhere in iotests that don't just specify Linux or leave it the
> default (...which is also linux.)
>=20
> There isn't a way to engage the old-style python unittest framework
> without implying Linux; you have to manually override it if so.

Then let's use:

    iotests.script_initialize(supported_oses=3D[])

and call it a day?

>=20
> For new tests, MOST of them specified Linux in some way or another, as
> you saw.
>=20
> So either:
> - 208 was an oversight, or
> - Many tests are accidentally limiting to Linux and could be loosened.

This can stay in your TODO for after this painful series.

> Which is it? Dunno. Guess I'll look at the VM tests to see if I can
> co-opt some of that... stay tuned?
>=20
> --js
>=20

