Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E561CC28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD71820684
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD71820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46896 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKz3-0000pl-Mh
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52492)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1haKjA-0003Px-6n
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1haKj9-0003lG-51
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:52:48 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1haKj8-0003kf-VB
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:52:47 -0400
Received: by mail-wr1-f44.google.com with SMTP id d18so9278717wrs.5
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 06:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PJz/CyI3mmyfAEQ3gFaGcCAu12c5Y9jTvdcUVmAdYNs=;
 b=X+ir8HRotwXXV4uYtmtxiAiBK5HtNkRz1LBULbcUQiBmtbQljbK2mwuC6Dm8PVAUN4
 0hgLxomV8B//ufMNLlPos6xMaSRrnC6UdXiJhr02jF1PVZtEQhAs5XUHNjuw0LpMZTfB
 q0v3jmOzhAsEzZYIgV1soJ2GkFL1tyNReWCdpof0UwKI0FqXqPwaJH5I+xc5t8u86eJl
 g2oA0Si6PQqE+hmBO0pR6QhhU1GkH/VnCrUdAmYbfaLbB2GzSZAk1MY60BHWLnvjYJ7b
 wrG0cb00CUm4Bx3REWOqjSAuYvBGBhepYPWRVwx60dKmYLDIDk3dyHN5ABHjgZGKtwzZ
 a31Q==
X-Gm-Message-State: APjAAAVbTzMZGz/DT60tbyT6Xrro7idL9moTjDxsMIEaaitFf4+8j6MR
 sBSLib0q2bdWuHSRjCDKVhi/3A==
X-Google-Smtp-Source: APXvYqwWOsfOcLukh8X+9uAdGDdX7i1KUcgWhZadXZ1oehYQYgMW+rOtsi1AzN0NTvy25OwnnfhuFQ==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr45569567wrq.28.1560174765651; 
 Mon, 10 Jun 2019 06:52:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:49d3:a711:c5a3:8ebf?
 ([2001:b07:6468:f312:49d3:a711:c5a3:8ebf])
 by smtp.gmail.com with ESMTPSA id o15sm13554208wrw.42.2019.06.10.06.52.44
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 06:52:45 -0700 (PDT)
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
 <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
 <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
 <e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>
 <98826c5f-4a74-5364-2aef-28a10db12c20@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39250506-f38f-c440-5728-7b970d32ab41@redhat.com>
Date: Mon, 10 Jun 2019 15:52:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <98826c5f-4a74-5364-2aef-28a10db12c20@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.44
Subject: Re: [Qemu-devel] qgraph
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
Cc: Natalia Fursova <Natalia.Fursova@ispras.ru>, qemu-devel@nongnu.org,
 =?UTF-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/19 15:28, Andreas Färber wrote:
> So if we want a new QMP operation, the most sense would probably make
> where-can-I-attach-type(foo) returning a list of QOM paths, showing only
> the first free slot per bus. That would allow a more efficient lookup
> implementation inside QEMU than needing to check each slot[n] property
> via qom-get after discovering it with qom-list.

Note that what Natalia is seeking is an introspection mechanism to be
used _before_ creating a virtual machine though.

Paolo

