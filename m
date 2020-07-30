Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E6DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E37D20829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hql32FEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E37D20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1BCe-0008Hn-Q2
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1BAW-0005eW-Is
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:12:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k1BAU-0000Sj-Tk
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596125550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kt+cVZrDw/cNhpH4pnKRPY1blBqWKVR4xMS6GodBcCI=;
 b=hql32FEGj8us4mREpUVFxCNA01fg55+HD8HUp5v2LoBHXI4scqMLzt2KcoFSGrREg9lBPg
 H1GJlIoJLYT4mqlmeAFNwWmuCehXiA135QHSXbkJnrD3q/Sxq0JY3cnSlyQpFAickw2xL3
 wCuLU8hJlhs7wQtepkUZpj5N2a02zZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-sk6h-_U2N-mc-CQY9o6niw-1; Thu, 30 Jul 2020 12:12:28 -0400
X-MC-Unique: sk6h-_U2N-mc-CQY9o6niw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AD14100A614;
 Thu, 30 Jul 2020 16:12:27 +0000 (UTC)
Received: from [10.3.114.255] (ovpn-114-255.phx2.redhat.com [10.3.114.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF76F6932B;
 Thu, 30 Jul 2020 16:12:13 +0000 (UTC)
Subject: Re: [PATCH V1 03/32] savevm: QMP command for cprsave
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-4-git-send-email-steven.sistare@oracle.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6aefdd56-b8fe-358b-6699-3f82a7fa8b1a@redhat.com>
Date: Thu, 30 Jul 2020 11:12:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596122076-341293-4-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 10:14 AM, Steve Sistare wrote:
> To enable live reboot, provide the cprsave QMP command and the VMS_REBOOT
> vmstate-saving operation, which saves the state of the virtual machine in a
> simple file.
> 
> Syntax:
>    {'command':'cprsave', 'data':{'file':'str', 'mode':'str'}}
> 
>    The mode argument must be 'reboot'.  Additional modes will be defined in
>    the future.
> 

Focusing on just the UI:

> +++ b/qapi/migration.json
> @@ -1621,3 +1621,17 @@
>   ##
>   { 'event': 'UNPLUG_PRIMARY',
>     'data': { 'device-id': 'str' } }
> +
> +##
> +# @cprsave:
> +#
> +# Create a checkpoint of the virtual machine device state in @file.
> +# Guest RAM and guest block device blocks are not saved.
> +#
> +# @file: name of checkpoint file

Since you used qemu_open() in the code, this can include a 
'/dev/fdset/NNN' magic name for saving into a previously-passed-in file 
descriptor instead of directly opening a local file name.  That's a good 
thing, but I don't know if it needs explicit mention in the docs.

> +# @mode: 'reboot' : checkpoint can be cprload'ed after a host kexec reboot.
> +#
> +# Since 5.0

5.2 (you've missed 5.0 by a long shot, and even 5.1 is too late now).

> +##
> +{ 'command': 'cprsave', 'data': { 'file': 'str', 'mode': 'str' } }

'mode' should be an enum type, rather than an open-coded string:

{ 'enum': 'CprMode', 'data': ['reboot'] }
{ 'command': 'cprsave', 'data': {'file': 'str', 'mode': 'CprMode' } }

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


