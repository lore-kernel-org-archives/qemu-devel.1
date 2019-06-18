Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95651C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E8B20863
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E8B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdI8t-0005w2-IV
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44017)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hdI4B-0003J7-0O
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 13:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hdI0E-00085H-J5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 13:34:39 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:40296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hdI0E-0007vN-DH
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 13:34:38 -0400
Received: by mail-wm1-f53.google.com with SMTP id v19so4106501wmj.5
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 10:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eSRfKfh0Ll28SYnOVih/5qqnnVruLdR8wscYeHZIZK8=;
 b=jUs7t5Yriuq2byLpwAT4T7CXa4HhSgZk3hhCfIBztbtI+mLfOHuHG4FawGjTvzYBHP
 RkJCmvtN/SC+p6QFHq9ncceDgpiK/ikgOSlcj2qYW+RRE074ohzBgcVNudK9Tij2bSwO
 WrUeUaayRlBKd5ejdQqY8dfFfaSNIt9gy02/jW+zwomWCb2CdUwUEg8EkUMPnTOhbkSE
 v68hAvuoarM3EgcHAadloRVu5m6TSje8N7hDxVX4zYv8TWx67lgul3dgTC1Ts5RPQ+ed
 oICBtlP2X0YKBqhFYzv9SFOCeQbR77rLM8IFQB5PDa+ZM7BJalHQCTGZhf+yoHuhRat8
 AArA==
X-Gm-Message-State: APjAAAXJQ+zr96rGAAH+1ZlE8kvsHgPeCoRmZQgT2DZaE3lgq2qJB+V3
 4UrwI4cgev67ARxiY2riqAZJgA==
X-Google-Smtp-Source: APXvYqwDjbRJXCIDLoM9r08ty8rOy+xO1EDZcRDkVUDc/QFeG0Ic09Qw2aI2ldMRGR+M8xNQvI7OKQ==
X-Received: by 2002:a1c:e356:: with SMTP id a83mr4762529wmh.38.1560879259096; 
 Tue, 18 Jun 2019 10:34:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51c0:d03f:68e:1f6d?
 ([2001:b07:6468:f312:51c0:d03f:68e:1f6d])
 by smtp.gmail.com with ESMTPSA id u11sm11416896wrn.1.2019.06.18.10.34.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jun 2019 10:34:18 -0700 (PDT)
To: "wangjie (P)" <wangjie88@huawei.com>,
 Michal Privoznik <mprivozn@redhat.com>
References: <7462792e-687f-b4b9-5242-5abccd318deb@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e914d2e-798f-311f-f189-8b4ca23fc270@redhat.com>
Date: Tue, 18 Jun 2019 19:34:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7462792e-687f-b4b9-5242-5abccd318deb@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.53
Subject: Re: [Qemu-devel] 
 =?utf-8?q?question=EF=BC=9Aabout_pr-helper_unlink_s?=
 =?utf-8?q?ock_file_fail?=
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
Cc: zhangjixiang2@huawei.com, oscar.zhangbo@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, "Fangyi \(C\)" <eric.fangyi@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/06/19 06:10, wangjie (P) wrote:
> Hi, I found there is a bug in pr-helper:
> 
>     We run pr-helper process in root, and drop all capabilities  expect
> CAP_SYS_RAWIO.
> 
>     But the sock file which connect from qemu is owned by qemu group,
> when pr-helper exit, 
> 
>     it will call  “close_server_socket ->
> object_unref(OBJECT(server_ioc)) -> qio_channel_socket_finalize ->
> socket_listen_cleanup” ,
> 
>     unlink sock file  will fail and output “Failed to unlink socket xxx,
> Permission denied”.
> 
>       I tried to add capability CAP_DAC_OVERRIDE in pr-helper, it will
> unlink sock success, but I think capability CAP_DAC_OVERRIDE is too
> dangerous.

Interesting... yeah, CAP_DAC_OVERRIDE is a big big hammer.  I think this
would be fixed by also changing owner and group of the pr-helper to
qemu; it should work because it uses CAP_SYS_RAWIO.

Paolo

