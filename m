Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35EEC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2382075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 10:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pmbq26lH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2382075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2HH-0000lt-MT
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 05:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is2Gf-0000Kx-Ui
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is2Ge-00044k-SA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:20:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50651
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is2Ge-00044I-OI
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 05:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579170048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzBfB4bfJPhVqu4rzNEwHeyiUfWmoRjTVRnofPlU71M=;
 b=Pmbq26lHx8dDxe5AceRv/FGxBCQjvVzC61B6J5BWmR7vFLbdcqCztlFZLiux/y20/DWUJn
 Cq6zGRX6vLyW5M8d5yXbQOVih82i0zpqGGaJTRhas9uNz+GWm0cfc3m7sWtDNHd2x4kC5S
 t5V2JYZxSaP6ebIEAqDEnb8/Taz0JjM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-X4zvmJKSNZK3VBdeuhoc_g-1; Thu, 16 Jan 2020 05:20:45 -0500
Received: by mail-wm1-f69.google.com with SMTP id p5so472208wmc.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 02:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2KWy4Hb5BngdWHmUPWH0AQf3CqKvqV+JeWBzkVvusIA=;
 b=si0f3gWeATyXfs8k+oQFY/KYsrJs5r1DQdKWIFYbRMG06UxdLHCZaJZq3A+sBesQ5o
 EYhx8iMLJDQwpJJ6gpHg/9InjK7eAa7+yTa15xKdlYd55w8AOupmQR5lS2ZEjk9oHoOy
 VZvGjGQnsbhoTwgFAyv6xDSQqe28XwAV6mbM7tmP8nzY971oC3gnUbHOEUkPUa+H4Uip
 Uss2a3Lf8+LbemFCvxJs5t02ppD1pU5y6wDbTafMI7b+YZfTJyMNhrfo0PntD2ASRDQ3
 IQ22Cj7H/91fXD4QrcDQwMW7+epOFXTgTcbxrjgwBAGlGNzWmqI3kVoBE/vY9tqgCSRQ
 0SEA==
X-Gm-Message-State: APjAAAWNt7Xo+RirCfps8k0GN6ydeDKSl15+9Q+OXsuzsrCc5RCZFVUp
 Jux3o+oLNgoA5yapyXzp9FPALTZFIaUae1Tlu5Q1SjIKlRTTa/VtSxdAEAdLEt6lROqFniLymQY
 0DsKWTJ3G1B6+DEk=
X-Received: by 2002:adf:fa12:: with SMTP id m18mr2378584wrr.309.1579170043835; 
 Thu, 16 Jan 2020 02:20:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzKlCWqd3A3rstEdACLKORlKUBZ1N2yWNgsaaQlNqtSjPMOXCQgU5sdq82zjO9/fZU8C2JoCw==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr2378567wrr.309.1579170043610; 
 Thu, 16 Jan 2020 02:20:43 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id 2sm27942604wrq.31.2020.01.16.02.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 02:20:42 -0800 (PST)
Subject: Re: [PATCH] ui/gtk: Get display refresh rate with GDK version 3.22 or
 later
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200116011217.2144-1-philmd@redhat.com>
 <20200116101606.GA533908@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64afd282-6dde-43b3-d8de-a645b5f97802@redhat.com>
Date: Thu, 16 Jan 2020 11:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116101606.GA533908@redhat.com>
Content-Language: en-US
X-MC-Unique: X4zvmJKSNZK3VBdeuhoc_g-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nikola Pavlica <pavlica.nikola@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 11:16 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jan 16, 2020 at 02:12:17AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> The GdkMonitor was introduced in GTK+ 3.22:
>> https://developer.gnome.org/gdk3/stable/api-index-3-22.html#api-index-3.=
22
>>
>> If we build with older GTK+, the build fails:
>=20
> Presumably the problem here is Ubuntu Xenial 16.04 which
> only has 3.18.9 ?

Indeed:

   $ lsb_release -a
   No LSB modules are available.
   Distributor ID: Ubuntu
   Description:    Ubuntu 16.04.5 LTS
   Release:        16.04
   Codename:       xenial

   $ pkg-config --modversion gtk+-3.0
   3.18.9

> We should put in a sanity check for this against our min version
>=20
>   #define  GDK_VERSION_MIN_REQUIRED GDK_VERSION_3_14
>   #define  GDK_VERSION_MAX_ALLOWED GDK_VERSION_3_14
>=20
> into glib-compat.h
>=20
> For that matter we can update our min version to 3.18 I believe
> since that looks like the oldest version any supported build
> platform has.
>=20
> Regards,
> Daniel
>=20


