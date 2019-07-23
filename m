Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47CCC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB4622543
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB4622543
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpwmI-0000dF-Q2
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 11:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47697)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpwm4-0000Eq-Ec
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpwm3-0003dU-H8
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:32:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpwm3-0003cx-B6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:32:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so39014510wmj.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 08:32:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gMCFhfMU8u9LnWxXWsb3D18cXWfw7C1rjtbtZYtks8c=;
 b=p/OBDSbgsBCsm4fnoNY6wPp5HZS9GuPMSOqa4ewDcBze6xy2hIe7RQmnYA7b6cW0fe
 4n/UH+2BQEi24BrMUF+gnXGiAkRLtlnwKEkO+pDaC7ifsTQtArVC7loCQob7YzCZgzJ/
 E9u/OPdbpoWsmkrzzQxc/y2eZwTw3/Z2YV3PkOkkhiPvqWSxcrE0Wze2RUIQrKl/CUGh
 rN6OUgXvgOR1tKXJcGIpCh7eeHZ4H7YXgX/90yr+oLPn1YP4a88psoSqNmV9IdbpvIV4
 qCXt+Y+fYSHb5oE0tXlOUe2+2qrdFtz/x5qPV+dlTDIs3aOoQ0PIzk7O8YDKPjIF5Je2
 vcbQ==
X-Gm-Message-State: APjAAAUAxvzqCjKwSQetRB3n9eAqEv4A+RagMameYLjIAa60Kg1jg2J7
 fiID+aL3MAP5BkGris6OcK+G9A==
X-Google-Smtp-Source: APXvYqyv0YjuPyPB6nCikrinsxDs7ERoyPMbZkCMAYmLe2vrN10kTiQCH4hL0WfHdNT9zgjMJlcu3Q==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr6921139wmc.75.1563895938184; 
 Tue, 23 Jul 2019 08:32:18 -0700 (PDT)
Received: from [10.201.49.73] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id d10sm51648173wro.18.2019.07.23.08.32.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jul 2019 08:32:17 -0700 (PDT)
To: "Zhong, Yang" <yang.zhong@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <7A85DF989CAE8F42902CF7B31A7D94A1487D6D13@shsmsx102.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <93e3762a-d906-6d6b-9a5f-7497af188f94@redhat.com>
Date: Tue, 23 Jul 2019 17:32:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7A85DF989CAE8F42902CF7B31A7D94A1487D6D13@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] The WCE issue in guest when i enable WCE in Qemu
 side.
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/07/19 14:17, Zhong, Yang wrote:
> When I set config-wce=true or false, the below value never change
>  root@unicorn ~ # cat /sys/block/vda/cache_type
> write back
> root@unicorn ~ # cat /sys/block/vda/device/features
> 0010 0010 0110 0110 0000 0000 0000 1000 1000 0000 0000 0000 0000 0000 0000 0000 
> From left to right, bit 11=0, which show there is no WCE feature in vhost-user-blk device.

Does your backend expose the feature in the VHOST_GET_FEATURES message?

> I also did one simple patch to add config_wce value into s->blkcfg.wce, but the result is same.

config_wce doesn't tell you if you are in writeback or writethrough
mode, it tells you if you can *change* the mode.

If your backend did not expose the feature, try changing that and then
"echo write through > /sys/block/vda/cache_type" should work?

Paolo

