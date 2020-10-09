Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DF4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953BE222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953BE222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQzbC-0004XH-GW
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 17:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kQzaQ-00046K-Iw
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:05:58 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:48616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kQzaH-00065g-TI
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:05:55 -0400
Received: from MUA
 by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.93.0.4) (envelope-from <mail@maciej.szmigiero.name>)
 id 1kQza5-0001cl-NX; Fri, 09 Oct 2020 23:05:37 +0200
Subject: Re: Who uses TYPE_VMBUS_DEVICE?
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201009193919.GF7303@habkost.net>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 Sg==
Message-ID: <5039480a-690a-314d-cab0-ca230a012990@maciej.szmigiero.name>
Date: Fri, 9 Oct 2020 23:05:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201009193919.GF7303@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 17:05:39
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.208,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org,
 Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eduardo,

On 09.10.2020 21:39, Eduardo Habkost wrote:
> Hi,
> 
> I've just stumbled upon hw/hyperv/vmbus.c and I'm a bit confused:
> I haven't found any subclasses of the abstract type
> TYPE_VMBUS_DEVICE in the QEMU tree.
> 
> I see a few patches in qemu-devel implementing a few vmbus
> devices, but none were merged to qemu.git master.  Are there any
> short term plans to merge vmbus device implementations in QEMU?
> 

Perhaps this depends on your definition of "short term".
At least one VMBus driver (hv-balloon) is being actively worked on
(by me).

Also, a working VMBus implementation (even without any downstream
devices) is apparently required for high-performance Windows
kernel debugging interfaces.

Maciej

