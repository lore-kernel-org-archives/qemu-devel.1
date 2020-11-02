Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA3CC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF11322272
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2RxXC53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF11322272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZVpu-0001Vz-QF
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZVpI-00014o-S5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:08:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZVpF-0008WD-R2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:08:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604308107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IkKfUaknoHcPDTc0xUp6Z9AUPKkgSKphKg2FCf8atiU=;
 b=S2RxXC53pjvc+bK0PsE7ciTJO4br8Pgs+LdNoWJzqbNVzhVhovUeA2Gvw5CiuS5L7L1of4
 65brSKCywGncF9jaixUB6U39fYxfoipsM64H8/0IUCoAvO87DfmcyIwzenwKWrBFE7Mn7T
 XbK9hFXnxXNPZBDkP9Mb0O8olxs56Kk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-xuAv8CeAMWy4sLdMv4e7HQ-1; Mon, 02 Nov 2020 04:08:25 -0500
X-MC-Unique: xuAv8CeAMWy4sLdMv4e7HQ-1
Received: by mail-wr1-f71.google.com with SMTP id 33so6122283wrf.22
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 01:08:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IkKfUaknoHcPDTc0xUp6Z9AUPKkgSKphKg2FCf8atiU=;
 b=DxzgIbF7eIHcK60Qe4a/LS5G12aAgUY2PrZtmCmPTVVlbxfr8jMU+BDkgy84emFHDk
 pc7zPf6W7jse8dVLVyKtGnUXoLOx3WB8O1P6ywOy+5lhJqLnE9Zskug5rnnWCx9HaU67
 nv9aUmxHzJU7SMScy7bJuMWDyXmoIJTOGBYh1FjkJKYkFitGYNombwP6yFplLAkxxpXB
 U0tvSKIh8opkhxUKvRZF36zaodmvUmiFXIT83aa4/pbesQFbOy+22duDQ3v/u/AB0RjN
 7/NnuKcSwURoXlIg7arlvHTcj5670Xaz5RF3jtN45G2/30tHX0/1HRgKsPSYusTRwvWm
 +h7w==
X-Gm-Message-State: AOAM532uGP7+Z5gJH4UThu2bfBnrOZ5hh8JpHsjKiWZMVeuz5dQrjlzg
 4ckwK6LwlH79N11f/U8X2f1QGaVkAx3nuaJlVbz4vzHoYL7MvA04i1DwgzTlgoRAUo4z+7WrCxp
 SPuk/fYiTPTtrwBU=
X-Received: by 2002:a1c:2583:: with SMTP id l125mr6711836wml.50.1604308104689; 
 Mon, 02 Nov 2020 01:08:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHSUUH3P7RlDHDnc4ra9a4/1Rqv/qxz6aDESqEApuGFHuf1Dh9CdfqSFrU/Awb92aeMplVnA==
X-Received: by 2002:a1c:2583:: with SMTP id l125mr6711821wml.50.1604308104541; 
 Mon, 02 Nov 2020 01:08:24 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id d3sm20543853wre.91.2020.11.02.01.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 01:08:23 -0800 (PST)
Subject: Re: [PATCH 1/2] MAINTAINERS: Add QAPI schema modules to their
 subsystems
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201102081550.171061-1-armbru@redhat.com>
 <20201102081550.171061-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b766a9ac-997a-1ce4-3f2f-eeb09e693871@redhat.com>
Date: Mon, 2 Nov 2020 10:08:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102081550.171061-2-armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 9:15 AM, Markus Armbruster wrote:
> Add the relevant QAPI schema modules to section Audio, QMP, Tracing,
> Cryptography.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


