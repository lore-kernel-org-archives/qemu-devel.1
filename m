Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A435C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1BA2193E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTQ4w2Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1BA2193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEfO-0000xg-3g
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIEX2-00006l-Ps
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:14:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kIEJE-00014e-HV
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600189199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ru/mL5Hd1MR8pJ+e7pAyN4rPmOhdtElEqExnXYflAts=;
 b=KTQ4w2VlGwq/yWdIyL+xxdEZIm3JUkPr76lhckKTRaH63cU4nR3UL/8P5EhTNCezdoUS0z
 fSNudQZjPB7NGH7E6/oGw0qPfIOhOVAbpCU0tvfR0pw8I8fQ9TPMoDFEgatJwgPSzygOY0
 pPdwchlmk+aCvqdD23eX7L3jvQu7oGc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-LIZnsE2cMSqHTMbOjGHaLA-1; Tue, 15 Sep 2020 12:59:57 -0400
X-MC-Unique: LIZnsE2cMSqHTMbOjGHaLA-1
Received: by mail-wm1-f71.google.com with SMTP id w3so57521wmg.4
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ru/mL5Hd1MR8pJ+e7pAyN4rPmOhdtElEqExnXYflAts=;
 b=bKAnsqE3JxznCC0g1MdPgJTRNMljnnc4vxAKQLfrOgPTgBqiduJZX14sIkud4EaoE8
 LIUpNJN1Zw6VMmIIUQ4Erutifg0uudXFb4XWFnACthFcSGDfELtHMLEo7usW451dwTGS
 BPmKPG8qJTTimeaV6whgA/9kJn/iDHih0K2OyP6oCoYCYfHEvRpR2ntplMd2Wh0wV0gn
 ksKUovDA0x7bNK9V7oBec0pBOWHlUdPPh8x87SKJOPY0FIuM5q3hOeorwM30NxSBGEv1
 KieNoZ6Km0kw4CnmFuMXdIux/JM0WPGOukwr/B/RPR/L1dN59GuqShcVbJ1vP3VtqfLl
 tD9A==
X-Gm-Message-State: AOAM533DZzrLrZDkJkEF03W2n+yQHMKoSu2nuRNkSr1lVCGeJE2m9YN/
 jOKBJQNhynuGZlSBNxT+Us7HnsTlF2J+x1dnV23J7rn1dD/D2YvVE3MkODlHy65sxlTrLChFigK
 BmI3khxeGfg9YDoI=
X-Received: by 2002:a1c:e256:: with SMTP id z83mr316345wmg.137.1600189196222; 
 Tue, 15 Sep 2020 09:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnQPFRF9EWcVYSfCbh0xMJO51d/20MGnTe3x+fcsxpuHSg6+Pc5qPVE+f8FWVvPAFTVJTPqA==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr316330wmg.137.1600189196024; 
 Tue, 15 Sep 2020 09:59:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:eac8:587f:8ca7:e1e8?
 ([2001:b07:6468:f312:eac8:587f:8ca7:e1e8])
 by smtp.gmail.com with ESMTPSA id n17sm29282827wrw.0.2020.09.15.09.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 09:59:55 -0700 (PDT)
Subject: Re: [PATCH v2 01/10] capstone: Convert Makefile bits to meson bits
To: luoyonggang@gmail.com, Richard Henderson <richard.henderson@linaro.org>
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-2-richard.henderson@linaro.org>
 <eced490f-0250-3516-5d75-c6c3ff6e97be@linaro.org>
 <CABgObfbWzf7DLgx23+yMqYqnMUaiJ=0WKaW4zvzkA4u5T9fQXQ@mail.gmail.com>
 <4813770a-34a4-72ce-17f7-7ea451a7af99@linaro.org>
 <CAE2XoE_he2L85WgAg5NBWKLT+FFy6RJDULsL-QWBH0jbhxZTpw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2444b9f2-3668-8ca8-2e9e-3215d55b1472@redhat.com>
Date: Tue, 15 Sep 2020 18:59:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_he2L85WgAg5NBWKLT+FFy6RJDULsL-QWBH0jbhxZTpw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 11:54:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/20 18:12, 罗勇刚(Yonggang Luo) wrote:
> 
> I suggest remove the capstone=system option cause the system library
> may not satisfy the requirements of qemu and create in-consistence
> expereince when bug or error happens about capstone. We either have
> git submodule capstone or nothing at all

Linux distributions generally do not want to have bundled libraries, so
the fallback to the system library is the default.  We single out
capstone, libfdt and slirp because they are slightly less common
dependencies and are missing on some distros; however, in general we
strive to _only_ use system libraries and not package any of QEMU's
dependencies.

Paolo


