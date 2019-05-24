Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CDCC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB682168B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB682168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4hy-0002H4-4E
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:33:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU4gv-0001qh-Fw
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:32:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU4gu-0005Ct-HE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:32:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU4gu-0005Bn-5N
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:32:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so8877356wrx.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 00:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=dCFtuYIZ+ESBSepd+4B2XtL0/1kRWgHHKvsOJ3MFEEM=;
	b=JUXmfaN48Khcxy1P7++uXtUQ3YTEgTxwS3XtBsuVzBenkBdK1t+d6G1mLNUS6/OF4g
	YRy4QtZJSLLieaHstX2Zm3Z9GC/sN9oxchOx6t0Oqse73l5OcNh86YG8KvBYIxLzNnnx
	Hf/WjXZKq3U8YlbEHZ/fC1WTg6aWSUi/A4IzpPNFCYHkp+/5cix3nAAWTu7bhPq6mH3Z
	GWvmc8uaEzn8b/Q2sXEgv2xqmlJzbKbPQ5GtmVu468sXnv7YzaVQ2NoidIixG8HmTFVP
	r2m5fNnjUhQHkUTxANn7SqdWZ281bbhgNJEuwqxS+GNMKuLDw825XuoBWdOV1c/Ktwdp
	xWew==
X-Gm-Message-State: APjAAAXdvD6Vc1O+fLml0hBnNf42iK+4tm6F8zMZP9+gwVDOo2axxsox
	Y+Vbl8H7aUUj5klb6LrIz0Drgw==
X-Google-Smtp-Source: APXvYqyhrun6RbF86vj1OmgqUwgZWNPFo1tniFRjuCVs6vq4EtMQt1Svi2u1hKwn1Ln8ZrcKiVUWxA==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr36447623wrp.37.1558683154820; 
	Fri, 24 May 2019 00:32:34 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id g11sm733021wmf.1.2019.05.24.00.32.33
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 00:32:33 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-7-armbru@redhat.com>
	<d1a31149-6732-e7d6-e2c3-bf3d919c4c03@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e6d5eef5-2603-6d7a-6371-7e184fa82763@redhat.com>
Date: Fri, 24 May 2019 09:32:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d1a31149-6732-e7d6-e2c3-bf3d919c4c03@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [RFC v4 6/7] tests: Don't limit check-headers to
 include/
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

On 5/24/19 9:24 AM, Thomas Huth wrote:
> On 23/05/2019 10.15, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> Please add a proper patch description. You don't really expect someone
> to review this monster patch without instructions where to look first?

From the cover letter:

PATCH 5 adds the tests, but only for include/.  764 headers, 179
known-bad.  We may decide to clean up include/ some before we apply
PATCH 6+7.

PATCH 6 extends them to all headers, except for generated ones.  Adds
797 headers, 409 known-bad.

Markus, you could have use "This patch is RFC, see the cover letter of
this series" :)

