Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C886EC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CB52077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4Spd77B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CB52077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqAM-0006tE-79
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iop1U-0004Wu-Po
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iop1T-0007Xv-BB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:35:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31619
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iop1T-0007XR-6z
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578404150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgJ63KNFeV8fEsy3bxMCPXMmgApiQL8nb2oNzV/98ZA=;
 b=I4Spd77BikD4gvaMTmI0/n6q8U2bMgK/IoTQe9BesPmvbQz+tXjPROeZl+5rLdW5lbE1hI
 awyejk6uwCU03Lv5rGggDtZZxj1T1YC2qwH6o+8YIRgAfOstZUZjLwJ9rW1QuYlI+eQogG
 ygrGOFP/o51Mdm20YQzDVsE4TrcjU38=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-GKAUFDldMZ-FdyOupQJ4Pg-1; Tue, 07 Jan 2020 08:35:33 -0500
Received: by mail-wr1-f69.google.com with SMTP id t3so27845937wrm.23
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 05:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fJbhXYVWjA1jrDmpcRkXb5jIT7BOB8Y1hafwH68X/4s=;
 b=J/4PDR5NDmL5EoY1ou8gJQejgk6hL95T78ZRwpswqWP4V/are86iT8CnplraIK8S1G
 ziIxucGDNs4xTgp1NDvm6OK/f3eSQBqTqiqQHGjZILgLRTRdmNTWyyouGgpGXv8ddE+o
 wYTOzvj3so7lv8gdKxXuAtrvJ7CUCBzdM3/kfhE5y0GZkV3wuIdsE7Uo4ofZYuS226Rn
 13MP6X1bgpKL+Q5Lk08uXsulp/nmX3bi3VVMg87q8GQ+UesdXPe4jXp/TqdmkDuk1wBS
 sWR2IVZqWbednNNf8oODCjOn33uO0G66U9HxBm5Y00aEvUjvnDIDfTBSb4nFcif3sw7l
 KdZQ==
X-Gm-Message-State: APjAAAUg8D6sYlm76Et1uoHu4KU34x8EOKaLc7lvmb3zeUIYbxIg/TPg
 C0N/hwBvprjrt6stgzAZVr7EXm0nPoCqZORgQedvEDDnl2Qj4nN6rYglP4p+7rPeTvM2XjZPFKx
 WAMc4enb7T/hj8ck=
X-Received: by 2002:adf:f508:: with SMTP id q8mr33861541wro.334.1578404132091; 
 Tue, 07 Jan 2020 05:35:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzEhGHBs6uCD4+GgBcnG6U3KrQhMvIw/NlraO6IXaclcxbRszM0lbPdiCL8E4D1cKhUfOHjjw==
X-Received: by 2002:adf:f508:: with SMTP id q8mr33861520wro.334.1578404131887; 
 Tue, 07 Jan 2020 05:35:31 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id k16sm79780983wru.0.2020.01.07.05.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 05:35:31 -0800 (PST)
Subject: Re: [PATCH v9 14/15] hw/i386: Introduce the microvm machine type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191015112346.45554-1-slp@redhat.com>
 <20191015112346.45554-15-slp@redhat.com>
 <6276a8e7-2928-6e33-64a1-3ae01a30a718@redhat.com>
 <a5863b05-4021-df51-d84f-1bb070fa6137@redhat.com>
 <8eec451f-3ee3-b111-2c03-3c29ade661a6@redhat.com>
 <21e2508a-764f-1db9-9c53-dc9eb43d7f68@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9733853-9202-504e-c823-b4441322d3fb@redhat.com>
Date: Tue, 7 Jan 2020 14:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <21e2508a-764f-1db9-9c53-dc9eb43d7f68@redhat.com>
Content-Language: en-US
X-MC-Unique: GKAUFDldMZ-FdyOupQJ4Pg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, imammedo@redhat.com,
 rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/12/19 01:09, Philippe Mathieu-Daud=C3=A9 wrote:
> We have CONFIG_SERIAL_ISA declared in "config-devices.h" so we could
> also use:
>=20
> -- >8 --
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -153,9 +153,11 @@ static void
> microvm_devices_init(MicrovmMachineState *mms)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 microvm_set_rtc(mms, rtc=
_state);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> +#ifdef CONFIG_SERIAL_ISA
> =C2=A0=C2=A0=C2=A0=C2=A0 if (mms->isa_serial) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serial_hds_isa_init(isa_=
bus, 0, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> +#endif
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 if (bios_name =3D=3D NULL) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bios_name =3D MICROVM_BI=
OS_FILENAME;
> ---
>=20
> The binary links too, and the difference with the other hunk is now the
> device is not listed in 'qemu-system-x86_64 -M microvm -device help'.
> However I guess understand we prefer to avoid that kind of ifdef'ry.

The ifdef'ery is okay in board code, but in this case I think it would
be even better to have a stub for serial_hds_isa_init that gives the
right error (via Error*, and then you can call it with &error_fatal
etc.).  So for now I included your patch that changes it to "select"
from the other series.

Paolo



