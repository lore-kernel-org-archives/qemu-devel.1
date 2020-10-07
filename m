Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA28C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2AB2076C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDBsMQns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2AB2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4cD-0000AS-2T
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ4bT-00086H-Es
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ4bR-0007XP-CO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602058512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xrybbro2tr1s2qaQchp/caOqr/ALsJFjIibYCLFRFl0=;
 b=HDBsMQnsNKa71m3XIXDmxs35bLbJqHXEm3Ir/gV3CVseLTvJqPj06vv4z5OT9Lt7d/eFsa
 ALNlxFap4sbCpt5yql5sAP0TSfHTdVVt/ISoVTPKsmm80DVxWzhbIo/PlrjdtHqlkDhwJs
 /b1g7Z3lmax2+a0sgvA20SoSXqMC2hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-LSpTFTrHMACeD3-oWqcUiA-1; Wed, 07 Oct 2020 04:15:10 -0400
X-MC-Unique: LSpTFTrHMACeD3-oWqcUiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0828010866A8
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 08:15:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3B3C1002C27;
 Wed,  7 Oct 2020 08:15:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2B07911329C1; Wed,  7 Oct 2020 10:15:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 07/36] qapi: enforce import order/styling with isort
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-8-jsnow@redhat.com>
Date: Wed, 07 Oct 2020 10:15:08 +0200
In-Reply-To: <20201005195158.2348217-8-jsnow@redhat.com> (John Snow's message
 of "Mon, 5 Oct 2020 15:51:29 -0400")
Message-ID: <87mu0yih9v.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> While we're mucking around with imports, we might as well formalize the
> style we use. Let's use isort to do it for us.
>
> lines_after_imports=2: Use two lines after imports, to match PEP8's
> desire to have "two lines before and after" class definitions, which are
> likely to start immediately after imports.
>
> force_sort_within_sections: Intermingles "from x" and "import x" style
> statements, such that sorting is always performed strictly on the module
> name itself.
>
> force_grid_wrap=4: Four or more imports from a single module will force
> the one-per-line style that's more git-friendly. This will generally
> happen for 'typing' imports.
>
> multi_line_output=3: Uses the one-per-line indented style for long
> imports.
>
> include_trailing_comma: Adds a comma to the last import in a group,
> which makes git conflicts nicer to deal with, generally.
>
> line_length: 72 is chosen to match PEP8's "docstrings and comments" line
> length limit. If you have a single line import that exceeds 72
> characters, your names are too long!
>
> Suggested-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qapi/.isort.cfg    | 7 +++++++
>  scripts/qapi/expr.py       | 3 ++-
>  scripts/qapi/introspect.py | 7 +++++--
>  scripts/qapi/parser.py     | 2 +-
>  scripts/qapi/schema.py     | 2 +-
>  5 files changed, 16 insertions(+), 5 deletions(-)
>  create mode 100644 scripts/qapi/.isort.cfg
>
> diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
> new file mode 100644
> index 00000000000..6d0fd6cc0d3
> --- /dev/null
> +++ b/scripts/qapi/.isort.cfg
> @@ -0,0 +1,7 @@
> +[settings]
> +force_grid_wrap=4
> +force_sort_within_sections=True
> +include_trailing_comma=True
> +line_length=72
> +lines_after_imports=2
> +multi_line_output=3
> \ No newline at end of file

Add one, please :)

> diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
> index 03b31ecfc19..e73b65b6a7e 100644
> --- a/scripts/qapi/expr.py
> +++ b/scripts/qapi/expr.py
> @@ -14,8 +14,9 @@
>  # This work is licensed under the terms of the GNU GPL, version 2.
>  # See the COPYING file in the top-level directory.
>  
> -import re
>  from collections import OrderedDict
> +import re
> +
>  from .common import c_name
>  from .error import QAPISemError
>  
> diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
> index b036fcf9ce7..31acd2f230a 100644
> --- a/scripts/qapi/introspect.py
> +++ b/scripts/qapi/introspect.py
> @@ -17,8 +17,11 @@
>      mcgen,
>  )
>  from .gen import QAPISchemaMonolithicCVisitor
> -from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
> -                     QAPISchemaType)
> +from .schema import (
> +    QAPISchemaArrayType,
> +    QAPISchemaBuiltinType,
> +    QAPISchemaType,
> +)
>  
>  
>  def _make_tree(obj, ifcond, features, extra=None):
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 68d8a1ce1cf..477ef25ccdf 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -14,9 +14,9 @@
>  # This work is licensed under the terms of the GNU GPL, version 2.
>  # See the COPYING file in the top-level directory.
>  
> +from collections import OrderedDict
>  import os
>  import re
> -from collections import OrderedDict
>  
>  from .error import QAPIParseError, QAPISemError
>  from .source import QAPISourceInfo
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index a835ee6fde3..093f7a38d88 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -14,9 +14,9 @@
>  
>  # TODO catching name collisions in generated code would be nice
>  
> +from collections import OrderedDict
>  import os
>  import re
> -from collections import OrderedDict
>  
>  from .common import c_name, pointer_suffix
>  from .error import QAPIError, QAPISemError

Reviewed-by: Markus Armbruster <armbru@redhat.com>


