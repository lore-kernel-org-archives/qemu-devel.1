Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA1DC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FE82070D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FE82070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVv28-0002Im-2v
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 05:38:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVv1F-0001rm-54
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVv1E-00025V-8A
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:37:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hVv1E-000250-3B
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:37:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id l17so1200197wrm.10
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 02:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=jHtm774aNPBp3Hw8V7Qqg3+GRzBzQTVxZxCjS9jm73E=;
	b=mOuEoYYx/fC0uklYuMerFoo46TWi4COS8uVQnMMbzsjYfsYZe4kl82a4BBqzUG+JK4
	YYSigXNBzjL9thPaCt/c99PdtkRs2OoZ6YfaWeOB7fCEFg+09ZSlEOp8RdytCvWSs4fU
	9WAvjWgygiuHuL88+pDWM7Zd6dEbRxMnt/5v3S1b0jkTcF17cg+6PMllXtAqe4Fww7Rw
	Xp0AA8Jcxbx6IssEI0nmqtcsv8T6fa18h0g2U4KK5WaQ7/H+UVgHcKufWfCgnaOJlc07
	qhCQXyjV1O3d4FL7jvU9Ra2AW1TMP7CRMbNxCz4tOdMDS9dodqLKoiCuqTlaOv7mmP6p
	rGNQ==
X-Gm-Message-State: APjAAAXckTswOEhgDgSie7Yngi70eG9Od4Kw/D4yT5waKKjbqb3OKLEe
	O/7g7oVhM1xQRYB/vrjtysq0cw==
X-Google-Smtp-Source: APXvYqyYNKSS0qxiV/z6hNxVMaibKl0XncN+v3pp7m9IXWCaKQTkDLTcvfINRHMTLt01+uA48jumnw==
X-Received: by 2002:a5d:65c9:: with SMTP id e9mr17618749wrw.348.1559122630605; 
	Wed, 29 May 2019 02:37:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553?
	([2001:b07:6468:f312:c92d:f9e8:f150:3553])
	by smtp.gmail.com with ESMTPSA id
	x68sm6823056wmf.13.2019.05.29.02.37.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 02:37:10 -0700 (PDT)
To: Jie Wang <wangjie88@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1559048796-57016-1-git-send-email-wangjie88@huawei.com>
	<cac8ed16-7846-ca22-2463-c3c738066d61@redhat.com>
	<f165741a-2ffd-62fd-b121-49bf1a3597f1@redhat.com>
	<8600e1e3-fd24-6e07-6951-f70b7a23f703@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ade54a00-f5e5-495f-f2d7-ba82430d6831@redhat.com>
Date: Wed, 29 May 2019 11:37:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8600e1e3-fd24-6e07-6951-f70b7a23f703@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] pr-manager-helper: fix pr
 process been killed when reconectting
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/05/19 10:37, Jie Wang wrote:
> when the problem appeared:
> 
> 1. qemu will initialize pr-helper and connect to it cyclically, but
> always failed because no running pr-helper process to connect.
> 
> 2. libvirt will always waiting for connected event, but will never to
> start new pr-helper process because not receive disconnect event.
> 
> I'm not found the best way to solve this problem, can you give me some
> suggestion?

I can't find a way that is better than your patch, either.  Another
possible problem is that this could cause libvirt to spawn two helpers
if you have a race like

	qemu: report DISCONNECTED
	libvirt: start pr-helper #1
	qemu: report DISCONNECTED
	libvirt: start pr-helper #2
	pr-helper #1: create socket
	pr-helper #2: fail to start

But it should not be an issue since one of the two pr-helpers will clean
up after itself.

Paolo

