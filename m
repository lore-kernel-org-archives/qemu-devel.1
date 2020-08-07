Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FF4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5010F21744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 16:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAlFWPeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5010F21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k44qq-0000go-Fu
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 12:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k44ok-0006IF-6W
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:02:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k44oh-0007QN-BQ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 12:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596816117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=05MK1eXcP8z4/MkVLHpHSNeptkJG8WR/W/EkcQwCAv0=;
 b=JAlFWPeToIFp6u4saz3p36uOmhCF8P6Gy13rVACRAMGZI+7J5niGSbZqUQQnvP0lYeO76v
 bYvZ9kW1gjFM0/ADcwnQuZlSUk4pauBjzw7fjr9DlOP37eJCxFlw6J2mOXffjKDHKtgufn
 tnPgE3UcuvxXjvq7/ZO1fLBgOqXRTrI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-nmfbAMwQNN6jDBGFv0FGYA-1; Fri, 07 Aug 2020 12:01:56 -0400
X-MC-Unique: nmfbAMwQNN6jDBGFv0FGYA-1
Received: by mail-wm1-f71.google.com with SMTP id p184so846616wmp.7
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 09:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=05MK1eXcP8z4/MkVLHpHSNeptkJG8WR/W/EkcQwCAv0=;
 b=E1RYA93DY92DIATi6UqUlGe7VBhjXegohQNrQ950GJw+Jt80PXnpmuJ/cdcMomAfLg
 nL7x1W/ReGsTAJFi851lp30d3jLN5644RbrNxdlTs/foJLD9pr1o8S/fNwQI45hB6tL+
 OhPGmUzXyCXjMA+eehgElp8JCVR3Y3NJa+JophnXRS3CIvmpdaiOV+SnOWNRBfvdH0QG
 nyW7EpRad7Wbt33A8LdBaMsruFuIokbIfpPr2ItoYpLx7KyMYnE6EXC8IWOrgCaXmr2/
 6gSpcaTbm7u5KQgPBzm+WH8qdpaNOMJGpL9VpElERe+ggHJ5vftVd/sA6cYwLKPZyZrI
 eXbQ==
X-Gm-Message-State: AOAM532kaONPhChcuyM8KqoEFkY4fRIiuu8qgQpyX6rWaoBGTFmSLGeM
 3tmxiP2oR5Rv2OdZ6KZfQ/mZ/NJKbDYMhqKy1X8H8j6uXx5lvHEZ4dOFr4x4alDq65TXv42YDey
 UNDzUagOUFPdLMQU=
X-Received: by 2002:a1c:2350:: with SMTP id j77mr14100456wmj.31.1596816113970; 
 Fri, 07 Aug 2020 09:01:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKLFxPsJtiYBHKxaHtUSx6TKOjA20YvoSxb/tR+SAk3iPsglNock8+8Bccyhri3oG9n7XBWg==
X-Received: by 2002:a1c:2350:: with SMTP id j77mr14100427wmj.31.1596816113693; 
 Fri, 07 Aug 2020 09:01:53 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.136.3])
 by smtp.gmail.com with ESMTPSA id m16sm10407435wrr.71.2020.08.07.09.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 09:01:53 -0700 (PDT)
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
 <9d7b7f59-ec3e-1f74-d1d4-359e3388f0f8@redhat.com>
 <87ft8yd0ht.fsf@dusky.pond.sub.org>
 <CAFEAcA8-qAh9RzAZNqFS9HphAEDuCVVGzZO7vKem-1WCJogyjw@mail.gmail.com>
 <f8cb36ff-a98a-9147-1c31-6f6394a4ec77@redhat.com>
 <CAFEAcA9U80eDOoRV9GkXdqSyg5CpWw2TWQk=DXXF3GXj2XOzNA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d4a4cb0-7ee5-b5f0-69c5-57c75ae5ce48@redhat.com>
Date: Fri, 7 Aug 2020 18:01:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9U80eDOoRV9GkXdqSyg5CpWw2TWQk=DXXF3GXj2XOzNA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/20 17:26, Peter Maydell wrote:
> For instance, I was just glancing through the Meson FAQ,
> and "tell the compiler not to use RTTI for C++" is apparently
> something that needed a change to Meson to support, which seems
> ridiculous.

I am not sure why they singled that out in the FAQ, but there's actually
an explanation for requiring a change to Meson: the Meson option takes
care of that for both Visual Studio and GCC.  If (as we do) you only
care about GCC, you can just add -Wno-exceptions just like you'd do with
Shell+make.

I agree that making it a FAQ is sort of ridiculous.

> This really feels like we're going to find ourselves
> in the future boxed into "we're using Meson, but we also need
> to do X, and Meson's opinion is 'nobody would want X', so we're
> stuck". This initial attempt at conversion already got stalled
> for a long time AFAIK because it took a long time to get a
> feature we wanted into Meson and then for Meson to do a
> release with the change in it. That seems like a bad sign to me.

I'd say it was mostly because I had other stuff to do.  Rebasing to a
new release needed me to have the right amount of free time (a lot) at
the right point of the release cycle (during freeze).

What you refer to is the fact that it took a long time for Meson to
declare the "keyval" module stable.  That module is what we use to load
.mak files from configure and minikconf into Meson, and it was a good
thing that it took a long time actually.

The initial version was called "kconfig", and the Meson developers were
worried about advertising something called "kconfig" when the only user
was QEMU and it was not even using kconfig.  In the end a user pointed
out that QEMU's config-host.mak file is in fact not a valid kconfig
files.  The Meson developers agreed to keep the code exactly the same,
just renaming the module from kconfig to keyval.  So I think they made
the right call.

This was the only feature that took time to stabilize, and I think they
made the right call.  For what it's worth, the list of things that were
contributed is as follows:

Completely new functionality:
* New "keyval" module
* New module "sourceset" to match source file lists against config

Extensions to existing constructs:
* configure_file(): Allow multiple inputs in command mode
* configure_file(): Add depfile argument

Interoperability:
* Support a NINJA environment variable
* mintro: include test protocol in introspection data
* Add TAP parser (which we don't use, it was only a bait for the
previous change :))

Paolo


