Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD06C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D64C257A6
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 10:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D64C257A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51953 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWImr-0000Hf-Ko
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 06:59:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWIm5-0008M4-A7
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWIm4-0007rV-At
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:59:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hWIm4-0007me-56
	for qemu-devel@nongnu.org; Thu, 30 May 2019 06:59:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so3938896wrx.0
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 03:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=823Rx/dJJCi+6xFy2EINB7ppoqk534OPz9oBiL9k7SU=;
	b=IMbNH8S6FjJq86wYMVpO0GyGzCYTrkO3gmfZ03VVCL3dqPn178Jw476AdrBLtlJ45e
	rcAPuh34ssJiUIuhkxLx4Q4CMVTKBhhRJFrJpZ9mwNJjgD7YZlSMe3tTM0Pdnp5PwQ9P
	lPL6n9d0Xydk1J06poEYDUK5E9PtoJzhWrV0LDS/tI7bBiI2bglX14OnD0WsF7PMDaVD
	OjmAGTNXjrVPHV8svu2eEv5nRKziXq/OPkv7x2mrOfagIbe6AHddo+Me34LnywB3U8Jd
	34WfFlMVCAOqaa3jZEqgig1lYEpq9meyWpm3cDitLzhWhiWRc2J2L+hMa674Ft9DhBc8
	cTTg==
X-Gm-Message-State: APjAAAVzPDGPmNlxUZdZ37pemmpDAme7iX/PF1r8W3vHMt7C2RYjlea0
	uLu5LOSjRJ1OU83fwbtE6tTaYA==
X-Google-Smtp-Source: APXvYqxBewcq/dVKonzy/t6y+/kCjrCcdp7wakcleFST3OtshMqcBdOdwqpaHDd/sQLrydiNz1HHUA==
X-Received: by 2002:a5d:644e:: with SMTP id d14mr2293045wrw.42.1559213946551; 
	Thu, 30 May 2019 03:59:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f91e:ffe0:9205:3b26?
	([2001:b07:6468:f312:f91e:ffe0:9205:3b26])
	by smtp.gmail.com with ESMTPSA id
	205sm2760429wmd.43.2019.05.30.03.59.05
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 03:59:05 -0700 (PDT)
To: Michal Privoznik <mprivozn@redhat.com>, Jie Wang <wangjie88@huawei.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1559048796-57016-1-git-send-email-wangjie88@huawei.com>
	<cac8ed16-7846-ca22-2463-c3c738066d61@redhat.com>
	<f165741a-2ffd-62fd-b121-49bf1a3597f1@redhat.com>
	<ca74a7bf-dd68-d4c3-2c25-8e43db52678c@redhat.com>
	<f9b6dd9e-3e58-add9-c5ab-da1a883a0a4b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8a358ee-eb1f-14ca-b406-295ef668bb55@redhat.com>
Date: Thu, 30 May 2019 12:59:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f9b6dd9e-3e58-add9-c5ab-da1a883a0a4b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
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

On 30/05/19 12:08, Michal Privoznik wrote:
>>> 1) Try to acquire (lock) pidfile
>>> 2) unlink(socket)
>>> 3) spawn pr-helper process (this yields child's PID)
>>> 4) wait some time until socket is created
>>> 5) some follow up work (move child's PID into same cgroup as qemu's main
>>> thread, relabel the socket so that qemu can access it)
>>
>> Note that qemu-pr-helper supports the systemd socket activation
>> protocol.  Would it help if libvirt used it?
> 
> Thing is, libvirt creates a mount namespace for domains (one namespace
> for one domain). In this namespace a dummy /dev is mounted and only
> nodes that qemu is configured to have are created. For instance, you
> won't see /dev/sda there unless your domain has it as a disk. Then,
> libvirt moves pr-helper process into the same cgroups as the qemu's main
> thread. This is all done so that pr-helper has the same view of the
> system as qemu. I don't think that he same result can be achieved using
> socket activation.

Why?  The only difference with "normal" behavior and socket activation
is who creates the socket and calls listen() on it.  Everything else is
entirely the same.

> Also, libvirt spawns one pr-helper per domain (so that the socket can be
> private and share seclabel with qemu process it's attached to).

Yes, that is why I thought the socket could be moved in advance to the
right security label, prior to exec.  Also, perhaps could the child move
itself to the right cgroup before dropping privileges.  This would
remove the window between 3 and 5, by moving all the work *before*
qemu-pr-helper is exec-ed.

Paolo

