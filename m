Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1078C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526862145D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMV2VFTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526862145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwS0-0005JM-Aq
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kRwMT-0007la-7j
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kRwMQ-0000qF-63
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602503485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmManNbAV7NcI1s7lDDVjxE+xcWhMQnNYQOHb1aRBLA=;
 b=fMV2VFTdrHGGELhflUYCqvolF38zIbzaIOza+wBzLWF+sVYe/HXkCIo+uAQ4RjwnsRn2yL
 Cv8Ee0yLpbdDZK2t4rHpe0Czpy10J0gxfUyEUrQ/TwyrCBFAmhBc/u/2F/DKmngNTvS/T6
 fEQXN/3yg4NpAPe6nHIRw6e+dcsTuuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-5PUHIsNgPlOXinXavs7qtA-1; Mon, 12 Oct 2020 07:51:21 -0400
X-MC-Unique: 5PUHIsNgPlOXinXavs7qtA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4C7064145;
 Mon, 12 Oct 2020 11:51:20 +0000 (UTC)
Received: from [10.3.112.62] (ovpn-112-62.phx2.redhat.com [10.3.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 553575C225;
 Mon, 12 Oct 2020 11:51:20 +0000 (UTC)
Subject: Re: [PATCH v4 4/7] keyval: Parse help options
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201011073505.1185335-1-armbru@redhat.com>
 <20201011073505.1185335-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2f9e1df0-9be8-e63c-8c2d-b1afbe952a0c@redhat.com>
Date: Mon, 12 Oct 2020 06:51:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201011073505.1185335-5-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/20 2:35 AM, Markus Armbruster wrote:
> From: Kevin Wolf <kwolf@redhat.com>
> 
> This adds a special meaning for 'help' and '?' as options to the keyval
> parser. Instead of being an error (because of a missing value) or a
> value for an implied key, they now request help, which is a new boolean
> output of the parser in addition to the QDict.
> 
> A new parameter 'p_help' is added to keyval_parse() that contains on
> return whether help was requested. If NULL is passed, requesting help
> results in an error and all other cases work like before.
> 

> +
> +    /* "help" by itself, without implied key */
> +    qdict = keyval_parse("help", NULL, &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 0);
> +    g_assert(help);
> +    qobject_unref(qdict);
> +
> +    /* "help" by itself, with implied key */
> +    qdict = keyval_parse("help", "implied", &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 0);
> +    g_assert(help);
> +    qobject_unref(qdict);
> +
> +    /* "help" when no help is available, without implied key */
> +    qdict = keyval_parse("help", NULL, NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* "help" when no help is available, with implied key */
> +    qdict = keyval_parse("help", "implied", NULL, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* Key "help" */
> +    qdict = keyval_parse("help=on", NULL, &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "help"), ==, "on");
> +    g_assert(!help);
> +    qobject_unref(qdict);
> +
> +    /* "help" followed by crap, without implied key */
> +    qdict = keyval_parse("help.abc", NULL, &help, &err);
> +    error_free_or_abort(&err);
> +    g_assert(!qdict);
> +
> +    /* "help" followed by crap, with implied key */
> +    qdict = keyval_parse("help.abc", "implied", &help, &err);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 1);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "help.abc");
> +    g_assert(!help);
> +    qobject_unref(qdict);
> +
> +    /* "help" with other stuff, without implied key */
> +    qdict = keyval_parse("number=42,help,foo=bar", NULL, &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 2);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "number"), ==, "42");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), ==, "bar");
> +    g_assert(help);
> +    qobject_unref(qdict);
> +
> +    /* "help" with other stuff, with implied key */
> +    qdict = keyval_parse("val,help,foo=bar", "implied", &help, &error_abort);
> +    g_assert_cmpuint(qdict_size(qdict), ==, 2);
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "implied"), ==, "val");
> +    g_assert_cmpstr(qdict_get_try_str(qdict, "foo"), ==, "bar");
> +    g_assert(help);
> +    qobject_unref(qdict);

Is it worth checking that "helper" with implied key is a value, not help?

> +++ b/util/keyval.c
> @@ -14,10 +14,11 @@
>    * KEY=VALUE,... syntax:
>    *
>    *   key-vals     = [ key-val { ',' key-val } [ ',' ] ]
> - *   key-val      = key '=' val
> + *   key-val      = key '=' val | help
>    *   key          = key-fragment { '.' key-fragment }
>    *   key-fragment = / [^=,.]+ /
>    *   val          = { / [^,]+ / | ',,' }
> + *   help         = 'help | '?'

Missing '

Otherwise
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


