Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A9C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226A62064C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPIMjfTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226A62064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4JP-0005j8-8p
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jT4IN-0004ua-E2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jT4IJ-0003kk-Oa
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:59:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38357
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jT4IJ-0003k4-AX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 09:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587995974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aigOB1XshybXPidiZrIUJLBx2OoC+5MOoSC7sqj57V8=;
 b=OPIMjfTq9Yt6hr16tHRafdrcjw/cfQz+XqPS3htGc4DD+TSZpfZqurcYNY296vhGGP2suz
 0+1TsDTBthBKuB+E6xgRimSkNmzDjbRSqKLNNbpogbuvNMU3fhs1/pF3+sLHheXf4v6pf9
 VKFMuRJBJqgUjhNFGLC5RmM7tAUUrnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-0vGeAQNtMFW7LSbNw_oDtA-1; Mon, 27 Apr 2020 09:59:27 -0400
X-MC-Unique: 0vGeAQNtMFW7LSbNw_oDtA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10231800D24
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 13:59:27 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DE095C1D4;
 Mon, 27 Apr 2020 13:59:26 +0000 (UTC)
Subject: Re: [PATCH 06/11] error: Use error_reportf_err() where appropriate
To: Markus Armbruster <armbru@redhat.com>
References: <20200424192027.11404-1-armbru@redhat.com>
 <20200424192027.11404-7-armbru@redhat.com>
 <44cf6721-88fa-acd3-b051-43e81b37506a@redhat.com>
 <87o8rdia2o.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b1d0b937-bdb6-e24f-7ecc-35a00a5c0252@redhat.com>
Date: Mon, 27 Apr 2020 08:59:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87o8rdia2o.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 01:12:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 3:53 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 

>> Although it touches NBD, I'm happy for this to go through your tree
>> with the larger series.
>>
>>> +++ b/qemu-nbd.c
>>> @@ -856,8 +856,7 @@ int main(int argc, char **argv)
>>>            }
>>>            tlscreds = nbd_get_tls_creds(tlscredsid, list, &local_err);
>>>            if (local_err) {
>>> -            error_report("Failed to get TLS creds %s",
>>> -                         error_get_pretty(local_err));
>>> +            error_reportf_err(local_err, "Failed to get TLS creds ");
>>
>> Odd one out for not using ':' in the message, but that's independent
>> of this patch.
> 
> The patch is short enough to deviate from "purely mechanical" and stick
> in ':' here.  Your choice.

Adding it in now is fine by me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


