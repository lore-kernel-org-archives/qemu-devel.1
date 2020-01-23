Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380A0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 001C321D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2JJ4TeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001C321D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuihd-0004XI-5H
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iuhBy-0003Zt-SW
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iuhBx-0004P1-KC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:26:58 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iuhBx-0004OW-DI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:26:57 -0500
Received: by mail-wm1-x344.google.com with SMTP id m24so3597656wmc.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 10:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7dXJiqFh/Qd0FgxO2ZOIyemz+7W8bSpsp6lnmrr/4EQ=;
 b=W2JJ4TeRyjyoPxJ9+jIE+APwYqc31Ed4827OmakVFGzMwG6cyXM93/MSUZOuZ9Fy4u
 Av25d6W3rWFuHkAGv4A9SX7ik1hVA45gqkX43xzSCDkkw/XsmJVi0H2vlBDshf62Ynlw
 yRO8fycmV9FeS44u3Bq/fHZBJ+GUKKNXZ1fz0wUMUzcWkS1gk91/tRTSXYv9/4NrsT6p
 UTkFElrJeWj47WjiD43EgBn5W+CjCzcHr++dZ1Vj8xsyOggXfOhRpBZojh+LR6rjC8zA
 yMQ7l3wTg8pMIb6eyw0Otb3OOxOGmqUaLdQaEAW4qElAPjaZj7HR1bGIErdFn+7jwyUz
 mh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7dXJiqFh/Qd0FgxO2ZOIyemz+7W8bSpsp6lnmrr/4EQ=;
 b=WO7CnonsfZ1oDuAFQQeO2Lito+Ts8FejV/x+9Do4Hl5I9GRCFzmMvPhtuoG4vQuiWK
 hGFsh8yekCxsv/YymCmIZSKuwNyGYzmD6ZEWC4/LS2JOwgVXv4azjxkQPc8ljUrtacMY
 4G8dwKzwxpGMTgdr4ArCRInINlf3fFZllmQedL8RH915KEarU0ieM2IupKxL/UcZ89sb
 +vXJ4FqaKpmTg6AxG4UQTfwTS4YUtoJSf0BX/zZWW/5JEsVtq1TB1t3Yr7SYY+kj328k
 jjvX7bIqz+P92KU+SbVTNMawfS1h42Z1IZTbqjMcDSvDVIcIIp1QE5ovD5dZ9iN3M7gn
 HZyg==
X-Gm-Message-State: APjAAAUQGS8TMhf9pLXbqp9crEAVojsKjwDsoBj1KDM+sbtnz7K5Kiz9
 R2WXIzxPpxbhRvi1VpUxSScnZA==
X-Google-Smtp-Source: APXvYqy33tetM39E+6BoKwUeZDxw3JJOKqAWYoioWj4ZqTs+QVvOzkPsrX/1nM6Y2uAXHJVewNTAIw==
X-Received: by 2002:a05:600c:2507:: with SMTP id
 d7mr5226059wma.28.1579804015556; 
 Thu, 23 Jan 2020 10:26:55 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a5sm3552190wmb.37.2020.01.23.10.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 10:26:54 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 66A121FF87;
 Thu, 23 Jan 2020 18:26:53 +0000 (GMT)
References: <20191217173252.4672-1-philmd@redhat.com>
 <6a8266c6-7c6d-3139-249f-2dd46c98e02f@redhat.com>
 <87blquza17.fsf@linaro.org>
 <47e28e48-362a-39ea-ee58-9bbe7d222394@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/6] Fix more GCC9 -O3 warnings
In-reply-to: <47e28e48-362a-39ea-ee58-9bbe7d222394@redhat.com>
Date: Thu, 23 Jan 2020 18:26:53 +0000
Message-ID: <878slyyqoi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 1/23/20 12:28 PM, Alex Benn=C3=A9e wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>=20
>>> On 12/17/19 6:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Fix some trivial warnings when building with -O3.
>>>> Philippe Mathieu-Daud=C3=A9 (6):
>>>>     audio/audio: Add missing fall through comment
>>>>     hw/display/tcx: Add missing fall through comments
>>>>     hw/net/imx_fec: Rewrite fall through comments
>>>>     hw/timer/aspeed_timer: Add a fall through comment
>>>>     hw/scsi/megasas: Silent GCC9 duplicated-cond warning
>>>>     qemu-io-cmds: Silent GCC9 format-overflow warning
>>>
>>> Sorry, this series failed because I used this tag in the first patch:
>>>
>>> Cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>
>>>
>>> Then git-send-email was happy with --dry-run, but then failed:
>>> (body) Adding cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmai=
l.com> from line
>>> 'Cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>'
>>> 5.1.1 <K  v  g  >: Recipient address rejected: User unknown in local
>>> recipient table
>>>
>>> Note to self, enclose utf-8 names, as:
>>> Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>
>> I never have to with my tags:
>> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Is it possible to be more even utf-8? Sounds like a bug in the git
>> tools
>> to me.
>
> The problem is the comma.
> What do you mean by "more UTF-8"?

It was a joke - I think you are either utf-8 clean or not. Now the
question is should the tools have slurped the coma as part of the name?
Is it a localisation issue?

--=20
Alex Benn=C3=A9e

