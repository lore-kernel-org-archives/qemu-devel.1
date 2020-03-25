Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB73C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598532073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDtIv2gH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598532073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH8PF-0007Xz-Iv
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jH8OX-00070I-Ta
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jH8OW-0001wm-FQ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:56:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jH8OW-0001w6-5a
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585151799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=if4nHKgfpw8B1AsCEBhVgAmrqo1dvIsWXXvDq7Z93T8=;
 b=aDtIv2gHVrP3SKQM1AMGytEGHr7+hacxT0Qc9Qs48kOmT5zNxxLkxZLF/pAEeliqSoQSRS
 Dd6v4eaixxGHpR+zw0SV7DNgKh67MTahye9K8fVGs2W6HT/T+zpTjp+eL4CGp/wvUPjLL/
 l4f3kRXUTc77bEk8fV8IqT1RA5Gj0Os=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-8IEQDnB9PhuI6GVm2RxeeA-1; Wed, 25 Mar 2020 11:56:37 -0400
X-MC-Unique: 8IEQDnB9PhuI6GVm2RxeeA-1
Received: by mail-wm1-f72.google.com with SMTP id s15so852821wmc.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u0ucPd8wZZF8yHJ+IxpLkbR+ZBVaadk/NDa5B5PcHks=;
 b=p+lWMV2wtPKnbgxj+mIY5Hs+Uag4TXHsMHkF48ZkCTjsQv8XCVij3BqS8JEVqw0jYr
 kGt4lpSXblCPe2MFioR88sx+4Neooe7/IPIlptwA7w3UKkVvrYn9s71gfwV6Cho2b/iV
 divtKxj/q8WhBfsoR02IOXpoiU3h6Opavxlb8MAeDsuCevJndpPbYfRIkx5JyR/g4CMQ
 TeCC/gHDahZRwkWlusy2s3Oq44jcBhmjl9CkK8Qoz779Kn1jVmGOw8MxoovOWW1DHxSn
 qLBCmqmdY6e5+wbgKrSFQVwd3w0Nkscl2P/wcE/jk6/ZtbwogLBb1j0sU7xknmOxa9Ku
 QQTQ==
X-Gm-Message-State: ANhLgQ3Nb1jfpmA5X2IST671fAeWJ82gA3+x29QynbFOmA2kYdWY8gr3
 zF4EwyBf/zCDH2gfBS8X0FN20ge1a03SMoevyuVlkBttzejCxSkhrPKo7MLIroQ+vcZTbn8OYGl
 e9yQafAOqOgEOxxA=
X-Received: by 2002:a5d:640a:: with SMTP id z10mr4382113wru.301.1585151796688; 
 Wed, 25 Mar 2020 08:56:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuqZI6oOn+jxzKfTJys+OH4PrQUTV0RcG7AuZpZld+ldlQ613h/Ttx8CvicDrjaeKBUkTvhAA==
X-Received: by 2002:a5d:640a:: with SMTP id z10mr4382100wru.301.1585151796506; 
 Wed, 25 Mar 2020 08:56:36 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id t10sm11716010wrx.38.2020.03.25.08.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 08:56:35 -0700 (PDT)
Subject: Re: [PATCH v3] hw/char/pl011: Enable TxFIFO and async transmission
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200311040923.29115-1-gshan@redhat.com>
 <4c32dbe0-7d96-5e60-addc-b1bf43e17f47@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da34a58a-0474-c46e-7bbf-cb150bddc717@redhat.com>
Date: Wed, 25 Mar 2020 16:56:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4c32dbe0-7d96-5e60-addc-b1bf43e17f47@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, marcandre.lureau@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/03/20 03:32, Gavin Shan wrote:
>>
>=20
> Marc-Andr=C3=A9, ping. Could you please review when you get a chance? Tha=
nks in
> advance :)

Or Peter; generally arch-specific changes (as opposed to fixes in
chardev API usage) are generally reviewed by arch maintainers.

Paolo


