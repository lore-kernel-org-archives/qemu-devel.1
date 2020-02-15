Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19E9C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 13:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926662067D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 13:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPoFpb8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926662067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2xIz-0007lS-PK
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 08:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2xIB-0007A4-Dl
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2xI9-0001kH-T0
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:15:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2xI9-0001iL-PE
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 08:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581772529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KWahX/RKIm+oXDeUGIHAua5W3Dyja8IhhkL4SAggSLk=;
 b=QPoFpb8pcz2FCFxs4kGvTtg+KNlUWj1S5mWg4ph7wZGCcnO+6EFvegn4qSDGjAvtzEWl+s
 I4m4DEgs6Zc5rgEOP7dVT4u/+Hr1eNJNiVvx0QZtLbpX7q3EOSH3K4GrqreaJq7bPzqR1P
 MWdF+ZGBrorwaHs/HSOXFA/K37EwGYI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-j8qdfXa0O6ySkes-FK32gg-1; Sat, 15 Feb 2020 08:15:25 -0500
Received: by mail-ed1-f71.google.com with SMTP id y23so9724689edt.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 05:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=KWahX/RKIm+oXDeUGIHAua5W3Dyja8IhhkL4SAggSLk=;
 b=rQiSKwkX+w3tfgJf/f/3hrr/iTLcB9liaMcUOT1VKA1reEDzY42TzrzKvxsWOER2i6
 /6uoYYS4Z7CnEfn2cOCEYuyDEdY+ymiA8y7jQYKMU7ckTbyw65FqQc+Vu21kRe5gXwjk
 G31eZL0owZH+MyY7JATIsETtTjysxh9WeD4gnoYrhD/9lPKlKKgvUMKwN0orwQLBUMuj
 8ZKB/KPlPFXbshNDcmy5QCxHlG5DsfLbG2zMUUX60ijdfywapKeFAMFZaCEN4YuQIG3K
 IBQ81isH4uPT9c0nLXBDMsQZ97fdvVDp6QuAGuO3aG/j6JZMc+cuJd02oWYKkgM8SoGl
 3mHQ==
X-Gm-Message-State: APjAAAUThIi3arm5gUw85wcWezAMqF6IbXLVxQbyaUw02JjxesMRh79T
 63K4IXgCkwPYOI0UxBL4+lXz5/kuEKQ5Xzz1adFoyrq6QQdPCuVlpYAotpGN6MwUeuya0bLw9RL
 0jjsGhN4jY1Vu/EE=
X-Received: by 2002:a05:6402:1d28:: with SMTP id
 dh8mr6735062edb.383.1581772523984; 
 Sat, 15 Feb 2020 05:15:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTh3ucXNnYiVXopz14ZipdpbUxAx+ym6HFtgkSej0hRdYdQp1xA5CN7XkVO6vNkEn6LvaXEQ==
X-Received: by 2002:a05:6402:1d28:: with SMTP id
 dh8mr6735052edb.383.1581772523816; 
 Sat, 15 Feb 2020 05:15:23 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id qw15sm662874ejb.92.2020.02.15.05.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 05:15:23 -0800 (PST)
To: Jiri Pirko <jiri@resnulli.us>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: hw/net/rocker: Dubious code in tx_consume()
Message-ID: <63e927fd-a462-a871-fcd7-c54dac07173e@redhat.com>
Date: Sat, 15 Feb 2020 14:15:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: j8qdfXa0O6ySkes-FK32gg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jiri,

I am trying to understand this code Scott Feldman added in commit 
dc488f88806:

  157 static int tx_consume(Rocker *r, DescInfo *info)
  158 {
  ...
  212     if (tlvs[ROCKER_TLV_TX_TSO_MSS]) {
  213         tx_tso_mss = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_MSS]);
  214     }
  ...
  252     if (iovcnt) {
  253         /* XXX perform Tx offloads */
  254         /* XXX   silence compiler for now */
  255         tx_l3_csum_off += tx_tso_mss = tx_tso_hdr_len = 0;
  256     }

Nobody complained TSO_MSS is not implemented during almost 5 years.
Can we remove this code?

Thanks,

Phil.


