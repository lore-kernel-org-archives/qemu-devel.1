Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9A5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB3F206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 11:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfP5xewJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB3F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k55sM-0000p7-9S
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 07:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k55rT-0008Pp-PC
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:21:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k55rS-0000tH-29
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 07:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597058461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXbYEs1/8+2FAcCsKigAZ+C0X28e6+vK6/uxLkuVACQ=;
 b=IfP5xewJlmGSdU2E5cZfhMyz9+9rk/EnpZ1YTR9IzBRotsh0KG4JxThJOMGIv1K9qyXhny
 Sxoab0gmKyp2cj2QgWoPN2gdlZ7mDPYTDcfO39sJFLExLFGRS13P/Rh4GvjQCY+39pQTP5
 0hD8SH4efEH6mGT8GYeDlC64K58KL5c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-HiPDeVjdOwSiVfOYlG1YnA-1; Mon, 10 Aug 2020 07:20:59 -0400
X-MC-Unique: HiPDeVjdOwSiVfOYlG1YnA-1
Received: by mail-wr1-f69.google.com with SMTP id 89so4082241wrr.15
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 04:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OXbYEs1/8+2FAcCsKigAZ+C0X28e6+vK6/uxLkuVACQ=;
 b=BMw/kcFGe4Gqu3mBPHZe9pXAgG/2wtHjOwAZh7UjsRA2kNRVBW3E84kPvpw+/gkEST
 LUPpRePYUvTFoU1sBRVcCdEN6tVgQ6Nnkstsr6WJgkUkGXFUUdbj/rM7cL1nX4PPNX30
 HJw/Ks8lWhTOzlZnkYn4eh/7RLHQDVyr2GRxflqZsAFQGM0NV5EMO20uXEIWXIZQGbbo
 Z8GeF0s9pms5UOSNte1XrBlLan7mF0i4jGTjibDbo5/GHXDRuxAojWJ1SeI9p7BhdL/U
 qgodZrbJMjM0CSJqTx4eAwDxz9DzdJU5f+peKoF9Lo+bQp15PKwc5rqwd5NoYlugPoDw
 c/DQ==
X-Gm-Message-State: AOAM532iMLo6xg8TPnk1kU+A5cX4gwZvlM4OgOUxxt0c4w78NG7O9veg
 9ZJwWDTgUsXJ/yG4/J6Nd5tiYKo3s+K1GOFFuOezp5iEJBQT/vqWPcjxEbfdKP0kyiScLPEMNU3
 KA8O5DqdWaH/UqMs=
X-Received: by 2002:adf:f48d:: with SMTP id l13mr954760wro.43.1597058458338;
 Mon, 10 Aug 2020 04:20:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwldMPKpipl4cZJzisIKYObQaa+31ij2rR9wPOQ2cAIyMFjd58UVcTnI+QU/WisDMdmAPFW1w==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr954738wro.43.1597058458106;
 Mon, 10 Aug 2020 04:20:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id p6sm19619797wru.33.2020.08.10.04.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 04:20:57 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <20200807142939.GK120942@redhat.com>
 <9d39936b-fd7c-6545-4ecf-03f140d13a08@redhat.com>
 <f028dc68-400f-cb4c-bacb-0f9c46a7d2ed@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4fbd1e97-98a6-cd32-d817-8ee683f0e894@redhat.com>
Date: Mon, 10 Aug 2020 13:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f028dc68-400f-cb4c-bacb-0f9c46a7d2ed@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:31:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, stefanha@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 12:34, Philippe Mathieu-Daudé wrote:
>>> New binaries have lost a bunch of libraries they previously linked
>>> to. This isn't neccessarily a bug, if the old make code was incorrectly
>>> adding too many libraries.
>> Yes this is because Meson uses --as-needed.
> Maybe worth a patch at the beginning of the series, before
> starting the conversion?

Could be, yes.  Thanks for the idea!

Paolo


