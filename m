Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608FDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF6120678
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 08:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xtnz7rpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF6120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2W2x-0007P1-2p
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 04:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2W2H-0006tj-OO
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k2W2E-0007F4-Vn
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 04:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596444089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfPXB0GoQcqgxiXEyX1OTWitrMT5AjsreB0zPSo5NDo=;
 b=Xtnz7rpPNduhCvqEVQIXuWvYGsf0vgjFVpvLRlKNlOXAIqJwlpLPqy/xsrjBkSmMeFpSMn
 Bz3XUWlu04Liitaox5VKh6pRY6b11TAHcx/18gkwGT1TNT5BGL6l3RtGYv4YqBiCoj7q3o
 pDNHNuIWZYp3T0QuXOAh0PXMjWX/0xM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-hUJ6jJ_WP9-CwXRvC4bCAQ-1; Mon, 03 Aug 2020 04:41:28 -0400
X-MC-Unique: hUJ6jJ_WP9-CwXRvC4bCAQ-1
Received: by mail-wm1-f72.google.com with SMTP id s4so4599330wmh.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 01:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dfPXB0GoQcqgxiXEyX1OTWitrMT5AjsreB0zPSo5NDo=;
 b=DZWCWLpRItdGjOt85OqUH0vNww9Dohc6JkEYSARY2NwnWucoW2X3bINLyp3lIFbCI0
 MTS1Pw0lEeWyEF4Qlh7c8ziavOPUnOL3G4BvV2UW2OH6cdeFZIA7GhZ0EvYvDE0JvXtP
 qkpT21lfjoZ4giit7jnO8aIkX+cNSQoB245ZEzuXwYRT3+XMQSzhQXChhiGQnJwgXFrb
 yaQjoVfJY+LKG+cHM8h0BPup8QuWI1yaH2vSEO7cX0y0pqrzRRz0ZU1aBcTw9BRbsf2H
 fYiR93OXag05iUoNUtCOFVEygyGgHt5jOb63ArdrfUWWmwqlx23DmmFnWjrAS3sssCtb
 vdGg==
X-Gm-Message-State: AOAM5334flGg18tXeqYYpj9lkMfQ5+IaEJs7jVNmjyjY7hDDCbUr0EV8
 qCH7QbZCEGRZKUuBu7Zi7ad/T4XcgVJwgs229vOS3RvctcaToz3SCXdmRCGLn64VA2tBWV8MkKV
 i5ChcpD3ofRukUXQ=
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr13430740wrb.232.1596444085792; 
 Mon, 03 Aug 2020 01:41:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpjsiXeFPoTIbGKaaN44mSQo0BzVrWvqfSWyW4x2bjnDKtShdJuxDSxwwBX/BzIemRlaQf7g==
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr13430714wrb.232.1596444085532; 
 Mon, 03 Aug 2020 01:41:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:310b:68e5:c01a:3778?
 ([2001:b07:6468:f312:310b:68e5:c01a:3778])
 by smtp.gmail.com with ESMTPSA id y2sm23562127wmg.25.2020.08.03.01.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 01:41:24 -0700 (PDT)
Subject: Re: [PATCH] schemas: Add vim modeline
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org> <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org> <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org> <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <20200731154429.GD3660103@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21cda868-85d3-77db-31d8-0248a5029318@redhat.com>
Date: Mon, 3 Aug 2020 10:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200731154429.GD3660103@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 04:41:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/20 17:44, Daniel P. Berrangé wrote:
> I'd consider the runtime protocol separately. In terms of what's on the
> wire, we use genuine JSON format. The runtime problem is simply that JSON
> standard is useless when it comes to integers, leaving behaviour undefined
> in the standard if you exceed 53 bits of precision. So there's no way to
> reliably parse unsigned 64-bit integers. Given that QEMU needs to pass
> uint64 values, JSON was simply the wrong choice of format for QMP.

JSON's 53-bit precision was not part of RFC4627, which was the JSON
specification in 2010.  They say hindsight is 20/20, but referring to
RFC7159 which would come 4 years later is rewriting history, not hindsight.

> There's a 3rd aspect which is our source code that deals with JSON, where
> we defined some JSON extensions to make it easier for C code to construct
> JSON documents for sending over the wire. Back when we did this, it was a
> reasonably good idea as no obvious alternative existed for this problem.
> Today, I would just suggest using GLib's  GVariant feature, which solves
> the same problem for GLib's DBus APIs.

Many years ago actually I tried replacing QObject with GVariant.  I'm
pretty sure the code for that experiment is lost but it took me just a
couple days so it could be redone.  The only issue was that QObjects are
mutable so some instances of QString had to be replaced with GString.

(A small part of it was merged as commit
9bada8971173345ceb37ed1a47b00a01a4dd48cf for unrelated reasons).

> It is a shame we didn't just use DBus back in the day as that's a well
> specified, simple protocol that would have done everything we needed,
> including the ability to actually represent integers reliably. We
> would be able to trivially talk to QEMU from any programming language,
> and use common DBus code-generator tools instead of writing code
> generators ourselves.

Not really, DBus doesn't provide the extensibility that we get from
optional arguments in commands and optional fields in structs.  Again,
we may discuss the QMP protocol itself, but JSON *was chosen for a reason*.

Paolo


