Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9A7C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583C7206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583C7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYVel-0001rT-KF
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 09:08:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hYVdU-0001Bd-2E
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hYVdT-0008MF-8z
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:07:24 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:50806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hYVdT-00084B-2p
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:07:23 -0400
Received: by mail-wm1-f49.google.com with SMTP id f204so2208485wme.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 06:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=J0qo3mtOF0q2/OSjXOZcCqYpHTpFA5LWRjVdzRAypNw=;
	b=fZXFxxn/g2Fqv+SIVtUBflfKIYI21T/ovFPhYoir1JkQx3RzZbOSjd/owfraAwQ+XO
	gD1Qd6FCFb/Tk3wlKF5X65Ofw6TqxE8Lpxb8vU7N/oRnzpKD5Kk64eJQUZVIuh9akCSu
	XA7lgi9GRXnK8GrGrb9fJTHrCo9a5/Wdwfa7aOID+NMFUg47a9cDe+AofWCBfn22c/qn
	GpLBX9EKCsOoEZkROk1xe3y7LEXiyobD2H+igoU30fuUmgdNGMf47tox29wT+CzH1n49
	KwNTEIkvdWpaGRnM3FNkZuKOJZUXP2m4maz5jZxDlVmzbJ//2JJomQ3YXHSBZDK+iQ1q
	oOag==
X-Gm-Message-State: APjAAAUutYU35zgT2XqNiJ4fjNJHw7HwbCr5aIUIiv/GLHWyMC3pvdr7
	jhnuxku8uoP0ZpskhSOvdtXJxg==
X-Google-Smtp-Source: APXvYqySG65yxYXbh3ixbQjFYfUJM5s6ginSUCIGddhibJ/6p4NnwLi4YCLEl+dSaw9AUk3d/d6FSw==
X-Received: by 2002:a7b:cb84:: with SMTP id m4mr23895863wmi.50.1559740032221; 
	Wed, 05 Jun 2019 06:07:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:657f:501:149f:5617?
	([2001:b07:6468:f312:657f:501:149f:5617])
	by smtp.gmail.com with ESMTPSA id
	88sm27437799wrl.68.2019.06.05.06.07.11
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 06:07:11 -0700 (PDT)
To: Natalia Fursova <Natalia.Fursova@ispras.ru>, qemu-devel@nongnu.org,
	=?UTF-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
	<1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
	<5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
Date: Wed, 5 Jun 2019 15:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.49
Subject: Re: [Qemu-devel] qgraph
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/19 14:34, Natalia Fursova wrote:
> 
> Thank you for your answer. I would like to clarify something about the qmp
> commands.
> For example, consider SCSI controller "lsi53c895a". For getting information
> we use two commands: "device-list-properties" and "qom-list-properties".
> Output consists of many properties, but there is no information about
> provided buses by this device. Is there a qmp command which provides this
> information?

Unfortunately there is no information in QMP about buses that are
provided.   qom-list-types gives the buses that are requested.

Paolo

