Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F9C47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D878A208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXCFNEcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D878A208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNJ4z-0001oo-Iz
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 13:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNJ0l-0008Qy-PE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:01:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNJ0j-0000dE-Mc
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:01:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id z4so6259617wrr.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tB+fC6aUFX/nHuAknhtBYZ2mcyNXKd/mtTXfsOR9uss=;
 b=XXCFNEcYLAYOpn9YJEV3XehHGhJU7rK/4DzeFqeat+YX9iHliJMi32ZAVgOsIJvQyB
 qQzI4w96tC3HEQW6Ymwr91U9AeZ6wY25nwkWCTgh5JFyDQ+G5JN6HtP/QjyEwnWROuSH
 Ca8sj/PZa3Kxe9bfMFARJLRz1HW+HOkKtSSqGJgAG6XcYCb+UwZex/2wW+o33N24ycJ7
 5x28nwajP4750w8qwBND79LnN1mljvReDXXRCvhA4JNSrRHzaH1OXf7W7r4Tl+YxvT95
 d42Io6oIVBiHadCgcrpvUHEtKQWdh2cfgVx4RMtEQwuN0qCvLo0VvsLSZaIiOdY7KuWP
 gI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tB+fC6aUFX/nHuAknhtBYZ2mcyNXKd/mtTXfsOR9uss=;
 b=WLR82PkTUNXBuzyTXXR5xKpunGTGsE+tnwhafPmCy6zZmG063i5yS7WTPVw7y/JVTK
 REUxS/4HnqlT44qA8BBnOnB06NzakTvjGcrE9eErrR7JaFS7Gwg0I7g0i8YEI6p4IjvX
 PeNKhp//4TDadcr+XCU+ujbIKjPMZNomgp7htMC938OfCc1eyH9M9wz2A9LtG7dQ/xC9
 urn1EphZgyiV4fY35TdkxbKnt3qJo68HaL03+1gQT3hnOjFgjN2F2RIApdEj4swerCvi
 vaJ0q1mZtSa8IcM7ooW/0Y5Prztjt6k+ye8U78rOX3qF9Je+/jQaIH6coQBYdgsSzm8e
 taeg==
X-Gm-Message-State: AOAM530pWeflfw7mSl+Dd+XiBT2eLuVkuTJ4a5RuHnbFV5GALCWI0V4J
 zzBDHpwXnM/VENkP1ubbWVU=
X-Google-Smtp-Source: ABdhPJwnijbVoXd+3TXX4T9UWyK7VhzbEd96T42aOThpjkdXZbalbW2CCntId2p765esaqy8f+KLBQ==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr5098299wrv.195.1601398910030; 
 Tue, 29 Sep 2020 10:01:50 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id c25sm6120321wml.31.2020.09.29.10.01.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 10:01:49 -0700 (PDT)
Subject: Re: [RFC PATCH v4 00/29] Hexagon patch series
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <c4307aa4-f194-a02f-a4db-90b546a6024a@amsat.org>
 <BYAPR02MB4886C5014B1012371DE0DCDFDE320@BYAPR02MB4886.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8f684258-8b41-ee3b-8921-41693113c1f1@amsat.org>
Date: Tue, 29 Sep 2020 19:01:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886C5014B1012371DE0DCDFDE320@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 5:53 PM, Taylor Simpson wrote:
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philippe.mathieu.daude@gmail.com> On
>> Behalf Of Philippe Mathieu-Daudé
>> Sent: Tuesday, September 29, 2020 6:22 AM
>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>> Cc: ale@rev.ng; riku.voipio@iki.fi; richard.henderson@linaro.org;
>> laurent@vivier.eu; aleksandar.m.mail@gmail.com
>> Subject: Re: [RFC PATCH v4 00/29] Hexagon patch series
>>
>> cc1: all warnings being treated as errors
>> make: *** [Makefile.ninja:638:
>> libqemu-hexagon-linux-user.fa.p/target_hexagon_decode.c.o] Error 1
>>
>> $ gcc --version
>> gcc (GCC) 10.2.1 20200723 (Red Hat 10.2.1-1)
>>
> 
> Thanks for all your feedback.  I really appreciate it and will make the changes you mentioned.

No problem, I also appreciate the effort you did to address all
of the previous issues :)

> 
> I'm using an older GCC that doesn't have these errors.  Is this the version of GCC that is recommended (mandated?) for building qemu?

QEMU aims to support the 2 latest releases of supported distributions.
From time to time a brave developer look at the different versions
packaged and make some cleanup in the code base. It used to be tedious,
now that repology.org exists it is a bit easier.

The last effort is from Thomas, see commit efc6c070aca:

    The supported distributions use the following version
    of GCC:

          RHEL-7: 4.8.5
          Debian (Stretch): 6.3.0
          Debian (Jessie): 4.8.4
          OpenBSD (ports): 4.9.4
          FreeBSD (ports): 8.2.0
          OpenSUSE Leap 15: 7.3.1
          Ubuntu (Xenial): 5.3.1
          macOS (Homebrew): 8.2.0

    So we can safely assume GCC 4.8 these days.

This is the "mandated" compiler version.


QEMU has some CI jobs, see:
https://wiki.qemu.org/Testing/CI

You can use most of them by opening GitLab and Travis/Cirrus
(for GitHub, which you already use).

GitLab will become our "gating CI" soon, so your series is
expected to pass all the GitLab jobs. IIRC running the tests
is as easy as register and push your branch to your account.

> 
> PS  You were right about Richard recommending const.  It's already on my TODO list from his review 😉
> 

=)

Regards,

Phil.

> Thanks,
> Taylor
> 

