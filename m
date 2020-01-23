Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854FAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4599C2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8VPBNLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4599C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuibx-0001pR-DO
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iughI-0003cc-Nj
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iughH-0000Pz-LV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:55:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55092
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iughG-0000Ni-2Y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579802113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsA7brPv5IiayWjJ564yZ0Wwt41HKNVlotkuFX3f/6o=;
 b=H8VPBNLlq8OqQdpSgn5D8ilLigkByPPSQ6bVKqR4vzDa9YAvmtcL8WtaTYkAM0D68p3c/i
 A6I2Hlh8e1vclQg8SQYpAs4u31DoAtt4dz3F/SIUROnMd5yf/gldzkKbtU+AbqBktMVsh8
 X9MUsza/wwDhs1JTYwIAQh28Kg7KzyU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-U3d7--yGPRe1cGEB-FznsQ-1; Thu, 23 Jan 2020 12:55:11 -0500
Received: by mail-wm1-f72.google.com with SMTP id m21so898176wmg.6
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 09:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0fl68LNmJbFTI1O/WBJWI+YervOar9TZo3leS9OrhI8=;
 b=l3yg4oSI09P+7Jbi6TfYqjq9oQ91gC1AN4Q6XJhWoe37E8nERLENPKLu9f7y9SUaMg
 nTXAOoUtVJDipvDEVpS3MLfnV2fpVB87iX4yFJc2m+ovpK97Vq4wz9oCPA/Ev3yVDpmu
 3aoW9AOLZFv79gvTdNuZu0myGXMleXBFgZzU7k1IM8p/1zBINTU3jgobSzZQpNbluvWf
 7fW2IqMh2n8u3NDuv+LPvvweK7Gp6zMecbm9PErSLD+n4QRK30w/DqUOHxF0MdHoSWtb
 IiTwY124a9tRSSnHqV1PY8yybERXHaBvv7RoKRF1uONpUFy9ig/oAOCB97G6dgRV/A7I
 8APQ==
X-Gm-Message-State: APjAAAWE8mhNGpZwkoGu0O6sCmuL2LPnwWgEBNia9/nJCr8gfdsYvJJW
 wJSeL5/NNzInVbyzLhhFtw3hkfSJNRmCEddgKiM0T59pfbdg/AgPUWGYtDVen2H02iT0XbF9QtD
 1uUgrPt7B91noHX0=
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr5568233wmf.56.1579802110487; 
 Thu, 23 Jan 2020 09:55:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwSzLK+pjpstzeHkdgPXBLM/skus+p40VzHZOu/bQJ33G5IjNZfVtXuSfnT14eq1UURR79AOA==
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr5568205wmf.56.1579802110302; 
 Thu, 23 Jan 2020 09:55:10 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u18sm3960739wrt.26.2020.01.23.09.55.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 09:55:09 -0800 (PST)
Subject: Re: [PATCH 0/6] Fix more GCC9 -O3 warnings
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20191217173252.4672-1-philmd@redhat.com>
 <6a8266c6-7c6d-3139-249f-2dd46c98e02f@redhat.com> <87blquza17.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <47e28e48-362a-39ea-ee58-9bbe7d222394@redhat.com>
Date: Thu, 23 Jan 2020 18:55:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87blquza17.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: U3d7--yGPRe1cGEB-FznsQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 12:28 PM, Alex Benn=C3=A9e wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> On 12/17/19 6:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Fix some trivial warnings when building with -O3.
>>> Philippe Mathieu-Daud=C3=A9 (6):
>>>     audio/audio: Add missing fall through comment
>>>     hw/display/tcx: Add missing fall through comments
>>>     hw/net/imx_fec: Rewrite fall through comments
>>>     hw/timer/aspeed_timer: Add a fall through comment
>>>     hw/scsi/megasas: Silent GCC9 duplicated-cond warning
>>>     qemu-io-cmds: Silent GCC9 format-overflow warning
>>
>> Sorry, this series failed because I used this tag in the first patch:
>>
>> Cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>
>>
>> Then git-send-email was happy with --dry-run, but then failed:
>> (body) Adding cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail=
.com> from line
>> 'Cc: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.ice.hu@gmail.com>'
>> 5.1.1 <K  v  g  >: Recipient address rejected: User unknown in local
>> recipient table
>>
>> Note to self, enclose utf-8 names, as:
>> Cc: "K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com>
>=20
> I never have to with my tags:
>=20
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> Is it possible to be more even utf-8? Sounds like a bug in the git tools
> to me.

The problem is the comma.
What do you mean by "more UTF-8"?


