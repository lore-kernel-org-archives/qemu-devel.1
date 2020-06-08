Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225BAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0AE8206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTtV6h5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AE8206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJnE-000057-6y
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiJmK-0007pE-LS
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:33:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiJmJ-00021o-Pd
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591630414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxWQ4bhEfnQYH5cmCr4iZSh4Wrs0FK3XYt4YmOQiIF8=;
 b=HTtV6h5AiJunZA1hIMHhOKxY8GTnuzLbDU3UpQoz0o6xP+OLzp0msGXTEN4kfuDrrflng6
 E6c1sqWyxffA+HetHoB3rQxctgha6D7QRnTJZbyhEZKKtJ0/kxTP0mBzOm6SNUJPTZxPd/
 GCQS3hEfyWLlabOthdI+A5BghICg/lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-mFA6yMqTMYmE-5BbQyBlwA-1; Mon, 08 Jun 2020 11:33:30 -0400
X-MC-Unique: mFA6yMqTMYmE-5BbQyBlwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A982E108BD0C;
 Mon,  8 Jun 2020 15:33:28 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EAEC891E6;
 Mon,  8 Jun 2020 15:33:25 +0000 (UTC)
Subject: Re: [PATCH] hw/openrisc/openrisc_sim: Add assertion to silent GCC
 warning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
References: <20200608071409.17024-1-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <95f1d638-3921-ffdf-8f07-2f077d1d0cc9@redhat.com>
Date: Mon, 8 Jun 2020 10:33:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608071409.17024-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, 1874073@bugs.launchpad.net,
 Christophe de Dinechin <dinechin@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 2:14 AM, Philippe Mathieu-Daudé wrote:
> When compiling with GCC 10 (Fedora 32) using CFLAGS=-O2 we get:

In the subject: s/silent/silence/

> 
>      CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
>    hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
>    hw/openrisc/openrisc_sim.c:87:42: error: ‘cpu_irqs[0]’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>       87 |         sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
>          |                                  ~~~~~~~~^~~
> 
> While humans can tell smp_cpus will always be in the [1, 2] range,
> (openrisc_sim_machine_init sets mc->max_cpus = 2), the compiler
> can't.
> 
> Add an assertion to give the compiler a hint there's no use of
> uninitialized data.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1874073
> Reported-by: Martin Liška <mliska@suse.cz>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   hw/openrisc/openrisc_sim.c | 1 +
>   1 file changed, 1 insertion(+)

Tested-by: Eric Blake <eblake@redhat.com>

With the typo fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


