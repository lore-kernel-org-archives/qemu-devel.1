Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A583C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:17:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CAB204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzLjFAKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CAB204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ZP9-00065Q-Vm
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 08:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2ZOF-0005CX-Ke
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:16:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2ZOD-0003f7-VP
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596456985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKieeyoAx5B+oErIwGDg709YE/sDDlfkuYQwdc4JY3s=;
 b=QzLjFAKPaFT2PMN+lAC2mcLG3CU0hJ1MVggFENSguMj/2PlLH5Q425lAlwcnhAWAJlnDqX
 ePoFZYlncmoT/l4CbyjkhQgZDrU6kC08ISmRdQd+f+vMhylTi186/oHHNiRHZPiwxLxoAz
 O0pEN8uBPTeuTzwxKknlVu+sZjmegFw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-IDqQNJqcO5qgiW3QhmfX7Q-1; Mon, 03 Aug 2020 08:16:23 -0400
X-MC-Unique: IDqQNJqcO5qgiW3QhmfX7Q-1
Received: by mail-wr1-f72.google.com with SMTP id e14so8107332wrr.7
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 05:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wKieeyoAx5B+oErIwGDg709YE/sDDlfkuYQwdc4JY3s=;
 b=uaHrKwlBkKuqkmaNeRwj54FOLhMuSUq6GwXYZVbW5gykW7gVzdAjGyNpJafnR3EuCG
 XJX0xeZ7xOQfX3QSD4MiwmgLP0bc8YFOa4Gwun8Hlzfs/AeOmPFGpCXxNZRx69GKAgw0
 bra9UdOJJptvsQlwElTYjPjRPpR75wIYAtANwjp10Pi/MsvAqtMG+LNswB2HeF8eWS8S
 F4UNRzQmA13Cz3PrUudnI5I+EjsHUS6m++yJahc1X9gzrBT6K94oSVcyeGyPofb7CSeo
 24rqL33PLkdyWNg+RBFOVWZBHXCKxiHjwBN3u8tdXYYAj6UDi/u7n01P7gvaEEYjV5t+
 dvpw==
X-Gm-Message-State: AOAM533K+/b5oUuqsmTpN0di8lyT89/XubdTMEfxHyKumdJodX0EGSn9
 pAgHZaVYdtPWg6rps5SPeWbM/4dL8MUanKT6+SUokdSJOc4G9TBbNwKrsCnB4JuGfZZ+oxcTG1I
 dWXGSjCZM5yhoWFk=
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr15368812wrx.324.1596456981508; 
 Mon, 03 Aug 2020 05:16:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5A70RLREWnZOYGugMsVckM/fUfXK/zuZT807WcbX1g2WVoR9O533UCtEYIDPBMwBFUmAtEw==
X-Received: by 2002:a05:6000:1203:: with SMTP id
 e3mr15368800wrx.324.1596456981273; 
 Mon, 03 Aug 2020 05:16:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20?
 ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
 by smtp.gmail.com with ESMTPSA id v67sm26189764wma.46.2020.08.03.05.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 05:16:20 -0700 (PDT)
Subject: Re: [PATCH] schemas: Add vim modeline
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <20200731154429.GD3660103@redhat.com>
 <21cda868-85d3-77db-31d8-0248a5029318@redhat.com>
 <20200803113655.GI3670709@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fcc9056d-4d72-5bdb-bd21-2bf6213f5a55@redhat.com>
Date: Mon, 3 Aug 2020 14:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200803113655.GI3670709@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/08/20 13:36, Daniel P. Berrangé wrote:
>>> Given that QEMU needs to pass
>>> uint64 values, JSON was simply the wrong choice of format for QMP.
>
> I wasn't refering to RFC7159. The problem of undefined integer precision
> with JSON came up right at the very start when QMP was first designed and
> implemented, and has come up again periodically ever since then. libvirt
> needed to do workarounds right at the start in 2009, in order to fully
> handle signed/unsigned 64-bit integers with QMP.

I assume the workaround you refer to is to store the number as a string
and converting it lazily to either an integer or a floating-point type
in whoever uses the JSON API.  It may not be pretty but probably it
would have been the same for any text-based, schema-less protocol.  For
example, it didn't require writing your own parser.

It could be avoided by using a schema in Libvirt, just like QEMU has no
problem with it on the other side; it's just a different design choice
with different trade-offs, I don't think it's enough of an issue to
declare JSON "the wrong choice of format for QMP".

Paolo


