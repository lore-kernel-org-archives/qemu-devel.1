Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A552C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6339720760
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoPkBdKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6339720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTw1-0004Z1-DO
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTpg-000523-Pa
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTpe-00054E-GV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603823789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sV4L9Hu6mkuUnpQGOW9h/Fvzhb0Ox6XCvDhYI2P8iw=;
 b=UoPkBdKYyqjZUrbMlHY6st1fjnxpKMyHEcWMkWb2VB9xQTEvc2QLW8PL4ycNhgfk7fjom3
 BMjPxyWbnC/WBzpEAtVNRK3PP53nTEYmX7UXt80WN1Xn2FgEPgEGMwJaokW5/8nSRiutM5
 9pUwQlOTXne3M1saCj352cY0hfqUcjU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-zKFDXi0yPTqWt8iqro6jEQ-1; Tue, 27 Oct 2020 14:36:25 -0400
X-MC-Unique: zKFDXi0yPTqWt8iqro6jEQ-1
Received: by mail-wr1-f72.google.com with SMTP id 33so1048140wrf.22
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 11:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1sV4L9Hu6mkuUnpQGOW9h/Fvzhb0Ox6XCvDhYI2P8iw=;
 b=NYehJN3QvhA+qZ9bpB6rRfCi6PqjJ5oHCml4jEx/9kegHqL2T+WwdaHeu7y8X3FNPq
 XikLyAhA/dW+Cb6iywum/2kKH8XIGNzTI3i4q3Q0HocBAaVlZFTgTUzrYbvitHgdcYQK
 zl35xV76qz6N/JfG4L9CGPk0SBxcacQVFNHX/FUEyXD9U09giNxBwwpCMvtV1/3nslMO
 qnJ+/1J+3lRxpV78GtbI9JQqmvj0olm3KQGgUmVYQj1cXloL+XeoQnIB2cLK8R+eelaU
 MDDC3dKVvpKGgJQk696ANABmkvyBagCZHxqJ/KosUCHTFxUHxfBkuypXLWOvKX/WBq+I
 MoMg==
X-Gm-Message-State: AOAM531jXPsi25HZNthuY0Qnpp0RKa0c4qgFSIE/V6EkoQodGQx7Ckf3
 F04aNmAOl8McqqfRt8DRleU/xD6ziizniDPvI9quDmw+Pnb+zs4ME13ILqI08/qRzgvjJNCgr7k
 vBf4y9zanBW0tNoE=
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr4438109wrr.300.1603823784471; 
 Tue, 27 Oct 2020 11:36:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzywYMXiRcea6wICxJeKKV4OnMaknmqu9YhKsZlOV06yzXCPhisl5YM+lmzRGnxv8Lavc8QsQ==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr4438085wrr.300.1603823784125; 
 Tue, 27 Oct 2020 11:36:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id 30sm3087520wrs.84.2020.10.27.11.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 11:36:23 -0700 (PDT)
Subject: Re: [PATCH 0/4] qemu-storage-daemon: QAPIfy --chardev the stupid way
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201026101005.2940615-1-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d00ef574-b2c4-887c-6a37-79f6cf6eeae0@redhat.com>
Date: Tue, 27 Oct 2020 19:36:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026101005.2940615-1-armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/20 11:10, Markus Armbruster wrote:
> Kevin's "[PATCH v2 0/6] qemu-storage-daemon: QAPIfy --chardev"
> involves surgery to the QAPI generator.  Some (most?) of it should go
> away if we deprecate the "data" wrappers due to simple unions in QMP.
> 
> Do we really need to mess with the code generator to solve the problem
> at hand?
> 
> 
> Let's recapitulate the problem:
> 
> * We want to QAPIfy --chardev, i.e. define its argument as a QAPI
>   type.

Considering that this is not 5.2 stuff at this point, I would like to
suggest again moving chardevs to -object, and ask you to evaluate that
option with the agreement that I do the work instead of you. :)

Paolo


