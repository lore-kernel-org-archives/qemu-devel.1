Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3A8C0650F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 00:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEED0208C4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 00:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEED0208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvsQu-0003nW-Vo
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 20:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56037)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hvsQW-0003NX-Ep
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hvsQV-00029e-Gm
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:06:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:26495)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hvsQV-000298-7f
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:06:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Aug 2019 17:06:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; d="scan'208";a="165856894"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga007.jf.intel.com with ESMTP; 08 Aug 2019 17:06:32 -0700
Date: Fri, 9 Aug 2019 08:06:09 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190809000609.GA4201@richard>
References: <20190808020723.GB26938@richard> <20190808080229.GA2534@redhat.com>
 <20190808084653.GB32524@richard> <20190808092213.GB2534@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190808092213.GB2534@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
Subject: Re: [Qemu-devel] [Fail] tests/test-util-filemonitor fails
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
Cc: marcandre.lureau@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 08, 2019 at 10:22:13AM +0100, Daniel P. Berrangé wrote:
>On Thu, Aug 08, 2019 at 04:46:53PM +0800, Wei Yang wrote:
>> On Thu, Aug 08, 2019 at 09:02:29AM +0100, Daniel P. Berrangé wrote:
>> >On Thu, Aug 08, 2019 at 10:07:23AM +0800, Wei Yang wrote:
>> >> Current qemu fails tests/test-util-filemonitor.
>> >
>> >You'll need to provide more info. The test works for me and passes in all
>> >the QEMU CI environments.
>> >
>> 
>> The error message from my side is:
>> 
>> /util/filemonitor: Expected watch id 200000000 but got 100000000
>> **
>> ERROR:tests/test-util-filemonitor.c:665:test_file_monitor_events: assertion failed: (err == 0)
>> 
>> What else you'd prefer to have?
>
>Can you set the  "FILEMONITOR_DEBUG=1" env variable before running
>the test - it will print out lots more info
>

Here is the output with more info.

    $ FILEMONITOR_DEBUG=1 QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/test-util-filemonitor
    /util/filemonitor: Add watch /tmp/test-util-filemonitor-151B6Z (null)
    Watch ID 100000000
    Add watch /tmp/test-util-filemonitor-151B6Z one.txt
    Watch ID 100000001
    Add watch /tmp/test-util-filemonitor-151B6Z two.txt
    Watch ID 100000002
    Create /tmp/test-util-filemonitor-151B6Z/one.txt
    Event id=100000000 event=0 file=one.txt
    Event id=100000001 event=0 file=one.txt
    Create /tmp/test-util-filemonitor-151B6Z/two.txt
    Event id=100000000 event=0 file=two.txt
    Event id=100000002 event=0 file=two.txt
    Create /tmp/test-util-filemonitor-151B6Z/three.txt
    Event id=100000000 event=0 file=three.txt
    Unlink /tmp/test-util-filemonitor-151B6Z/three.txt
    Event id=100000000 event=2 file=three.txt
    Rename /tmp/test-util-filemonitor-151B6Z/one.txt -> /tmp/test-util-filemonitor-151B6Z/two.txt
    Event id=100000000 event=2 file=one.txt
    Event id=100000001 event=2 file=one.txt
    Event id=100000000 event=0 file=two.txt
    Event id=100000002 event=0 file=two.txt
    Append /tmp/test-util-filemonitor-151B6Z/two.txt
    Event id=100000000 event=1 file=two.txt
    Event id=100000002 event=1 file=two.txt
    Touch /tmp/test-util-filemonitor-151B6Z/two.txt
    Event id=100000000 event=3 file=two.txt
    Event id=100000002 event=3 file=two.txt
    Del watch /tmp/test-util-filemonitor-151B6Z 100000001
    Add watch /tmp/test-util-filemonitor-151B6Z one.txt
    Watch ID 100000003
    Create /tmp/test-util-filemonitor-151B6Z/one.txt
    Event id=100000000 event=0 file=one.txt
    Event id=100000003 event=0 file=one.txt
    Del watch /tmp/test-util-filemonitor-151B6Z 100000003
    Unlink /tmp/test-util-filemonitor-151B6Z/one.txt
    Event id=100000000 event=2 file=one.txt
    Mkdir /tmp/test-util-filemonitor-151B6Z/fish
    Event id=100000000 event=0 file=fish
    Add watch /tmp/test-util-filemonitor-151B6Z fish/
    Watch ID 200000000
    Add watch /tmp/test-util-filemonitor-151B6Z fish/one.txt
    Watch ID 200000001
    Create /tmp/test-util-filemonitor-151B6Z/fish/one.txt
    Event id=200000000 event=0 file=one.txt
    Event id=200000001 event=0 file=one.txt
    Del watch /tmp/test-util-filemonitor-151B6Z 200000001
    Rename /tmp/test-util-filemonitor-151B6Z/fish/one.txt -> /tmp/test-util-filemonitor-151B6Z/two.txt
    Event id=200000000 event=2 file=one.txt
    Event id=100000000 event=0 file=two.txt
    Event id=100000002 event=0 file=two.txt
    Rmdir /tmp/test-util-filemonitor-151B6Z/fish
    Event id=200000000 event=4 file=
    Expected watch id 200000000 but got 100000000
    **
    ERROR:tests/test-util-filemonitor.c:665:test_file_monitor_events: assertion failed: (err == 0)
    Aborted (core dumped)


>Also what operating system are you using, and what kernel version
>

OS: Ubuntu 18.04.2 LTS
Kernel: I built the kernel whose last commit is bed38c3e2dca.

>Regards,
>Daniel
>-- 
>|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

-- 
Wei Yang
Help you, Help me

