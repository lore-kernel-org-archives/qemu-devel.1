Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5155C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92446218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92446218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVWx-00084d-NJ
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <amorenoz@redhat.com>) id 1iAVW2-0007fb-Dx
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <amorenoz@redhat.com>) id 1iAVW1-0000I1-2I
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:40:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36088)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <amorenoz@redhat.com>) id 1iAVW0-0000Hi-Rc
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:40:45 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD5FC3680A
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:40:43 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j2so2097389wre.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 01:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=gwUNK0lxSCcFdPr+jcJr+0NEqsMVkwJIZW5RrLXRxuo=;
 b=i0eNfKhpMH6PQCGDrbYi+dFxPOuYdQOYYZyU/GSjIz6dZuPA+xSIyLZuSVl0GgPuMi
 dJLObRpq1/ytNLJd4yVbGJoolg1AreMk55lqLSGJqKaUWFbDauaHew2BGjcnwy1g/R65
 4aqhohtlm3tC4PV7M8k6h1P9Cc8+Rdo74gE3oqqKaiFB2y6AYHDNW1FfpO9pWlKrQUMQ
 7jvzASVzTLECiq4t96USwdfiCvYI+tBvwC4JP1+N9+q3U4WpxQ5nYoQRw9sJWRSmH1Yi
 gE19uNGZvIFcxFr+1ZYf4HW4aoJL+nmf/XeEQv/PM7rSI6ylf7rYNLof3b+q3A+NxeC7
 sVbA==
X-Gm-Message-State: APjAAAVNmyQDEFu2oRAIRJ6OSsoRfM57Fzguufz2cKs2uN3jEd/Lm2x1
 qtG+mSEf5VA8DSIAGRcdDBtu6wC1D2kWYLv5bAd1dHTdpGkuogZL9s7ICGqxT5TrYZdypFSUawV
 5BSRFHuG57MfrpU0=
X-Received: by 2002:a5d:4590:: with SMTP id p16mr1965896wrq.82.1568796042487; 
 Wed, 18 Sep 2019 01:40:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4MYQazdYRQPwg8GHZW0Kxgy7O0jI06zvBfsdHGWnWXmJMNld4bTfp9cyTEOUkytmLXq1ttA==
X-Received: by 2002:a5d:4590:: with SMTP id p16mr1965877wrq.82.1568796042225; 
 Wed, 18 Sep 2019 01:40:42 -0700 (PDT)
Received: from amorenoz.users.ipa.redhat.com ([81.0.4.169])
 by smtp.gmail.com with ESMTPSA id t6sm2132812wmf.8.2019.09.18.01.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 01:40:41 -0700 (PDT)
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20190917191901.28348-1-amorenoz@redhat.com>
 <20190917173941-mutt-send-email-mst@kernel.org>
