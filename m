Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E0EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F412071C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 18:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E24LmVR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F412071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdI7p-0007Zu-Ho
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 14:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdI6B-00061V-U7
 for qemu-devel@nongnu.org; Mon, 25 May 2020 14:45:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdI6A-0006i8-8A
 for qemu-devel@nongnu.org; Mon, 25 May 2020 14:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590432316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ytrg520e6eklZFYtgqmgKnt9UsQwIoyQ9w/FsDgqMMI=;
 b=E24LmVR0oB+xlZCFS7SV1ouf8YbApD2ug48Gn9E/6sAtowexJ4zS7B2IBsULMrpFnaejzJ
 mOjnJhoEcYU+PJXfwzZhNyQIdexXw84JJcC7W/lNWofXdwJcHIys0Dbmve9nF4XMRgJ2De
 1Xxfp3hA1Dw7vec0kb/LsdEkiIW0SMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-pvxF2sSBMNeof8nV_9t3Tg-1; Mon, 25 May 2020 14:45:13 -0400
X-MC-Unique: pvxF2sSBMNeof8nV_9t3Tg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B6F7800688;
 Mon, 25 May 2020 18:45:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-92.ams2.redhat.com [10.36.112.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39F4E7D964;
 Mon, 25 May 2020 18:45:07 +0000 (UTC)
Subject: Re: -nic model=rocker causes qemu to abort
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <eafa7c11-b3af-2247-ddb3-538891ad0732@msgid.tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1f540f9c-45f3-d02e-a087-d1059d7a8977@redhat.com>
Date: Mon, 25 May 2020 20:45:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eafa7c11-b3af-2247-ddb3-538891ad0732@msgid.tls.msk.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:28:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/04/2020 18.43, Michael Tokarev wrote:
> Hi!
> 
> Just a fun case of (invalid) usage of qemu-system command line.
> Someone tried -nic model=rocker, and qemu does this:
> 
>  Unexpected error in object_property_find() at /build/qemu/git/qom/object.c:1029:
>  qemu-system-x86_64: Property '.mac' not found
>  Aborted
> 
> This happens after this commit:
> 
> commit 52310c3fa7dc854dd2376ae8a518141abcdb78f3
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Fri Mar 2 10:30:50 2018 +0100
> 
>     net: allow using any PCI NICs in -net or -nic
> 
> 
> Previously rocker rightly wasn't usable as a nic model,
> and after this commit it is now possible.
> 
> While I agree this is invalid usage, perhaps qemu should not
> abort like this?  Maybe it should check the required property
> too, before allowing this device to be a nic model?

QEMU theoretically should never abort() - abort() means there is
something wrong in the code ... so we should definitely fix this by
other means. Some questions:

1) How is that rocker device normally used? Similar to a normal network
card? Or completely different?

2) In case it is similar to a normal network card, would it make sense
to allow it with -nic or -net, too? Or should we simply disallow it
here? I think we could either use a list of devices that should never be
allowed here, or we check for the availability of that "mac" property...

 Thomas


