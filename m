Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6277AC7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EAEC20725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pj5JPP5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAEC20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3f8U-0000hR-Dw
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 07:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j3f7s-00008t-Qu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j3f7r-0006wV-KA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:03:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59723
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j3f7r-0006w2-Gw
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581941026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giCEDhSz1G1PbpafeQ5wa64q1X9yZJf0yhz8C3LBMRA=;
 b=Pj5JPP5Gj1mg4PXS1XkVQLZIGfZx82j1I9EE5MEMOc4py/dfdSAv6BSgdwJMoKJddtnyLZ
 vX3OzW6n1YYmPi5sCdFoTdbHdnrqH9lr+AuKjHe8R0B9VUgCNea9Fny4lAfD8lRuipq1df
 tn6ZKvwv5peZu8QUeDewim+eb29IA80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-6zMDMjGaNpKtYJmpnsuxLA-1; Mon, 17 Feb 2020 07:03:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDC82108442C;
 Mon, 17 Feb 2020 12:03:41 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4487119488;
 Mon, 17 Feb 2020 12:03:41 +0000 (UTC)
Subject: Re: [GEDI] [PATCH 07/17] gluster: Drop useless has_zero_init callback
To: Niels de Vos <ndevos@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-8-eblake@redhat.com>
 <20200217080614.GG239686@ndevos-x270.lan.nixpanic.net>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <457280bf-58da-404d-7ac1-edf1531623c9@redhat.com>
Date: Mon, 17 Feb 2020 06:03:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217080614.GG239686@ndevos-x270.lan.nixpanic.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 6zMDMjGaNpKtYJmpnsuxLA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:GLUSTER" <integration@gluster.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, david.edmondson@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 2:06 AM, Niels de Vos wrote:
> On Fri, Jan 31, 2020 at 11:44:26AM -0600, Eric Blake wrote:
>> block.c already defaults to 0 if we don't provide a callback; there's
>> no need to write a callback that always fails.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> Reviewed-by: Niels de Vos <ndevos@redhat.com>
> 

Per your other message,

On 2/17/20 2:16 AM, Niels de Vos wrote:
 > On Fri, Jan 31, 2020 at 11:44:31AM -0600, Eric Blake wrote:
 >> Since gluster already copies file-posix for lseek usage in block
 >> status, it also makes sense to copy it for learning if the image
 >> currently reads as all zeroes.
 >>

 >> +static int qemu_gluster_known_zeroes(BlockDriverState *bs)
 >> +{
 >> +    /*
 >> +     * GlusterFS volume could be backed by a block device, with no way
 >
 > Actually, Gluster dropped support for volumes backed by block devices
 > (LVM) a few releases back. Nobody could be found that used it, and it
 > could not be combined with other Gluster features. All contents on a
 > Gluster volume is now always backed by 'normal' files on a filesystem.

That's useful to know.  Thanks!

 >
 > Creation or truncation should behave just as on a file on a local
 > filesystem. So maybe qemu_gluster_known_zeroes is not needed at all?

Which version of gluster first required a regular filesystem backing for 
all gluster files?  Does qemu support older versions (in which case, 
what is the correct version-probing invocation to return 0 prior to that 
point, and 1 after), or do all versions supported by qemu already 
guarantee zero initialization on creation or widening truncation by 
virtue of POSIX file semantics (in which case, patch 7 should instead 
switch to using .bdrv_has_zero_init_1 for both functions)?  Per 
configure, we probe for glusterfs_xlator_opt from gluster 4, which 
implies the code still tries to be portable to even older gluster, but 
I'm not sure if this squares with qemu-doc.texi which mentions our 
minimum distro policy (for example, now that qemu requires python 3 
consistent with our distro policy, that rules out several older systems 
where older gluster was likely to be present).

I'm respinning the series for other reasons, but would like to get this 
right as part of that respin.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


