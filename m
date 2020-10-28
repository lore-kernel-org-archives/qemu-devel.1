Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB1AC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 23:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1426F20684
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 23:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIBnz7dy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1426F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXvJQ-0001Sr-EY
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 19:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXvIJ-0000wm-M9
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 19:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXvIE-00040R-Cj
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 19:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603929347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lp4PFjrB4q/jCIfYNLEL7dq1r8V9zujPQycQETCe5K4=;
 b=DIBnz7dy1LN5PWpgaGr5stxTUAMlRGbSq03AZgQGgZ144XZ6HBEg0FE6+ClZUhHSeH/vRp
 WD1x4VFc5UhFkTY1nccSwgYsNllWUMbPJIEfRrZC7DP+W9s1Iy+eI4o2P+teg4223AmQEC
 d4PV6z/DFLGccX66e8UAUDWBh3GDI8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-v-ghBPOPOMaqUM12rJ40og-1; Wed, 28 Oct 2020 19:55:43 -0400
X-MC-Unique: v-ghBPOPOMaqUM12rJ40og-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D83A8DFFCD;
 Wed, 28 Oct 2020 23:53:43 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 771755D98C;
 Wed, 28 Oct 2020 23:53:33 +0000 (UTC)
Subject: Re: [PATCH v3 04/15] python: add directory structure README.rst files
To: Cleber Rosa <crosa@redhat.com>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-5-jsnow@redhat.com>
 <20201028220509.GH2201333@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <9a7076d2-4840-6a6d-7a0e-026af89dea3e@redhat.com>
Date: Wed, 28 Oct 2020 19:53:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201028220509.GH2201333@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 6:05 PM, Cleber Rosa wrote:
> On Tue, Oct 20, 2020 at 03:35:44PM -0400, John Snow wrote:
>> Add short readmes to python/, python/qemu/, python/qemu/machine, and
>> python/qemu/machine that explain the directory hierarchy. These readmes
>> are visible when browsing the source on e.g. gitlab/github and are
>> designed to help new developers/users quickly make sense of the source
>> tree.
>>
>> They are not designed for inclusion in a published manual.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   python/README.rst              | 27 +++++++++++++++++++++++++++
>>   python/qemu/README.rst         |  8 ++++++++
>>   python/qemu/machine/README.rst |  9 +++++++++
>>   python/qemu/qmp/README.rst     |  9 +++++++++
>>   4 files changed, 53 insertions(+)
>>   create mode 100644 python/README.rst
>>   create mode 100644 python/qemu/README.rst
>>   create mode 100644 python/qemu/machine/README.rst
>>   create mode 100644 python/qemu/qmp/README.rst
>>
>> diff --git a/python/README.rst b/python/README.rst
>> new file mode 100644
>> index 0000000000..ff40e4c931
>> --- /dev/null
>> +++ b/python/README.rst
>> @@ -0,0 +1,27 @@
>> +QEMU Python Tooling
>> +===================
>> +
>> +This directory houses Python tooling used by the QEMU project to build,
>> +configure, and test QEMU. It is organized by namespace (``qemu``), and
>> +then by package (``qemu/machine``, ``qemu/qmp``).
>> +
>> +``setup.py`` is used by ``pip`` to install this tooling to the current
>> +environment. You will generally invoke it by doing one of the following:
>> +
>> +1. ``pip3 install .`` will install these packages to your current
>> +   environment. If you are inside a virtual environment, they will
>> +   install there. If you are not, it will attempt to install to the
>> +   global environment, which is not recommended.
>> +
>> +2. ``pip3 install --user .`` will install these packages to your user's
>> +   local python packages. If you are inside of a virtual environment,
>> +   this will fail.
>> +
>> +If you amend the ``-e`` argument, pip will install in "editable" mode;
>> +which installs a version of the package that uses symlinks to these
>> +files, such that the package always reflects the latest version in your
>> +git tree.
>> +
> 
> It actually uses *egg-link* files, which are not what people will
> understand by "symlinks".
> 

Ehm, good point; I don't want to *lie* here. I think I do want to avoid 
the jargon though.

"that installs a forwarder pointing to these files" -- better?

>> +See `Installing packages using pip and virtual environments
>> +<https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/>`_
>> +for more information.
>> diff --git a/python/qemu/README.rst b/python/qemu/README.rst
>> new file mode 100644
>> index 0000000000..31209c80a5
>> --- /dev/null
>> +++ b/python/qemu/README.rst
>> @@ -0,0 +1,8 @@
>> +QEMU Python Namespace
>> +=====================
>> +
>> +This directory serves as the root of a `Python PEP 420 implicit
>> +namespace package <<https://www.python.org/dev/peps/pep-0420/>`_.
>> +
>> +Each directory below is assumed to be an installable Python package that
>> +is available under the ``qemu.<package>`` namespace.
>> diff --git a/python/qemu/machine/README.rst b/python/qemu/machine/README.rst
>> new file mode 100644
>> index 0000000000..73ad23c501
>> --- /dev/null
>> +++ b/python/qemu/machine/README.rst
>> @@ -0,0 +1,9 @@
>> +qemu.machine Package
>> +====================
>> +
>> +This package provides core utilities used for testing and debugging
>> +QEMU. It is used by the iotests, vm tests, and several other utilities
>> +in the ./scripts directory. It is not a fully-fledged SDK and it is
>> +subject to change at any time.
>> +
> 
> I'm not sure if you intend to list all test types that use this, but
> the acceptance tests also do use them.
> 

Wasn't a conscious omission, but didn't necessarily mean to make it 
comprehensive; I can add it while fixing the above feedback item too.

> - Cleber.
> 

Thanks!


