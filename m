Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E654C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B3A2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B3A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTgnY-0006iU-JI
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:06:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jTgks-0004Iw-DJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jTgkq-0007q9-2N
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:03:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:42697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jingqi.liu@intel.com>)
 id 1jTgkp-0007pF-09
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:03:35 -0400
IronPort-SDR: evUs7uKx15m0zHgUj1m33jzKMzgWJ16+6KDwFOPkSbFV5jvCITXtprCLEDIMwDegSXkPsUmtSK
 9qDPnBSUtbfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 00:03:31 -0700
IronPort-SDR: KJp3imhaCeAYkfJwwuznSt7R7NYZhyxrmKGxfsdwqcsOYx43rYsAONXCPJtJBcop9ftoo5rPMt
 q+VMhQWCrnPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; 
 d="scan'208,217";a="459492266"
Received: from jingqili-mobl.ccr.corp.intel.com (HELO [10.238.4.212])
 ([10.238.4.212])
 by fmsmga006.fm.intel.com with ESMTP; 29 Apr 2020 00:03:28 -0700
Subject: Re: [PATCH v2 3/3] configure: add libdaxctl support
To: Joao Martins <joao.m.martins@oracle.com>
References: <20200415033538.43329-1-jingqi.liu@intel.com>
 <20200415033538.43329-4-jingqi.liu@intel.com>
 <7b6a53cb-7591-26dd-2bdc-8d6a0bbb0338@oracle.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <9fca45c6-ab11-4263-eb99-c0c993f11987@intel.com>
Date: Wed, 29 Apr 2020 15:03:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7b6a53cb-7591-26dd-2bdc-8d6a0bbb0338@oracle.com>
Content-Type: multipart/alternative;
 boundary="------------4264F1F39D4D5103731A4369"
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=jingqi.liu@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 03:03:31
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.100
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
--------------4264F1F39D4D5103731A4369
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/2020 12:23 AM, Joao Martins wrote:
> On 4/15/20 4:35 AM, Jingqi Liu wrote:
>> Add a pair of configure options --{enable,disable}-libdaxctl to control
>> whether QEMU is compiled with libdaxctl [1]. Libdaxctl is a utility
>> library for managing the device dax subsystem.
>>
>> QEMU uses mmap(2) to maps vNVDIMM backends and aligns the mapping
>> address to the page size (getpagesize(2)) by default. However, some
>> types of backends may require an alignment different than the page
>> size. The 'align' option is provided to memory-backend-file to allow
>> users to specify the proper alignment.
>>
>> For device dax (e.g., /dev/dax0.0), the 'align' option needs to match
>> the alignment requirement of the device dax, which can be fetched
>> through the libdaxctl APIs.
>>
>> [1] Libdaxctl is a part of ndctl project.
>> The project's repository is: https://github.com/pmem/ndctl
>>
>> For more information about libdaxctl APIs, you can refer to the
>> comments in source code of: pmem/ndctl/daxctl/lib/libdaxctl.c.
>>
>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>> ---
>>   configure | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/configure b/configure
>> index e225a1e3ff..df1752cf08 100755
>> --- a/configure
>> +++ b/configure
>> @@ -509,6 +509,7 @@ libpmem=""
>>   default_devices="yes"
>>   plugins="no"
>>   fuzzing="no"
>> +libdaxctl=""
>>   
>>   supported_cpu="no"
>>   supported_os="no"
>> @@ -1601,6 +1602,10 @@ for opt do
>>     ;;
>>     --gdb=*) gdb_bin="$optarg"
>>     ;;
>> +  --enable-libdaxctl) libdaxctl=yes
>> +  ;;
>> +  --disable-libdaxctl) libdaxctl=no
>> +  ;;
>>     *)
>>         echo "ERROR: unknown option $opt"
>>         echo "Try '$0 --help' for more information"
>> @@ -1894,6 +1899,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>>     debug-mutex     mutex debugging support
>>     libpmem         libpmem support
>>     xkbcommon       xkbcommon support
>> +  libdaxctl       libdaxctl support
>>   
>>   NOTE: The object files are built at the place where configure is launched
>>   EOF
>> @@ -6190,6 +6196,25 @@ if test "$libpmem" != "no"; then
>>   	fi
>>   fi
>>   
>> +##########################################
>> +# check for libdaxctl
>> +
>> +if test "$libdaxctl" != "no"; then
>> +	if $pkg_config --exists "libdaxctl"; then
>> +		libdaxctl="yes"
>> +		libdaxctl_libs=$($pkg_config --libs libdaxctl)
>> +		libdaxctl_cflags=$($pkg_config --cflags libdaxctl)
>> +		libs_softmmu="$libs_softmmu $libdaxctl_libs"
>> +		QEMU_CFLAGS="$QEMU_CFLAGS $libdaxctl_cflags"
>> +	else
>> +		if test "$libdaxctl" = "yes" ; then
>> +			feature_not_found "libdaxctl" "Install libdaxctl"
>> +		fi
> Region iteration APIs, align and path getter routines are only available since
> libdaxctl v56/v57 (the latest is v68).
>
> Not sure how likely this happens in today's distros but if we care about systems
> with < v57 we should probably check that
> daxctl_region_foreach/daxctl_region_get_align/daxctl_region_get_path symbols
> exist? Or alternatively requiring v57 or up which serves as a bandage, but more
> long term ... any usage of newer daxctl APIs will require the former.

