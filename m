Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42AAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA19207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBLG44Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA19207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmzj-0000HE-MQ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbmz6-0008Co-B9
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:19:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48806
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jbmz5-0001dl-12
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590074386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Caex46Z0ZZLxMcmRuahpYp2sck4ebNlHBl4o3nBLhn4=;
 b=QBLG44PtaurZGZlzubp6Rw936GGjwRWTJ/mohro94i5eVq/itFA5a7tM5zsNE1T0Y7X9kS
 km7QcEA1/UvLvttgNbml7Ik54bNk+gGpx1wCc4mKQfPXSgCjF1Nrjw60HN0lmC0Z39B0D4
 UBp1A6iZNTsWFBhSZI5YpWMGaSgUy0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-2SBNLGpTMGaJ70cg4RP2Rw-1; Thu, 21 May 2020 11:19:42 -0400
X-MC-Unique: 2SBNLGpTMGaJ70cg4RP2Rw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 537F7835B40;
 Thu, 21 May 2020 15:19:41 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE2DE5D9C9;
 Thu, 21 May 2020 15:19:40 +0000 (UTC)
Subject: Re: [PATCH v5 4/5] qemu-img: Add convert --bitmaps option
To: Nir Soffer <nsoffer@redhat.com>
References: <20200520220118.1037094-1-eblake@redhat.com>
 <20200520220118.1037094-5-eblake@redhat.com>
 <CAMRbyyvYifirLrb6kTej6mUPBnhr8rsFOx-QeMGDrWG=Zi4i0Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3de9e06c-27e6-c852-8556-1b1415e1b272@redhat.com>
Date: Thu, 21 May 2020 10:19:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyyvYifirLrb6kTej6mUPBnhr8rsFOx-QeMGDrWG=Zi4i0Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 10:11 AM, Nir Soffer wrote:
> On Thu, May 21, 2020 at 1:01 AM Eric Blake <eblake@redhat.com> wrote:
>>
>> Make it easier to copy all the persistent bitmaps of (the top layer
>> of) a source image along with its guest-visible contents, by adding a
>> boolean flag for use with qemu-img convert.  This is basically
>> shorthand, as the same effect could be accomplished with a series of
>> 'qemu-img bitmap --add' and 'qemu-img bitmap --merge -b source'
>> commands, or by QMP commands.
>>
>> Note that this command will fail in the same scenarios where 'qemu-img
>> measure --bitmaps' fails, when either the source or the destanation

destination

>> lacks persistent bitmap support altogether.
> 
> If we remove --bitmaps option from qemu-img measure, we need to remove
> this note.

Or rather, adjust it to state that "this command will fail in the 
scenarios where 'qemu-img measure' omits a 'bitmaps size:' output line.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


