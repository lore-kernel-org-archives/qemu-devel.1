Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569B6C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D05021479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D05021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOhoE-00018K-FJ
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 08:05:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOhnG-0000kl-EW
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOhnF-0003dm-A0
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:04:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOhnF-0003c1-2n
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:04:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id f2so2872498wmj.3
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 05:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=DXqcqX3R9ycJHgWv6i04IKjPTqmrGuz5Pa5GybDIcYI=;
	b=QJ/u9xGpVj/xjp6GBBHixj7UnO6rrPxLI7J7e2ArcRB9K/n7syavibr3UJvQN0p+qh
	FF912K26yGwwCSi3gtlUkpKC6Ccuxrsvf58KPaROZI1kS22MFehsBuebNJzHUfvSI63C
	eSPFsK1UgqSADRt6laf0ewSSbv5zC55R+ijuqQCFfGEYQhfS22H7AmVCFaJdh28hiFUq
	5dC/Jxpj+Y4sbSpVPJr8SwwGKx9H7THI9UUOBm1rgjtPitG+/C7RuKOxwBxmciczEgoD
	a6TF9NTRC8NHgIehWoxWQX6CWi303ybuW/nF8kNSNc0ImYpobxCQWkUvpsizTHVymL8o
	SB7A==
X-Gm-Message-State: APjAAAWCKixH8BDXppdqCKq6eYUDRMYAOb9D47gyAvt6foBCAYyvpZZy
	hSM0TVj4h7i7kJcWnCpO0E8j9A==
X-Google-Smtp-Source: APXvYqys/Ax81nG5UrqL5Rltpmtr9FOTE99Uyor9EXjaf6wQS0wCJ4FDXoSTmPreJus37LrIf2oPpg==
X-Received: by 2002:a1c:e916:: with SMTP id q22mr2666658wmc.148.1557403496116; 
	Thu, 09 May 2019 05:04:56 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id o8sm3547306wra.4.2019.05.09.05.04.54
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 05:04:55 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
References: <20190508085645.11595-1-kraxel@redhat.com>
	<38ea2334-b819-a439-7a43-92b52263b402@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a8d4aea0-cf45-45f2-604e-adc79bbeb135@redhat.com>
Date: Thu, 9 May 2019 14:04:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <38ea2334-b819-a439-7a43-92b52263b402@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 00/13] tests/vm: serial console autoinstall,
 misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Eduardo Habkost <ehabkost@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 5/9/19 1:53 PM, Thomas Huth wrote:
> On 08/05/2019 10.56, Gerd Hoffmann wrote:
>> This patch series changes the way virtual machines for test builds are
>> managed.  They are created locally on the developer machine now.  The
>> installer is booted on the serial console and the scripts walks through
>> the dialogs to install and configure the guest.
>>
>> That takes the download.patchew.org server out of the loop and makes it
>> alot easier to tweak the guest images (adding build dependencies for
>> example).
>>
>> The install scripts take care to apply host proxy settings (from *_proxy
>> environment variables) to the guest, so any package downloads will be
>> routed through the proxy and can be cached that way.  This also makes
>> them work behind strict firewalls.
>>
>> There are also a bunch of smaller tweaks for tests/vm to fix issues I
>> was struggling with.  See commit messages of individual patches for
>> details.
>>
>> Known issue:  NetBSD package install is not working for me right now.
>> It did work a while ago.  Not sure what is going on here.
> 
> I now gave your series another try and replaced patch 3 with the python3
> fix from Eduardo locally here. FreeBSD works great. OpenBSD is fine too,
> except for the known issue that the "gmake check" does not work - but
> this issue has been there before already. [...]

"gmake check" was working on OpenBSD with this series:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07513.html
I think most of the patch proposed there have been merged, so are you
talking about a new issue?

