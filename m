Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742FEC4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B7920708
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAt4+nPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B7920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXmm-0006J1-Ug
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNXll-0005sA-Ql
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNXlj-0008M0-V5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:47:25 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601455642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goc6zRNbCV0Tz0y7aZZOuEvN0ilVYCALC9pPhwjQOoM=;
 b=jAt4+nPNxDcghqohCh+TLDKk+SANcu1VtmV2jGWpckw3IVb5kwHI/Q5R/mxH3RNy3+h2Tm
 lefFG9deKayMYZmPvCwnXqxzXYzySmiFuDHTLwn3eiSeJ3d+mpBfhvRke2YNGuZn6xr7YJ
 z3WQdGChLwZ+0Qj2gNWLeufpsy4TAAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-zNz_jMmgPvCcc76EMjO3TA-1; Wed, 30 Sep 2020 04:47:20 -0400
X-MC-Unique: zNz_jMmgPvCcc76EMjO3TA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 913F51DE08;
 Wed, 30 Sep 2020 08:47:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F5CD5578B;
 Wed, 30 Sep 2020 08:47:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D5F8C113864A; Wed, 30 Sep 2020 10:47:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v4 04/46] qapi: modify docstrings to be sphinx-compatible
References: <20200930043150.1454766-1-jsnow@redhat.com>
 <20200930043150.1454766-5-jsnow@redhat.com>
Date: Wed, 30 Sep 2020 10:47:17 +0200
In-Reply-To: <20200930043150.1454766-5-jsnow@redhat.com> (John Snow's message
 of "Wed, 30 Sep 2020 00:31:08 -0400")
Message-ID: <87wo0bejmy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> I did not say "sphinx beautiful", just "sphinx compatible". They will
> not throw errors when parsed and interpreted as ReST.

"Bang on the keyboard until Sphinx doesn't throw errors anymore" might
be good enough for a certain kind of mathematician, but a constructive
solution needs a bit more direction.  Is there a specification to
follow?  Other useful resources?

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/gen.py    | 6 ++++--
>  scripts/qapi/parser.py | 9 +++++----
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index ca66c82b5b8..fc19b2aeb9b 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -154,9 +154,11 @@ def _bottom(self):
>  
>  @contextmanager
>  def ifcontext(ifcond, *args):
> -    """A 'with' statement context manager to wrap with start_if()/end_if()
> +    """
> +    A 'with' statement context manager that wraps with `start_if` and `end_if`.

Sadly, the fact that start_if() and end_if() are functions isn't
immediately obvious anymore.

I've seen :func:`start_if` elsewhere.  Is this something we should or
want to use?

>  
> -    *args: any number of QAPIGenCCode
> +    :param ifcond: List of conditionals
> +    :param args: any number of `QAPIGenCCode`.
>  
>      Example::
>  
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 9d1a3e2eea9..02983979965 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -381,10 +381,11 @@ def append(self, line):
>  
>          The way that the line is dealt with depends on which part of
>          the documentation we're parsing right now:
> -        * The body section: ._append_line is ._append_body_line
> -        * An argument section: ._append_line is ._append_args_line
> -        * A features section: ._append_line is ._append_features_line
> -        * An additional section: ._append_line is ._append_various_line
> +
> +         * The body section: ._append_line is ._append_body_line
> +         * An argument section: ._append_line is ._append_args_line
> +         * A features section: ._append_line is ._append_features_line
> +         * An additional section: ._append_line is ._append_various_line
>          """
>          line = line[1:]
>          if not line:

I understand why you insert a blank line (reST wants blank lines around
lists), I don't understand why you indent.  Can you explain?


