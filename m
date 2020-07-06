Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE61C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843E7206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KV/Ccw1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843E7206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsSYZ-0001GT-Nm
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 10:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsSY0-0000oc-PS
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:56:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37148
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsSXy-0006pz-OE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594047401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgkMNXMliYbiJ41vAZE0ZDDbBULQiVhgs5b1vvr90FE=;
 b=KV/Ccw1+X/tY2yRC5qFzXfeunNApLUvZf9DJiWb4L51idIid6/pfIo8jOgwRN1ipaSs/Xt
 NsxlPFLV3CIXLxBKnGXbClrUqoPu8PnvNTQOHnMuoLP0WZEWLACJA6tT/MeQLQjZFHDbYu
 DNNtCyAz0/vZ071sRCrsi2A7r+mEDqc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-MhKFPjaDNPOgA70Vr1pEQw-1; Mon, 06 Jul 2020 10:56:34 -0400
X-MC-Unique: MhKFPjaDNPOgA70Vr1pEQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 405E38014D4;
 Mon,  6 Jul 2020 14:56:33 +0000 (UTC)
Received: from [10.3.113.97] (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE705C290;
 Mon,  6 Jul 2020 14:56:32 +0000 (UTC)
Subject: Re: [PATCH rc6 22/30] target/avr: Register AVR support with the rest
 of QEMU
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>
References: <20200705140315.260514-1-huth@tuxfamily.org>
 <20200705140315.260514-23-huth@tuxfamily.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <257c315e-687f-0c29-9f6a-eeb0702e64a1@redhat.com>
Date: Mon, 6 Jul 2020 09:56:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200705140315.260514-23-huth@tuxfamily.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/20 9:03 AM, Thomas Huth wrote:
> From: Michael Rolnik <mrolnik@gmail.com>
> 
> Add AVR related definitions into QEMU.
> 
> [AM: Remove word 'Atmel' from filenames and all elements of code]
> Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---

> +++ b/qapi/machine.json
> @@ -25,7 +25,7 @@
>   # Since: 3.0
>   ##

Missing a line that resembles:

# @avr since 5.1

>   { 'enum' : 'SysEmuTarget',
> -  'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'cris', 'hppa', 'i386', 'lm32',
>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
>                'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


