Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A45C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D6320754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBBLASGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D6320754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNftQ-0001kZ-GZ
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNfqD-0008Sz-HR
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44762)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNfqC-0001yS-0E
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:24:33 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601486671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5AAEcFEMnhFnNFSU1/JqoJcFCZ8UwLDwu1uI9eI4tnM=;
 b=KBBLASGiV6h8ftHNWoic/r82YO1bJve9uv7jRdQQWBNTj9pNgV2gQLqJN+DT/d44ZHJg1p
 sABU/oQuwTKDM53LwYhipylmGJbswl2EuK/Yy9z35QMjegUS4ZGAlElChprd7bsagoZhnn
 isVy2XjEJ1Uc8XcwZjcd4sy6JZIZjfM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-T7FgFAIlPH-sP_llliW0Zw-1; Wed, 30 Sep 2020 13:24:29 -0400
X-MC-Unique: T7FgFAIlPH-sP_llliW0Zw-1
Received: by mail-wr1-f72.google.com with SMTP id a2so859384wrp.8
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 10:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5AAEcFEMnhFnNFSU1/JqoJcFCZ8UwLDwu1uI9eI4tnM=;
 b=YrIuisXCR4p1AWXsXVFehDVGwpxX9BQLKNR6QNsk3wRXKQhVOH9fsUFiQahcv5TzUp
 UAT7+djLs8KjNa9OC+c7zDH899/Zlh8zBrVh/jfmH3ej5aiRZ4u9KSdQRNDSKAaSZcly
 Uqw+KdRjy86s5gxo4W+CLZrBCUqrKl2svvGXMI6W9Ywuu+6U07oW78cWNif6IMxU0MXK
 cTnrX8Mu35vXURo0BUMcibhOcjD+XCM+t4sOtCg6NEBoYM//ehZHZX7zxgDkuQNQWsMz
 R4hRdXM7wPckPxXuHg/nP4pWz8TTBCyXRZX+faGPMHP7bSmNlD9HRpk+g3Euaf7C7mfE
 VGcQ==
X-Gm-Message-State: AOAM533yXHIDgX53Ee7duUIf7MlBe+5gfNYqRR/r3m9OZpg+n3DL/JhR
 4i44Q035QgZWv2v8Dh4LEBVu+emZDMjp8sx7PfHOVPS0DBmWQSHNNG1TVSEzbwJw2E5DcyiKdz2
 nJnVga8fSxASJ2t4=
X-Received: by 2002:a5d:4f82:: with SMTP id d2mr4245774wru.65.1601486667800;
 Wed, 30 Sep 2020 10:24:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxARy+AsKYWHLPXxIvxUAS01oNNslinRPrCsmUFWpmItuZ91EwekBc/C9FLeN1R3go+u3kueA==
X-Received: by 2002:a5d:4f82:: with SMTP id d2mr4245752wru.65.1601486667595;
 Wed, 30 Sep 2020 10:24:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4?
 ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id w2sm4024839wrs.15.2020.09.30.10.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 10:24:27 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] user-mode: Prune build dependencies (part 3)
To: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
 <20200930171529.GR3717385@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c46bedf-9aa6-4ea9-40e1-b0f85a767bb5@redhat.com>
Date: Wed, 30 Sep 2020 19:24:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930171529.GR3717385@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/20 19:15, Eduardo Habkost wrote:
> On Wed, Sep 30, 2020 at 06:49:38PM +0200, Philippe Mathieu-Daudé wrote:
>> This is the third part of a series reducing user-mode
>> dependencies. By stripping out unused code, the build
>> and testing time is reduced (as is space used by objects).
> I'm queueing patches 2-9 on machine-next.  Thanks!
> 
> Markus, Eric: I can merge the QAPI patches (1, 11) if I get an
> Acked-by.
> 
> I'll send separate comments on patch 10.
> 

1-8 is fine, but I think 9-11 is too much complication (especially not
really future-proof) for the benefit.

Paolo


