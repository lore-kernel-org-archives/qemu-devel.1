Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C984FC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9281B2468C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XG3Kne+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9281B2468C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdol-00013o-QW
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBdnY-0000J6-Ne
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBdnX-0002cq-HT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:15:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47753
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBdnX-0002Zm-CQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583842547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxegmkL0yYqQaiG+2k5R0aOoh9G/0UwBlSYSkdAmOR8=;
 b=XG3Kne+xJZ+5lh2SrfCSEcctJ9m0BaYlxYo675Iu3XxFWAOS6yWsq78x1KaALHfbQvFr09
 hCo1IWzN8RGGdCP9lW2YK9FHy9P7sqNBKQokKLVWpZ+qlnUnATvZvXdobjUbyar/pmo2Dr
 yBl9cWiwoTfY90SCRptxl0DG4Wcs8Vc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-xd6h0g_rPia9kEg99d9jNg-1; Tue, 10 Mar 2020 08:15:43 -0400
X-MC-Unique: xd6h0g_rPia9kEg99d9jNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23A51DBC5;
 Tue, 10 Mar 2020 12:15:41 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2A8628997;
 Tue, 10 Mar 2020 12:15:29 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] qemu-img: Deprecate use of -b without -F
To: Kashyap Chamarthy <kchamart@redhat.com>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-5-eblake@redhat.com> <20200309153119.GA20640@paraplu>
 <11ba06c9-fa1e-3168-0322-1859040b655e@redhat.com>
 <20200310094723.GC22884@paraplu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <2fd580c2-4b94-4430-1072-ef04bbd2da60@redhat.com>
Date: Tue, 10 Mar 2020 07:15:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310094723.GC22884@paraplu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

On 3/10/20 4:47 AM, Kashyap Chamarthy wrote:

>> To provoke the warning during convert, you'll
>> have to also pass -B (or -o backing_file), without -o backing_fmt (since
>> convert lacks the -F shorthand).
> 
> Hmm, I tried the following way, but it doesn't provoke the warning:
> 
>      $> ~/build/qemu/qemu-img convert -B ./base.raw -O qcow2 overlay1.qcow2 flattened.qcow2
> 
>      $> ~/build/qemu/qemu-img info flattened.qcow2
>      image: flattened.qcow2
>      file format: qcow2
>      virtual size: 4 GiB (4294967296 bytes)
>      disk size: 196 KiB
>      cluster_size: 65536
>      backing file: ./base.raw
>      Format specific information:
>          compat: 1.1
>          lazy refcounts: false
>          refcount bits: 16
>          corrupt: false
> 
> What am I missing?

Rather, it looks like my patch is missing a warning on that path.  I'll 
have to investigate, for v4.

> 
> 
>              - - -
> 
> <digression>
> 
> Ah, didn't realize the inconsistency of 'convert' lacking the '-F'
> shorthand ... which reminds me, there are at least _three_ ways that I
> know of, to specify backing file format with 'create':
> 
>      $ qemu-img create -f qcow2 -o 'backing_file=./base.raw,backing_fmt=raw' ./overlay1.qcow2
>      $ qemu-img create -f qcow2 -b ./base.raw -o backing_fmt=raw overlay1.qcow2
>      $ qemu-img create -f qcow2 -b ./base.raw -F raw ./overlay1.qcow2
> 
> I'm wondering about the consistency of having all the above three
> supported for other operations too.  Now I at least know 'convert' lacks
> the "-F".

The -o forms (backing_file= and backing_fmt=) always work.  Various 
commands then have additional shorthand: -b/-F for create, -B for 
convert.  You're right that we aren't very consistent, but I'm reluctant 
to change the inconsistencies in this patch (at one point in the past, 
we tried to get rid of the shorthand and force all users to go through 
-o, but that broke too many clients that were depending on the 
undocumented shorthand, so we documented the existing shorthand instead).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