Thanks for your suggestion.
Better to require v57 or up.
How about adding the following check:
+       if $pkg_config --atleast-version=57 "libdaxctl"; then


Jingqi


--------------4264F1F39D4D5103731A4369
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 4/29/2020 12:23 AM, Joao Martins
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:7b6a53cb-7591-26dd-2bdc-8d6a0bbb0338@oracle.com">
      <pre class="moz-quote-pre" wrap="">On 4/15/20 4:35 AM, Jingqi Liu wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Add a pair of configure options --{enable,disable}-libdaxctl to control
whether QEMU is compiled with libdaxctl [1]. Libdaxctl is a utility
library for managing the device dax subsystem.

QEMU uses mmap(2) to maps vNVDIMM backends and aligns the mapping
address to the page size (getpagesize(2)) by default. However, some
types of backends may require an alignment different than the page
size. The 'align' option is provided to memory-backend-file to allow
users to specify the proper alignment.

For device dax (e.g., /dev/dax0.0), the 'align' option needs to match
the alignment requirement of the device dax, which can be fetched
through the libdaxctl APIs.

[1] Libdaxctl is a part of ndctl project.
The project's repository is: <a class="moz-txt-link-freetext" href="https://github.com/pmem/ndctl">https://github.com/pmem/ndctl</a>

For more information about libdaxctl APIs, you can refer to the
comments in source code of: pmem/ndctl/daxctl/lib/libdaxctl.c.

Signed-off-by: Jingqi Liu <a class="moz-txt-link-rfc2396E" href="mailto:jingqi.liu@intel.com">&lt;jingqi.liu@intel.com&gt;</a>
---
 configure | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/configure b/configure
index e225a1e3ff..df1752cf08 100755
--- a/configure
+++ b/configure
@@ -509,6 +509,7 @@ libpmem=""
 default_devices="yes"
 plugins="no"
 fuzzing="no"
+libdaxctl=""
 
 supported_cpu="no"
 supported_os="no"
@@ -1601,6 +1602,10 @@ for opt do
   ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
+  --enable-libdaxctl) libdaxctl=yes
+  ;;
+  --disable-libdaxctl) libdaxctl=no
+  ;;
   *)
       echo "ERROR: unknown option $opt"
       echo "Try '$0 --help' for more information"
@@ -1894,6 +1899,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   debug-mutex     mutex debugging support
   libpmem         libpmem support
   xkbcommon       xkbcommon support
+  libdaxctl       libdaxctl support
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -6190,6 +6196,25 @@ if test "$libpmem" != "no"; then
 	fi
 fi
 
+##########################################
+# check for libdaxctl
+
+if test "$libdaxctl" != "no"; then
+	if $pkg_config --exists "libdaxctl"; then
+		libdaxctl="yes"
+		libdaxctl_libs=$($pkg_config --libs libdaxctl)
+		libdaxctl_cflags=$($pkg_config --cflags libdaxctl)
+		libs_softmmu="$libs_softmmu $libdaxctl_libs"
+		QEMU_CFLAGS="$QEMU_CFLAGS $libdaxctl_cflags"
+	else
+		if test "$libdaxctl" = "yes" ; then
+			feature_not_found "libdaxctl" "Install libdaxctl"
+		fi
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Region iteration APIs, align and path getter routines are only available since
libdaxctl v56/v57 (the latest is v68).

Not sure how likely this happens in today's distros but if we care about systems
with &lt; v57 we should probably check that
daxctl_region_foreach/daxctl_region_get_align/daxctl_region_get_path symbols
exist? Or alternatively requiring v57 or up which serves as a bandage, but more
long term ... any usage of newer daxctl APIs will require the former.
</pre>
    </blockquote>
    <pre>Thanks for your suggestion.
Better to require v57 or up. 
How about adding the following check:
+       if $pkg_config --atleast-version=57 "libdaxctl"; then


Jingqi
</pre>
  </body>
</html>

--------------4264F1F39D4D5103731A4369--

