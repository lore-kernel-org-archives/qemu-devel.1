Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEE9C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B081F21882
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B081F21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSjKt-0008TE-On
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iSjIz-0006Ya-HP
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iSjIu-0004YV-52
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:02:36 -0500
Received: from relay68.bu.edu ([128.197.228.73]:51395)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iSjIu-0004Xj-1L
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:02:32 -0500
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: 144.121.20.162.lightower.net [144.121.20.162] (may be forged)
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id xA7F21Yu000452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
 Thu, 7 Nov 2019 10:02:02 -0500
Subject: Re: [PATCH v4 20/20] fuzz: add documentation to docs/devel/
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-21-alxndr@bu.edu>
 <20191107134036.GF365089@stefanha-x1.localdomain>
From: Alexander Oleinik <alxndr@bu.edu>
Message-ID: <cafdaecb-3572-e3ef-e283-6b836abef908@bu.edu>
Date: Thu, 7 Nov 2019 10:02:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191107134036.GF365089@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.6.x [fuzzy]
X-Received-From: 128.197.228.73
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/19 8:40 AM, Stefan Hajnoczi wrote:
> On Wed, Oct 30, 2019 at 02:50:04PM +0000, Oleinik, Alexander wrote:
>> +== Building the fuzzers ==
>> +
>> +NOTE: If possible, build a 32-bit binary. When forking, the 32-bit fuzzer is
>> +much faster, since the page-map has a smaller size. This is due to the fact that
>> +AddressSanitizer mmaps ~20TB of memory, as part of its detection. This results
>> +in a large page-map, and a much slower fork(). O
>> +
>> +To build the fuzzers, install a recent version of clang:
>> +Configure with (substitute the clang binaries with the version you installed):
>> +
>> +    CC=clang-8 CXX=clang++-8 /path/to/configure --enable-fuzzing
>> +
>> +Fuzz targets are built similarly to system/softmmu:
>> +
>> +    make i386-softmmu/fuzz
>> +
>> +This builds ./i386-softmmu/qemu-fuzz-i386
> 
> I'm surprised that "make i386-softmmu/fuzz" builds
> i386-softmmu/qemu-fuzz-i386.  Should that be "make
> i386-softmmu/qemu-fuzz-i386"
I tried to make the rule match the names for regular targets.
Ie:
make i386-softmmu/clean
make i386-softmmu/all
make i386-softmmu/install
Now there is an i386-softmmu/fuzz

>> += Implmentation Details =
> 
> s/Implmentation/Implementation/
> 
>> +
>> +== The Fuzzer's Lifecycle ==
>> +
>> +The fuzzer has two entrypoints that libfuzzer calls. libfuzzer provides it's
>> +own main(), which performs some setup, and calls the entrypoints:
>> +
>> +LLVMFuzzerInitialize: called prior to fuzzing. Used to initialize all of the
>> +necessary state
>> +
>> +LLVMFuzzerTestOneInput: called for each fuzzing run. Processes the input and
>> +resets the state at the end of each run.
>> +
>> +In more detail:
>> +
>> +LLVMFuzzerInitialize parses the arguments to the fuzzer (must start with two
>> +dashes, so they are ignored by libfuzzer main()). Currently, the arguments
>> +select the fuzz target. Then, the qtest client is initialized. If the target
>> +requires qos, qgraph is set up and the QOM/LIBQOS modules are initailized.
> 
> s/initailized/initialized/
> 


