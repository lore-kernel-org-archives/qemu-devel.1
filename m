Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7FEC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC24206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC24206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40607 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYV1l-0006kg-JZ
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 08:28:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYV0c-0006AS-3o
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYV0b-0007rh-Ab
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:27:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hYV0b-0007qg-3F
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:27:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so6828620wru.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 05:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VUvd3fJgcva0n+rYslNhqq2PpcuLx5aDCrYJf6TMzdk=;
	b=CqmGJjf1eWWhDciRF/Q1VnxsQjl5kLaPdUQZJOXTRz7n9JTTTPRTkR+E5nhMR9j9x4
	aCqsohjK8G9VLEPPVtLFFxbx5xzfr874m7rgtu9/XFHCDyPewVFGXsM0dH74ZdKW+DMH
	nxI19f3rxXQOHh5UHIjTtY7I/oPJN5noCcvRj2SPxaUhIVAjTRLcaVuTEcVdkUlLES5S
	fsihjJW4Dn9I24cHUYkNGLHZusd8lWld77oMM1i4p0YycH8MhMC4mxWVMbHhIUa3nCI7
	s466oT5LQULxGqw+Yc1D8msMxZ4RVXCMMnlkTcZftVI7+Dz6Jaau0hpXjlLR0ggIQ2hT
	fHAA==
X-Gm-Message-State: APjAAAWhGNgauJ5OerSmWo7wx9yk13T1i/h34fX1TGVxzku2yNsv+Xbt
	aL3pa3dLWa1Idvc1oCY51KZRsQ==
X-Google-Smtp-Source: APXvYqw4dDpRc/ZvTxWQGcSjRwj42MSa8fHccQA2fWWteSriOk5OMLWpGEtGDSyVmQj71QUtcHnKyg==
X-Received: by 2002:a5d:624c:: with SMTP id m12mr10150427wrv.354.1559737632166;
	Wed, 05 Jun 2019 05:27:12 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	f2sm20995279wrq.48.2019.06.05.05.27.11
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 05:27:11 -0700 (PDT)
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
References: <20190605010828.6969-1-richardw.yang@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c3b37e07-6d13-1ed9-bb75-0a94c31c8399@redhat.com>
Date: Wed, 5 Jun 2019 14:27:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605010828.6969-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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
Cc: dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

migratioin -> migration

