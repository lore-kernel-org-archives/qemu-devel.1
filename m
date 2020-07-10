Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF554C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0AD20748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 14:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZaVfMhY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0AD20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtteA-0005dw-RD
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 10:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jttdT-0005Cc-M4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:04:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47927
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jttdP-0001ra-RF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 10:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594389854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WgNfg3oqEj5c70XSScxBajnder0gvhem97MEfEPVVro=;
 b=WZaVfMhYiehTNJWhkWD3ZEkeIhKuRgmsY+77oYaZ03ORFxFmfGLFk4rMA/Pir8U2olQM7h
 JqD+kBQC3ilw8b+056q7M7hjZUSUv3hT9FYVf5sbGR/ZcuVom4oVSZ0VVXsxsWVoYDXoXE
 lpNX8xWydNt5vmoo8Z/E268ogNFerQQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-tuxSrz_GMSKWXmBv36o2aw-1; Fri, 10 Jul 2020 10:04:05 -0400
X-MC-Unique: tuxSrz_GMSKWXmBv36o2aw-1
Received: by mail-wm1-f70.google.com with SMTP id w25so9414570wmc.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 07:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WgNfg3oqEj5c70XSScxBajnder0gvhem97MEfEPVVro=;
 b=b6qUPfzdYpQBjesb/GCyP/L2QuXZTtXTM6zUtHCB3ZFZwD1S7lZj0P4eIioYpLiwE/
 kxfYq+rI2ZT323nDK8jTuNVlzoc1kGbJQ/wdAGfFX8BvTEVkp56Q312PcCPfyZskZRgU
 tZUUDmGBlgvE+l6iFqHPZtof27J8yV1trb/2Hc180u2M7i16nrcwUtsoCXMzbeFqMqpq
 taU0G8BTbhTwEAh4FyghJz+LVMoD0EpCkxgl0OaaMouU0yeETxnBz6naXRic1TjWbeh9
 wkyNEMob5BdSGVM3JhNkTbrHiQILJR8bSqvO63R2vSJOGwLLez6WNpQvQFbqF9AdA5LM
 5GAg==
X-Gm-Message-State: AOAM532rqGDPpkbYIdNNq4THmnxoOY/sOXDKgRuhXnhxsetGSgFYc4Dm
 /QTqM9LnKEIZR19u0ZVA1Rfvc5/5oVERtNKdWYWKvhA/fsEStMAAyCQvOegaivJaGmWDFLaO75P
 uKwsIo32TjMdXSbc=
X-Received: by 2002:adf:db42:: with SMTP id f2mr67455989wrj.298.1594389843783; 
 Fri, 10 Jul 2020 07:04:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT1i/Me6lUQVkxQzGWNVT0+46arN9mO+vAHRLDqevXPqXA//T9b5OLzqnU7lb9ILpfv9rFQw==
X-Received: by 2002:adf:db42:: with SMTP id f2mr67455962wrj.298.1594389843560; 
 Fri, 10 Jul 2020 07:04:03 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k18sm10347094wrx.34.2020.07.10.07.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 07:04:02 -0700 (PDT)
Subject: Re: Migrating custom qemu.org infrastructure to GitLab
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <5bf99e61-8aa2-53f0-0157-52becec1df26@redhat.com>
Date: Fri, 10 Jul 2020 16:04:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <cleber@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 11:52 AM, Stefan Hajnoczi wrote:
> 
> There is a snowball effect where the experience is improved the more
> GitLab features we use, so I hope that most of these migrations will
> be possible.

I've been looking at other features we might be interested in.

1/ Calendar

I was looking for a calendar option to register the release dates
and the Tuesday QEMU/KVM external call.
They recommend to pair with GSuite instead:
https://about.gitlab.com/handbook/tools-and-tips/#google-calendar
Or calendly: https://calendly.com/

2/ Due dates

We can set 'due date' to issues/merge requests, useful to not
miss soft-freeze or CVE embargo expiration:
https://docs.gitlab.com/ee/user/project/issues/due_dates.html

3/ Milestones as releases

https://docs.gitlab.com/ee/user/project/milestones/#milestones-as-releases

4/ d3js graphs

https://docs.gitlab.com/ee/development/new_fe_guide/development/components.html#graphs
So we can now have more interesting graphs in the wiki/doc such:
https://observablehq.com/@philmd/qemu-aarch64-softmmu-qom-tree

5/ CI testing metrics
https://docs.gitlab.com/ee/ci/metrics_reports.html#how-it-works

6/ Sentry error tracking

Maybe to gather the CI errors?
https://docs.gitlab.com/ee/user/project/operations/error_tracking.html#sentry-error-tracking

7/ License Compliance

https://docs.gitlab.com/ee/user/compliance/license_compliance/

8/ Connecting with other bug tracking services:

In case we want to link BZ:
https://docs.gitlab.com/ee/user/project/integrations/bugzilla.html

Or eventually launchpad:
https://docs.gitlab.com/ee/user/project/integrations/custom_issue_tracker.html


From these points I'm interested in investigating

- CI testing metrics
- d3js graphs
- License Compliance

Regards,

Phil.


