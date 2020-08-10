Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248CAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC742078D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWyWirlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC742078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5D8L-0002nc-1Z
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5D7k-0002Ov-Bv
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:06:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5D7h-0008Ve-IT
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597086374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kkOKCF2a88WeEfdfy8mqiRI2pMkAgSwQF36yJfUTHho=;
 b=NWyWirlCFINbFT5/WN0RgZBg/BZN5D3CSZaj5dPBhtfsU8G22S2BWZHUbXmX4U1KWTQE57
 TXXzqT0LHdVFn2DCar2+Sv9fla/qdjcIRFxtG0UO4gChOFQ22BbLojj01FgHI9/uum3CqQ
 qYa554mFtqJD8vbn83MT0I9bMq1ddqM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-raugdkNqO9Wx5Zb_89cF5w-1; Mon, 10 Aug 2020 15:06:12 -0400
X-MC-Unique: raugdkNqO9Wx5Zb_89cF5w-1
Received: by mail-wr1-f71.google.com with SMTP id d6so4566758wrv.23
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kkOKCF2a88WeEfdfy8mqiRI2pMkAgSwQF36yJfUTHho=;
 b=uWPw+4LjDGgrQt+Y1iNZe7Vt9SFyZPUVPo1N3yDfVteBnuNw819R9GhvtDHeG94sIk
 qB/EK2ud+zA+BlYjP76uBF85J8iLdcpfozyZctd/abyAdzt7zWB/4WcTNi1/Zp2ezXb7
 hz+kW9/f0V8lSW5mgYjep5oRH7RitZ/B0ABo3jdujWJqEhTSyd9ebyWYq7/AnTHyv5V3
 sfyvZyF2BDhIpN0EzZpBWv2JUaU9sFD7Z6xt0XROQcu3ebcg3Pjq3v0loJ0fwFId9S7p
 26yddoYHAui5EjpYi3XTREMv6U3svPwV0W0To/pR8jXofDBriJCM9a8dEnAjehzimf2F
 MEbg==
X-Gm-Message-State: AOAM532W0C8DZZp63RJ7nj5TjKLug6C2nyYQ7KAagqP8f7gamHRZjN8/
 ZTlS7b7tN2YVwxnVC4IWEAOpKYKqLUkiWErxGx2Cb77YESK2YuG2tWyo6n2Bpi/6bqwlMaoymJt
 DfYcd8oiJNLPUVmI=
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr5959wmh.80.1597086371166;
 Mon, 10 Aug 2020 12:06:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvTrkPlUOyj2tqmIqCxQRh/pHOkWhoUMfx3Xgytuq5INkT2ZOQ7KfFIjHLtWNUQMTbcW2/2Q==
X-Received: by 2002:a1c:ed16:: with SMTP id l22mr5939wmh.80.1597086370849;
 Mon, 10 Aug 2020 12:06:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id 31sm22365459wrj.94.2020.08.10.12.06.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 12:06:10 -0700 (PDT)
Subject: Re: [PATCH 135/147] meson: sphinx-build
To: Peter Maydell <peter.maydell@linaro.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-136-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8J3-Sb4r4CqmLE=cmZHL311_B4EZD7L5+N-OhHD+X9jg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c4c75a6-0165-6549-6d3d-24c3f3f7d180@redhat.com>
Date: Mon, 10 Aug 2020 21:06:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8J3-Sb4r4CqmLE=cmZHL311_B4EZD7L5+N-OhHD+X9jg@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 20:33, Peter Maydell wrote:
> On Mon, 10 Aug 2020 at 19:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
>> diff --git a/configure b/configure
>> index 21b9ed2..7e7b4d8 100755
>> --- a/configure
>> +++ b/configure
>> @@ -7768,7 +7768,6 @@ echo "INSTALL_PROG=$install -c -m 0755" >> $config_host_mak
>>  echo "INSTALL_LIB=$install -c -m 0644" >> $config_host_mak
>>  echo "PYTHON=$python" >> $config_host_mak
>>  echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
>> -echo "SPHINX_WERROR=$sphinx_werror" >> $config_host_mak
> 
> Shouldn't we also be deleting the code in configure that
> sets $sphinx_werror if we're no longer using it ?

Yes.

>> +    these_man_pages = []
>> +    install_dirs = []
>> +    foreach page, section : man_pages.get(manual, {})
>> +      these_man_pages += page
>> +      install_dirs += section == '' ? false : get_option('mandir') / section
>> +    endforeach
>> +    if these_man_pages.length() > 0
>> +      sphinxmans += custom_target(manual + ' man pages',
>> +                         build_always_stale: true,
>> +                         build_by_default: build_docs,
>> +                         output: these_man_pages,
>> +                         install: build_docs,
>> +                         install_dir: install_dirs,
>> +                         command: [SPHINX_ARGS, '-b', 'man', '-d', private_dir,
>> +                                   input_dir, meson.current_build_dir()])
>> +    endif
>> +  endforeach
>> +  alias_target('sphinxdocs', sphinxdocs)
>> +  alias_target('man', sphinxmans)
> 
> Does "build_always_stale: true" do what I guess it does from the
> name? Does this mean we're discarding the makefile's approach of
> only running sphinx if it's necessary in favour of always running
> half a dozen sphinx invocations every build ?

Yes, because the Makefile's approach is not maintainable in my opinion;
*.rst.inc files were already not included in the Makefile.  I'll look
into using a Sphinx extension to produce a dependency file.

Paolo


Paolo


