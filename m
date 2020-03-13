Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8667DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF6520409
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QN9+AHqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF6520409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCf1W-00056F-Hl
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 03:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jCf0a-0004ae-Ar
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jCf0Y-0005Bh-QR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:45:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55594
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jCf0Y-00059Y-Ka
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584085525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ev1LaletljAcFZDUIc2HtfAsv7u1N5T2U0c9M7bw5lw=;
 b=QN9+AHqegZr9nZLj4zFDt9bc6Jj6Ahu1iJa3Q9iNwd+eWlh8+tcoojtAVzC4aFTJNLb+R4
 aM8b7fDbX0+upJrNlvOMstylPwT/B4zkfgaTI5/RQnsCGPYd7qE1lfq9lfzNPDAmPTGHI4
 EaVieTFe4ZQdVWWxe4bCjrUlpPQkWdI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-e1em2ej8M-6ErMGTxKXgvw-1; Fri, 13 Mar 2020 03:45:24 -0400
X-MC-Unique: e1em2ej8M-6ErMGTxKXgvw-1
Received: by mail-wm1-f72.google.com with SMTP id a13so3107334wme.7
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 00:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ev1LaletljAcFZDUIc2HtfAsv7u1N5T2U0c9M7bw5lw=;
 b=a5rEYIZd/Ywy5zLArneg6aRikB9jyO7ftS2AT6twns8lU9b12NpQq1M3MHZxOroPEv
 KAzOS/3qvq8fQziGrLIHDANrCYrO1PLhM2IlCMJLSNoVsJm6TnNYFftZU+eu/9HY81kc
 4rW1im55oA4ZkrO76K9EU/jXBApjGlic6Y/qs1yiHREM+5ld6H8CXF6VUjmrUPKohpYC
 mew3TBDaLEUavlJExSOPbs8smtr3079PGHz0ilo1/3Ufk4clnAnFfZGXyAhpRoqzuCcm
 iQ7qmajLrdKsXcwi4agMh0WhrOWmsI5HHhBQPPnpXFnWsQRc8DCrAPICcLjED0kJuXEc
 KA6w==
X-Gm-Message-State: ANhLgQ1WUxljQnhXUG/p+suHu8UoLlWPHOXlxxvDKzemSpwNb9WBqh9h
 1UBk6w26EGcRsOWgkEW7K2IVrJlVbcFqHCNCGTLdTHp4ayYIRvFft1QeSppM7BRcicGTnIE4Kkm
 pVI5iZwl/4ys+HTc=
X-Received: by 2002:adf:e3cc:: with SMTP id k12mr12085820wrm.266.1584085523128; 
 Fri, 13 Mar 2020 00:45:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsOp/nAuDaPuH0+tKKVu8VZ2G+oh3toFW21OglVBuxYlNegzHo8cLQtWGJx2kvBqYL+ul8WYQ==
X-Received: by 2002:adf:e3cc:: with SMTP id k12mr12085799wrm.266.1584085522923; 
 Fri, 13 Mar 2020 00:45:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac?
 ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
 by smtp.gmail.com with ESMTPSA id c11sm79036800wrp.51.2020.03.13.00.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 00:45:22 -0700 (PDT)
Subject: Re: [PATCH] modules: load modules from versioned /var/run dir
To: Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@gmail.com>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
References: <20200306132648.27577-1-christian.ehrhardt@canonical.com>
 <20200310093910.GB140737@stefanha-x1.localdomain>
 <ab8aaa05-8738-f789-8281-cc9d4235a225@msgid.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d837839f-e1e5-3cbf-b8fd-a2a6cc4ad5ce@redhat.com>
Date: Fri, 13 Mar 2020 08:45:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ab8aaa05-8738-f789-8281-cc9d4235a225@msgid.tls.msk.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pkg-qemu-devel@lists.alioth.debian.org,
 Miroslav Rezanina <mrezanin@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/03/20 08:34, Michael Tokarev wrote:
>> The use of /var/run makes me a little uneasy.  I guess it's related to
>> wanting to uninstall the old package so the .so in their original
>> location cannot be used (even if they had a versioned path)?
> 
> BTW, this is /run nowadays, not /var/run, as far as I can see.

/var/run is still symlinked to /run.  QEMU generally uses /var/run,
though we could consider switching sooner or later.

Paolo


