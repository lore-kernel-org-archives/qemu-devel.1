Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4BBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803D62168B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 10:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803D62168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i562s-0004eI-Ky
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 06:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i55y5-0000BL-Fv
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i55y4-0000BZ-J6
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:23:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i55y4-0000BC-B1
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 06:23:20 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B6DD3C916
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 10:23:19 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id c11so4154680wml.6
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 03:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=Mi812qGWugZcJas51sJW8j1WVPtF+9WsCic9WmYIbLQ=;
 b=k70c11bA2Uph3Je0tlX4Lbj4PaJ5yDqZqy+SH7oBD7sAOIQgC6qe1ZVje54oVWVyp1
 8+PG2ZKFA5/YZcpzNHKI6TpbexbYhCSv9RmStDFBvPGcME01Eu2nk+Ih/tSpWeztJtkl
 0sCphijnnGz+vKnkR20X6MyWmsyXwRXAizo+JM5A0XWLBSz/yMLMP1+HykufFHYQZbUn
 VzbiunoqLHxDek1eBpwDw/h6MOpOJz/FMEac8l2ic/+AIxmQ9hYa3azvv29i0js/WK+t
 Q8KOMrm0Y78wncI8X1sLEtmJUiEaWGDbvF0yFqfg8Q4G6/fibdHNSLLSd45tPWKtx6tW
 g6rg==
X-Gm-Message-State: APjAAAU9/11NmvShMVQckASN38sLBiQa4M284vEA7/OQu0W4mfF9apXd
 8BPZGJm7DFh9iFuqKu+cnzzBSafMHoNiXkUySBaNvSUAsAFfBRuzb8j3B5WS6GSt3TDJPZJJCrW
 +cpx3UD4ejT9ss9U=
X-Received: by 2002:a1c:2582:: with SMTP id
 l124mr44313814wml.153.1567506198062; 
 Tue, 03 Sep 2019 03:23:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0t5gXwNDM5rCFHa5xvi2wzWCTKhjcWgtORZYMtYVJp57Wxq71N2ygiPJZ4BELnpyyB8V8tQ==
X-Received: by 2002:a1c:2582:: with SMTP id
 l124mr44313803wml.153.1567506197923; 
 Tue, 03 Sep 2019 03:23:17 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id b194sm40614414wmg.46.2019.09.03.03.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 03:23:16 -0700 (PDT)
References: <20190829165026.225173-1-slp@redhat.com>
 <20190902093548.GD9069@stefanha-x1.localdomain>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
In-reply-to: <20190902093548.GD9069@stefanha-x1.localdomain>
Date: Tue, 03 Sep 2019 12:23:14 +0200
Message-ID: <87lfv5isq5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, cohuck@redhat.com, qemu-devel@nongnu.org,
 abologna@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Thu, Aug 29, 2019 at 06:50:27PM +0200, Sergio Lopez wrote:
>>      case VIRTIO_MMIO_QUEUE_PFN:
>> +        if (!proxy->legacy) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                "%s: read from legacy register (0x%lx) in non-legacy mode\n",
>> +                __func__, offset);
>
> Please use HWADDR_PRIx since offset has type hwaddr.  On ILP32 and LLP64
> hosts %lx is only 32-bit.

Ack.

Thanks!
Sergio.

> Otherwise:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1uPxIACgkQ9GknjS8M
AjXTtw/9FskR1SqUdIfX8TorFVP3bSyhy2Cva5HdE67lzXWbyT0QpyQQFrtuVHIY
bkMdtcVGII9AbGzQCKCeeMQwR8bLIsiMTn4XS9DgpnUHC3ht/D8kLoDpIwI5hK6Y
/DPj9OY9bsN5XSj6yDcbstBP6MM8+7nc0G/CdRn07cqioc+Pp7Ph9rUFEdk6l+1k
jKAuY2aqYnZT0yddHdh33wF/XabuImzAFAlkrnM389wRuPxQiI1P7kAbZpL0czZd
g1VKSnvGKwiUA5KLGNc8a4WI4fSXscTR68AzLvjX3Uezd+cBkafBRsHBr6uoK3kZ
t4+ZSAr3jL0R2ainUQmSkOZYW3+VQJQEoObCXFZ+d4CHNUy28jVJa99wY2FdHziN
YfH/4LqNRlLpLZkdJWbETljauafiEHg5bAp23p39xgWnaBDOED+FwUJVoAbUlrZi
W3qat4r4UFIjFWpislDh5e1C5v5bN6kMpcHbNyhB2TZvLBa0BFFbJdPNb4g/oKcy
g9tKmRlAUYQcaTIks+f+9T2DaF8dvazaUT25wHTzOEujpm5FE2+OAjbjFu79zTtr
alVTK8o8nor4xSV3pUJDZa+SIw/UZtg8nm/JyQ2vISx3bKFg6YG1TB3L2LeNm6uM
7RJrdur34819cbjzRaMIChRqcqtxDFf/R7PQHHunazphnE64tBg=
=XNnr
-----END PGP SIGNATURE-----
--=-=-=--

