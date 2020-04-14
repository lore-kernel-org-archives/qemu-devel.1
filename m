Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E0C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0E820575
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDC/AWhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0E820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOFms-0002jI-CQ
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 03:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xadimgnik@gmail.com>) id 1jOFmB-0002Ce-6u
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xadimgnik@gmail.com>) id 1jOFmA-00015f-0r
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:14:31 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:41926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <xadimgnik@gmail.com>)
 id 1jOFm4-00013Q-88; Tue, 14 Apr 2020 03:14:24 -0400
Received: by mail-ed1-x533.google.com with SMTP id v1so15666395edq.8;
 Tue, 14 Apr 2020 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=UPl8Vc08yZvXnj9e+clalIg/qDk+S78wH0kNLz1cnTM=;
 b=cDC/AWhYs8VeclpczMQ+nWKlkHo+6TNqJh0NrHl5/bs0WriSFIdo3XBsaUD7ePRZHe
 NEW9SqTY4oaqIC2Y/EaS4yfPk3Uv4LuVEi3oLJy03dqZVz/J3BrAP3NgBtwgGzUeQlHe
 qQi9H4zrpUQIS9tpRFllWKDfMd6EzHU99W78oJiqDrWWwDyYS5qa0OkpPi8V95m9p8Um
 FHdTbD+1XAY38mrLapjh6w5wbslEhc9mdhUmpcK2hDNeWCgPBLQZWiH9FbWRTdVOOKB9
 dI5qDksUntfo2FUhoDWEi8zY5e4XYPgugP2/Xd7gHznBjNehL1/JodqE67TYC4gr1sw8
 AGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=UPl8Vc08yZvXnj9e+clalIg/qDk+S78wH0kNLz1cnTM=;
 b=iJ5KFY5ylSNIEJENYcg6n1/H3d2MM1dNBfzkpddWV0kMWRwy1JprqFSvMtdAirb02b
 RSD4MEo5q6lgIyU1+tBKwLPkNbzWzD6OYKCvLHJmrz5hYPWR0NZ6jglnxCJE+25JlaQs
 wlsFEGe1WNb2hTWWdExY46rUeqRLvQUHRguG3ZEK98E7smRU1Am0QFYG1DVoGWFTAPAI
 XMSeNXyNbsHEyy1/JcAQ6Ub3pXfavn1HI3j6n2WLG9yNHLmPdXnfNb48gF+GESh9qd2B
 31eg1DtSV2bS+i0zoMhVkCuOPrxWzxBk8MKW2dz/Pw8+R6UOda2rluhZFy7k+D27a9MX
 GZWQ==
X-Gm-Message-State: AGi0Puahu8ATMpN6xcQyr0k6cYE7r2L85iUPxqk2P11P1uXtrQV2pZLm
 J/l2PihVP2MOkY+52kie+GE=
X-Google-Smtp-Source: APiQypLHMbamzeoV0tCSAZIWZTN7JIFW698jKJ43W/2gz9gP/YIzqn3fve8VHf/Z7HPLTQ3RWL1aEQ==
X-Received: by 2002:a17:907:1185:: with SMTP id
 uz5mr19460491ejb.335.1586848462436; 
 Tue, 14 Apr 2020 00:14:22 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.185])
 by smtp.gmail.com with ESMTPSA id k33sm1600483edc.18.2020.04.14.00.14.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2020 00:14:21 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <f4bug@amsat.org>,
 <qemu-devel@nongnu.org>
References: <20200412210954.32313-1-f4bug@amsat.org>
 <20200412210954.32313-4-f4bug@amsat.org>
