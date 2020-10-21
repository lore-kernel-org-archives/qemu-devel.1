Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0242C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 11:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D263220872
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 11:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKs7gb5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D263220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVCbF-0004eH-OV
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 07:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVCaX-0004Bd-Eh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 07:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVCaT-0007a4-PQ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 07:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603280843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvUfupnFdBi7nza7FvTqTdzldq5fzd9seTHFXQAFEF8=;
 b=FKs7gb5Og9Fdcu2+RnCdZUymMtrCOL1G6yGx4mYyyjfo/1tJdkswgJsLzW0lppmrD4+Lz8
 SBixejjLO2kmGYwNPYygGjpYSf2unkZxANSF1XvDLmrBR//cZHdRbix03EtqmHPU7wu+tb
 CxBUaI5a9vRmZe5LiC6qQqjjJanxriM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576--hjR_xBtPFyV5wZM1iognA-1; Wed, 21 Oct 2020 07:47:21 -0400
X-MC-Unique: -hjR_xBtPFyV5wZM1iognA-1
Received: by mail-wr1-f72.google.com with SMTP id u15so2338163wrn.4
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 04:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dvUfupnFdBi7nza7FvTqTdzldq5fzd9seTHFXQAFEF8=;
 b=mZ09YjA7lKhJtQyDYHXmOC+H+l0qmkHKKvjE49nG5zW28OBWuQPjS0Vkv8hq3t40BJ
 +kAui+jNNRLdOgTgVVw0nK7kxH50t90D7LXhvR75AzHvIDKPY7tCKd8JKa77C7T3Fl7X
 ryy2PY8uXQDRkXXL/9pjh0qOdm7YINIP+udWy+Usv4AmDVbjDkBNg/+dzQQgLMcTfKsa
 2G5ciSpM9gU9P/wEl7uHNB21QdI+BI99durvoAddNqbxq75OjYkNmrn4p2Jq+Kw8EMAb
 moh/iNLZjJClBVmYJT+W72Da07ZFvky8GAVxl8g+QrTMEzUbEYCsVRpQez8D86juFtNy
 uTfg==
X-Gm-Message-State: AOAM531pi25R3kz6uj/5z2aNMIyP8+4OuA3D1QbTOQGTlznF1OZ7xsJX
 Jo61ItIdyx+3owDGhJTdmsrMdzVewGbJNSyTC31i8u8B01LeIzy4ImLVTLT5FHUidBjoHfYutu8
 jeuGsL47xlmUA4Sw=
X-Received: by 2002:adf:de91:: with SMTP id w17mr4205391wrl.84.1603280839946; 
 Wed, 21 Oct 2020 04:47:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtq8GsPqh2dvZIrOCjm+qbOhhMqe1oggpW+4jIXMHETCjiRefXyQK4mKwdkGiE52eKSpwlWA==
X-Received: by 2002:adf:de91:: with SMTP id w17mr4205366wrl.84.1603280839674; 
 Wed, 21 Oct 2020 04:47:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id z11sm3280682wrh.70.2020.10.21.04.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 04:47:18 -0700 (PDT)
Subject: Re: [PATCH] os: deprecate the -enable-fips option and QEMU's FIPS
 enforcement
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201020162211.401204-1-berrange@redhat.com>
 <f97dc04a-0cc4-3ba0-ea5e-b185cd0958a7@redhat.com>
 <20201021083803.GC412988@redhat.com>
 <aae2164f-0973-f7b3-3146-1ea659c00922@redhat.com>
 <20201021101743.GI412988@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eaafe94d-1bf5-c2a5-a02a-bb56d5c45bdc@redhat.com>
Date: Wed, 21 Oct 2020 13:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021101743.GI412988@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: libvir-list@redhat.com, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/20 12:17, Daniel P. Berrangé wrote:
>> But would it be correct?  In order to have the advertised behavior of
>> "enable FIPS compliance just with procfs, no need to do anything in
>> QEMU" you need to disable VNC password authentication; so while
>> fips_set_state is an abomination, fips_get_state should remain.
> There's no need for fips_get_state. Once you build QEMU with
> libgcrypt, when  VNC requests a DES cipher handle, gcrypt will
> return an error as that algorithm is forbidden in FIPS mode.

Oh, I thought we were still using our own code for the modified DES but
it _is_ actually using gcrypt or nettle if available.  Sorry for the noise.

> This is the primary reason for outsourcing all crypto to a
> separate library and ignoring the impls in QEMU.
> 
> Claiming QEMU is FIPS compliant without using libgcrypt is a
> bit of joke since we don't do any self-tests of ciphers, hence
> this deprecation notice is warning people that libgcrypt is
> going to be mandatory if you care about FIPS.

Yes, agreed.

Paolo


