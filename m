Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8127BC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19E220870
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rn8iqxji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19E220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7H3-00073y-RY
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ7EH-0004SC-7K
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ7EF-0003B3-Af
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602068606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXqg3K9rUAwQUNTmT29UQkZLeax6GYa1KEGlE/GykaY=;
 b=Rn8iqxjirgxQRX8MrpG4NgT0jv6edh3MtUY4mSzd1+ZYAvZm+DjKj/QOlzjMIQBISmnpB3
 pJRjFg+FWiLdpkxAayaj5+c+wR6pNojOIwSVFKZNyPKp3IvjOfvxTw/CBaEHgu969vf2EM
 FaZHxvn2RtgZhqUis4cRPY7LcO4WMAk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-P-oDUu6tNeSznzWO0-Ipow-1; Wed, 07 Oct 2020 07:03:24 -0400
X-MC-Unique: P-oDUu6tNeSznzWO0-Ipow-1
Received: by mail-wm1-f71.google.com with SMTP id u207so292725wmu.4
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hXqg3K9rUAwQUNTmT29UQkZLeax6GYa1KEGlE/GykaY=;
 b=YjKjPCdyKwidhIXHB1kxzExcMP0O4slMukypiSQpOSAnziODTnXJhj5NFEs0dRSs8F
 I5g2fryB19ykdDTxnoDiRJHpP4j7VmD3efITGGZzOk5r8gS0G17WbcubX+NV78XvRJs2
 LNtDkjfQNNEi+XFAi8rYuCCFLxhr47jij9aac/oXbALXFyRDgOEZAamzL+QW7X/NNNWK
 m+3On2ohR94SrivN3HH46+DvhESTprht/Jk0kupDdp2e4XbmfqDYgf7Xep+jsAAbrfzM
 uHUAfX8Z5VDBLwJSRfOjKfqm0TcT2XZSuMh6xbmUVik9vUjKjGCz8ptvPvWeV40SHn42
 Qj8Q==
X-Gm-Message-State: AOAM5338KcQOh6dnBm1GQkzsI6qtDZ0p28d4KYXsDwrinBqzjmQ2pozX
 tpRKeyX/4ArBFepZug8DZcoMMuQcnDBLsK6OskzS0Ko8luoUqI76Z8BwhgIiYMoIkqVvo1tA5ft
 OES7jYnIjq9B9xSA=
X-Received: by 2002:a1c:6856:: with SMTP id d83mr2760588wmc.71.1602068603533; 
 Wed, 07 Oct 2020 04:03:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsnhV7I2v9uZT9yuSu6AqjtkgwAnOxzwPJ6OllCB8LMQpVUda6zsTKZ28EyWvFLBQxSfPpWw==
X-Received: by 2002:a1c:6856:: with SMTP id d83mr2760564wmc.71.1602068603275; 
 Wed, 07 Oct 2020 04:03:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff?
 ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
 by smtp.gmail.com with ESMTPSA id y6sm2394643wrn.41.2020.10.07.04.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 04:03:22 -0700 (PDT)
Subject: Re: [PATCH 2/3] docs/devel/qtest: Include protocol spec in document
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20201005205228.697463-1-ehabkost@redhat.com>
 <20201005205228.697463-3-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27b0312b-cef9-9aea-3196-871eeca6760d@redhat.com>
Date: Wed, 7 Oct 2020 13:03:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005205228.697463-3-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/10/20 22:52, Eduardo Habkost wrote:
> + * DOC: QTest Protocol
> + *
> + * .. highlight:: none
>   *
>   * Line based protocol, request/response based.  Server can send async messages
>   * so clients should always handle many async messages before the response
>   * comes in.
>   *
>   * Valid requests
> + * ^^^^^^^^^^^^^^
>   *
>   * Clock management:
> + * """""""""""""""""
>   *
>   * The qtest client is completely in charge of the QEMU_CLOCK_VIRTUAL.  qtest commands
>   * let you adjust the value of the clock (monotonically).  All the commands
>   * return the current value of the clock in nanoseconds.
>   *
> + * .. code-block::

What version of Sphinx do you have?  I need to have ".. code-block::
none" here, so presumably the "highlight" directive is newer than my
version (1.7.6, pretty old I admit)?

Paolo


