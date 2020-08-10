Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0677CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B520322B4B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aY+msYEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B520322B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DWt-0006T6-0L
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5DWI-00061o-C1
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:31:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48092
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5DWG-0002oX-ML
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597087899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Z3gJ1lWjgKo15hIqZZeIVEOklrVnirRgdcVsAFadGU=;
 b=aY+msYENShRYVf87vNa+s0tkAaaE6FUri3O2PyirY75v15B77bwFPMrBw7a9gFAMPJ5TrE
 1O2YeYICPi0MkJkgK5eJAcqVOL2mn0L6prAZaybtR6yT7B2wqepNmoFGIdssQT443NiVPF
 BHtIikJ85Ifr5Pkdh2BwrTXeN+DMeQw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-9ffMVnF3Mvep5B3wqmSOjg-1; Mon, 10 Aug 2020 15:31:36 -0400
X-MC-Unique: 9ffMVnF3Mvep5B3wqmSOjg-1
Received: by mail-wm1-f71.google.com with SMTP id h205so162974wmf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Z3gJ1lWjgKo15hIqZZeIVEOklrVnirRgdcVsAFadGU=;
 b=GigWqAasgX8X1qVg1b/lo/Tprb+bBu0ohLYkB/kcp92f4OkmtKfnrSKuVLZM2fZt/A
 ycBYaRUf6kYCGJ43KzTUsQ9VGr5mwRvPEtkf7VONMw+w0ukNXFApXWnNOvObSQ5uKMk8
 cNH1hmC8UpeeWh++TZZ7h7yOWEw38jR2dEHfT+TSCj11p+vY8h8Qk+Ra5DzALGq3DHpS
 +FvyL8xzMV/edA6V2HPcSd2mtqZYFOhQLH+5jx/uTpe0WTHTbjKQyqxRcXYCxTDtWydx
 YTWzBsoHG1hm3dyJtekj3Jonk1lBmI6NO26AD5v7YISQ4qY5OtY0Yef7FVtgaa7Z/Yj0
 wbWw==
X-Gm-Message-State: AOAM530sNtWngWjOJvG13sKdqk2rkfJOXT+M+X0WftjruWTU+nH4ARAD
 uskAt6uQoZxCURVjAZS6+Oze9/Z1i1iaayhVugmMar1ZhTd7hLrpywTs+DjlDYkQ0TCoONxCfLz
 +dzXdYiWYMFtCX4Y=
X-Received: by 2002:a05:6000:1149:: with SMTP id
 d9mr24900618wrx.335.1597087895505; 
 Mon, 10 Aug 2020 12:31:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvMABAQibdGLhMI0w7/s1lLlqAAvynSebGANSdE2QavC8QC5nX6VFCK/gT6Gjju59qXZ7yUQ==
X-Received: by 2002:a05:6000:1149:: with SMTP id
 d9mr24900605wrx.335.1597087895242; 
 Mon, 10 Aug 2020 12:31:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id z8sm892019wmf.10.2020.08.10.12.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 12:31:34 -0700 (PDT)
Subject: Re: [PATCH 135/147] meson: sphinx-build
To: Peter Maydell <peter.maydell@linaro.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-136-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8J3-Sb4r4CqmLE=cmZHL311_B4EZD7L5+N-OhHD+X9jg@mail.gmail.com>
 <0c4c75a6-0165-6549-6d3d-24c3f3f7d180@redhat.com>
 <CAFEAcA8o6PvVMhxS5VPmqMiXEjCdFf194-LAOqrMm4VhaOAV6w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85e3b495-9855-dc16-986a-1042de99237c@redhat.com>
Date: Mon, 10 Aug 2020 21:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8o6PvVMhxS5VPmqMiXEjCdFf194-LAOqrMm4VhaOAV6w@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:00:11
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 21:21, Peter Maydell wrote:
>> Yes, because the Makefile's approach is not maintainable in my opinion;
>> *.rst.inc files were already not included in the Makefile.  I'll look
>> into using a Sphinx extension to produce a dependency file.
>
> Yeah, agreed that the makefile approach isn't great. (It lists
> some .rst.inc files but we added more without updating the
> dependencies, I think.)
> 
> If Sphinx can be persuaded to output a dependency file that
> would certainly be the nicest approach; I hadn't thought
> of trying that.

It should be possible and probably not too hard once I figure out how
Sphinx events work.  It's a fair request since build_always_stale is
inferior and Meson requires no particular magic to include the depfile.
 Maybe that will win you over. :)

I can also leave out sphinx from the initial conversion.

> It would be nice to note in the commit messages where the
> conversion has made this kind of "we're going to do it a
> different way" design decision rather than just being
> a translation of the makefile logic into Meson.

Yes, I'll do that for the final version (to be posted Friday or next
Monday).

Thanks for running these initial test, it looks encouraging.

Paolo