From: Adrian Moreno <amorenoz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=amorenoz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBF1syNUBCADQ9dk3fDMxOZ/+OQpmbanpodYxEv8IRtDz8PXw8YX7UyGfozOpLjQ8Fftj
 ZxuubYNbt2QVbSgviFilFdNWu2eTnN/JaGtfhmTOLPVoakkPHZF8lbgImMoch7L0fH8wN2IM
 KPxQyPNlX+K9FD5brHsV1lfe1TwAxmhcvLW8yNrVq+9eDIDykxc7tH4exIqXgZroahGxMHKy
 c8Ti2kJka/t6pDfRaY0J+6J7I1nrn6GXXSMNA45EH8+0N/QlcXhP3rfftnoPeVmpjswzvJqY
 FNjf/Q5VPLx7RX0Qx+y8mMB2JcChV5Bl7D7x5EUbItj6+Sy7QfOgCtPegk9HSrBCNYaLABEB
 AAG0I0FkcmlhbiBNb3Jlbm8gPGFtb3Jlbm96QHJlZGhhdC5jb20+iQFUBBMBCAA+FiEEogUD
 gihhmbOPHy26d5C5fbYeFsUFAl1syNUCGwMFCQHhM4AFCwkIBwIGFQoJCAsCBBYCAwECHgEC
 F4AACgkQd5C5fbYeFsX7qwgArGHSkX+ILNcujkVzjTG4OtkpJMPFlkn/1PxSEKD0jLuzx14B
 COzpg/Mqj3Re/QBuOas+ci9bsUA0/2nORtmmEBvzDOJpR5FH1jaGCx8USlY4WM6QqEDNZgTw
 hsy9KhjFzFjMk+oo3HyItXA+Uq9yrRBTjNBGTXxezMRcMuUZ4MIAfY0IRBglL2BufiuL43jD
 BvTENNFLoQ/wFV7qkFWSkv+8IjTsxr7M6XUo1QLd29Hn0dvwssN579HL1+BP46i2REpzeBEG
 L75iVChi+YnIQQNMJ9NYarVabZx4Y1Gn8+7B/1SNArDV+IDgnYgt7E58otoV2Ap310dmtuvE
 VbxGpbkBDQRdbMjVAQgAqyp9oA7WDu7/Y9T4Ommt69iZx8os7shUIfdgPEy5xrcPn6qGwN1/
 HQ4j8nWfBG9uuX1X0RXUZIUEtYTxtED4yaCQMTqDUf9cBAwAA2mYxBfoiNYx8YqxM+sT0/J4
 2qmDd+y+20UR4yzHE8AmIbspTzDFIJDAi+jKSR8F355z0sfW7CIMDC4ZWrPsskjEy1YN/U10
 r6tRRH1kNyrCSbTG0d9MtcQO58h7DLXuzUhErB+BtG52A04t5cweIJTJC+koV5XPeilzlHnm
 RFoj0ncruGa9Odns21BNt3cy9wLfK+aUnWuAB1uc6bJGQPiAwjkilz7g7MBRUuIQ2Zt7HGLc
 SwARAQABiQE8BBgBCAAmFiEEogUDgihhmbOPHy26d5C5fbYeFsUFAl1syNUCGwwFCQHhM4AA
 CgkQd5C5fbYeFsUlSwf8CH+u/IXaE7WeWxwFkMaORfW8cM4q0xrL3M6yRGuQNW+kMjnrvK9U
 J9G+L1/5uTRbDQ/4LdoKqize8LjehA+iF6ba4t9Npikh8fLKWgaJfQ/hPhH4C3O5gWPOLTW6
 ylGxiuER4CdFwQIoAMMslhFA7G+teeOKBq36E+1+zrybI6Xy1UBSlpDK9j4CtTnMQejjuSQb
 Qhle+l8VroaUHq869wjAhRHHhqmtJKggI+OvzgQpDIwfHIDypb1BuKydi2W6cVYEALUYyCLS
 dTBDhzj8zR5tPCsga8J7+TclQzkWOiI2C6ZtiWrMsL/Uym3uXk5nsoc7lSj7yLd/MrBRhYfP JQ==
Message-ID: <a9cf2607-9384-ec12-e3d9-86b2aeb69660@redhat.com>
Date: Wed, 18 Sep 2019 10:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917173941-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vhost-user: save features if the char dev
 is closed
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
Cc: ddstreet@canonical.com, Pei Zhang <pezhang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 11:40 PM, Michael S. Tsirkin wrote:
> On Tue, Sep 17, 2019 at 09:19:01PM +0200, Adrian Moreno wrote:
>> That way the state can be correctly restored when the device is opened
>> again. This might happen if the backend is restarted.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1738768
>> Reported-by: Pei Zhang <pezhang@redhat.com>
>> Fixes: 6ab79a20af3a (do not call vhost_net_cleanup() on running net fr=
om char user event)
>> Cc: ddstreet@canonical.com
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>>  net/vhost-user.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/net/vhost-user.c b/net/vhost-user.c
>> index 51921de443..acf20cb9e0 100644
>> --- a/net/vhost-user.c
>> +++ b/net/vhost-user.c
>> @@ -235,6 +235,13 @@ static void chr_closed_bh(void *opaque)
>> =20
>>      s =3D DO_UPCAST(NetVhostUserState, nc, ncs[0]);
>> =20
>> +    if (s->vhost_net) {
>> +        uint64_t features =3D vhost_net_get_acked_features(s->vhost_n=
et);
>> +        if (features) {
>> +            s->acked_features =3D features;
>> +         }
>=20
> why does it make sense to check if (features)?
> 0x0 is a valid feature bitmap, isn't it?
You're right. It doesn't.
I'll remove the check.

>=20
>> +    }
>> +
>>      qmp_set_link(name, false, &err);
>> =20
>>      qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_even=
t,
>> --=20
>> 2.21.0

Thanks.

