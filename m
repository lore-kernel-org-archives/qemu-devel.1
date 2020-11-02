Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E35DC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 12:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B38223AC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 12:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxXcKDGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B38223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYWq-0006C1-Pd
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 07:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZYWF-0005lA-VI
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 07:01:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZYWE-0004Wj-9F
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 07:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604318461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dtAMTn//B67yDHl6S+FPA8RzwBwlrcl+R8C+Mh8XIBM=;
 b=AxXcKDGtC8C0VYQ9bCvkMcFpkg6X+FgI6tVhwyp5fxQmhuHk6gWC2NlJfKKUvLyU20n7L9
 TPoAhtrouaUE0wtM2CptRGsojXMDz3nquZzX80ZlCCUYuerVrvcMqWbdO8SyL95jf7Wbgp
 pAszPLT+BlNMJW1z32Ch7nAnmJSnyQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-lLqvwOAbM42F5TL4YGkdQg-1; Mon, 02 Nov 2020 07:00:57 -0500
X-MC-Unique: lLqvwOAbM42F5TL4YGkdQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F17DF10932A2;
 Mon,  2 Nov 2020 12:00:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFF2E5DA6B;
 Mon,  2 Nov 2020 12:00:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 214AE1132BD6; Mon,  2 Nov 2020 13:00:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pc: comment stule fixup
References: <20201102100948.1101121-1-mst@redhat.com>
Date: Mon, 02 Nov 2020 13:00:49 +0100
In-Reply-To: <20201102100948.1101121-1-mst@redhat.com> (Michael S. Tsirkin's
 message of "Mon, 2 Nov 2020 05:09:54 -0500")
Message-ID: <877dr4j7da.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Fix up checkpatch comment style warnings.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/i386/pc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 416fb0e0f6..5872ae6095 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1150,9 +1150,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>              exit(1);
>          }
>          /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
> -            * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
> -            * IRQ8 and IRQ2.
> -            */
> +         * and earlier, use IRQ2 for compat. Otherwise, use IRQ16~23,
> +         * IRQ8 and IRQ2.
> +         */
>          uint8_t compat = object_property_get_uint(OBJECT(hpet),
>                  HPET_INTCAP, NULL);
>          if (!compat) {

Since you're touching this already...

CODING_STYLE.rst:

    Multiline comment blocks should have a row of stars on the left,
    and the initial /``*`` and terminating ``*``/ both on their own lines:

    .. code-block:: c

        /*
         * like
         * this
         */


