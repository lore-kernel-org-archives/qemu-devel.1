Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8477BC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05491206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpU66duE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05491206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqgx-0006Rb-3n
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqgM-0005uQ-4b
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqgJ-0005jQ-4H
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600813357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLBGFBaYD0QtbT0TZLo8sSkhlpKfdDiMoVsGNAUan4s=;
 b=gpU66duE0Sj1ijI1PEO/hvAMBryRN5xEyPleYO1JJDvfGk3WfImvIsz9GC+SyMSU7XmbBB
 uEsV1oqBQjEy/krre/MQAewsxg530NWX9OzShM8A/o8DoqxmTnGFcTSkTRJDIWfEwWmYr9
 nhMx0WrNOiCDyoaIG2RLOylILfELBOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-_E25HuzFPT6kanuKVih4rA-1; Tue, 22 Sep 2020 18:22:35 -0400
X-MC-Unique: _E25HuzFPT6kanuKVih4rA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56C941005E5E;
 Tue, 22 Sep 2020 22:22:34 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E097B5C1A3;
 Tue, 22 Sep 2020 22:22:33 +0000 (UTC)
Date: Tue, 22 Sep 2020 18:22:32 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 09/38] qapi/common.py: Add indent manager
Message-ID: <20200922222232.GK2044576@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-10-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-10-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:00:32PM -0400, John Snow wrote:
> Code style tools really dislike the use of global keywords, because it
> generally involves re-binding the name at runtime which can have strange
> effects depending on when and how that global name is referenced in
> other modules.
> 
> Make a little indent level manager instead.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/common.py | 51 +++++++++++++++++++++++++++++-------------
>  scripts/qapi/visit.py  |  7 +++---
>  2 files changed, 38 insertions(+), 20 deletions(-)
> 
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index cee63eb95c..e0c5871b10 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -93,33 +93,52 @@ def c_name(name, protect=True):
>  pointer_suffix = ' *' + eatspace
>  
>  
> -def genindent(count):
> -    ret = ''
> -    for _ in range(count):
> -        ret += ' '
> -    return ret
> +class Indentation:
> +    """
> +    Indentation level management.
>  
> +    :param initial: Initial number of spaces, default 0.
> +    """
> +    def __init__(self, initial: int = 0) -> None:
> +        self._level = initial
>  
> -indent_level = 0
> +    def __int__(self) -> int:
> +        return self._level
>  
> +    def __repr__(self) -> str:
> +        return "{}({:d})".format(type(self).__name__, self._level)
>  
> -def push_indent(indent_amount=4):
> -    global indent_level
> -    indent_level += indent_amount
> +    def __str__(self) -> str:
> +        """Return the current indentation as a string of spaces."""
> +        return ' ' * self._level
>  
> +    def __bool__(self) -> bool:
> +        """True when there is a non-zero indentation."""
> +        return bool(self._level)
>  
> -def pop_indent(indent_amount=4):
> -    global indent_level
> -    indent_level -= indent_amount
> +    def increase(self, amount: int = 4) -> int:
> +        """Increase the indentation level by `amount`, default 4."""
> +        self._level += amount
> +        return self._level
> +
> +    def decrease(self, amount: int = 4) -> int:
> +        """Decrease the indentation level by `amount`, default 4."""
> +        if self._level < amount:
> +            raise ArithmeticError(
> +                f"Can't remove {amount:d} spaces from {self!r}")
> +        self._level -= amount
> +        return self._level
> +
> +
> +indent = Indentation()

Personally, I would keep the push_indent(), pop_indent() API, and
introduce an indent() function, to follow the existing API style
of plain functions.

Something like:

  indent_prefixes = []
  def push_indent(amount=4):
      """Add `amount` spaces to indentation prefix"""
      indent_prefixes.push(' '*amount)
  def pop_indent():
      """Revert the most recent push_indent() call"""
      indent_prefixes.pop()
  def indent():
      """Return the current indentation prefix"""
      return ''.join(indent_prefixes)

What you did is still an improvement, though, so:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo


