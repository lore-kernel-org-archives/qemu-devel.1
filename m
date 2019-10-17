Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0885ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA50220872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRBSJnle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA50220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL911-0000Dt-DC
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL8MX-0006ep-2x
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL8MW-0000XF-1A
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:10:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33569
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL8MV-0000Wt-UK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571328651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RepJ903D10eNe417LxnOmR8HtEzoIAHRfe/KqpSXijA=;
 b=bRBSJnlehjKTI2/c23yYmX2usuwpRjQ7XR1THp735HPnJWUlZrpJI9ru2ufX9yNgLeX/tQ
 vHzrZ3hPEGhabgBpjOvppnLmlJ9bgFPMMohOc55ExIxtKTFR/3VtIH4GqGg/0+mTaHgy2Q
 Tbt9Q7c96yct2SjK4ImDqFjErSdUOYg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-lZwk3Dp8P6mZWvPiDdKEDA-1; Thu, 17 Oct 2019 12:10:47 -0400
Received: by mail-wr1-f69.google.com with SMTP id e25so596162wra.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CvQc/NEnvbXnTc/qr03QQindo2pV2kgowwbGYhaOFzk=;
 b=XtmZnINz6r+PfYT8rntQnz2RyB+BdOHCWO5gFGT3vfNhSFpnVp8GkeJZ7QJr3aLCLb
 qu6IbY/ueNrr1EhGr4CGE1LUYZdjpmS5gAmKzUcW95rhu+td1ITSR6jtZFSOsSV78O6Y
 7nXlgVwGO4LIF/5O3Wd2XcEKg9j3kMqRz9kIMA7mGkn2frRR+f5E3g7KMXnNtfEd1VqD
 jYKSkPE/v5YUt2wrmV7yYiQPp1AhIBwCpyx1yJ6RivRvFtvDosbtE3kp9A8VJZpxTW6E
 1GleyAaELQsPDNDC2o9VUWxMQvPwDvxaRLzYINVS2OLJQfarM6+nUBQBMqfPhib45ujv
 M1bA==
X-Gm-Message-State: APjAAAUoDxu6jWvHWcNzgtlXfEo4waKNr/s3gedcELUO1Cb6KD5sL8W7
 GY4jXUnXKv/5I59Lwh/C3vO5G5YeOoYV55+p6cjDTYfcJATVi3O1bhVvuR45gmKRkDXYbVkOcUi
 os2o9N1zXhv4ePW0=
X-Received: by 2002:a1c:7c0a:: with SMTP id x10mr3656388wmc.48.1571328646601; 
 Thu, 17 Oct 2019 09:10:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyceWUH1/UgnMLP803Z3VPEixGq0Jwy6ZMGNM+QXh4YIrEPrii0nKg4fijd4viTIUHsbQi0+w==
X-Received: by 2002:a1c:7c0a:: with SMTP id x10mr3656359wmc.48.1571328646438; 
 Thu, 17 Oct 2019 09:10:46 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id d193sm3248211wmd.0.2019.10.17.09.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 09:10:45 -0700 (PDT)
Subject: Re: [PATCH 3/8] hw/timer/lm32_timer: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <128a3f39-4460-6407-21ed-4b3e957f327f@redhat.com>
Date: Thu, 17 Oct 2019 18:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132905.5604-4-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: lZwk3Dp8P6mZWvPiDdKEDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 3:29 PM, Peter Maydell wrote:
> Switch the lm32_timer code away from bottom-half based ptimers to the
> new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the ytimer.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/lm32_timer.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