In-Reply-To: <20200412210954.32313-4-f4bug@amsat.org>
Subject: RE: [PATCH-for-5.1 3/3] hw: Remove unnecessary DEVICE() cast
Date: Tue, 14 Apr 2020 08:14:18 +0100
Message-ID: <004101d6122c$52094ad0$f61be070$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQLGp+eFp3IRGcFg/miJ8dc6gyP15QIEt8vKpobi2pA=
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::533
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
Reply-To: paul@xen.org
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 'David Hildenbrand' <david@redhat.com>, 'Jason Wang' <jasowang@redhat.com>,
 'Mark Cave-Ayland' <mark.cave-ayland@ilande.co.uk>,
 'Gerd Hoffmann' <kraxel@redhat.com>,
 "'Edgar E. Iglesias'" <edgar.iglesias@gmail.com>,
 'Stefano Stabellini' <sstabellini@kernel.org>, qemu-block@nongnu.org,
 'Markus Armbruster' <armbru@redhat.com>, 'Halil Pasic' <pasic@linux.ibm.com>,
 'Christian Borntraeger' <borntraeger@de.ibm.com>,
 'Aleksandar Markovic' <aleksandar.qemu.devel@gmail.com>,
 'Joel Stanley' <joel@jms.id.au>, 'Anthony Perard' <anthony.perard@citrix.com>,
 xen-devel@lists.xenproject.org, 'David Gibson' <david@gibson.dropbear.id.au>,
 =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>,
 'Eduardo Habkost' <ehabkost@redhat.com>, 'Corey Minyard' <minyard@acm.org>,
 "'Dr. David Alan Gilbert'" <dgilbert@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, 'Peter Chubb' <peter.chubb@nicta.com.au>,
 =?utf-8?Q?'C=C3=A9dric_Le_Goater'?= <clg@kaod.org>,
 'John Snow' <jsnow@redhat.com>, 'Richard Henderson' <rth@twiddle.net>,
 "=?utf-8?Q?'Daniel_P._Berrang=C3=A9'?=" <berrange@redhat.com>,
 'Andrew Jeffery' <andrew@aj.id.au>, 'Cornelia Huck' <cohuck@redhat.com>,
 'Laurent Vivier' <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 'Paolo Bonzini' <pbonzini@redhat.com>, 'Aurelien Jarno' <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philippe.mathieu.daude@gmail.com> =
On Behalf Of Philippe Mathieu-Daud=C3=A9
> Sent: 12 April 2020 22:10
> To: qemu-devel@nongnu.org
> Cc: Richard Henderson <rth@twiddle.net>; Halil Pasic =
<pasic@linux.ibm.com>; Peter Chubb
> <peter.chubb@nicta.com.au>; C=C3=A9dric Le Goater <clg@kaod.org>; =
David Gibson
> <david@gibson.dropbear.id.au>; Eduardo Habkost <ehabkost@redhat.com>; =
Anthony Perard
> <anthony.perard@citrix.com>; BALATON Zoltan <balaton@eik.bme.hu>; =
xen-devel@lists.xenproject.org;
> Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>; =
qemu-block@nongnu.org; Corey Minyard
> <minyard@acm.org>; Daniel P. Berrang=C3=A9 <berrange@redhat.com>; =
Christian Borntraeger
> <borntraeger@de.ibm.com>; Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com>; Stefano Stabellini
> <sstabellini@kernel.org>; Mark Cave-Ayland =
<mark.cave-ayland@ilande.co.uk>; qemu-arm@nongnu.org; qemu-
> ppc@nongnu.org; Jason Wang <jasowang@redhat.com>; Markus Armbruster =
<armbru@redhat.com>; qemu-
> s390x@nongnu.org; Dr. David Alan Gilbert <dgilbert@redhat.com>; Joel =
Stanley <joel@jms.id.au>; David
> Hildenbrand <david@redhat.com>; Aurelien Jarno <aurelien@aurel32.net>; =
Laurent Vivier
> <laurent@vivier.eu>; Peter Maydell <peter.maydell@linaro.org>; =
Cornelia Huck <cohuck@redhat.com>;
> Paolo Bonzini <pbonzini@redhat.com>; Andrew Jeffery <andrew@aj.id.au>; =
John Snow <jsnow@redhat.com>;
> Edgar E. Iglesias <edgar.iglesias@gmail.com>; Gerd Hoffmann =
<kraxel@redhat.com>; Paul Durrant
> <paul@xen.org>; Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Subject: [PATCH-for-5.1 3/3] hw: Remove unnecessary DEVICE() cast
>=20
> The DEVICE() macro is defined as:
>=20
>   #define DEVICE(obj) OBJECT_CHECK(DeviceState, (obj), TYPE_DEVICE)
>=20
> Remove unnecessary DEVICE() casts.
>=20
> Patch created mechanically using spatch with this script:
>=20
>   @@
>   typedef DeviceState;
>   DeviceState *s;
>   @@
>   -   DEVICE(s)
>   +   s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Xen part...

Acked-by: Paul Durrant <paul@xen.org>




