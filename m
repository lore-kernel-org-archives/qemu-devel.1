Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60450C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA69217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 19:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxhGjDlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA69217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itcLA-0001ft-0h
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 14:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itcJY-0000Ln-DE
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itcJT-0006iz-78
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:02:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47607
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itcJT-0006iJ-3Y
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 14:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579546934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhCNMjX983nC8F7qVvCJbWLa8D2WM/aCqt/wvcrqF5c=;
 b=PxhGjDlhtapvcfZ1aw8X8GXk29gR1iKRiMSHCo+wELCQzamZEkmmPulU5+cRWhJg7FO5tL
 jcAVCMAGd6kS4WOHENetrj5BzYL9Ic92J1plGUBWYx2cWf0PO2H+PoJVkZplBIxDVdBf47
 Tw0YBnCW5QAJyxFnnxqv6CbpL3g2b1Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-kIsg5AqcOAqLl7499ktvEQ-1; Mon, 20 Jan 2020 14:02:13 -0500
Received: by mail-wr1-f71.google.com with SMTP id v17so191954wrm.17
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 11:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EJI/jxaTJNO4GsVuiSQITtTXsjQkBuso2rOaws0BmPk=;
 b=gBziaubxANLh/Mcpr6in2xRjZ72CnEIKJQbC2+VvpZzvOePbYovjZuqK1JbzGvtFFy
 bHjw9S5emNHkpedwzriKk6vYxsbgMJpf7jVQGJbuutAg7P0jPLvezMZfaB6cOZfFWT3o
 /6G31WikxS8X+E2x+2VMxmWQQfEdhuIEAQrCa3t+yWqERkMPxuPlwF0APyXhnmMDC/KP
 Dc59anYkR5FKDJnXlx6/gEeRv+lVSm9zLabDHNxrZFj3YOu/3d5lCiNiH3HIL8TB+/vT
 O+vVg0e4LM/Zc+Rat7T47LK47KndZ9npLDWNCgtTnzu+L4Yv8AQAfZ59U7D2hpspZYiX
 nu3A==
X-Gm-Message-State: APjAAAXI25qhSaTPa76XYyCUDr0GkImiFX2C11RQ1qHBEfx9ZQZ41G5R
 SVloKgafGvbu7zT3+02nlYeJclu0TBF9IhdULVpxZZ16ar5CHPqIVEuBPOXS/yZ6f3qds9Rc5Yu
 /ycr4oxBqOV42jTY=
X-Received: by 2002:a5d:448c:: with SMTP id j12mr886401wrq.125.1579546931856; 
 Mon, 20 Jan 2020 11:02:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2cZTFEZVZvE3m3/E8DIYUdIJXEOKgSXPPCBDN2N9+6dZ0ycPEn2e0TmzY3FIQfFgw8Qq0jA==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr886366wrq.125.1579546931571; 
 Mon, 20 Jan 2020 11:02:11 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s128sm391543wme.39.2020.01.20.11.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 11:02:10 -0800 (PST)
Subject: Re: [PATCH 0/6] Fix more GCC9 -O3 warnings
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
References: <20191217173252.4672-1-philmd@redhat.com>
 <84fthiaahd.wl-Peter.Chubb@data61.csiro.au>
 <87a77q9njk.fsf@dusky.pond.sub.org>
 <97c34bbd-79d2-070e-a35e-4fdf68b2e291@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db49a831-df35-c209-5db5-0631a5ef2497@redhat.com>
Date: Mon, 20 Jan 2020 20:02:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <97c34bbd-79d2-070e-a35e-4fdf68b2e291@redhat.com>
Content-Language: en-US
X-MC-Unique: kIsg5AqcOAqLl7499ktvEQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Hannes Reinecke <hare@suse.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 1/18/20 8:24 PM, Paolo Bonzini wrote:
> On 18/12/19 07:05, Markus Armbruster wrote:
>> "Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro.au>
>> writes:
>>
>>>>>>>> "Philippe" =3D=3D Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =
writes:
>>>
>>> Philippe> Fix some trivial warnings when building with -O3.
>>>
>>> For compatibility with lint and other older checkers, it'd be good to k=
eep
>>> this as /* FALLTHROUGH */ (which gcc should accept according to its
>>> manual).
>>
>> We have hundreds of /* fall through */ comments already.
>>
>>> Fixing the comments' placement is a different matter, and should be
>>> done.  Seems to me that until gcc started warning for this, noone had
>>> actually run a checker, and the comments were just for human info.
>>>
>>> Peter C
>>
>=20
> Queued, thanks.

Thanks, but I sent a v2 (20191218192526.13845-1-philmd@redhat.com) with:

- addressed Thomas and Aleksandar comments
- dropped 'hw/scsi/megasas: Silent GCC9 duplicated-cond warning'
- dropped 'qemu-io-cmds: Silent GCC9 format-overflow warning'

See:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg666280.html

Can you queue it instead?


