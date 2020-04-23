Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A631C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F69E21569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAiqzHXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F69E21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRWf6-0007FO-BX
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 03:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWeV-0006mv-KP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRWeV-0007Uj-5b
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:52:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRWeU-0007UN-PR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 03:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587628325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yyWFHY+3gQdaQvjjK6WQzkgxrsq8Exq5czJhoFzq52Q=;
 b=UAiqzHXkUKBEd+WiR+hcFSxZZfRGFPtA+VBWVnbNRXOSq8dkZlIUpoM+pbax0BjbT3aciN
 KUL11FsXQ82J8XlXv5Cg4/PSZUc3vZzPUe0Zi3tmk0msivxc7p/O/N7rvXTHURSHGOxv5T
 P4kiEcx3Yy3XW68ubghQUqheRq60WpY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-gPI-P2-OMbqn2JP-phSVGg-1; Thu, 23 Apr 2020 03:52:03 -0400
X-MC-Unique: gPI-P2-OMbqn2JP-phSVGg-1
Received: by mail-wr1-f70.google.com with SMTP id y10so2450418wrn.5
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 00:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q94NFUiKsNYOrzCwJ59TsYAiZO8MV3PwVk5Cyfnxnug=;
 b=K+azZacNDprRnF9THOHXf2qDIEqP04kpMQjCEnQv5uYi2X6nk0Orr2NDoCyim8xgJ0
 dts4eOEC0AGGpmm/ij4f+u2Z39FqKOAl2I0U71dcgk3/uLYHa406YjF/ClDsYocSE8xs
 YZxNGtqlAVskVBnIuared8qgVAHGiYinEjS8lhBppjlZ4BXccO4E/xNXLm3fT1alXT0E
 E4c9x2b0/6YG4V0REVrdzqpaBFqbxrLVDsMGjZaaS46zyJJQi9Ph7Om0h/kkGMonARxc
 OlHOgU2wARnLE7tVs4B6dbBEHsdl+fGydAi4zEi0u+s8biNpTC476tdXyU1JMQ7Po5lw
 cfog==
X-Gm-Message-State: AGi0PuahFJtbA4h/kg1EimOUHjp0HpuJNihBIpMLQCUgixRuiZpa26g/
 dVCKgORhqTv+Ul31/Zdf9XhvVR5dDAHs+j0nrNKSFMhEMFyzK3fKwuDkUgly652AHyQ2w1aASY9
 p/JJk1AjBYGJYHHI=
X-Received: by 2002:adf:8363:: with SMTP id 90mr3223076wrd.233.1587628322647; 
 Thu, 23 Apr 2020 00:52:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXlVK6yWdgbT8SZVv/yf3SJw9Lx62WZBRFjLI08rxYNobnZvr+x6zfpJjjOlMiUVZfW3qIiQ==
X-Received: by 2002:adf:8363:: with SMTP id 90mr3223059wrd.233.1587628322472; 
 Thu, 23 Apr 2020 00:52:02 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n6sm2647182wrs.81.2020.04.23.00.52.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 00:52:01 -0700 (PDT)
Subject: Re: [PATCH 01/11] MAINTAINERS: Fix KVM path expansion glob
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-2-philmd@redhat.com>
 <e2537c54-f65d-1b9b-43ba-9657cc2b3146@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0eb2c68d-1681-2b2b-cbeb-74e472c5ae95@redhat.com>
Date: Thu, 23 Apr 2020 09:52:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e2537c54-f65d-1b9b-43ba-9657cc2b3146@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 01:42:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 7:30 PM, Richard Henderson wrote:
> On 3/16/20 5:00 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> The KVM files has been moved from target-ARCH to the target/ARCH/
>> folder in commit fcf5ef2a. Fix the pathname expansion.
>>
>> Fixes: fcf5ef2a ("Move target-* CPU file into a target/ folder")
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20

Paolo, do you plan to queue this trivial patch or should I ask qemu-trivial=
?


