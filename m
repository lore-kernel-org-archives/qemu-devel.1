Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B2CC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D302D20796
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 08:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXCIj2Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D302D20796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH0a2-0006Fc-S5
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 04:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kH0ZH-0005O5-3G
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:07:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kH0ZE-00081i-MK
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 04:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599898047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wTOh+FE22Q6jXVOlCwC7CrqVzT4LK0kodnuzI35bQGE=;
 b=fXCIj2RatZX+HrUJ2Eti7cUZtrbJqHFCx0p4/ZMzqdWL5zpTwmCX9jqC4w5uQP/nN61Kl8
 OT7sTwLhYH05SaPHue9S9GMOMMA19jn4lVhp4ErEk8PLShwYQD7JSHnTjN5z+j/30+Vqnj
 /bTB2o9mB26ZM/2SgIviboE7xHXOxSo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-Ucc03eADNjqo0zLIBRpVNg-1; Sat, 12 Sep 2020 04:07:25 -0400
X-MC-Unique: Ucc03eADNjqo0zLIBRpVNg-1
Received: by mail-wr1-f72.google.com with SMTP id v5so4094718wrs.17
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 01:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wTOh+FE22Q6jXVOlCwC7CrqVzT4LK0kodnuzI35bQGE=;
 b=D/dRYz35FvWdUzu4pmfYbP6ki9AsIzSLktpSNZD9MmgS+VYhv41+Ks+hnqerkYcNEG
 8mizmVF83EmbDbc1A4EKEDw0N+E95/CrR0xplf0tvuobqUaiUS1/VDPEo8eWigpQHjEM
 ozOBP0xH7xDZYmpSesliu5W5Db8caEOzSzc2GFPqX7r0FR+7aASQzoL2P0GNOLG3ePp+
 xPu1feRCNqGsuaOFiBoljraxLrqcr9fMsxTReUjblD0qAK/uhRsfa+LpnVPiqYFumeJD
 /sGVFFMWIiydpYCDJJ+TVAHo5flvVShhwSVuVb93xvwVcWWMLqjPqraBQ+dwrZjhQQPe
 ur0Q==
X-Gm-Message-State: AOAM532M2dcn8SjqXRSwmefwEdCJehS+VY7o4I9+62ETnAocM/Pcec+M
 BsN0aJMLBIdelzt2m/LUbUMSVCHRvrA/PiGFL2X2unnncifDYBqPWPsYwQJJUCDDrsC7dW1B8Xu
 3OGA0BxleCdevmaE=
X-Received: by 2002:adf:c44d:: with SMTP id a13mr5680017wrg.11.1599898044638; 
 Sat, 12 Sep 2020 01:07:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgf0F8MYAsFeKzImvSjCFNN/TjlR/HEfqm3l/IXbFQZ3PNw1rZc22FtN7ttXN2JFxmkx3V8A==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr5680001wrg.11.1599898044453; 
 Sat, 12 Sep 2020 01:07:24 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id v6sm8816435wrt.90.2020.09.12.01.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 01:07:23 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] hw/mips/mipssim: Use MMIO serial device on fake
 ISA I/O
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200907011538.818996-1-philmd@redhat.com>
 <20200907011538.818996-2-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e3f36d43-0c3d-0dc4-1e4f-2694a323f638@redhat.com>
Date: Sat, 12 Sep 2020 10:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907011538.818996-2-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 02:01:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/09/20 03:15, Philippe Mathieu-Daudé wrote:
> TYPE_SERIAL_IO is a superset of TYPE_SERIAL_MM, using
> regshift=0 and endianness=DEVICE_LITTLE_ENDIAN.

*subset*. :)

Queued the patch, thanks.


Paolo

> Directly use the TYPE_SERIAL_MM device, enforcing the
> regshift/endianness values. 'regshift' default is already
> '0'. 'endianness' is meaningless for 8-bit accesses.


