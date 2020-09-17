Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08AFC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9C720707
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIpLrMQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9C720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIzfD-0008Uu-8Z
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 15:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIzdN-0007SV-A1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 15:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIzdK-0002oy-F2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 15:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600371113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jx/87Pxg0asLW/nwj++awcVuGTAyZf67H2C4XtCJys=;
 b=iIpLrMQP8tl3kK2OANvu35pTJtgVXXVZ5wfYcK5gsLzydQuav6mzDuhs/ef5DwSj9GQkNs
 af7woGqQBSQMNXqIIdoZmf0BBcs+GpjZEQ+pOInASywLuLFhhighY2sUmLtwhNm5kUWUlx
 rg6Z4KKyWGA5lOrfwNM4ikkbzmYw1E8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-vb4rL0y3MGeUhw9A0ymenA-1; Thu, 17 Sep 2020 15:31:49 -0400
X-MC-Unique: vb4rL0y3MGeUhw9A0ymenA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E035B80ED8E;
 Thu, 17 Sep 2020 19:31:47 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 037CA77D86;
 Thu, 17 Sep 2020 19:31:46 +0000 (UTC)
Subject: Re: [PATCH 14/37] qapi/common.py: Move comments into docstrings
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-15-jsnow@redhat.com>
 <87d02kpizr.fsf@dusky.pond.sub.org>
 <49e28f59-012c-9b7b-02b7-1854f85884b2@redhat.com>
 <20200917191455.GX7594@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <3b1ce70b-377d-144f-9331-4f6da4c93f6f@redhat.com>
Date: Thu, 17 Sep 2020 15:31:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917191455.GX7594@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 3:14 PM, Eduardo Habkost wrote:
> On Thu, Sep 17, 2020 at 02:44:53PM -0400, John Snow wrote:
> [...]
>> Having said this, I have not found any tool to date that actually *checks*
>> these comments for consistency. The pycharm IDE interactively highlights
>> them when it senses that you have made a mistake, but that cannot be worked
>> into our CI process that I know of - it's a proprietary checker.
>>
>> So right now, they're just plaintext that I am writing to approximate the
>> Sphinx style until such time as I enable autodoc for the module and
>> fine-tune the actual formatting and so on.
> 
> After applying this series, I only had to make two small tweaks
> to make Sphinx + autodoc happy with the docstrings you wrote.
> 
> With the following patch, "make sphinxdocs" will generate the
> QAPI Python module documentation at docs/devel/qapi.html.
> 
> I had to explicitly skip qapi/doc.py because autodoc thinks the
> string constants are documentation strings.
> 

Awesome!

I think I am going to delay explicitly pursuing writing a manual for the 
QAPI parser for now, but it's good to know I am not too far off. I'm 
going to target the mypy conversions first, because they can be invasive 
and full of churn.

When I get there, though ... I am thinking I should add this as 
Devel/QAPI Parser.

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   docs/conf.py           |  5 +++-
>   docs/devel/index.rst   |  1 +
>   docs/devel/qapi.rst    | 67 ++++++++++++++++++++++++++++++++++++++++++
>   scripts/qapi/common.py |  2 +-
>   scripts/qapi/gen.py    |  2 +-
>   5 files changed, 74 insertions(+), 3 deletions(-)
>   create mode 100644 docs/devel/qapi.rst
> 
> diff --git a/docs/conf.py b/docs/conf.py
> index 8aeac40124..85be0e1860 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -54,6 +54,9 @@ except NameError:
>   #
>   sys.path.insert(0, os.path.join(qemu_docdir, "sphinx"))
>   
> +# Make scripts/qapi module available for autodoc
> +sys.path.insert(0, os.path.join(qemu_docdir, "../scripts"))
> +
>   
>   # -- General configuration ------------------------------------------------
>   
> @@ -67,7 +70,7 @@ needs_sphinx = '1.6'
>   # Add any Sphinx extension module names here, as strings. They can be
>   # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
>   # ones.
> -extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile']
> +extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile', 'sphinx.ext.autodoc']
>   
>   # Add any paths that contain templates here, relative to this directory.
>   templates_path = ['_templates']
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 04773ce076..a4d2cb9893 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -31,3 +31,4 @@ Contents:
>      reset
>      s390-dasd-ipl
>      clocks
> +   qapi
> diff --git a/docs/devel/qapi.rst b/docs/devel/qapi.rst
> new file mode 100644
> index 0000000000..9130ef84c6
> --- /dev/null
> +++ b/docs/devel/qapi.rst
> @@ -0,0 +1,67 @@
> +QAPI Python module reference
> +============================
> +
> +.. automodule:: qapi
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.commands
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.common
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.debug
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.error
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.events
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.expr
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.gen
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.introspect
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.params
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.parser
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.schema
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.script
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.source
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.types
> +   :members:
> +   :undoc-members:
> +
> +.. automodule:: qapi.visit
> +   :members:
> +   :undoc-members:
> +
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index 0b1af694e6..7c8c4cb846 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -78,7 +78,7 @@ def c_name(name: str, protect: bool = True) -> str:
>   
>       :param name: The name to map.
>       :param protect: If true, avoid returning certain ticklish identifiers
> -                    (like C keywords) by prepending 'q_'.
> +                    (like C keywords) by prepending ``q_``.
>       """
>       # ANSI X3J11/88-090, 3.1.1
>       c89_words = set(['auto', 'break', 'case', 'char', 'const', 'continue',
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 0a72aecdd0..cf33732256 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -161,7 +161,7 @@ def ifcontext(ifcond: List[str],
>                 *args: QAPIGenCCode) -> Generator[None, None, None]:
>       """A 'with' statement context manager to wrap with start_if()/end_if()
>   
> -    *args: any number of QAPIGenCCode
> +    :param args: any number of QAPIGenCCode
>   
>       Example::
>   
> 


