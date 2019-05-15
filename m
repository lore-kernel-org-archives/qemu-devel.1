Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEB6C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4745E20818
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nLGMQikr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4745E20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38831 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQw0F-0000qm-Kg
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 11:39:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQvzS-0000Xd-UQ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQvzS-0000BQ-3W
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:38:46 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQvzR-0000A6-Rm
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:38:46 -0400
Received: by mail-pl1-x643.google.com with SMTP id x15so51536pln.9
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=FPDmVUQBfo3MXOU5jAzbqLXzrKP0wMPfqbVAf5439C0=;
	b=nLGMQikr/UXQ1blYG9uCWfctFHE8gcMw9CVsGN8B1bEpU40tGs9GlVE8/7z7UPX68r
	mdYBqrMXYjOosFaQLk9Iuto/vc9dKkCQot1vv2171YKWbResV1X+f0M+b713F1UV09UK
	gSlHsozYXMUepdIDezHjCZVD5jbGCXNF4vNblrO3n/BzdWJzC/vV/QBpHZzCcrRXIqgq
	8RuNzzdsE9vzp9FsGtmPz5hGQjFfzlG56pTJgGTkXBHVAD7p2+6XFkrGSUqz+BQdYWJg
	ikcxMwwqokEFtjK0ccKn424YHnmufoCV6pSFtjjhbZOLlZdhxIsldj4Kpr9CwUcRa0Yv
	7Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FPDmVUQBfo3MXOU5jAzbqLXzrKP0wMPfqbVAf5439C0=;
	b=SSfLUnq8DH1W5hABBnGJZad2AdSIIXGiajzHvr8gAPbZLRbLLP6zaTHD0dmrjbPTvy
	jYHSnghLcuciSG2CWYtQG4cBjDToToa7HVQHzGP/vNtNwaH2KUjYHDHHYLzN1hzIwgaf
	SFIAPtMqokjfCH+8qkJpJ53VMDK27IeYRZu6suULoEBAS5pyd97L39Qt+TeA6LC9476a
	LvtMPXqtAaTYE7SAD9LzSHCGz6rrSd46fmLedRNop96UuFVJ41MckmZof+06feJwUkdE
	v99Ds9ib1Ule06urw/4bvihtBCgO3hMWLTjARIARv3Ssee09P0LmNz5mQi+RFRUfNCUl
	H90g==
X-Gm-Message-State: APjAAAUdk6GJ3bxO9+TP/7WD48uffovXOxI4b9Av2b2gPiZo2+M1EqbP
	lDhD26o+HmNwg6168msQCiwdLA==
X-Google-Smtp-Source: APXvYqzIwWK1EdHKst5Ll0P89gobl2JdwyxZ7PgzMJLoPurhB3udfbrxBm2WPQ1tJ8I3EGuM1AQkUQ==
X-Received: by 2002:a17:902:728d:: with SMTP id
	d13mr1809334pll.337.1557934724360; 
	Wed, 15 May 2019 08:38:44 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	a80sm7485321pfj.105.2019.05.15.08.38.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 08:38:43 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
	<e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com>
	<87lfz88bva.fsf@dusky.pond.sub.org> <20190515102615.GB4751@redhat.com>
	<87a7fn6a5v.fsf@dusky.pond.sub.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9cb896b5-d2ad-9307-3f8e-13c3e6dc85f9@linaro.org>
Date: Wed, 15 May 2019 08:38:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87a7fn6a5v.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/19 7:54 AM, Markus Armbruster wrote:
> We don't want to deprecate qemu-bridge-helper while libvirt has a
> sensible use for it.
> 
> We can still deprecate -netdev tap parameter "helper" and -netdev bridge
> entirely.
> 
> Once they're gone, qemu-bridge-helper wull have no user within QEMU.  We
> could discuss moving it to libvirt then, but I doubt it'll be worth the
> trouble.

At present, one can do reasonable testing of QEMU by itself, without needing a
management layer on top.  If you remove -netdev bridge, then that is no longer
possible.  (I discount slirp as reasonable; things Just Work with bridging.)

I am opposed to requiring libvirt in order to test QEMU.


r~

