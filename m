Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460FBC43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 07:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D627520708
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 07:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4Lq2TzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D627520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJuFg-0007hK-VA
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 03:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJuEk-0006yg-Dm
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 03:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJuEh-0001WN-BV
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 03:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600588692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GB5/zu05Cq7nBrtEwXVxtUbbylCF5Lq338WruWDUeo=;
 b=J4Lq2TzDiuv5yw1RbKZX86vWlPExi9BzyvB8WWckaVj3MX3xAhX4QZytV3OXiSLaGmF/xD
 l9FOfDlonA/80fIg5zM+vn64waQBbO9sAdvmUTCX+VMMxqgKEH4EZQQaNyiTadxuVaxoJe
 Zv4tKnmKMyCduQ1WBuC7aDNCHpe8WuU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-gZNbgJBvOSi1p2sNrn-D0w-1; Sun, 20 Sep 2020 03:58:09 -0400
X-MC-Unique: gZNbgJBvOSi1p2sNrn-D0w-1
Received: by mail-wr1-f69.google.com with SMTP id f18so4334812wrv.19
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 00:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5GB5/zu05Cq7nBrtEwXVxtUbbylCF5Lq338WruWDUeo=;
 b=jSXEFzOGTSS1b8P8QYzx4XO+iJXkRsSzsIyTa66IfIaa6QI0vgpiGwsfQJKISPuzMN
 7V2iwtH9ecTX3tp16iIEjnqv0XWwhfo5A5BONJp4kwALOQV9vrUgLqfBXTx/GHAJWdtC
 1KqUZIb6fQ5sr5MTnytsfbvCy53kycNh6lRPSJ5WGDw4GEd4tDvEbGd6CMOSqX/18gUv
 +BS+LvtZZ7ePJK/MdkjBeAnytvT8sCDwpg8oGSBtGckz7rD30Efq/sn/ot7y6XnZloR6
 y4U0YsUs2dl9xDTUYz4l3ZJ9SGLoueevgtO7cLvb6nQXaNCyDhsPHCLwoTQyvg5Y/Bu8
 WCDw==
X-Gm-Message-State: AOAM531mSR6VApqmWQ9Jui0K+wmKWc187k9yi7/CTtxHQFhGQSFwYucx
 qgHVarhr/Rd0hWbqRx9r+lLM4Z/nMkdg/sMuqWRhSBbSffiSofkvNDi392mTba+TqSsFAViDLw9
 ljr5ymrxs/k1L6BI=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr45991269wrr.111.1600588688334; 
 Sun, 20 Sep 2020 00:58:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDxGahU3R6/Z2VUh+0jodGp0ohMCA0Ur7q0HohUgMTpaFvOFXU98CG202z/SO7G9NVFd7mZw==
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr45991247wrr.111.1600588688117; 
 Sun, 20 Sep 2020 00:58:08 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id v17sm15609962wrc.23.2020.09.20.00.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 00:58:07 -0700 (PDT)
Subject: Re: [PATCH v4 00/15] Reverse debugging
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160006358590.31457.16757371597343007847.stgit@pasha-ThinkPad-X280>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad338011-6abf-7833-6553-cf724b4fb23d@redhat.com>
Date: Sun, 20 Sep 2020 09:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160006358590.31457.16757371597343007847.stgit@pasha-ThinkPad-X280>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 03:58:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, ehabkost@redhat.com,
 alex.bennee@linaro.org, mtosatti@redhat.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com, philmd@redhat.com,
 zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/09/20 08:06, Pavel Dovgalyuk wrote:
> GDB remote protocol supports reverse debugging of the targets.
> It includes 'reverse step' and 'reverse continue' operations.
> The first one finds the previous step of the execution,
> and the second one is intended to stop at the last breakpoint that
> would happen when the program is executed normally.
> 
> Reverse debugging is possible in the replay mode, when at least
> one snapshot was created at the record or replay phase.
> QEMU can use these snapshots for travelling back in time with GDB.

I had queued this, it is a very nice patch series.  Unfortunately, the
tests failed on gitlab:

https://gitlab.com/bonzini/qemu/-/jobs/745795080

Paolo


