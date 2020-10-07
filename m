Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A96C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6700D20789
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 09:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WW8kdY1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6700D20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ5Nc-0000Gv-4z
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 05:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ5MQ-0008Ea-KM
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQ5MN-00055g-UX
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 05:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602061422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n091WmdmNqT1y7o6+bkbcunetSuLe2Fytcs3n8kknAg=;
 b=WW8kdY1cX2p87tT+SighkJpQhvFN5b3mPF+LgiOPWj3BNFDdIDENeK8a9bXLn5TJnsfC02
 a81nX9bo4WdXh8Oc89wkq05l0qVfeoTzPy1eM1GsESsAhRj5s+c+vK+a5BHRwVZ7b38JOY
 ss+D/Br3B7nG9mEIAJhDitCbG89Yxrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-v7rNs0qZMvq6w7oUvV7L6g-1; Wed, 07 Oct 2020 05:03:39 -0400
X-MC-Unique: v7rNs0qZMvq6w7oUvV7L6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CB55804011
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 09:03:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 374DC60BFA;
 Wed,  7 Oct 2020 09:03:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 92E6C11329C1; Wed,  7 Oct 2020 11:03:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 15/36] qapi/common.py: add type hint annotations
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-16-jsnow@redhat.com>
Date: Wed, 07 Oct 2020 11:03:36 +0200
In-Reply-To: <20201005195158.2348217-16-jsnow@redhat.com> (John Snow's message
 of "Mon, 5 Oct 2020 15:51:37 -0400")
Message-ID: <877ds2if13.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> Annotations do not change runtime behavior.
> This commit *only* adds annotations.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> ---
>  scripts/qapi/common.py | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 338adedef4f..74a2c001ed9 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -12,6 +12,7 @@
>  # See the COPYING file in the top-level directory.
>  
>  import re
> +from typing import Optional, Sequence
>  
>  
>  EATSPACE = '\033EATSPACE.'
> @@ -22,7 +23,7 @@
>  # ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
>  # ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
>  # ENUM24_Name -> ENUM24_NAME
> -def camel_to_upper(value):
> +def camel_to_upper(value: str) -> str:
>      c_fun_str = c_name(value, False)
>      if value.isupper():
>          return c_fun_str
> @@ -41,7 +42,9 @@ def camel_to_upper(value):
>      return new_name.lstrip('_').upper()
>  
>  
> -def c_enum_const(type_name, const_name, prefix=None):
> +def c_enum_const(type_name: str,
> +                 const_name: str,
> +                 prefix: Optional[str] = None) -> str:
>      if prefix is not None:
>          type_name = prefix
>      return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
> @@ -56,7 +59,7 @@ def c_enum_const(type_name, const_name, prefix=None):
>  # into substrings of a generated C function name.
>  # '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
>  # protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
> -def c_name(name, protect=True):
> +def c_name(name: str, protect: bool = True) -> str:
>      # ANSI X3J11/88-090, 3.1.1
>      c89_words = set(['auto', 'break', 'case', 'char', 'const', 'continue',
>                       'default', 'do', 'double', 'else', 'enum', 'extern',
> @@ -131,24 +134,24 @@ def decrease(self, amount: int = 4) -> None:
>  
>  # Generate @code with @kwds interpolated.
>  # Obey indent, and strip EATSPACE.
> -def cgen(code, **kwds):
> +def cgen(code: str, **kwds: object) -> str:
>      raw = code % kwds
>      if indent:
>          raw = re.sub(r'^(?!(#|$))', str(indent), raw, flags=re.MULTILINE)
>      return re.sub(re.escape(EATSPACE) + r' *', '', raw)
>  
>  
> -def mcgen(code, **kwds):
> +def mcgen(code: str, **kwds: object) -> str:
>      if code[0] == '\n':
>          code = code[1:]
>      return cgen(code, **kwds)
>  
>  
> -def c_fname(filename):
> +def c_fname(filename: str) -> str:
>      return re.sub(r'[^A-Za-z0-9_]', '_', filename)
>  
>  
> -def guardstart(name):
> +def guardstart(name: str) -> str:
>      return mcgen('''
>  #ifndef %(name)s
>  #define %(name)s
> @@ -157,7 +160,7 @@ def guardstart(name):
>                   name=c_fname(name).upper())
>  
>  
> -def guardend(name):
> +def guardend(name: str) -> str:
>      return mcgen('''
>  
>  #endif /* %(name)s */
> @@ -165,7 +168,7 @@ def guardend(name):
>                   name=c_fname(name).upper())
>  
>  
> -def gen_if(ifcond):
> +def gen_if(ifcond: Sequence[str]) -> str:
>      ret = ''
>      for ifc in ifcond:
>          ret += mcgen('''
> @@ -174,7 +177,7 @@ def gen_if(ifcond):
>      return ret
>  
>  
> -def gen_endif(ifcond):
> +def gen_endif(ifcond: Sequence[str]) -> str:
>      ret = ''
>      for ifc in reversed(ifcond):
>          ret += mcgen('''
> @@ -183,7 +186,9 @@ def gen_endif(ifcond):
>      return ret
>  
>  
> -def build_params(arg_type, boxed, extra=None):
> +def build_params(arg_type,
> +                 boxed: bool,
> +                 extra: Optional[str] = None) -> str:
>      ret = ''
>      sep = ''
>      if boxed:

@arg_type is the only parameter left unannotated.  Scratching head...
aha:

    qapi/common.py: move build_params into gen.py
    
    Including it in common.py creates a circular import dependency; schema
    relies on common, but common.build_params requires a type annotation
    from schema. To type this properly, it needs to be moved outside the
    cycle.

Let's amend the commit message:

    Note that build_params() cannot be fully annotated due to import
    dependency issues.  The commit after next will take care of it.

If we swap the next two commits, the fix follows immediately.  Better,
but only worth it if swapping is pretty much effortless.


