Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DD6C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD072332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD072332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Lik-0000Nb-2Q
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i0LJL-0003HX-H9
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i0LJK-0003G2-GR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:45:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i0LJK-0003Ep-Af
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 03:45:38 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2F5385545
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 07:45:36 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id t9so828214wrx.9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 00:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gRuH2f3gZIE7itReI28qNk3gmy2+1sz4SZxDr8nmqGY=;
 b=GBDJL38MxFr8aM5DLZmna0GUCtHsiTIpGFpv0jYLdP8yj6UM0qODZ+dln3PWqFxdgP
 PgHGtTKFhi4Tw1CKCzsnnLiMl8tEdnraUx7OmKKTtmFobAR4QfmshAeHE3XtAEDBfrSH
 z8gvakM9fFEOVdnLFEQagNB7OT4GpyTcsZ3FL4iOQeaGFOUFlq/oIfgXJHVK7FvZT5mv
 G9XNK82ZVYiFvbp/k+z0D8EdFwHlTuVR49HAaVrFMV3YFe9OULwQlgp9+HY/146Nqt48
 sxnRnYOf0Cg74QgTpMmorzx1o+GHO7jAhgK1V++IZTVSGreEki1QchW3vt5Sge3/tqze
 Su/w==
X-Gm-Message-State: APjAAAXxzqTxs84vDE1bLt+ttTcw9XNgA1H0hwFmL2KqhkIVGvX7qwY7
 Hi5pYkgDkLRbJIpqi0A7tl7TrNd14+ZCMJXSnKadUIMvyvVHQcZ34PPY8Hr6zWgDROilBMFPzkc
 BwXHWKnBg8NjcdLM=
X-Received: by 2002:a05:600c:21ca:: with SMTP id
 x10mr4495341wmj.112.1566373535431; 
 Wed, 21 Aug 2019 00:45:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxp3/qlaYM5XMBgCQbZg7jQTaB8DNA97WKaHyZdXh6pXYikSCbGowUHzYiheygFZoW+guTn7w==
X-Received: by 2002:a05:600c:21ca:: with SMTP id
 x10mr4495304wmj.112.1566373535120; 
 Wed, 21 Aug 2019 00:45:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:56e1:adff:fed9:caf0?
 ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id l5sm2141438wmj.4.2019.08.21.00.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 00:45:34 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
 <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
 <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
 <7f6e8a5c-8262-ae39-333a-e8f18b3174f0@redhat.com>
 <20190821064208.eckikvttpdc3zjmd@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6206c058-8fa6-2a19-b76b-dcb5fa260e56@redhat.com>
Date: Wed, 21 Aug 2019 09:45:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821064208.eckikvttpdc3zjmd@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Regression with floppy drive controller
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alex <coderain@sdf.org>,
 seabios@seabios.org, QEMU Developers <qemu-devel@nongnu.org>,
 Nikolay Nikolov <nickysn@users.sourceforge.net>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/08/19 08:42, Gerd Hoffmann wrote:
>> So we should use '-cpu Conroe' or '-cpu core2duo' minimum?
> -cpu Conroe for -M isapc is kida silly though ...
> 
> Maybe we should simply build seabios with CONFIG_TSC_TIMER=n ?
> 
> Using the TSC in a virtual machine is problematic anyway, the
> calibration can be _way_ off on a loaded host, this is why seabios
> prefers the (fixed frequency) pmtimer. 

Yeah, that falls back to the PIT which is a good enough source for
SeasBIOS's needs (1 MHz, one third of the pmtimer).  It overflows a bit
too easily but it shouldn't be a big deal for users of isapc.

Paolo

