Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56C0C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1405821974
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3zlLbUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1405821974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvEs-0007Nt-3s
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIv2f-0001FY-MD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIv2d-0005zc-KI
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600353462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5ljKXt5/AlhCB6GjRy9I5pVuFkANjIjaLJHncf6tWY=;
 b=Z3zlLbUP++5OP+MIBeMm9WuiytISknjuz5kTUG5Zu5Sn6RfSCtpBxwqbHz6siwwgtZq7u5
 bM410cGaDXPKA94o5KCyq4jJN2eI1q4qcS1NcUErjjPM87/VgqZAzLWIbJFRigngOhprjG
 uSwxb+rdK6HQsxaxkyKNoXwxFem0+8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-8aZGIeWAMd2cVv4XcPSZnQ-1; Thu, 17 Sep 2020 10:37:40 -0400
X-MC-Unique: 8aZGIeWAMd2cVv4XcPSZnQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 483FA195D582;
 Thu, 17 Sep 2020 14:37:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01E8A73661;
 Thu, 17 Sep 2020 14:37:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8764C113864A; Thu, 17 Sep 2020 16:37:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 14/37] qapi/common.py: Move comments into docstrings
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-15-jsnow@redhat.com>
Date: Thu, 17 Sep 2020 16:37:12 +0200
In-Reply-To: <20200915224027.2529813-15-jsnow@redhat.com> (John Snow's message
 of "Tue, 15 Sep 2020 18:40:04 -0400")
Message-ID: <87d02kpizr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> As docstrings, they'll show up in documentation and IDE help.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/common.py | 50 ++++++++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index af01348b35..38d380f0a9 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -20,10 +20,18 @@
>  c_name_trans = str.maketrans('.-', '__')
>  
>  
> -# ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
> -# ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
> -# ENUM24_Name -> ENUM24_NAME
>  def camel_to_upper(value: str) -> str:
> +    """
> +    Converts CamelCase to CAMEL_CASE.
> +
> +    Examples:
> +      ENUMName -> ENUM_NAME
> +      EnumName1 -> ENUM_NAME1
> +      ENUM_NAME -> ENUM_NAME
> +      ENUM_NAME1 -> ENUM_NAME1
> +      ENUM_Name2 -> ENUM_NAME2
> +      ENUM24_Name -> ENUM24_NAME
> +    """
>      c_fun_str = c_name(value, False)
>      if value.isupper():
>          return c_fun_str
> @@ -45,21 +53,33 @@ def camel_to_upper(value: str) -> str:
>  def c_enum_const(type_name: str,
>                   const_name: str,
>                   prefix: Optional[str] = None) -> str:
> +    """
> +    Generate a C enumeration constant name.
> +
> +    :param type_name: The name of the enumeration.
> +    :param const_name: The name of this constant.
> +    :param prefix: Optional, prefix that overrides the type_name.
> +    """

Not actually a move.  Suggest to retitle

    qapi/common: Turn comments in docstrings, and add more

>      if prefix is not None:
>          type_name = prefix
>      return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
>  
>  
> -# Map @name to a valid C identifier.
> -# If @protect, avoid returning certain ticklish identifiers (like
> -# C keywords) by prepending 'q_'.
> -#
> -# Used for converting 'name' from a 'name':'type' qapi definition
> -# into a generated struct member, as well as converting type names
> -# into substrings of a generated C function name.
> -# '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
> -# protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
>  def c_name(name: str, protect: bool = True) -> str:
> +    """
> +    Map `name` to a valid C identifier.
> +
> +    Used for converting 'name' from a 'name':'type' qapi definition
> +    into a generated struct member, as well as converting type names
> +    into substrings of a generated C function name.
> +
> +    '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
> +    protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
> +
> +    :param name: The name to map.
> +    :param protect: If true, avoid returning certain ticklish identifiers
> +                    (like C keywords) by prepending 'q_'.
> +    """
>      # ANSI X3J11/88-090, 3.1.1
>      c89_words = set(['auto', 'break', 'case', 'char', 'const', 'continue',
>                       'default', 'do', 'double', 'else', 'enum', 'extern',
> @@ -135,9 +155,11 @@ def pop(self, amount: int = 4) -> int:
>  INDENT = Indent(0)
>  
>  
> -# Generate @code with @kwds interpolated.
> -# Obey INDENT level, and strip EATSPACE.
>  def cgen(code: str, **kwds: Union[str, int]) -> str:
> +    """
> +    Generate `code` with `kwds` interpolated.
> +    Obey `INDENT`, and strip `EATSPACE`.
> +    """
>      raw = code % kwds
>      if INDENT:
>          raw, _ = re.subn(r'^(?!(#|$))', str(INDENT), raw, flags=re.MULTILINE)

Can you point to documentation on the docstring conventions and markup
to use?


