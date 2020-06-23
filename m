Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6B1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B031206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5sJgxhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B031206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnli6-0008T9-BZ
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 12:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnlh8-0007Z2-4M
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:22:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27696
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jnlh6-0002K4-IQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 12:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592929363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfIaZINvqipDoq4qSm1UAilbCkxWjD6StI8fh3XEiHI=;
 b=I5sJgxhUZjoMGjRORcaxPPsDrBvH9Vy0iiFMOfIsqMPN6PD1+0cTLrWUrO2TaFeIipH1bs
 5cEs8WK/m+tQddS/zZxUL5jXJ0DRMSogCHWj+44+l1isn6zffYT8RnBBiQr3t/FlZ0mrd7
 Hk6RapFvA8xT1Q057UQspXgp7KmAPDU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-vTcX198rPISPaaEIFglbKw-1; Tue, 23 Jun 2020 12:22:42 -0400
X-MC-Unique: vTcX198rPISPaaEIFglbKw-1
Received: by mail-wm1-f70.google.com with SMTP id h6so4763951wmb.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 09:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nfIaZINvqipDoq4qSm1UAilbCkxWjD6StI8fh3XEiHI=;
 b=aMFM1b/dWeArWYWtK5O9sL9MjFjQUFOAKdzHDwpjeHyl5+1P9N4zmq2/rRrA9mobZx
 M8ZWyV3227jviz6bNwUR0xWri/AofexuhpUdiezt0NzLGRmSvgHKmMNwGBPhpDurjTJo
 rjVqT2ZmivmUfC1ALWJTGBLv7JUlMjbZ5niVJqG50uUUCDJJ71BeKBHY+b6P93nP2rAS
 Ej+fm8p1wLd8Rr30d0czJQNlFyupCaFxn+rpJOcHaIuN5uXz+X6mgdq/UwTju0JbtbOu
 rikbrSqNy9jaAFLPVrzPdhZvweQOhAcYhxy9GkJbIH8ceGW1ysDkX1i/ki+loxssHIt6
 i03g==
X-Gm-Message-State: AOAM531WXyT+46EP7X4bknCmhuIBZyLKHJp45zZmujfyEQZZZFayu9mg
 4/FkbEWmS27d9/pYAJWatSrP6JFE1gkqvHC1L3c1fFlyCwVYDVib+Zf/iWJH8c3DWRNVuNlrSKT
 QGOZRgG3Yhbnw8dI=
X-Received: by 2002:adf:f885:: with SMTP id u5mr25716442wrp.402.1592929359689; 
 Tue, 23 Jun 2020 09:22:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV4AD9fEP8Xzy7FO+yEWJjwG6jGYnEI1lwSThpvpkxPMxd7CR3c8Q1R3rrEIFmpuksKkhw9A==
X-Received: by 2002:adf:f885:: with SMTP id u5mr25716423wrp.402.1592929359495; 
 Tue, 23 Jun 2020 09:22:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879?
 ([2001:b07:6468:f312:24f5:23b:4085:b879])
 by smtp.gmail.com with ESMTPSA id w13sm23434284wrr.67.2020.06.23.09.22.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 09:22:38 -0700 (PDT)
Subject: Re: [PATCH] qom: Allow object_property_add_child() to fail
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
References: <20200623155452.30954-1-eric.auger@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05765f9d-7981-4d1d-6569-5eb18d8dcaf2@redhat.com>
Date: Tue, 23 Jun 2020 18:22:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623155452.30954-1-eric.auger@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/20 17:54, Eric Auger wrote:
> This patch introduces two new functions, object_property_add_err() and
> object_property_add_child_err() whose prototype features an error handle.
> object_property_add_child_err() now gets called from user_creatable_add_type.
> This solution was chosen instead of changing the prototype of existing
> functions because the number of existing callers is huge.

The idea is good, but I would rather name the functions
object_property_try_add{,_child} to follow e.g. g_try_malloc.

In fact, the existing function object_property_try_add can simply be
made non-static.

Paolo


