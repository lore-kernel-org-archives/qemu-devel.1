Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8BCECE599
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 00:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A120020872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 00:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A120020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKtui-0000PD-NH
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 20:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iKttp-0008Ow-Vy
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 20:44:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iKtto-0004Bi-Qo
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 20:44:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:41792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iKtto-0004BK-Hf
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 20:44:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Oct 2019 17:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,305,1566889200"; d="scan'208";a="195001357"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga008.fm.intel.com with ESMTP; 16 Oct 2019 17:44:13 -0700
Date: Thu, 17 Oct 2019 08:43:57 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] checkpatch: sugguest to use qemu_real_host_page_size
 instead of getpagesize() or sysconf(_SC_PAGESIZE)
Message-ID: <20191017004357.GB12405@richard>
References: <20191016012432.22731-1-richardw.yang@linux.intel.com>
 <20191016184850.GB15027@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016184850.GB15027@stefanha-x1.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: thuth@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 Wei Yang <richardw.yang@linux.intel.com>, pbonzini@redhat.com,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 07:48:50PM +0100, Stefan Hajnoczi wrote:
>On Wed, Oct 16, 2019 at 09:24:32AM +0800, Wei Yang wrote:
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> CC: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  scripts/checkpatch.pl | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index aa9a354a0e..4b360ed310 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2915,6 +2915,12 @@ sub process {
>>  		if ($line =~ /\bbzero\(/) {
>>  			ERROR("use memset() instead of bzero()\n" . $herecurr);
>>  		}
>> +		if ($line =~ /getpagesize\(\)/) {
>> +			ERROR("use qemu_real_host_page_size instead of getpagesize()\n" . $herecurr);
>> +		}
>> +		if ($line =~ /sysconf\(_SC_PAGESIZE\)/) {
>> +			ERROR("use qemu_real_host_page_size instead of sysconf(_SC_PAGESIZE)\n" . $herecurr);
>> +		}
>>  		my $non_exit_glib_asserts = qr{g_assert_cmpstr|
>>  						g_assert_cmpint|
>>  						g_assert_cmpuint|
>
>Just wanted to say thank you for extending checkpatch.pl!  We don't do
>it enough but it's the best way to extend QEMU coding style because it's
>automated :).
>

You are welcome. Glad to do something.

>Stefan



-- 
Wei Yang
Help you, Help me

