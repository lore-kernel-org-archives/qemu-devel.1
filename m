Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4010C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8416820684
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTplKp3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8416820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZzdh-0002xm-NB
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 10:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iZzZf-00079H-FX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iZzZe-00021k-E1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:49:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iZzZd-00020E-1y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574869786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZU/Lmuf1xn104Hv3dmrD8rRF/mxKgsJe4KE2bYLLPc=;
 b=hTplKp3sHCapPFPOi/htjDflpvP5YU7W8vn0vniQPW+vU2kohcbbcHFP1dCl36Zxbggky4
 wOGrUFGmy/uOC7WWyc8HC3/Fz8elJ1jTjRKkfGZC/VYtMC7cEGHjZkG3w8UKpl7WbhwWeC
 L4TkgQubCFLEjhBvs2CWEG5eT3G8OLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-EYhmuvHVMqydXvij6u-ouA-1; Wed, 27 Nov 2019 10:49:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8201412D65AA;
 Wed, 27 Nov 2019 15:49:42 +0000 (UTC)
Received: from [10.3.116.163] (ovpn-116-163.phx2.redhat.com [10.3.116.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDAFB19C69;
 Wed, 27 Nov 2019 15:49:41 +0000 (UTC)
Subject: Re: QMP netdev_add multiple dnssearch values
To: Markus Armbruster <armbru@redhat.com>,
 Alex Kirillov <lekiravi@yandex-team.ru>
References: <713881571320392@iva8-147456c4bd40.qloud-c.yandex.net>
 <87d0elmmdt.fsf@dusky.pond.sub.org>
 <2137591572344429@sas1-eb34c5849710.qloud-c.yandex.net>
 <87zhgha1lt.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d1f5421a-8a94-2869-4c96-24485cd17afd@redhat.com>
Date: Wed, 27 Nov 2019 09:49:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87zhgha1lt.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: EYhmuvHVMqydXvij6u-ouA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/27/19 7:30 AM, Markus Armbruster wrote:

> "Good enough" was true back then.  It wasn't true when we reused it for
> netdev_add: hostfwd and guestfwd are list-valued.
> 
> We did define a QAPI schema a few months later (14aa0c2de0 "qapi schema:
> add Netdev types").  net_client_init() uses it to convert from QemuOpts
> to QAPI type Netdev.  This took us to the crazy pipeline we still use
> today:
> 
>                              CLI, HMP
>                          (key=value,...)
>                                 |
>                                 v
>      QMP (JSON) -> QDict -> QemuOpts -> Netdev
> 
> We should instead use:
> 
>                            CLI, HMP
>                        (key=value,...)
>                               |
>                               v
>                            QemuOpts
>                               |
>                               v
>      QMP (JSON) -> QDict -> Netdev
> 
> Back in 2016, Eric (cc'ed) posted patches to get us to this pipeline.
> They got stuck on backward compatibility worries: the old code accepts
> all parameters as JSON strings in addition to their proper type, the new
> code doesn't.  Undocumented misfeature, but we chickened out anyway.

That was before we had a deprecation process.  Now we do.  If we are 
still worried about it, then we should start the deprecation clock 
(squeezing it into 4.2-rc3 is risky, more likely is starting it in 5.0, 
so that we get rid of string support in 5.2).  If we are not worried 
about it, then we can just kill the misfeature in 5.0.

> 
> Let's reconsider.  Eric's patches break interface misuse that may or may
> not exist in the field.  They fix a correct use of interface people want
> to use (or Alex wouldn't have reported this bug), and they make QMP
> introspection work for netdev_add.
> 
> Eric, what do you think?

Yes, it's time to revive that work (I have no idea if my patches from 
back then will still rebase nicely, though).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


