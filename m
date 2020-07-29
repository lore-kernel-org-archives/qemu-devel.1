Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446ECC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112D720809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpqjOi5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112D720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0oeP-0001BF-Ch
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0od2-00085n-ON
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:08:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24702
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0ocz-0001h1-5C
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 12:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596038903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swsbPGm2x5Xh7g1u+3v/v/jGI6JViJcKp4FFD1Ba9qQ=;
 b=ZpqjOi5vYrfj8kvlPCAPcTm8lA8eFeFBH17oL3nkMl/6M94561zpmwsTzz5QUP4f3lvvaq
 CVUZlIC5rbqOxBNWWgS7cle2CB3FmCMX+H+2oY8AATqtjFLhqMHfxT6phNfAMJKWj1xS/w
 AifB0tNJjoYuKNoBc2yRNSslkjxtMuU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-9zde2vy5M3GV_rE7i0k72A-1; Wed, 29 Jul 2020 12:08:20 -0400
X-MC-Unique: 9zde2vy5M3GV_rE7i0k72A-1
Received: by mail-ej1-f69.google.com with SMTP id l18so8630821ejn.17
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 09:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=swsbPGm2x5Xh7g1u+3v/v/jGI6JViJcKp4FFD1Ba9qQ=;
 b=gUY2qIQyCt5twJNqx7h7xWuOs4eQ6NBdzUBSM3ZUAuUNxOJ2YgeOEJU1x1PvgJBDJZ
 Ncw8fbGZDwuYtU5InA/O+PgF3l4Y5OqeWr4p2gBd/kze0QvSrxT5IwUaEmDo9dOULCBw
 NjaKCX+4hCdD/1sJ8GPwTspY+cWd5TY9PgAuM+QzrykA3+S2dqrCe9TKKFmueIJPagq/
 1nX10Hhv+9PmhljFEtuKvnqh43UkOh5R8kAkZJjFDFAg5XNuXR4VG2GIMDov3foq+2qD
 3JvJRQ6F0GAgxs4d79nPXZOxotCdSr1r2rATLtuBx7vMRiapCco9F4r0uWfxtmrLJSOc
 PySg==
X-Gm-Message-State: AOAM533UMqNL1sEqQiiy+3AtcdtNYEK+JQprGnsE4ft0uk1ZVjbwZJgX
 C2/4eJ5CEJhSP/waf0wYu5F0ugShE0qWI5NCItucJugwPVZ60AKfJTd1R5HSOU7ifXBHkYBZ7Fs
 NRcj9gA3ZDjw4otI=
X-Received: by 2002:a17:906:a3d6:: with SMTP id
 ca22mr770731ejb.78.1596038899251; 
 Wed, 29 Jul 2020 09:08:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeQSu9/HovDkcvw2kOc6rb/wCdcDUTu2EYeoq5z9niNXm1d57ac7nUFxnJVZNjBIm9H/93nw==
X-Received: by 2002:a17:906:a3d6:: with SMTP id
 ca22mr770704ejb.78.1596038899012; 
 Wed, 29 Jul 2020 09:08:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:101f:6e7:e073:454c?
 ([2001:b07:6468:f312:101f:6e7:e073:454c])
 by smtp.gmail.com with ESMTPSA id mf17sm1945228ejb.56.2020.07.29.09.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 09:08:18 -0700 (PDT)
Subject: Re: sysbus_create_simple Vs qdev_create
To: Markus Armbruster <armbru@redhat.com>
References: <87lfjkvo81.fsf@dusky.pond.sub.org>
 <20200716222130.GO1274972@habkost.net> <87tuy6k9pa.fsf@dusky.pond.sub.org>
 <20200717162312.GR1274972@habkost.net> <87r1t6hc0f.fsf@dusky.pond.sub.org>
 <20200720155955.GV1274972@habkost.net> <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
 <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
 <20200728224733.GP225270@habkost.net>
 <422d7879-3fdc-d38e-259f-2477b9d3c169@redhat.com>
 <87zh7i5uj5.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ee49ad2-8b6b-cb6f-c3c9-b440631cfc75@redhat.com>
Date: Wed, 29 Jul 2020 18:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87zh7i5uj5.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:18:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/20 15:18, Markus Armbruster wrote:
>> Even code riddled by backwards-compatibility special cases, such as
>> -accel and -machine, can share code between themselves and -object to
>> some extent; this is thanks to functions such as object_property_parse,
>> whose parsing is deferred to visitors and hence to QAPI.
>
> QOM relies on QAPI visitors to access properties.  There is no
> integration with the QAPI schema.

Indeed it doesn't use _all_ of the QAPI goodies.  It does use visitors
and it's a major feature of QOM.

> Going through a visitor enables property access from QMP, HMP and CLI.
> 
> Access from C *also* goes through a visitor.  We typically go from C
> type to QObject and back.  Comically inefficient (which hardly matters),
> verbose to use and somewhat hard to understand (which does).

It's verbose in the getters/setters, but we have wrappers such as
object_property_set_str, object_property_set_bool etc. that do not make
it too hard to understand.

> Compare to what QOM replaced: qdev.  Properties are a layer on top of
> ordinary C.  From C, you can either use the C layer (struct members,
> basically), or the property layer for C (functions taking C types, no
> conversion to string and back under the hood), or the "text" layer
> (parse from text / format to text).
> 
> My point is not that qdev was great and QOM is terrible.  There are
> reasons we replaced qdev with QOM.  My point is QOM doesn't *have* to be
> the way it is.  It is the way it is because we made it so.

QOM didn't only replace qdev: it also removed the need to have a command
line option du jour for any new concept, e.g. all the TLS stuff, RNG
backends, RAM backends, etc.

It didn't succeed (at all) in deprecating chardev/netdev/device etc.,
but this is a very underappreciated part of QOM, and this is why I think
it's appropriate to say QOM is "C with classes and CLI/RPC
serialization", as opposed for example to "C with classes and multi
programming language interface" that is GObject.

> I've long had the nagging feeling that if we had special-cased
> containers, children and links, we could have made a QOM that was easier
> to reason about, and much easier to integrate with a QAPI schema.

That's at least plausible.  But I have a nagging feeling that it would
only cover 99% of what we're doing with QOM. :)

Paolo


