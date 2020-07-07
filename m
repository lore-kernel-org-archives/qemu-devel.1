Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1C7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 05:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52BC206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 05:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFtA/16d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52BC206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsgU5-0004Nk-Sp
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 01:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsgTO-00037o-VK
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 01:48:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58369
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsgTN-0000Kb-9P
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 01:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594100932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n77SueP3i7TT9doc0vMKga+X706KQuI3SUNQe+049+o=;
 b=NFtA/16dj2ulSYOL/Yf1ZOqjViDDNvGkLhIX5FH04zWuUkYuW0JYoDJEwRMz5CP+3tRmEh
 q/2h/3w/MFm5hipwsOV6+hTYbD5BNKwt08Rm+bV9BOtyvo2fkjTbR9Ep8yoc5ZifjlqvTj
 XzhwX3wYYkQl7uHkpP2nBIiEV2CLPAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-vaUZg23hP4ibPLZLblui6w-1; Tue, 07 Jul 2020 01:48:50 -0400
X-MC-Unique: vaUZg23hP4ibPLZLblui6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC3FAEC1A2;
 Tue,  7 Jul 2020 05:48:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAD5A51C4C;
 Tue,  7 Jul 2020 05:48:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 494281132FD2; Tue,  7 Jul 2020 07:48:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] util/qemu-option: Document the get_opt_value() function
References: <20200629070858.19850-1-philmd@redhat.com>
Date: Tue, 07 Jul 2020 07:48:48 +0200
In-Reply-To: <20200629070858.19850-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 29 Jun 2020 09:08:58
 +0200")
Message-ID: <87imezan9b.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, Kevin Wolf <kwolf@redhat.com>,
 "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Coverity noticed commit 950c4e6c94 introduced a dereference before
> null check in get_opt_value (CID1391003):
>
>   In get_opt_value: All paths that lead to this null pointer
>   comparison already dereference the pointer earlier (CWE-476)
>
> We fixed this in commit 6e3ad3f0e31, but relaxed the check in commit
> 0c2f6e7ee99 because "No callers of get_opt_value() pass in a NULL
> for the 'value' parameter".
>
> Since this function is publicly exposed, it risks new users to do
> the same error again. Avoid that documenting the 'value' argument
> must not be NULL.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Drop confuse comment (Damien Hedde)
> ---
>  include/qemu/option.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/qemu/option.h b/include/qemu/option.h
> index eb4097889d..ac50d25774 100644
> --- a/include/qemu/option.h
> +++ b/include/qemu/option.h
> @@ -28,6 +28,19 @@
> =20
>  #include "qemu/queue.h"
> =20
> +/**
> + * get_opt_value
> + * @p: a pointer to the option name, delimited by commas
> + * @value: a non-NULL pointer that will received the delimited options

s/received/receive/

> + *
> + * The @value char pointer will be allocated and filled with
> + * the delimited options.
> + *
> + * Returns the position of the comma delimiter/zero byte after the
> + * option name in @p.
> + * The memory pointer in @value must be released with a call to g_free()
> + * when no longer required.
> + */
>  const char *get_opt_value(const char *p, char **value);
> =20
>  void parse_option_size(const char *name, const char *value,

You are adding a *second* doc comment: the definition already has one.
It's clearer than yours on some things, and less explicit on others.
Feel free to improve or replace it.  But do put it next to the
definition.

I'm not trying to re-argue where to put doc comments.  I *am* arguing
for local consistency while we lack global consistency.  For code I
maintain, I insist on local consistency.

The code belonging to MAINTAINERS section "Command line option argument
parsing" has doc comments next to the definition.  Except for
qemu_opt_has_help_opt(), which predates my maintainer mandate.


