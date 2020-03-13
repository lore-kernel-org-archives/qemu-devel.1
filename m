Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04E6C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC984206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P72VWnaJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC984206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCowl-0000V4-Ts
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jCovf-0007Uo-0J
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jCovd-0004WC-NS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:21:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jCovd-0004UB-Io
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584123660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XcIyd+uM+2qbh04Yf9VVkFbnnkP3DV9NYAx45Z/U9cs=;
 b=P72VWnaJRDsuJmJuQCgwbCUK/du3kNTOoyOIua0fTXTrSqxq2rA7GresSOT12udAJ5K3W0
 cs9fGODQURjgAJjLBdnpmzuR3GhoFO6DZoN7BwPwFFHVwBKzPt002Oug2fWgfMuEeMq/o5
 a8pTfvvRez5tuxBNIaEHrM5nVhEm/cQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-l3mZ9X6uOsOAdJVUawnLoQ-1; Fri, 13 Mar 2020 14:20:58 -0400
X-MC-Unique: l3mZ9X6uOsOAdJVUawnLoQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FF181083860;
 Fri, 13 Mar 2020 18:20:57 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32E5B100164D;
 Fri, 13 Mar 2020 18:20:54 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] qemu-img: Deprecate use of -b without -F
To: Kashyap Chamarthy <kchamart@redhat.com>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-5-eblake@redhat.com> <20200309153119.GA20640@paraplu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <32854036-8842-c81b-5ce7-bebd5579df44@redhat.com>
Date: Fri, 13 Mar 2020 13:20:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309153119.GA20640@paraplu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 10:31 AM, Kashyap Chamarthy wrote:
> On Fri, Mar 06, 2020 at 04:51:21PM -0600, Eric Blake wrote:
>> Creating an image that requires format probing of the backing image is
>> inherently unsafe (we've had several CVEs over the years based on

>>
>> +qemu-img backing file without format (since 5.0.0)
>> +''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The use of ``qemu-img create``, ``qemu-img rebase``, ``qemu-img
>> +convert``, or ``qemu-img amend`` to create or modify an image that
>> +depends on a backing file now recommends that an explicit backing
>> +format be provided.  This is for safety: if qemu probes a different
>> +format than what you thought, the data presented to the guest will be
>> +corrupt; similarly, presenting a raw image to a guest allows a
>> +potential security exploit if a future probe sees a non-raw image
>> +based on guest writes.  To avoid the warning message, or even future
>> +refusal to create an unsafe image, you must pass ``-o backing_fmt=``
>> +(or the shorthand ``-F`` during create) to specify the intended
>> +backing format.  You may use ``qemu-img rebase -u`` to retroactively
>> +add a backing format to an existing image.  However, be aware that
>> +there are already potential security risks to blindly using ``qemu-img
>> +info`` to probe the format of an untrusted backing image, when
>> +deciding what format to add into an existing image.
> 
> Nit: s/qemu/QEMU/g/
> 
> Ultra Nit: should this paragraph be broken down into two?  Experience
> tells people usually feel deterred read "substantial paragraphs" :-)

Shoot, I missed incorporating this comment during my v4 posting. It's 
now changed in my local tree, but I'll hold off on a v5 unless other 
review warrants it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


