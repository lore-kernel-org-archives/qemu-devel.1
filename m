Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D386C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958082074A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 18:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qn7FeO33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958082074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNKQu-0000BA-8C
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 14:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNKOp-0007LJ-3f
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kNKOm-0005Cf-MZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 14:30:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601404246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/O8CZwKo7fTI6l1OOOv7CqIVDiU6UcznG/egraVFIB0=;
 b=Qn7FeO33ifoVzgph4iog4/gEMB+2eYtoSJ69bwtInxlLkdAbjV6X0LVhKMMx2wRl/hDzEm
 Twb9MbwccRwwHHZ+qu9TDDwYL5NMN2Uk/3FsGh8Kc7HkA0We3yXjaFIw4RGtzm4VP9NdTC
 7/FaelS5K6DwjEbwBwAw3ME4H5X0rCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-gmtWOhnbMAqTOYxiAPhbRw-1; Tue, 29 Sep 2020 14:30:42 -0400
X-MC-Unique: gmtWOhnbMAqTOYxiAPhbRw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 005A01021208
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 18:30:41 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CA905C1C4;
 Tue, 29 Sep 2020 18:30:39 +0000 (UTC)
Subject: Re: [PATCH v3 06/47] [DO-NOT-MERGE] docs: enable sphinx-autodoc for
 scripts/qapi
To: Cleber Rosa <crosa@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-7-jsnow@redhat.com>
 <20200929040027.GG700868@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <fe300f2f-274e-0859-36d3-96a5868a5074@redhat.com>
Date: Tue, 29 Sep 2020 14:30:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929040027.GG700868@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 12:00 AM, Cleber Rosa wrote:
> On Thu, Sep 24, 2020 at 08:28:19PM -0400, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   docs/conf.py                          |  6 +++++-
>>   docs/devel/index.rst                  |  1 +
>>   docs/devel/python/index.rst           |  7 +++++++
>>   docs/devel/python/qapi.commands.rst   |  7 +++++++
>>   docs/devel/python/qapi.common.rst     |  7 +++++++
>>   docs/devel/python/qapi.doc.rst        |  7 +++++++
>>   docs/devel/python/qapi.error.rst      |  7 +++++++
>>   docs/devel/python/qapi.events.rst     |  7 +++++++
>>   docs/devel/python/qapi.expr.rst       |  7 +++++++
>>   docs/devel/python/qapi.gen.rst        |  7 +++++++
>>   docs/devel/python/qapi.introspect.rst |  7 +++++++
>>   docs/devel/python/qapi.parser.rst     |  8 ++++++++
>>   docs/devel/python/qapi.rst            | 26 ++++++++++++++++++++++++++
>>   docs/devel/python/qapi.schema.rst     |  7 +++++++
>>   docs/devel/python/qapi.source.rst     |  7 +++++++
>>   docs/devel/python/qapi.types.rst      |  7 +++++++
>>   docs/devel/python/qapi.visit.rst      |  7 +++++++
>>   17 files changed, 131 insertions(+), 1 deletion(-)
>>   create mode 100644 docs/devel/python/index.rst
>>   create mode 100644 docs/devel/python/qapi.commands.rst
>>   create mode 100644 docs/devel/python/qapi.common.rst
>>   create mode 100644 docs/devel/python/qapi.doc.rst
>>   create mode 100644 docs/devel/python/qapi.error.rst
>>   create mode 100644 docs/devel/python/qapi.events.rst
>>   create mode 100644 docs/devel/python/qapi.expr.rst
>>   create mode 100644 docs/devel/python/qapi.gen.rst
>>   create mode 100644 docs/devel/python/qapi.introspect.rst
>>   create mode 100644 docs/devel/python/qapi.parser.rst
>>   create mode 100644 docs/devel/python/qapi.rst
>>   create mode 100644 docs/devel/python/qapi.schema.rst
>>   create mode 100644 docs/devel/python/qapi.source.rst
>>   create mode 100644 docs/devel/python/qapi.types.rst
>>   create mode 100644 docs/devel/python/qapi.visit.rst
>>
>> diff --git a/docs/conf.py b/docs/conf.py
>> index a68f616d5a..d03ef465a6 100644
>> --- a/docs/conf.py
>> +++ b/docs/conf.py
>> @@ -54,6 +54,9 @@
>>   #
>>   sys.path.insert(0, os.path.join(qemu_docdir, "sphinx"))
>>   
>> +# Make scripts/qapi module available for autodoc
>> +sys.path.insert(0, os.path.join(qemu_docdir, "../scripts"))
>> +
> 
> Do I hear qapi asking to moved out of "scripts" and becoming more like
> "python/qemu"?
> 

Once all six parts of this series goes in I will move it to the python 
folder, but you're about 150 patches early.

