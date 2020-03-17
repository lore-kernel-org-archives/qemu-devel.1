Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B728EC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82230206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJpcrp17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82230206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDPD-0007WY-M9
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEDOC-0006UW-KK
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEDOB-0000oE-8u
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:40:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37563)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEDOB-0000jp-3F
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584456014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBEcqXjfhNcJf9LeWO9VtenTKBK/Yti2iUo1Fo0vhfM=;
 b=aJpcrp175k0/uqSKJ06/c4Xu/1g0EEHCiiWooYFLq2Ik+5moMemscPKs6QS0ihMvB1Ahx+
 B92OEWgVqaAgcUAHnPayhPYL1dL2JIiE8p6vmf7fiMBwl/h5OAVGuSAFfTOKv3foWHzG3q
 FiljFDEdXX7Q3O9lOzvXF+ZYPrnVTlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-xLJvM9g3MXG0YrhZyOOZGA-1; Tue, 17 Mar 2020 10:40:09 -0400
X-MC-Unique: xLJvM9g3MXG0YrhZyOOZGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A363D107ACC9;
 Tue, 17 Mar 2020 14:40:07 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DECD77E317;
 Tue, 17 Mar 2020 14:40:00 +0000 (UTC)
Subject: Re: [PULL 00/10] Bitmaps patches
To: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
References: <20200317043819.20197-1-jsnow@redhat.com>
 <CAFEAcA_=DHpNZ+b9Hrim39R74Jik8MKqu8MPJm80wMsQS0FADQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5805273e-0a2f-850a-a07a-97dac0d7211e@redhat.com>
Date: Tue, 17 Mar 2020 09:40:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_=DHpNZ+b9Hrim39R74Jik8MKqu8MPJm80wMsQS0FADQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Libvirt <libvir-list@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 9:00 AM, Peter Maydell wrote:
> On Tue, 17 Mar 2020 at 04:38, John Snow <jsnow@redhat.com> wrote:

>>
>>    block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty (2020-03-12 16:36:46 -0400)
>>
>> ----------------------------------------------------------------
>> Pull request
>>
>> ---------------------------------------------------------------
> 
> Hi; this fails to compile with clang:
> 
> /home/petmay01/linaro/qemu-for-merges/nbd/server.c:1937:1: error:
> unused function 'glib_listautoptr_cleanup_NBDExtentArray'
> [-Werror,-Wunused-function]
> G_DEFINE_AUTOPTR_CLEANUP_FUNC(NBDExtentArray, nbd_extent_array_free);
> ^
> /usr/include/glib-2.0/glib/gmacros.h:462:22: note: expanded from macro
> 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
>    static inline void _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName) (GList
> **_l) { g_list_free_full (*_l, (GDestroyNotify) func); } \
>                       ^
> /usr/include/glib-2.0/glib/gmacros.h:443:48: note: expanded from macro
> '_GLIB_AUTOPTR_LIST_FUNC_NAME'
> #define _GLIB_AUTOPTR_LIST_FUNC_NAME(TypeName)
> glib_listautoptr_cleanup_##TypeName
>                                                 ^
> <scratch space>:49:1: note: expanded from here
> glib_listautoptr_cleanup_NBDExtentArray
> ^

Should we add -Wno-unused-function to CFLAGS when dealing with a version 
of clang that complains about that version of glib's headers?  Is it 
fixed in a newer version of glib, where we could just backport a newer 
definition of G_DEFINE_AUTOPTR_CLEANUP_FUNC() that adds whatever 
annotations are needed to shut the compiler up?

On IRC, danpb pointed me to libvirt's solution:
https://libvirt.org/git/?p=libvirt.git;a=commit;h=44e7f029

Maybe we just write our own macro wrapper around 
G_DEFINE_AUTOPTR_CLEANUP_FUNC which takes care of adding necessary 
annotations and use that instead (and our macro name might be shorter...)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


