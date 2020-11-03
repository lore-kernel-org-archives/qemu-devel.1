Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A478C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D591B206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIhFJKJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D591B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzGs-0000zf-TU
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZzG5-0000JS-RM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:34:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZzG1-0006Rw-JY
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 11:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604421243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUu/IDDy3B59Y/WrNoUHKxzlUS7uCkziN9UJzUBcbMs=;
 b=LIhFJKJGpFsmjeng+E/8R6Go6rmHnerQHmUB0C0kIVDq+2NSZ8H2fx3WjnjJMYeneAtRmm
 0eWl+i8yO1XdQjWd7v9NVkObKYxWxLlyMQVa4esW+Imk5ZaTvbtLvHRbxo1IS874QJ1g9u
 a0pAgFmOpMBGljdvVA8jFsRdtISxPTg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-kthoXN5jPAqYYQZphUKwtw-1; Tue, 03 Nov 2020 11:33:50 -0500
X-MC-Unique: kthoXN5jPAqYYQZphUKwtw-1
Received: by mail-ed1-f72.google.com with SMTP id n16so7708056edw.19
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 08:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DUu/IDDy3B59Y/WrNoUHKxzlUS7uCkziN9UJzUBcbMs=;
 b=Y7qAZK5C2e716HxZ3+4A1aSNQ5pw9qOp4FbqkHOlo7yii7mtfjQH4Yc2xw+jCWBI1r
 uU2tawoFPIId4I33+7ytfb5IyvAwi+wkc0VTYNaQhTU634/hjAGaBNujSL69jJYNhicL
 j9m5DljHXrOWjsF6EIWYplTb1fyNRt5qjlWDdfdnTX2Z5cpVGuDbrYebNiKTxwtJGLKB
 7npE5wk+fwQvwGrUsPBVm/si44/MJwcTRvWQUwGchLM9umjf1dDnpmV7awxMIYFfSbaR
 oCpN1DqovG/mAWi5cXpNxIJ4Z0KQEM1K+HhTTinZSNDIsI1m1qO+3fO+82lkzQaUYVv9
 gVow==
X-Gm-Message-State: AOAM533yTv+HyIOYCH9LkhXOcav/4p+zvyG9FMrfKidiBNtKfH3MgRn4
 4QMXIF/4ZPFfvcTE7V8w/FGrU6/liKlwxqF+6NZ3nbRfbhL/Q3OMC3KS/7+o4GBLIZU3YGIokau
 8gTYJLW4ITGlzrkA=
X-Received: by 2002:a05:6402:1119:: with SMTP id
 u25mr23713751edv.37.1604421229492; 
 Tue, 03 Nov 2020 08:33:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0FnTFmazmf3vxCpkjfX0mY6RHe/UYhHPWRg4cYPDdAGfOZrfaVYsIuGqjNsbHjwxe4kuRvg==
X-Received: by 2002:a05:6402:1119:: with SMTP id
 u25mr23713729edv.37.1604421229282; 
 Tue, 03 Nov 2020 08:33:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id d23sm8476749edp.36.2020.11.03.08.33.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 08:33:48 -0800 (PST)
Subject: Re: [PATCH v2] qapi, qemu-options: make all parsing visitors parse
 boolean options the same
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201103161339.447118-1-pbonzini@redhat.com>
 <20201103162551.GQ205187@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e950af86-c45d-4165-a9f2-85ee6e845b01@redhat.com>
Date: Tue, 3 Nov 2020 17:33:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103162551.GQ205187@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/11/20 17:25, Daniel P. Berrangé wrote:
>> OptsVisitor, StringInputVisitor and the keyval visitor have
>> three different ideas of how a human could write the value of
>> a boolean option.  Pay homage to the backwards-compatibility
>> gods and make the new common helper accept all four sets (on/off,
>> true/false, y/n and yes/no), and case-insensitive at that.
>>
>> Since OptsVisitor is supposed to match qemu-options, adjust
>> it as well.
> FWIW, libvirt does not appear to use true/false or y/n, nor
> ever use uppercase / mixed case.
> 
> IOW this level of back compat may well be overkill.
> 
> I'd particular suggest deprecating case-insensitivity, as
> Yes, YES, yEs feel unlikely to be important or widely used.

True; at least it's type-safe code unlike the short-form boolean option.
 It only hurts in the odd case of a boolean option becoming on/off/auto
or on/off/split.

I didn't want to introduce deprecation at this point, because
consistency is better anyway even if we plan to later deprecate
something.  For example, since there is a common parser now, introducing
deprecation would be much easier.  It also lets us switch parsers even
during the deprecation period (which is how I got into this mess).

Paolo


