Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A4FC28D18
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637592086A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637592086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYWew-00074N-Cl
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:12:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYWdI-00067x-TV
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYWdH-0004ON-It
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:11:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hYWdF-0004Lu-KF
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:11:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id f10so2427666wmb.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 07:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=z6IgQJxRPYMJDE2qUDN1r3HB4av5lx06Rmxd27LH654=;
	b=a630c8SG26kFQl8dZi0DucptNFDsFE5nZPl9Jbd8fOIkogW59NL3HYTqC6d4v+BRxL
	9ZUP077seF57s/inkK1M74ICC2mcgMWDp8RVFAF5RACkJwDaGXtuCBRd4EUNIJOjxETA
	IZdyCzPAugph9kOg/ensQuN6922yFv3mZeYzjG7zar3f6ITjxhBe+SovLDgobYyJQIfp
	x97VSFodrvdnc+GVbNd5JEXcxXc/WySUgi19j2zUAea91Fjl6EeYYZtylPAATz5xYDAQ
	6XLXDLph3/fJ6kh/T6RVFr3uWAA8AGk2l4zTrmY6mKemkJEtbt7VuMEBE0amJn1dsdf8
	5QTw==
X-Gm-Message-State: APjAAAXcduQOzcOyyOuEWazavtAZ3P6Pl5mPmpOMqFmgll5W4AuJmHmU
	I11l//sdXWP+0p8iFknu/c6BXA==
X-Google-Smtp-Source: APXvYqy0/W/arBsYdbpHAy8KdGoxasl/Z6zJUBPYCFCPfbfehoOezsLXJh1BYJ1a94UgUr4FPxl27A==
X-Received: by 2002:a1c:99ca:: with SMTP id b193mr8884880wme.31.1559743871475; 
	Wed, 05 Jun 2019 07:11:11 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	v184sm7625410wme.10.2019.06.05.07.11.10
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 07:11:10 -0700 (PDT)
To: Wei Yang <richard.weiyang@gmail.com>
References: <20190605010828.6969-1-richardw.yang@linux.intel.com>
	<c3b37e07-6d13-1ed9-bb75-0a94c31c8399@redhat.com>
	<20190605133919.2yslqh6seu7ij5mr@master>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d1860a08-7bfa-89e0-0011-e5f961132eaa@redhat.com>
Date: Wed, 5 Jun 2019 16:11:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605133919.2yslqh6seu7ij5mr@master>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] migratioin/ram.c: reset complete_round
 when we gets a queued page
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/19 3:39 PM, Wei Yang wrote:
> On Wed, Jun 05, 2019 at 02:27:11PM +0200, Philippe Mathieu-Daud?? wrote:
>> migratioin -> migration
> 
> Ah... I should take an English lesson...

Your English is fine, I believe this is just a typo that slipped in ;)

