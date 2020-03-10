Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61AFC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6643124686
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhNRRx++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6643124686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdsv-0005qn-Kd
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jBdrC-0003Zx-P6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jBdrB-00010l-Lb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:19:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56730
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jBdrB-00010D-Hy
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583842773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ub1y87WBl5ESLCZ3TGJ2ZE0YhuWBUMi64J6Yl16T9PY=;
 b=fhNRRx++zKggjRN8vcH10eyvH/2sxIgo/YkUzaxatUs8LM4QPALovNiihiwEHMN+1pcKpy
 B+0tQOFsd825C2qICv1FuNUdAKGNddC+9WdnWTviSGXzxHe8o8j5waFuT59g1mLHL8Hwb0
 peaz4OkWm06w2CUTPuFLY6Xb14kYVVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-sbs6U2c9OkGf5Jn_w9haoQ-1; Tue, 10 Mar 2020 08:19:31 -0400
X-MC-Unique: sbs6U2c9OkGf5Jn_w9haoQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77EF08010E8;
 Tue, 10 Mar 2020 12:19:30 +0000 (UTC)
Received: from [10.3.116.177] (ovpn-116-177.phx2.redhat.com [10.3.116.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA0D410027AA;
 Tue, 10 Mar 2020 12:19:25 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] qemu-img: Deprecate use of -b without -F
To: Kashyap Chamarthy <kchamart@redhat.com>
References: <20200306225121.3199279-1-eblake@redhat.com>
 <20200306225121.3199279-5-eblake@redhat.com> <20200309153119.GA20640@paraplu>
 <11ba06c9-fa1e-3168-0322-1859040b655e@redhat.com>
 <20200310105746.GD22884@paraplu>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <090db695-2281-6704-1d72-4c4c64e3b72a@redhat.com>
Date: Tue, 10 Mar 2020 07:19:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310105746.GD22884@paraplu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 3/10/20 5:57 AM, Kashyap Chamarthy wrote:
> On Mon, Mar 09, 2020 at 10:42:25AM -0500, Eric Blake wrote:
> 
> [...]
> 
>>>> +qemu-img backing file without format (since 5.0.0)
>>>> +''''''''''''''''''''''''''''''''''''''''''''''''''
>>>> +
>>>> +The use of ``qemu-img create``, ``qemu-img rebase``, ``qemu-img
>>>> +convert``, or ``qemu-img amend`` to create or modify an image that
>>>> +depends on a backing file now recommends that an explicit backing
>>>> +format be provided.
> 
> Also for the `qemu-img amend` case, I'm not clear if the following scenario
> ought to throw the warning:
> 
>      $> ~/build/qemu/qemu-img info --backing-chain overlay1.qcow2
>      image: overlay1.qcow2
>      file format: qcow2
>      virtual size: 4 GiB (4294967296 bytes)
>      disk size: 196 KiB
>      cluster_size: 65536
>      backing file: base.raw
>      Format specific information:
>          compat: 1.1
>          lazy refcounts: false
>          refcount bits: 16
>          corrupt: false
>      
>      image: base.raw
>      file format: raw
>      virtual size: 4 GiB (4294967296 bytes)
>      disk size: 778 MiB
> 
>      $> ~/build/qemu/qemu-img amend -o compat=v3 overlay1.qcow2

This particular amend is not changing the backing file, and since I did 
not add warnings on the opening of an existing unsafe image, it is 
silent.  Instead, you need to test a case where amend provokes a path 
that would change the backing file (perhaps as simple as '-o 
backing_file=./base.raw'), while omitting a format for the new backing 
file string.

> 
>      $> echo $?
>      0
> 
> I'm just trying to work out the scenarios where the warnings ought to
> show up (for all the four cases: create, rebase, convert, amend).

Look at patch 2/4 - that patch was written AFTER this patch in order to 
silence every warning that was introduced because of this patch, then 
rebased to occur first.  My experience in writing 2/4 was that I indeed 
hit warnings through all four sub-commands.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


