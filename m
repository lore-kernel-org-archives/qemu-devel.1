Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3387DC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2409021741
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxMVbV+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2409021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmDF-000131-2T
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 03:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUmBx-00006s-KN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60228)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUmBv-0005p2-1I
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603179376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pPjg6rgzZVnoGIa9sR3Qqlq+RIZEmzswxTDF9vIFM0=;
 b=VxMVbV+HcWkNvnKP9EVwve5vp8siRS2R5vCN4do1gb8IsRVR8rAK2b+9W2WMk+hS1hnjNU
 /KFV4hjAJmcVr9Q9TGIjy25wCDQjQfN+BHQ4SR47BIWTgdUNrlFILeFICPZec0c3malbJP
 jpcBB5TEjoqqIuLVCd5yWkVfzDCN/uw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-E_thm8v4OriATsJBXPRizQ-1; Tue, 20 Oct 2020 03:36:13 -0400
X-MC-Unique: E_thm8v4OriATsJBXPRizQ-1
Received: by mail-wm1-f70.google.com with SMTP id i9so100630wml.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 00:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7pPjg6rgzZVnoGIa9sR3Qqlq+RIZEmzswxTDF9vIFM0=;
 b=sbTK5zn6CCkJqIA4wfnM+eR3hh/IWE767A+N5WW1GzC5iNm8EEQaJTODc8Vksxv41f
 NcWV1g0BfNjAgYG8ICMtI7PnvZO+3Pd8BoZzYkCAjI/nqB2ZsSBcSdaaKJHg37jpdWKE
 8sMaobY67O9ZyQP6DLDPXQYQW5O747duXlijVVUz4+1tr1bzan3VmF1xHVwbGVqL8+pq
 WXrB12nLBvbNS1CdBI6GtP9zJC0xTCfKK/kD2yQW0TQ5274EaY23ezISCz8C5vs5geWI
 czD0j0NOktAqiqUkBvJQqNAwSGt3poLhpKwcVpE8STZ0RmUg3fn2ntNcflrT1Y9VZSY8
 uGpg==
X-Gm-Message-State: AOAM533C6TGBhzJWNp/1/2wzoqDzuqdQM9Fueqz7xxG/xR4T494gCvJU
 PaDrXqg+5A4M8uumbIUu52y2V3eOL+t3jn+Bf2uGcxJSyhm2Vfmn4kN/smnjhwWx6igHEoQQnYL
 +Q6it0malLrEfZdE=
X-Received: by 2002:a05:600c:216:: with SMTP id
 22mr689278wmi.149.1603179372547; 
 Tue, 20 Oct 2020 00:36:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu4KDMsrqHOHfMuSazBpB1B6cGpeAh09kmPToIzZ9Q14Ks8H4x+eoQaiP9DQLzJytW5jLIpQ==
X-Received: by 2002:a05:600c:216:: with SMTP id
 22mr689251wmi.149.1603179372268; 
 Tue, 20 Oct 2020 00:36:12 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e11sm1804951wrj.75.2020.10.20.00.36.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 00:36:11 -0700 (PDT)
Subject: Re: [PULL v3 2/6] tests/9pfs: change qtest name prefix to synth
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1603111175.git.qemu_oss@crudebyte.com>
 <eefd2394efd6ba379d36d80c52de9ad956343b47.1603111175.git.qemu_oss@crudebyte.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <26d3b93c-5dbd-a58c-19e7-060120cfa326@redhat.com>
Date: Tue, 20 Oct 2020 09:36:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <eefd2394efd6ba379d36d80c52de9ad956343b47.1603111175.git.qemu_oss@crudebyte.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 8:34 PM, Christian Schoenebeck wrote:
> All existing 9pfs test cases are using the 'synth' fs driver so far, which
> means they are not accessing real files, but a purely simulated (in RAM
> only) file system.
> 
> Let's make this clear by changing the prefix of the individual qtest case
> names from 'fs/' to 'synth/'. That way they'll be easily distinguishable
> from upcoming new 9pfs test cases supposed to be using a different fs
> driver.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Message-Id: <e04e75acb849b085c6d6320b2433a15fa935bcff.1602182956.git.qemu_oss@crudebyte.com>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Harmless, but don't need to sign twice ;)


