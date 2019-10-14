Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7ECC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 03:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A5D20815
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 03:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A5D20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJquK-0006cF-W7
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 23:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJqtP-0005yu-T1
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJqtO-0003Dl-Iy
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:19:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:24703)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iJqtO-0003DC-4a; Sun, 13 Oct 2019 23:19:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Oct 2019 20:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,294,1566889200"; d="scan'208";a="278741008"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga001.jf.intel.com with ESMTP; 13 Oct 2019 20:19:21 -0700
Date: Mon, 14 Oct 2019 11:19:06 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/2] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
Message-ID: <20191014031906.GA10129@richard>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
 <20191013021145.16011-2-richardw.yang@linux.intel.com>
 <41a924dc-f91b-c03b-4f82-570757105798@linaro.org>
 <20191014010142.GA29752@richard>
 <4036820a-f357-9e67-7e58-cbb9186d0ef4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4036820a-f357-9e67-7e58-cbb9186d0ef4@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Cc: fam@euphon.net, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, den@openvz.org,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, marcandre.lureau@redhat.com,
 ehabkost@redhat.com, sw@weilnetz.de, dgilbert@redhat.com,
 yuval.shaia@oracle.com, alex.williamson@redhat.com, stefanha@redhat.com,
 imammedo@redhat.com, david@gibson.dropbear.id.au, kwolf@redhat.com,
 cohuck@redhat.com, qemu-s390x@nongnu.org, mreitz@redhat.com,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 13, 2019 at 07:38:04PM -0700, Richard Henderson wrote:
>On 10/13/19 6:01 PM, Wei Yang wrote:
>>> No, please.
>>>
>>> (1) The compiler does not know that qemu_*host_page_size is a power of 2, and
>>> will generate a real division at runtime.  The same is true for
>>> TARGET_PAGE_SIZE when TARGET_PAGE_BITS_VARY.
>>>
>> 
>> Confused
>> 
>> The definition of ROUND_UP is:
>> 
>> #define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))
>
>Ah, my bad, I did confuse this with QEMU_ALIGN_UP.
>
>Hmm.
>
>	lea	-1(n, size), t
>	neg	size
>	and	size, t
>
>vs
>
>	mov	mask, t
>	not	t
>	add	n, t
>	and	mask, t
>
>which is what I proposed here
>
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04526.html
>
>I'm ok with your version.
>
>Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>

Thanks for your clarification.

Have a nice day

>
>r~
>

-- 
Wei Yang
Help you, Help me

