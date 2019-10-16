Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E12ECE58F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 01:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8362084B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 01:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8362084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34835 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKY5L-0002Rh-IM
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 21:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iKY4P-0001Go-NC
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 21:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iKY4M-0003KI-9W
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 21:25:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:60588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iKY4K-0003IK-JM; Tue, 15 Oct 2019 21:25:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Oct 2019 18:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,301,1566889200"; d="scan'208";a="208298945"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga001.fm.intel.com with ESMTP; 15 Oct 2019 18:25:33 -0700
Date: Wed, 16 Oct 2019 09:25:18 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] core: replace getpagesize() with
 qemu_real_host_page_size
Message-ID: <20191016012518.GB21912@richard>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
 <20191013021145.16011-3-richardw.yang@linux.intel.com>
 <20191013092841.GG4080@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013092841.GG4080@umbus.fritz.box>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, cohuck@redhat.com,
 qemu-s390x@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org,
 Wei Yang <richardw.yang@linux.intel.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 13, 2019 at 08:28:41PM +1100, David Gibson wrote:
>On Sun, Oct 13, 2019 at 10:11:45AM +0800, Wei Yang wrote:
>> There are three page size in qemu:
>> 
>>   real host page size
>>   host page size
>>   target page size
>> 
>> All of them have dedicate variable to represent. For the last two, we
>> use the same form in the whole qemu project, while for the first one we
>> use two forms: qemu_real_host_page_size and getpagesize().
>> 
>> qemu_real_host_page_size is defined to be a replacement of
>> getpagesize(), so let it serve the role.
>> 
>> [Note] Not fully tested for some arch or device.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
>Although the chances of someone messing this up again are almost 100%.
>

Hi, David

I found put a check in checkpatch.pl may be a good way to prevent it.

Just draft a patch, hope you would like it.

>-- 
>David Gibson			| I'll have my music baroque, and my code
>david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
>				| _way_ _around_!
>http://www.ozlabs.org/~dgibson



-- 
Wei Yang
Help you, Help me

