Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8944EC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B46D20715
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 17:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faBmoz1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B46D20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHsAg-00053s-12
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 13:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kHqsi-0003Kn-Im
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:59:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25494
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kHqsf-0000I4-6A
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600099139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7onWJr8WtR6jjPyCfLawYtMRJr+eaJ/qwb3p6Qyyos=;
 b=faBmoz1oEMeBZgfzIVgitrC7SzrP7mcWLc4WeyKqXHagxGXTkKKEdyTTDnGgTIhJEHVuEQ
 cYdxpuHKyrCpcclGvrR6m8nTPIJVC44ofxOVsiFqKtsdusQNSPgFJa7VGgub0Pfxs8Lb4w
 JYnXxl0x4TI/ELZncRs9atpm825JOgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-F_PyXFNMO_iFMMVZXG1Ygw-1; Mon, 14 Sep 2020 11:58:57 -0400
X-MC-Unique: F_PyXFNMO_iFMMVZXG1Ygw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DED9800C60;
 Mon, 14 Sep 2020 15:58:56 +0000 (UTC)
Received: from [10.3.113.68] (ovpn-113-68.phx2.redhat.com [10.3.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F15B07B7B4;
 Mon, 14 Sep 2020 15:58:55 +0000 (UTC)
Subject: Re: [PATCH v5 8/8] qapi: New -compat deprecated-input=crash
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200914084802.4185028-1-armbru@redhat.com>
 <20200914084802.4185028-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e1c94dc7-b97f-4919-0210-fe3c0e19e93f@redhat.com>
Date: Mon, 14 Sep 2020 10:58:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914084802.4185028-9-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 3:48 AM, Markus Armbruster wrote:
> Policy "crash" calls abort() when deprecated input is received.
> 
> Bugs in integration tests may mask the error from policy "reject".
> Provide a larger hammer: crash outright.  Masking that seems unlikely.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/qemu-options.hx
> @@ -3392,7 +3392,7 @@ DEFHEADING()
>   DEFHEADING(Debug/Expert options:)
>   
>   DEF("compat", HAS_ARG, QEMU_OPTION_compat,
> -    "-compat [deprecated-input=accept|reject][,deprecated-output=accept|hide]\n"
> +    "-compat [deprecated-input=accept|reject|crash][,deprecated-output=accept|hide]\n"
>       "                Policy for handling deprecated management interfaces\n",
>       QEMU_ARCH_ALL)
>   SRST
> @@ -3403,6 +3403,8 @@ SRST
>           Accept deprecated commands and arguments
>       ``deprecated-input=reject``
>           Reject deprecated commands and arguments
> +    ``deprecated-input=crash``
> +        Crash on deprecated command

Missing 'and arguments'?

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


