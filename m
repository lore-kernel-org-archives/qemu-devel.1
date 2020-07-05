Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688E0C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 05:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A242088E
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 05:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqZ0p37e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A242088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrxMp-0002YN-Gj
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 01:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrxLY-0001sH-Mw
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 01:37:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50100
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrxLV-0006S9-Uy
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 01:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593927463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QjMyNamLLkRJJI8ub+Padxcs+ybIZnNdDYQZ7F5eZm8=;
 b=NqZ0p37e8S6v0Tj3zP807s/jgXy1lZ3ZSyxU3IHZLQsl9ZEDP976bhXgYgR14f4id+rSRg
 QTPtqCg9WZhXFpzQG8Y3HRd/C5HrmvZlkPPfhm9wMzwV7lZeSXqD2KP0CMvBVR7pH9dbWx
 ybAfrhG6AJyhe4Y8RELNgQwPiKH4Qlk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-QyhX3z_ZNYGG-O7f7s04zA-1; Sun, 05 Jul 2020 01:37:42 -0400
X-MC-Unique: QyhX3z_ZNYGG-O7f7s04zA-1
Received: by mail-wr1-f70.google.com with SMTP id j5so37673355wro.6
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 22:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QjMyNamLLkRJJI8ub+Padxcs+ybIZnNdDYQZ7F5eZm8=;
 b=WQJxtt/dKOuF8U9420F/uz2MMqCYEDQn43ep8R/2dP5AXtrzy2l+/VmTXO2NpbYMUY
 AnvQ+BVDC3bILIWY6RMDDHKBzP3z0f2dkMOawL7Hf0uLe5O1RTOof5yU6dpZ3RuDlqLG
 iGbCLVNZg69hWEpUdpxwbYsvwpJRtzfVlH2qlwZrHeYOrLtRwbZWFyuT5g7+tC8YmmpZ
 6qdWL/fBnfajuAwgWy3FL0XGhWdgUEyF9c4qrts4SU3IooJ5gVI3WGE+lK5RBhFNq56S
 1KgL9UmdP7YvbKZKUWjQMfgDhv+UZ1Oi1A9u08T7zN4U5+b9qSnxqs/i29Y/Ujvg5Yjx
 p/7w==
X-Gm-Message-State: AOAM532Z1c7eGAS3Yk6EXl3HWTv2qCXr3aygoDML7zGw28/eIGkALNUG
 oyW/Mxn/T710bTth093vg2WnssM2PxC4v/JdAXc+QXqXaTG86EcHF5tf9U3oC0oMJZRzeJQ9Luc
 Rkt0TKjVuEFY2Uq8=
X-Received: by 2002:adf:ded2:: with SMTP id i18mr43454255wrn.109.1593927461084; 
 Sat, 04 Jul 2020 22:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3gbpxpgGybQ3VzZRMzQ46rw4ptwRvsmRqLomV48jR8zUbdkEyVOboq2NFCpnpK8+MW/QV+A==
X-Received: by 2002:adf:ded2:: with SMTP id i18mr43454210wrn.109.1593927460808; 
 Sat, 04 Jul 2020 22:37:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:adf2:29a0:7689:d40c?
 ([2001:b07:6468:f312:adf2:29a0:7689:d40c])
 by smtp.gmail.com with ESMTPSA id w14sm18980566wrt.55.2020.07.04.22.37.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 22:37:40 -0700 (PDT)
Subject: Re: [PATCH 24/26] hw/usb/usb-hcd: Use UHCI type definitions
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-25-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2007041916060.92265@zero.eik.bme.hu>
 <f19dc1c9-8b72-695b-bce1-660e547e5658@amsat.org>
 <alpine.BSF.2.22.395.2007042140380.45095@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ba4dd94b-ec7a-b4ec-4786-c8c5dcd8127f@redhat.com>
Date: Sun, 5 Jul 2020 07:37:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2007042140380.45095@zero.eik.bme.hu>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 00:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/07/20 21:44, BALATON Zoltan wrote:
> 
> No it's OK, no need to list all defines. I just did not notice the macro
> argument that's why I was wondering where it comes from. This seems to
> be used elsewhere at least here:
> 
> hw/audio/es1370.c:#define a(n) if (val & CTRL_##n) strcat (buf, " "#n)
> hw/audio/es1370.c:#define a(n) if (val & SCTRL_##n) strcat (buf, " "#n)
> hw/audio/es1370.c:#define b(n) if (!(val & SCTRL_##n)) strcat (buf, " "#n)
> 
> Maybe writing it without the space between "# is clearer as then it
> looks more like it's part of the value.

I think keeping the space is better.

The reason is that CTRL_##n pastes together CTRL_ and n, but " "#n is
different:

1) First, it turns n into a string, for example "1"

2) Then, just because there is another string just before, the two are
concatenated, as in "CTRL_" "1".

Paolo


