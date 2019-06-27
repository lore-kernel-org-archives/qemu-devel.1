Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A4CC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0BF20828
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0BF20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgTRO-0000kj-UX
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgTPf-0007Lg-P0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgTPe-0002MP-Qg
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:22:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgTPe-0002Lc-Kl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:22:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so2326983wrs.5
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 05:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bEnPtOCHldxlaR4GoCrGGTuLP3Tba+VS/he2P/5fKj8=;
 b=JQIkesxyM88TbQUTLSi7gBhvgqMY1cSGZtMHrTH38u8izWBI6nVGMLBFR8BQS1C8rL
 4v8mkr3tXe8t8fEjukLqZXRfcqyeMDFlqCtkiJ2oZCaNMCzKl/GvRxu5+84JYgHFfRL6
 KIcRUQD8rR9YTliejwLOJnHn3CRK1o4u1bwGdEMvOWQjNf1lZz1Pop73iAvFEqMQLzii
 nBV3sYzI1XRAvMKf2jVzXXiy7Vd/QY1cHC4/Z4EiwgpMjEoKUVSZcgMyxK9BnKRlTcw8
 BCfatZPZTa/7AIJMOOXt6c63hAGwJuUteAb3bn1cz1KbjLagl6tXVNrneZzQ8h9qIYS+
 xTNg==
X-Gm-Message-State: APjAAAV35kjmCauKhD9FXZTsmPeiRfUFzsZBJUFKXoXbviDXEI3Ql0mX
 HfvP3eCAfRT1b60iBPrnSV00TQdj15E=
X-Google-Smtp-Source: APXvYqyFZaNHaRCUr74ENypGHxa2F8RTj62lxKoxYFaJFJdTrAcWX5rK0CzgtbCw/ximq38ExlhGlw==
X-Received: by 2002:adf:fc01:: with SMTP id i1mr2952423wrr.314.1561638120750; 
 Thu, 27 Jun 2019 05:22:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9fc:4658:37f8:2b9c?
 ([2001:b07:6468:f312:9fc:4658:37f8:2b9c])
 by smtp.gmail.com with ESMTPSA id l12sm3906498wrb.81.2019.06.27.05.21.59
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 05:22:00 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-8-git-send-email-pbonzini@redhat.com>
 <874l4bgsww.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3c5ba71-f21b-adcc-3e2e-92bbbc56f63f@redhat.com>
Date: Thu, 27 Jun 2019 14:21:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <874l4bgsww.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 7/7] rdmacm-mux: convert to Meson
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/06/19 13:38, Markus Armbruster wrote:
>> +if config_host['CONFIG_PVRDMA'] == 'y'
>> +  # if not found, CONFIG_PVRDMA should not be set
> Our Makefiles use "either unset or 'y'" booleans pretty pervasively.  Is
> it idiomatic meson?

No, the idiomatic way would be to use the found() method.  Something like:

# in toplevel meson.build:
ibverbs = cc.find_library('ibverbs')
ibumad = cc.find_library('ibumad')
rdmacm = cc.find_library('rdmacm')
if ibverbs.found() and ibumad.found() and rdmacm.found()
  pvrdma = declare_dependency(dependencies: [ibverbs, ibumad, rdmacm]
else
  # magic "not found" dependency
  pvrdma = dependency('', required: false)
endif

# in contrib/rdmacm-mux/meson.build
if pvrdma.found() then
  executable('rdmacm-mux', files('main.c'),
             dependencies: [glib, ibumad])
endif

>> +  libumad = cc.find_library('ibumad', required: true)
> With configure & make, we have configure check -libumad works, and make
> use it.
> 
> Ignorant question: cc.find_library() looks like it checks.  Could this
> replace checking in configure?

Yes, see above.  However, you would have to remove all uses of
$(RDMA_LIBS) and in the Makefiles first.

Paolo