>>   
>>   # -- General configuration ------------------------------------------------
>>   
>> @@ -67,7 +70,8 @@
>>   # Add any Sphinx extension module names here, as strings. They can be
>>   # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
>>   # ones.
>> -extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile']
>> +extensions = ['kerneldoc', 'qmp_lexer', 'hxtool',
>> +              'depfile', 'sphinx.ext.autodoc']
>>   
>>   # Add any paths that contain templates here, relative to this directory.
>>   templates_path = ['_templates']
>> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
>> index 04773ce076..04726ca787 100644
>> --- a/docs/devel/index.rst
>> +++ b/docs/devel/index.rst
>> @@ -31,3 +31,4 @@ Contents:
>>      reset
>>      s390-dasd-ipl
>>      clocks
>> +   python/index
>> diff --git a/docs/devel/python/index.rst b/docs/devel/python/index.rst
>> new file mode 100644
>> index 0000000000..31c470154b
>> --- /dev/null
>> +++ b/docs/devel/python/index.rst
>> @@ -0,0 +1,7 @@
>> +qapi
>> +====
>> +
>> +.. toctree::
>> +   :maxdepth: 4
>> +
>> +   qapi
>> diff --git a/docs/devel/python/qapi.commands.rst b/docs/devel/python/qapi.commands.rst
>> new file mode 100644
>> index 0000000000..018f7b08a9
>> --- /dev/null
>> +++ b/docs/devel/python/qapi.commands.rst
>> @@ -0,0 +1,7 @@
>> +qapi.commands module
>> +====================
>> +
>> +.. automodule:: qapi.commands
>> +   :members:
>> +   :undoc-members:
>> +   :show-inheritance:
>> diff --git a/docs/devel/python/qapi.common.rst b/docs/devel/python/qapi.common.rst
>> new file mode 100644
>> index 0000000000..128a90d74b
>> --- /dev/null
>> +++ b/docs/devel/python/qapi.common.rst
>> @@ -0,0 +1,7 @@
>> +qapi.common module
>> +==================
>> +
>> +.. automodule:: qapi.common
>> +   :members:
>> +   :undoc-members:
>> +   :show-inheritance:
>> diff --git a/docs/devel/python/qapi.doc.rst b/docs/devel/python/qapi.doc.rst
>> new file mode 100644
>> index 0000000000..556c2bca1f
>> --- /dev/null
>> +++ b/docs/devel/python/qapi.doc.rst
>> @@ -0,0 +1,7 @@
>> +qapi.doc module
>> +===============
>> +
>> +.. automodule:: qapi.doc
>> +   :members:
>> +   :undoc-members:
>> +   :show-inheritance:
>> diff --git a/docs/devel/python/qapi.error.rst b/docs/devel/python/qapi.error.rst
>> new file mode 100644
>> index 0000000000..980e32b63d
>> --- /dev/null
>> +++ b/docs/devel/python/qapi.error.rst
>> @@ -0,0 +1,7 @@
>> +qapi.error module
>> +=================
>> +
>> +.. automodule:: qapi.error
>> +   :members:
>> +   :undoc-members:
>> +   :show-inheritance:
>> diff --git a/docs/devel/python/qapi.events.rst b/docs/devel/python/qapi.events.rst
>> new file mode 100644
>> index 0000000000..1fce85b044
>> --- /dev/null
>> +++ b/docs/devel/python/qapi.events.rst
>> @@ -0,0 +1,7 @@
>> +qapi.events module
>> +==================
>> +
>> +.. automodule:: qapi.events
>> +   :members:
>> +   :undoc-members:
>> +   :show-inheritance:
>> diff --git a/docs/devel/python/qapi.expr.rst b/docs/devel/python/qapi.expr.rst
>> new file mode 100644
>> index 0000000000..0660270629
>> --- /dev/null
>> +++ b/docs/devel/python/qapi.expr.rst
>> @@ -0,0 +1,7 @@
>> +qapi.expr module
>> +================
>> +
>> +.. automodule:: qapi.expr
>> +   :members:
>> +   :undoc-members:
>> +   :show-inheritance:
>> diff --git a/docs/devel/python/qapi.gen.rst b/docs/devel/python/qapi.gen.rst
>> new file mode 100644
>> index 0000000000..7b495fd4bf
>> --- /dev/null
>> +++ b/docs/devel/python/qapi.gen.rst
>> @@ -0,0 +1,7 @@
>> +qapi.gen module
>> +===============
>> +
>> +.. automodule:: qapi.gen
>> +   :members:
>> +   :undoc-members:
>> +   :show-inheritance:
>> diff --git a/docs/devel/python/qapi.introspect.rst b/docs/devel/python/qapi.introspect.rst
>> new file mode 100644
>> index 0000000000..f65ebfccd1
>> --- /dev/null
>> +++ b/docs/devel/python/qapi.introspect.rst
>> @@ -0,0 +1,7 @@
>> +qapi.introspect module
>> +======================
>> +
>> +.. automodule:: qapi.introspect
>> +   :members:
>> +   :undoc-members:
>> +   :show-inheritance:
>> diff --git a/docs/devel/python/qapi.parser.rst b/docs/devel/python/qapi.parser.rst
>> new file mode 100644
>> index 0000000000..1a8f7b347e
>> --- /dev/null
>> +++ b/docs/devel/python/qapi.parser.rst
>> @@ -0,0 +1,8 @@
>> +qapi.parser module
>> +==================
>> +
>> +.. automodule:: qapi.parser
>> +   :members:
>> +   :undoc-members:
>> +   :show-inheritance:
>> +   :private-members:
>> diff --git a/docs/devel/python/qapi.rst b/docs/devel/python/qapi.rst
>> new file mode 100644
>> index 0000000000..24fbf34981
>> --- /dev/null
>> +++ b/docs/devel/python/qapi.rst
>> @@ -0,0 +1,26 @@
>> +qapi package
>> +============
>> +
>> +.. automodule:: qapi
>> +   :members:
>> +   :undoc-members:
>> +   :show-inheritance:
>> +
> 
> This renders *very* timidly, ending up almost invisible.  Also,
> there's no useful introduction to what this "qapi" when you enter this
> section.
> 
> Maybe create a "API reference" section, explaining it first?
> 

Respectfully, "DO NOT MERGE" is written in large capital letters in the 
subject of this patch.

You are free to try to format the manual as you please at a later date, 
but it's not something that I will be doing right now. The purpose of 
this patch is solely to prove that my docstring formatting adheres to 
some kind of standard, and the method to prove it is nontrivial, hence 
these patches.

--js


