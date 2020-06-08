Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82D4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5EA2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCCg8AUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5EA2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJd5-0002m8-0K
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiJcO-0002M2-85
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:23:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiJcN-0008MJ-7W
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 11:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591629798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=21O95eMTdCDH7miL/Fc0q5iL2TEP4u+kEzbsBCFwYA8=;
 b=VCCg8AUqqYKFqU/K8Ri2mnf3JJC7GBlduOAPiJgrsHTxuL3/x/hzbRACwPrCC6k8m19jGl
 zzRoqqEA51O4bJL/pENT4LwvWvqay6dHFiX3Wjc9PLBdRnJYcWcnfi/qYTmSbI8P+lfhIB
 XFoesQkEoRYSHiT+LZd/UyJI3X53Pfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-DYrmtQXVNJKmPuw9kdZdhA-1; Mon, 08 Jun 2020 11:23:12 -0400
X-MC-Unique: DYrmtQXVNJKmPuw9kdZdhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C34ACA0C06;
 Mon,  8 Jun 2020 15:23:11 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77636648DB;
 Mon,  8 Jun 2020 15:23:11 +0000 (UTC)
Subject: Re: [Bug 1882350] [NEW] it always create sdx device when I configure
 ide device with hdx name
To: Bug 1882350 <1882350@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <159144063074.3735.15991486640962003601.malonedeb@soybean.canonical.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c04b7074-85f5-d0c7-818c-69019d513192@redhat.com>
Date: Mon, 8 Jun 2020 10:23:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159144063074.3735.15991486640962003601.malonedeb@soybean.canonical.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/20 5:50 AM, marshell wrote:
> Public bug reported:
> 
> I have configured 2 ide disks with name starting with hd, but when the
> vm boots up, it shows disks whose name starting with sd.

This looks more like a libvirt question than a qemu one.

> 
> 1. ide disks in vm xml:
> 
>      <disk type='file' device='disk'>
>        <driver name='qemu' type='raw'/>
>        <source file='/data3_raw.qcow2'/>
>        <target dev='hdc' bus='ide'/>
>      </disk>
>      <disk type='file' device='disk'>
>        <driver name='qemu' type='qcow2'/>
>        <source file='/data2.qcow2'/>
>        <target dev='hdb' bus='ide'/>
>      </disk>

The name that libvirt chooses to identify disks from the host 
perspective is independent...

> 
> 
> 2. in VM:
> 
> sda            8:0    0    2G  0 disk
> sdb            8:16   0    1G  0 disk

...from what the guest OS chooses to use.  Although there are many 
situations where a Linux guest will pick the same names as libvirt chose 
on the host side based on the transport (such as SCSI or virtio), there 
is no guarantee that this is always the case, nor that your guest is 
always running Linux as its OS.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


