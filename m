Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9DC2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD58206E9
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJpF7gK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD58206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFtP-0007jv-GW
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 09:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnq-00085f-Fu
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jNFnp-0002nP-ET
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:04:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jNFnp-0002nH-B8
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586610245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XwCjF1FA7bZD/BVfLxjIdpj3FDTZQ8sXYvzUMCawWpg=;
 b=ZJpF7gK5bltGUL/dG1HIOC3cwwl6+pySdlYh776kFlZ0JyXghkrjXDHQJ6rCXAe+PHa1rx
 3d+SkLDviwQhIIhBDzWQ6Mc+x5yVjuLY4QMWMvd08wHK6sDOmqfrfa7X1vKMY5IHxmnCO7
 XDGKR+EfQA2T0zI+xk+9wIybnq0HRNE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-MG7WIqMBMQOsHbu3dQ3TTQ-1; Sat, 11 Apr 2020 09:03:59 -0400
X-MC-Unique: MG7WIqMBMQOsHbu3dQ3TTQ-1
Received: by mail-wr1-f71.google.com with SMTP id v14so3152576wrq.13
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 06:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XwCjF1FA7bZD/BVfLxjIdpj3FDTZQ8sXYvzUMCawWpg=;
 b=mgBV7JrPFAj0ralZQmWhAULnYRGwqjt3JlBWX27YpG1q97UoIK2gZlMPWFlCwQm27q
 hYnMQnjqxAn1UAJEAdmC8Pt0dPX6x0e9pBHnnoLTjZ50ed2JVEkuk0plYDSZkcoZe2X3
 pyfpYrT5b9ST0CdoGxASMP7Ws0o7Kw69/y6k6l+wa+iantQtJSGJrwCFYiEzPRfenSMi
 A1LEDjTmA/ZY5enKQsE7KYVKE5BW677uvq1NcQoPeuwtG0D8gV89uz08MwO3IDzMnO1B
 p2QmHik7j882NcaPNLW2N0kcZTLICiTeRRv/CbkOyrVAgSctkms3MTlZOdAvGT1ldGtG
 cuzQ==
X-Gm-Message-State: AGi0PubSyvvjcgLQEPzP8ihw6YnpUoFsXQnFhMXs//KOf5QCPD0MCnJC
 hZ8OEHeP9wvHubo2TsmXJNmepXU6kKA1vYq6wSiSeRVfgdOHKioYUqVg0UDFzvHqMOtknT5wv/w
 PjHVelse32QgDET8=
X-Received: by 2002:a5d:5307:: with SMTP id e7mr9117907wrv.97.1586610238325;
 Sat, 11 Apr 2020 06:03:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypIkn/nRwWkuKj9whVIqEOmPhtClehmlu+MJsnbfdG2kri15427vjdh6lVB/J1CKXRec7Tm6dA==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr9117892wrv.97.1586610238034;
 Sat, 11 Apr 2020 06:03:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f95d:5f37:e378:f48d?
 ([2001:b07:6468:f312:f95d:5f37:e378:f48d])
 by smtp.gmail.com with ESMTPSA id t8sm6874795wrq.88.2020.04.11.06.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2020 06:03:57 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] lockable: replaced locks with lock guard macros
 where appropriate
To: Daniel Brodsky <dnbrdsky@gmail.com>
References: <20200404042108.389635-1-dnbrdsky@gmail.com>
 <20200404042108.389635-3-dnbrdsky@gmail.com>
 <CA+ZmoZVJhyuXbbUJHTQdFZKA6+WqYUgnxEXF0y-nq0=aK4cpww@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aacbf5fb-2c13-b7a8-3a28-de0a9b1b465e@redhat.com>
Date: Sat, 11 Apr 2020 15:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+ZmoZVJhyuXbbUJHTQdFZKA6+WqYUgnxEXF0y-nq0=aK4cpww@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "open list:iSCSI" <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Peter Lieven <pl@kamp.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/04/20 13:19, Daniel Brodsky wrote:
> Just making sure this patch didn't get lost.
> ping http://patchwork.ozlabs.org/patch/1266336/

The patch looks good, but it will be included in QEMU only after 5.0 is
released.

Thanks,

Paolo


