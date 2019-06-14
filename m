Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4984CC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F9C2173C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F9C2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52754 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboGN-00028n-9p
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbnx6-0005p2-Lo
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbnx3-0000Nq-Lf
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:17:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53372)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbnx2-0000Lh-Kn
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:17:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so2761526wmj.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 08:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OJZt8LyegHjHl0pjwmJ4PmVGSvMjVt0atPej0vFBSUw=;
 b=MRziS/93/nzihQe6iHSNuAmOTC1Ly9zJGoJzkifH8hocYhSekXxNjzvfOlMVvPoMLO
 RGIop1GeouVbwLfK67Vp7Grj8oaTUGaT7Lnxa0akG/MlFzUuxG7ki5NNQRnZO6Gb2ZZS
 BSEe1M0rGosrguGZ1sxfFCBl61j9caCE275BPM950OOfsAXfqzYQMFj3iTRYGUtidx2f
 lnuZxuAeTxvCfgwSRZcRekGpf32XagPrmR3EE7BFQSPxbJzckCJaCUSJUTWW+65HlbQb
 mcb6Vp5IptdifMHEYv55KNgNxSF7A2shkUG+SHDlCN+o8NikqGGjDfdvkIQzaNIcBMS3
 4U2A==
X-Gm-Message-State: APjAAAVTfom8AnhGmmuFFl6RC3JFeNVCplPbEQofW9vvo7M2QpmWAGLO
 v/kEEc513YLUbJWbLbh4yQy1GA==
X-Google-Smtp-Source: APXvYqyGOhe3NZ10V0PfgMqXk5H7wfkbPCG1x25FqbCSOzU6xqgePaHm61PF2XpUBLKx8cRFZmEqkQ==
X-Received: by 2002:a05:600c:2253:: with SMTP id
 a19mr8538154wmm.156.1560525430167; 
 Fri, 14 Jun 2019 08:17:10 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id x11sm5218647wmg.23.2019.06.14.08.17.09
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 08:17:09 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190614072432.820-1-philmd@redhat.com>
 <CAFEAcA9zEKePcOHK6WMqAitf282EWh5LUYRqZ3oAJ_W1wPsohw@mail.gmail.com>
 <8736kce0b2.fsf@zen.linaroharston>
 <CAFEAcA8Uw8QNMa8EFzsjNzADdUAmkiYtXi04GN7+M-9w+eLSkA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <af9eaa48-bcbf-d330-b442-213c0b5d2437@redhat.com>
Date: Fri, 14 Jun 2019 17:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Uw8QNMa8EFzsjNzADdUAmkiYtXi04GN7+M-9w+eLSkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH 0/6] configure: Try to fix --static linking
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 integration@gluster.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Lo=c3=afc_Minier?= <loic.minier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Bharata B Rao <bharata@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 4:30 PM, Peter Maydell wrote:
> On Fri, 14 Jun 2019 at 14:58, Alex Bennée <alex.bennee@linaro.org> wrote:
> 
>> It would be nice to have a --static-user config flag and deprecate the
>> --static flag. I don't think there is a decent use case for system
>> emulation targets.
> 
> It would be really tricky to build half with static and half
> without: our configure and build system really assumes that
> fundamental stuff like "what libraries" and "what compiler flags"
> are the same across the whole of the build.
> 
> Is --static-user really much better than:
>  * allow --static --disable-system --disable-tools
>  * forbid --static without --disable-system --disable-tools
>  * require users to build the static usermode binaries separately
>    from the system/tools build
> 
> (which is in practice what we have now) ?
> 
> Debian wants both static usermode and non-static usermode
> binaries, so they'd still need to build multiple times anyway.

Glad to read, so the v2 of this series is worthful.

