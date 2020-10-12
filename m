Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DFFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C80DF2080D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWeoZQ3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80DF2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwGU-0000So-UI
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kRwF3-0008FX-2i
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kRwF0-00085U-5J
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602503024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbqA7Hgm9F2RRAMdpov5WLOHY0DFhVbcrDVKelPeAus=;
 b=CWeoZQ3lXJnVbtF9AF7rkAHD/k9+CFviDtt5NumiY+Yqd959dSDyiopmht6p9taNss48rD
 Kl/CCXnhEI0bCVX6AOOrJuKrCtUpKaQ0QW+BZFX3XpPi/oH9UH796P23OMVluwz9UhwjWp
 AoQGuKSEj0ob2lwTFwDFAeXS0WNl1qQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-CmD0KHxtNZ67DupRrNqb_A-1; Mon, 12 Oct 2020 07:43:41 -0400
X-MC-Unique: CmD0KHxtNZ67DupRrNqb_A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D050107AD93;
 Mon, 12 Oct 2020 11:43:40 +0000 (UTC)
Received: from [10.3.112.62] (ovpn-112-62.phx2.redhat.com [10.3.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFA04100238C;
 Mon, 12 Oct 2020 11:43:39 +0000 (UTC)
Subject: Re: [PATCH v4 1/7] keyval: Fix and clarify grammar
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201011073505.1185335-1-armbru@redhat.com>
 <20201011073505.1185335-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f0f23fd5-dae9-9692-135a-f22c04520d64@redhat.com>
Date: Mon, 12 Oct 2020 06:43:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201011073505.1185335-2-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On 10/11/20 2:34 AM, Markus Armbruster wrote:
> The grammar has a few issues:
> 
> * key-fragment = / [^=,.]* /
> 
>    Prose restricts key fragments: they "must be valid QAPI names or
>    consist only of decimal digits".  Technically, '' consists only of
>    decimal digits.  The code rejects that.  Fix the grammar.
> 
> * val          = { / [^,]* / | ',,' }
> 
>    Use + instead of *.  Accepts the same language.
> 
> * val-no-key   = / [^=,]* /
> 
>    The code rejects an empty value.  Fix the grammar.
> 
> * Section "Additional syntax for use with an implied key" is
>    confusing.  Rewrite it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   util/keyval.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/util/keyval.c b/util/keyval.c
> index 13def4af54..82d8497c71 100644
> --- a/util/keyval.c
> +++ b/util/keyval.c
> @@ -16,8 +16,8 @@
>    *   key-vals     = [ key-val { ',' key-val } [ ',' ] ]
>    *   key-val      = key '=' val
>    *   key          = key-fragment { '.' key-fragment }
> - *   key-fragment = / [^=,.]* /
> - *   val          = { / [^,]* / | ',,' }
> + *   key-fragment = / [^=,.]+ /

This requires a non-empty string.  Good (we don't allow an empty key).

> + *   val          = { / [^,]+ / | ',,' }

I agree that this has no real change.  Previously, you allowed zero or 
more repetitions of a regex that could produce zero characters; now, 
each outer repetition must make progress.

>    *
>    * Semantics defined by reduction to JSON:
>    *
> @@ -71,12 +71,16 @@
>    * Awkward.  Note that we carefully restrict alternate types to avoid
>    * similar ambiguity.
>    *
> - * Additional syntax for use with an implied key:
> + * Alternative syntax for use with an implied key:
>    *
> - *   key-vals-ik  = val-no-key [ ',' key-vals ]
> - *   val-no-key   = / [^=,]* /
> + *   key-vals     = [ key-val-1st { ',' key-val } [ ',' ] ]
> + *   key-val-1st  = val-no-key | key-val
> + *   val-no-key   = / [^=,]+ /
>    *
> - * where no-key is syntactic sugar for implied-key=val-no-key.
> + * where val-no-key is syntactic sugar for implied-key=val-no-key.
> + *
> + * Note that you can't use the sugared form when the value contains
> + * '=' or ','.

Nor can you use the sugared form when the value is intended to be empty 
(although this may be academic, as your other patches enumerate the list 
of clients, and none of them seem to allow an empty value even when 
desugared).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


