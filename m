Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9061C48BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2947206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2947206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he1is-0008W6-1M
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 14:23:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43128)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1he1cD-0005BR-FM
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1he1TK-0006Y4-SR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:07:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1he1TK-0006XU-N6
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:07:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so4017673wru.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 11:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k/kPHIwqfXNuKr2zWlt6gicBnsTyjHVtxH6YkiH1Z+s=;
 b=kSncgUVXpb2M8tzR8E08E1Uk7GDu40BG8qPaUw9igmJG2ARfr1IWzXQVzaM+8SQoyw
 IpuKkrCGX0rTCvgyb2eUFXWRM0r9pJDMgCyyjmoBiG+NGPZRjbXkgmy+eIEGXF3HIsR1
 /J6lnnpsIcTHyjE0rvqXbIWTS6GXeyq5TFIcn8j8Urk9wvQWBPtm54EdpNWVTOAAe4+b
 YdmmjoZmMRfcefm5qHeJDN3V8bKkLdVmgCmbC7XGOCTC43c19eq9wgcnCQQwLsDvYKWD
 XUz592CDaB9m285dPpZy+by4ulR3jMG90dw1kSaNuX/hHoErQau3OVJpYMaOE8FQ1O71
 Bw/w==
X-Gm-Message-State: APjAAAWfTfsyMPJqQJpBS0rP2jYLLCjjIBZ5hkgQdwOUb2BsaoafV/eY
 ZVge0Js9Aze5nJajuZR33k+sdg==
X-Google-Smtp-Source: APXvYqwSF8vJbPS+nkazVKj4H+WICp28bfxoOc8a3DKoZCft86JoYknptEvJ2/cJby57MDmn/Kl0lg==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr38682872wru.161.1561054060635; 
 Thu, 20 Jun 2019 11:07:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7822:aa18:a9d8:39ab?
 ([2001:b07:6468:f312:7822:aa18:a9d8:39ab])
 by smtp.gmail.com with ESMTPSA id d18sm610813wrb.90.2019.06.20.11.07.39
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 11:07:40 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190620173709.14753-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06488da0-bac1-25e1-d238-f42284aa2cc0@redhat.com>
Date: Thu, 20 Jun 2019 20:07:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620173709.14753-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v5 0/3] virtio-scsi: restart DMA after
 iothread
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/06/19 19:37, Stefan Hajnoczi wrote:
> v5:
>  * Plumbing vm change state handlers into DeviceClass/BusClass is a rather
>    large bug fix.  Instead I've combined the previous priorities approach with
>    the observation from Kevin and Paolo that we really want to order by qdev
>    tree depth.
> 
>    The new qdev_add_vm_change_state_handler() API lets DeviceStates register
>    callbacks that execute in qdev tree depth order.  This solves the
>    virtio-scsi bug since the virtio-scsi device's callback must complete before
>    its child scsi-disk's callback runs.
> 
>    Is this a good compromise for everyone?

Yes!  Perhaps a bit of a hack, but it works and both the API and the
implementation are very sane.  Converting other devices to use
qdev_add_vm_change_state_handler() is left as an exercise for the
reviewer, I guess? :)

Paolo

