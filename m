Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C579C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CF321835
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 16:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNcPD3er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CF321835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihG8X-0002hj-81
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 11:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihG3b-0004LJ-Dk
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihG3Z-0005ka-O6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:50:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51408
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihG3Z-0005jG-JF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 11:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576601443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hxi4TFPUAhXySks0MDg1YAzEzstwrloAcjIJSqHZj1U=;
 b=XNcPD3erCJ2pmg2N3rgG5QJrwu0bulGZqdXzv8una6NNhXrnwJwOtXjaZVj/iNoZLzJ1gI
 jibt//3mUsKmVCclpB+sLIFooXU8PUUJA2YHY07jKH3e2Sm35u3WA0Ij87JcOZ6vEgXSLw
 ITR49mt3vhBvv3ABxVYdSoumV5QcqOk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-_4vmNwiONZ6GyUXw8_zGEA-1; Tue, 17 Dec 2019 11:50:42 -0500
Received: by mail-wm1-f72.google.com with SMTP id l11so963742wmi.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 08:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aQejgbF//N7qVjT/SefZZofdV97veJrrkximXLqTP+A=;
 b=Bvkedte1kTQTQVqV72hvOsIMMPV9DxJMTqwqh6mDO3NIa19SXUak7Woz4finH2RIEP
 kh9ug0TqxcKYuHyDkfJjYJhXzZEMvaLDDtAN+lcrKp19yKCi6R+WEma5qmWZljse94JY
 MzAfamJ/CJsfqhmk2USS/X79DAW1XCSRw4QlXU1sNYTYB+inaElpgDvQMShc3WkHSd1i
 pUlZPk44vp1oZPlYl1liqvs/YHumZ/7IiNIo9PnsIm9iPuKlYnljBhOZDAjCrGFu6v6Q
 cr3VI18S121fwHE3+vTgWfMoN/yx00DSsoYfOsBzRwS4DYfrZdOV7sOboRU7Zx/479Ki
 97Ig==
X-Gm-Message-State: APjAAAXr2PRvZ6AFDtFsmHAasKoSjl9WV3OMgt7nBijbLSZ6aW23IgJo
 Om0PHSBrkJWupY3r7HmFTdurYBjpM2ikYaB4zxfnfOWHOvHtBTNtfmu7xOEsKRlF/8zDKW+qs5b
 et7itvj2kj3EAics=
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr40284773wrr.74.1576601440827; 
 Tue, 17 Dec 2019 08:50:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMWX+DFZaPRiAJdgMUIPC3pOtgwgD77koA4kzYE32onbQoSruQixU1C2EpCg2MAQDxpzSFXg==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr40284727wrr.74.1576601440590; 
 Tue, 17 Dec 2019 08:50:40 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id s1sm3636122wmc.23.2019.12.17.08.50.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 08:50:39 -0800 (PST)
Subject: Re: [PATCH 00/14] chardev: Use QEMUChrEvent enum in IOEventHandler
 typedef
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20191217163808.20068-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <154a68ee-c683-d5c5-dad8-df483aa00c20@redhat.com>
Date: Tue, 17 Dec 2019 17:50:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217163808.20068-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: _4vmNwiONZ6GyUXw8_zGEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paul Burton <pburton@wavecomp.com>,
 Jason Wang <jasowang@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alberto Garcia <berto@igalia.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, Joel Stanley <joel@jms.id.au>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Michael Walle <michael@walle.cc>,
 Palmer Dabbelt <palmer@dabbelt.com>, Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 5:37 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> After this chat on #qemu IRC:
> 13:20 <stsquad> so what is the difference between a IOReadHandler and IOE=
ventHandler?
> 13:25 <f4bug> stsquad: one is in-band and the other out-of-band?
> 13:26 <stsquad> f4bug: ahh yes it seems so - connect/disconnect etc...
> 13:27 <f4bug> see QEMUChrEvent for IOEventHandler
>=20
> I thought it might be a good opportunity to make the IOEventHandler
> typedef meaning more obvious, by using the QEMUChrEvent enum.
>=20
> To be able to build I had to explicit a 'default' case when frontends
> use a switch(event) case and do not handle all events.
>=20
> Then I used a coccinelle spatch to change the various IOEventHandler.
> I don't think the last patch can be split, but suggestions are welcome!
>=20
> Regards,
>=20
> Phil.
>=20
> PD: I use git-publish. To avoid spamming too much, I'm using per-patch
> Cc tag, after the '---' separator. This way each recipient should get
> the cover and the specific patches of interests, + the last one.
>=20
> Sent with: 'git publish --suppress-cc=3Dcccmd'

While 'git-publish --verbose' show it was adding recipient from the tags:
(mbox) Adding cc: ...
(mbox) Adding cc: ...

It still sent each patch to everybody from the cover:
Server:
MAIL FROM:
RCPT TO: ...
RCPT TO: ...

Maybe the list was cached in the tag and I should have use the=20
--override-cc flag too:

   --override-cc     Ignore any profile or saved CC emails

I apologize for the no-relevant patches I spammed you with :(

> Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: KONRAD Frederic <frederic.konrad@adacore.com>
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Alberto Garcia <berto@igalia.com>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Thomas Huth <huth@tuxfamily.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: Paul Burton <pburton@wavecomp.com>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Zhang Chen <chen.zhang@intel.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: qemu-s390x@nongnu.org
> Cc: qemu-riscv@nongnu.org


