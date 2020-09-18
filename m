Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6B3C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFB32072E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSHeA0vG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFB32072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBe0-0005LL-Fg
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBWj-0006Td-86
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:13:54 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:33227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1kJBWg-0003rl-S1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:13:52 -0400
Received: by mail-pj1-x1042.google.com with SMTP id md22so3973000pjb.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QoWO5fhqzSYWTWcAIhsOh8YSobKDK5lSvbMoPLX+MSc=;
 b=fSHeA0vGev0FX3NsaP4L5MaQQuEUjG2Px92J20k5mweNDHqGG8g75Azg2aq0EPFDtG
 tQpngRMMzt1ONKVSiDn2JtEbJch4h/D20FaDRBwakcppt1nLqK8ZjM1mTEo2J2mYRlF6
 q3lvktstMX2S9nhBcAhrQk4Xe8fcr+xCM3x2bzo63HHCzE/GI3vKRSZGMgtXHarHtF+2
 kh29qWkFPlp3O41AYdaYLaatjpCOWl+IIFkTDrP/433geVvcAaDsriATBo7RM3z/mDt6
 t6LUhSzF2i4nrpr0Ax5koyleARBu54oiHMfzqZkZlJl+1d2Kf+Cjda1Gt0wE4fvhbPKY
 kFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QoWO5fhqzSYWTWcAIhsOh8YSobKDK5lSvbMoPLX+MSc=;
 b=VcczNjFjBGYtg15tn/0slkqtX14IXK1T1XbnoQSTI5Sirs+KksFwcgoa0hChLAWD3/
 ftJmeoT4x7pCOcMwO4bkdgYpM6llqnrKKepgUOzpVqc5HfB1seEE9N7WiNyXA2GuH6ji
 d3IizK7ghj31fZnj24qIDOVPYrmYKhbaQZHvhffzoNLmPw4meBRzhtPhkBaKbJlMx0A5
 JOoT+3mYmlSIB+nwJEGrFa5C7tsNWln/g7M4gDFOZ77hfmKsiwEgCBlTAsKo17HQT2OP
 K231A9kwoU0Dz/82EsWepKeZ7xxeUAYPDHo2Wl0rWWWshBwAuW+fxkn6Q2Ijr8qfu0bm
 oZTw==
X-Gm-Message-State: AOAM530W+Umhg+vfwqjLJTadG/0vEMQRdSX1ZMfhTR6iavi0ELxd9phG
 b2RaqZUFsPAQedI59oCmIqSfCjCABa2g9ji2
X-Google-Smtp-Source: ABdhPJzCLGBgD3Mynw/GE9rsnMvSGTGio8vKx7l9xOnuJgKtL/pdN5+C8yzuTGcncqnRNExiTpssCQ==
X-Received: by 2002:a17:90a:ea08:: with SMTP id
 w8mr12309791pjy.124.1600416829397; 
 Fri, 18 Sep 2020 01:13:49 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id s24sm2105890pgv.55.2020.09.18.01.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:13:49 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Fri, 18 Sep 2020 16:13:41 +0800
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200918081341.ew2m4fnfxicqjmgs@Rk>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200915153557.GA713593@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200915153557.GA713593@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=coiby.xu@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 04:35:57PM +0100, Stefan Hajnoczi wrote:
>On Mon, Jun 15, 2020 at 02:39:02AM +0800, Coiby Xu wrote:
>> v9
>>  - move logical block size check function to a utility function
>>  - fix issues regarding license, coding style, memory deallocation, etc.
>
>Hi,
>Any update on v10?
>
>Please let me know if there's anything I can do to help.
>
>Stefan

Thank you for ping me! v10 has been submitted.


--
Best regards,
Coiby

