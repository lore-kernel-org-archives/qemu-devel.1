Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A946C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422F3206BA
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422F3206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1JZe-0007pt-9c
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1i1JJ9-0008Qv-5v
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1i1JJ7-00044f-RU
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:49:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:59721)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1i1JJ7-00043D-JZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:49:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; d="scan'208";a="180821343"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2019 16:49:22 -0700
Date: Sat, 24 Aug 2019 07:49:00 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190823234900.GA27793@richard>
References: <20190621142739.23703-1-richardw.yang@linux.intel.com>
 <20190819112632.GA2765@work-vm>
 <20190819140828.otv7vq5lahvquczl@master>
 <12c6eab2-7988-cdb9-ab54-ae052cd45188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c6eab2-7988-cdb9-ab54-ae052cd45188@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: Re: [Qemu-devel] [PATCH] migrtion: define
 MigrationState/MigrationIncomingState.state as MigrationStatus
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
Cc: qemu-devel@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 quintela@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richard.weiyang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 11:21:50AM -0500, Eric Blake wrote:
>On 8/19/19 9:08 AM, Wei Yang wrote:
>> On Mon, Aug 19, 2019 at 12:26:32PM +0100, Dr. David Alan Gilbert wrote:
>>> * Wei Yang (richardw.yang@linux.intel.com) wrote:
>
>Typo in the subject line: migrtion should be migration
>
>>>> No functional change. Add default case to fix warning.
>>>
>>> I think the problem with this is that migrate_set_state uses an
>>> atomic_cmpxchg and so we have to be careful that the type we use
>>> is compatible with that.
>>> MigrationStatus is an enum and I think compilers are allowed to
>>> choose the types of that;  so I'm not sure we're guaranteed
>>> that an enum is always OK for the atomic_cmpxchg, and if it is
>> 
>> Took a look into the definition of atomic_cmpxchg, which finally calls
>> 
>>   * __atomic_compare_exchange_n for c++11
>>   * __sync_val_compare_and_swap
>
>Those are compiler-defined macros, so you have to consult the compiler
>documentation to see if they state what happens when invoked on an enum
>type.  You also have to check whether our macro
>typeof_strip_qual(enum_type) produces 'int' or something else.
>
>C99 doesn't specify _Atomic at all (which is why we handrolled our own
>atomic.h built on top of compiler primitives, instead of using
><stdatomic.h>).  But reading C11, I see that 6.7.2.4 states that
>_Atomic(type) is okay except for:
>
>"The type name in an atomic type specifier shall not refer to an array
>type, a function type, an atomic type, or a qualified type."
>
>which does NOT preclude the use of _Atomic(enum_type), so presumably
>compilers have to be prepared to handle an atomic enum type.  Still,
>it's rather shaky ground if you can't prove compilers handle it correctly.
>

Sounds this is a dark area for all those compilers. I would keep the code
untouched now.

Thanks

>
>> 
>> Both of them take two pointers to compare and exchange its content.
>> 
>> Per C99 standard, http://www.open-std.org/JTC1/SC22/WG14/www/docs/n1256.pdf,
>> it mentioned:
>> 
>>   Each enumerated type shall be compatible with char, a signed integer type,
>>   or an unsigned integer type. The choice of type is implementation-defined,
>>   but shall be capable of representing the values of all the members of the
>>   enumeration.
>> 
>> Based on this, I think atomic_cmpxchg should work fine with enum.
>
>What C99 says is rather weak; you really want to be basing your
>decisions on atomics based on C11 or later.
>
>
>-- 
>Eric Blake, Principal Software Engineer
>Red Hat, Inc.           +1-919-301-3226
>Virtualization:  qemu.org | libvirt.org
>




-- 
Wei Yang
Help you, Help me

