Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE98C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1501E206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 14:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCpgJgJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1501E206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsSDN-0002bs-BD
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 10:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsSCe-0001sf-9O
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:34:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45298
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsSCc-0003jc-Pu
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 10:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594046078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sy82O70eh7lmpMogxX4Wig8ko74faHSoOvBCIgJ2Ptk=;
 b=aCpgJgJfvykEPpxM1gKUCVJKOM/YLwuy/Y+8DL4H6KygPBZTiE0AJfDLhg+V0lzHIwuv+N
 qRFyuxAVnkgnNpLMiBPoIPwWD7bsrYR4lxjIfXaAdm/jBNHXu+GGYpt6UN7QD7kHPFpKIk
 z279dd5JvJfFZjt0NLjpqo+7DRxgW9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-_sF_CQ2dNJeFDnj5XmgwzA-1; Mon, 06 Jul 2020 10:34:34 -0400
X-MC-Unique: _sF_CQ2dNJeFDnj5XmgwzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41B7E8DFFD9;
 Mon,  6 Jul 2020 14:33:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E742D19D61;
 Mon,  6 Jul 2020 14:33:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 746051132FD2; Mon,  6 Jul 2020 16:33:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 01/44] error: Improve examples in error.h's big comment
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-2-armbru@redhat.com>
Date: Mon, 06 Jul 2020 16:33:49 +0200
In-Reply-To: <20200706080950.403087-2-armbru@redhat.com> (Markus Armbruster's
 message of "Mon, 6 Jul 2020 10:09:07 +0200")
Message-ID: <87imf090he.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Show errp instead of &err where &err is actually unusual.  Add a
> missing declaration.  Add a second error pileup example.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  include/qapi/error.h | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index ad5b6e896d..3e64324b7a 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -16,15 +16,15 @@
>   * Error reporting system loosely patterned after Glib's GError.
>   *
>   * Create an error:
> - *     error_setg(&err, "situation normal, all fouled up");
> + *     error_setg(errp, "situation normal, all fouled up");
>   *
>   * Create an error and add additional explanation:
> - *     error_setg(&err, "invalid quark");
> - *     error_append_hint(&err, "Valid quarks are up, down, strange, "
> + *     error_setg(errp, "invalid quark");
> + *     error_append_hint(errp, "Valid quarks are up, down, strange, "
>   *                       "charm, top, bottom.\n");
>   *
>   * Do *not* contract this to
> - *     error_setg(&err, "invalid quark\n"
> + *     error_setg(errp, "invalid quark\n" // WRONG!
>   *                "Valid quarks are up, down, strange, charm, top, bottom.");
>   *
>   * Report an error to the current monitor if we have one, else stderr:

I intend to drop the change from &err to errp, and update the commit
message accordingly.

error_setg(&err, ...) is indeed unusual, and I cleaned up several unwise
uses in PATCH 32+35+39.  However, error_append_hint(errp, ...) is bad
advice until Vladimir's ERRP_AUTO_PROPAGATE() makes it work.  No need to
get ahead of his work here.

[...]


