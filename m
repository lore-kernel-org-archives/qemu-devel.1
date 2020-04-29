Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D0C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769FF206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769FF206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfys-0002H9-M2
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jTfwO-0006Dc-9V
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jTfwM-0002vK-Lv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:37047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1jTfwM-0002Rz-2U
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:26 -0400
IronPort-SDR: eL/Wtek0e7AtFXGRrWcBF4eeNIIuPjEwmHDAJt0T54bL+yWMN5wMhVqR7uiKJ2G2KoTuQyG+4A
 h3Nc2S88nSrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 23:11:18 -0700
IronPort-SDR: IlZMj7Kf+Kczz0iK4+8LPC/6u+vJgn1eAnGEu3WARZFJ3YxZXCMoDbNoTMFgK7Eu1LSCydJzOg
 a77ezAfhfOkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
 d="scan'208,217";a="459481662"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.238.4.212])
 ([10.238.4.212])
 by fmsmga006.fm.intel.com with ESMTP; 28 Apr 2020 23:11:17 -0700
Subject: Re: [PATCH v2 2/3] docs/nvdimm: add description of alignment
 requirement of device dax
To: Joao Martins <joao.m.martins@oracle.com>
References: <20200415033538.43329-1-jingqi.liu@intel.com>
 <20200415033538.43329-3-jingqi.liu@intel.com>
 <b520218c-a8f5-101e-1e3e-ad212fe35cdd@oracle.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <a8d90850-6782-35b9-5113-a1f56aadbdb0@intel.com>
Date: Wed, 29 Apr 2020 14:11:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b520218c-a8f5-101e-1e3e-ad212fe35cdd@oracle.com>
Content-Type: multipart/alternative;
 boundary="------------AC36DB6C685D9406A2F9EC4D"
Received-SPF: pass client-ip=192.55.52.115; envelope-from=jingqi.liu@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:11:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.115
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------AC36DB6C685D9406A2F9EC4D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/2020 12:22 AM, Joao Martins wrote:
> On 4/15/20 4:35 AM, Jingqi Liu wrote:
>> For device dax (e.g., /dev/dax0.0), the NUM of 'align=NUM' option
>> needs to match the alignment requirement of the device dax.
>> It must be larger than or equal to the 'align' of device dax.
>>
>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>> ---
>>   docs/nvdimm.txt | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
>> index 362e99109e..3c7b6dab5f 100644
>> --- a/docs/nvdimm.txt
>> +++ b/docs/nvdimm.txt
>> @@ -132,6 +132,15 @@ address to the page size (getpagesize(2)) by default. However, some
>>   types of backends may require an alignment different than the page
>>   size. In that case, QEMU v2.12.0 and later provide 'align' option to
>>   memory-backend-file to allow users to specify the proper alignment.
>> +For device dax (e.g., /dev/dax0.0), this alignment needs to match the
>> +alignment requirement of the device dax. The NUM of 'align=NUM' option
>> +must be larger than or equal to the 'align' of device dax.
>> +We can use the following command to show the 'align' of device dax.
>> +
>> +    ndctl list -X
>> +
>> +In order to get the proper 'align' of device dax, you need to install
>> +the library 'libdaxctl'.
>>   
>>   For example, device dax require the 2 MB alignment, so we can use
>>   following QEMU command line options to use it (/dev/dax0.0) as the
>>
> Given that this series introduces support for libdaxctl, perhaps suggesting in
> the docs how you can also query the @align with daxctl tool? e.g.
>
> "We can one of the following commands to show the 'align' of device dax:
>
>       ndctl list -X
>       daxctl list -R"

Thanks for your comments.
I'll add "daxctl list -R" in this doc.

Jingqi

> The unlikely reason being that users may only install daxctl-{,libs,devel} and
> not ndctl-*. It also covers other users like ACPI HMAT/hmem which are not
> instrumented with ndctl.
>
> With that:
>
>    Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>
> 	Joao

Thanks.


--------------AC36DB6C685D9406A2F9EC4D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 4/29/2020 12:22 AM, Joao Martins
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b520218c-a8f5-101e-1e3e-ad212fe35cdd@oracle.com">
      <pre class="moz-quote-pre" wrap="">On 4/15/20 4:35 AM, Jingqi Liu wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">For device dax (e.g., /dev/dax0.0), the NUM of 'align=NUM' option
needs to match the alignment requirement of the device dax.
It must be larger than or equal to the 'align' of device dax.

Signed-off-by: Jingqi Liu <a class="moz-txt-link-rfc2396E" href="mailto:jingqi.liu@intel.com">&lt;jingqi.liu@intel.com&gt;</a>
---
 docs/nvdimm.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 362e99109e..3c7b6dab5f 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -132,6 +132,15 @@ address to the page size (getpagesize(2)) by default. However, some
 types of backends may require an alignment different than the page
 size. In that case, QEMU v2.12.0 and later provide 'align' option to
 memory-backend-file to allow users to specify the proper alignment.
+For device dax (e.g., /dev/dax0.0), this alignment needs to match the
+alignment requirement of the device dax. The NUM of 'align=NUM' option
+must be larger than or equal to the 'align' of device dax.
+We can use the following command to show the 'align' of device dax.
+
+    ndctl list -X
+
+In order to get the proper 'align' of device dax, you need to install
+the library 'libdaxctl'.
 
 For example, device dax require the 2 MB alignment, so we can use
 following QEMU command line options to use it (/dev/dax0.0) as the

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Given that this series introduces support for libdaxctl, perhaps suggesting in
the docs how you can also query the @align with daxctl tool? e.g.

"We can one of the following commands to show the 'align' of device dax:

     ndctl list -X
     daxctl list -R"
</pre>
    </blockquote>
    <pre>Thanks for your comments.
I'll add "daxctl list -R" in this doc.

Jingqi 
</pre>
    <blockquote type="cite"
      cite="mid:b520218c-a8f5-101e-1e3e-ad212fe35cdd@oracle.com">
      <pre class="moz-quote-pre" wrap="">
The unlikely reason being that users may only install daxctl-{,libs,devel} and
not ndctl-*. It also covers other users like ACPI HMAT/hmem which are not
instrumented with ndctl.

With that:

  Reviewed-by: Joao Martins <a class="moz-txt-link-rfc2396E" href="mailto:joao.m.martins@oracle.com">&lt;joao.m.martins@oracle.com&gt;</a>

	Joao</pre>
    </blockquote>
    <pre>Thanks.</pre>
    <blockquote type="cite"
      cite="mid:b520218c-a8f5-101e-1e3e-ad212fe35cdd@oracle.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------AC36DB6C685D9406A2F9EC4D--

