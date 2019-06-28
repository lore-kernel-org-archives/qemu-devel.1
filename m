Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B067C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 22:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2654F2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 22:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2654F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgz9t-0002cU-7k
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 18:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgz8r-00025L-MW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgz8p-0001uq-QV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:14:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgz8o-0001sd-Pd
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 18:14:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so10445652wme.4
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 15:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0wWbAEATxrgk2zjEO4zasGzG+X4TBMBhYxyvX1AFfNI=;
 b=PGTGXmDNgmjbD3q7rtA/POauOnD5ueqitzeZYIjOdMBV42PLRYeCPTwF9lZ9EM35vb
 oxU6RiU33qFcYCPBIajXai88M4yc0O2j7iTVgnC/oRnXz6DRhMY+DaEHWTbH0RzxC+hB
 373nG7arFjXZfbsWBXniDqLViDy3lS6PXDSDbSRXSP+DbOhr+zvLATit/syoDJPpYGDn
 dsSwMXSDsdHRXsoeh0Mrs0iGuNnHej/1qd8VpnZM8IrtL7m58pQNhB3RGLLfV/I0Dcm1
 3NrB4v5snFi/7Jp4xjYCf21fQLYpO72395s5ToU07nuBiJs3UuOyE+1xDFysPxj/0kxw
 UrfA==
X-Gm-Message-State: APjAAAWWG/5xo0tGlAZzWVwr3RSezMG7Qi1wmEywBMW3Zam2bOcoZimI
 AA9MFttvpFa4gtpseSDMFpp4/g==
X-Google-Smtp-Source: APXvYqyJXekAmMUlYEO70eJDx/e6SvTtuC4Mw+tA9kxDMeCG6TPMO15Y64D2tOZwkLe03VpwRmGP6g==
X-Received: by 2002:a1c:9c4d:: with SMTP id f74mr8449055wme.156.1561760085146; 
 Fri, 28 Jun 2019 15:14:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a5c0:d60f:9764:1c58?
 ([2001:b07:6468:f312:a5c0:d60f:9764:1c58])
 by smtp.gmail.com with ESMTPSA id n14sm7788094wra.75.2019.06.28.15.14.44
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Jun 2019 15:14:44 -0700 (PDT)
To: Alistair Francis <alistair23@gmail.com>
References: <97104495f5c945d25315aff1bd618e1a7bacf34c.1561589072.git.alistair.francis@wdc.com>
 <1bd3ffcd-3f91-ecb9-2315-da7125f1dcdd@redhat.com>
 <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4428dc80-9ace-3bb0-a497-e3d416199bfd@redhat.com>
Date: Sat, 29 Jun 2019 00:14:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPeo4XXVy3onoM4W14N5Nj7CFWX=JpDT-JQQRUPw5CQ3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v1 1/1] hw/scsi: Report errors and sense to
 guests through scsi-block
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
Cc: fam@euphon.net, shinichiro.kawasaki@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/06/19 23:57, Alistair Francis wrote:
> 
> I tried to run my VM with option "-drive
> ...,rerror=report,werror=report" as he noted, but the eternal loop
> symptom still happens when host block-scsi device returns EIO. Then I
> believe EIO should be added to the report target error list.

What is the sense data he's seeing?  EIO is a catch-all return value
for scsi_sense_buf_to_errno so I'd rather be more specific.

Thanks,

Paolo

