Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66815C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 13:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1882158C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 13:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bemXyOzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1882158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHSWk-0008JN-OX
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 09:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHSW2-0007sr-AQ
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 09:58:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHSVy-0001tK-9r
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 09:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600005477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vdQUEHlWkCiys46XzinUGc5luQGW0Iy59x6BKXAEGJI=;
 b=bemXyOzEPegTJqHDP9y14kHDiZc/EtUuhVrtctvQmj73gzJdPAOos6Ou0PwEu5RYG+Nd1G
 QkgFOpuEq3Yy/hqayPbmJmW33WZ0/YoWxGXF8pOLEf/jQ7OyA/UNKTvBLy5ltf+0J62gIP
 nT16GGUpxNIDqk+1y/tK/oBf045LHCs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-Ch44NfKwP7CfNDWrdvL7-A-1; Sun, 13 Sep 2020 09:57:55 -0400
X-MC-Unique: Ch44NfKwP7CfNDWrdvL7-A-1
Received: by mail-ed1-f71.google.com with SMTP id l2so8230185ede.19
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 06:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vdQUEHlWkCiys46XzinUGc5luQGW0Iy59x6BKXAEGJI=;
 b=Z307LD21YAupWj77GBVqMjYqA6Q3U9CjpGhbjwgjRdz7pKBBxXWafc9pDeh2R0aC0O
 oxcv8fdmJ/qfoy3tligojkaXkOFT5Gr+/yu8rYxf0lJT+4lPv/Rv0YCLa42J1pGeLm7P
 HDL3faUKI5LSiroT7GSrgj0zQp/qvDKlHogFYWSBf7Nf/ODUJe7aN+8FTUBR0kcQt2qW
 D/DdaH7TLEAwYnQkF119ay9aH+y2018sxT/gu+25Jx6uvqmKtI+oZQ63kwWr256ubtur
 1qFwsHzTyNqVYZslUbQTLjW77qID25O9tMpnJmgVf49vOwTF8kGiy1pvOPT2oTbgXv45
 bnFA==
X-Gm-Message-State: AOAM531yNa5stP5sCaqcco2stlilV2zp15e4QV4oyhBpfKSlfHsadXvx
 PMv3UFpvnaATZ5gy3FVbM+47yrwVzsmDYya2Oyot7ndo7RnyLI4t7/L0+/bS/7XGp2oya7Se6aM
 kviBSWfdqSoeR78o=
X-Received: by 2002:a50:a2e6:: with SMTP id 93mr12349620edm.147.1600005474225; 
 Sun, 13 Sep 2020 06:57:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxvBrlolFPvpM1p1qyYX8TJKhVNJ04TGSuVH4unuRJYoZcjHUaTxFdSM3uvvNwK9zRJ19j7A==
X-Received: by 2002:a50:a2e6:: with SMTP id 93mr12349608edm.147.1600005473986; 
 Sun, 13 Sep 2020 06:57:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:edca:afb8:6969:492b?
 ([2001:b07:6468:f312:edca:afb8:6969:492b])
 by smtp.gmail.com with ESMTPSA id o14sm7334326edj.77.2020.09.13.06.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 06:57:53 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
To: luoyonggang@gmail.com
References: <20200913100534.22084-1-pbonzini@redhat.com>
 <CAE2XoE8sgGfeoxn7+g4vEnYF52Axx3DOA=37hCO05sCkf+cEdw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bce56203-de6a-4aab-478b-8cb61ade477c@redhat.com>
Date: Sun, 13 Sep 2020 15:57:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8sgGfeoxn7+g4vEnYF52Axx3DOA=37hCO05sCkf+cEdw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 07:31:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/20 12:15, 罗勇刚(Yonggang Luo) wrote:
> 
> I am confusing about this? we were converting configure to meson,
> and python is a force dependencies, why we need rewrite the script in
> Perl? If we wanna build qemu, the first thing we need to install is
> python+meson, so there is no need convert to Perl or bash script. And
> perl/bash will incur msys2/mingw user, the ideal way is we only 
> depends on python+meson to building qemu

The main issue is that the Python interpreter is any of python, python3,
python3.5.  Furthermore Meson's shebang python is not necessarily the
first "python3" in the path.

Perl is pretty much always "/usr/bin/env perl".  Note that Perl is
already needed to run "make check".  When/if it will be possible to only
build QEMU with python+meson there will be no configure script anymore,
so Perl is a reasonable choice for parsing the configure command line
options.  It wasn't my first choice, in fact this series includes a
Python implementation, but it does have some advantages.

Paolo


