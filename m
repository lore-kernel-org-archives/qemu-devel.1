Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18732C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0DB214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="br5ioMz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0DB214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmKx-0000DR-SX
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTmJa-0007Kj-DJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTmJZ-0006Q2-QZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:59:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29229
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTmJZ-0006Pf-BZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 08:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588165188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pqyfKPHJzI8RTEq3EP/RCf8DZ0KItBlO1ppxMbKyypE=;
 b=br5ioMz7MD0fazkoa9CPp95EAmz3FJrE3lq7rGD6DhUvUl0VE2uBvmRnT4J1cyjvYopcPE
 nNUwni8iytHtrieqefN6sS/OnRZv8RRqdlgMMbg0advsKfX+l8lcV9SXt3Yzmj7i2nJjZ3
 4nLN3QdzT1AtEHMeWaBLMdasOvMnyaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-cvfLs9v3O-C383YYu8EkBw-1; Wed, 29 Apr 2020 08:59:44 -0400
X-MC-Unique: cvfLs9v3O-C383YYu8EkBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B359107ACCA;
 Wed, 29 Apr 2020 12:59:43 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A6AC600E5;
 Wed, 29 Apr 2020 12:59:42 +0000 (UTC)
Subject: Re: [PATCH v3] audio/jack: add JACK client audiodev
To: Geoffrey McRae <geoff@hostfission.com>, qemu-devel@nongnu.org
References: <20200429073149.6A1953C0D11@aeryn.lan.ktmba>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ad3a2a08-1995-62cb-edf6-b8f25e78b121@redhat.com>
Date: Wed, 29 Apr 2020 07:59:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429073149.6A1953C0D11@aeryn.lan.ktmba>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 12:53 AM, Geoffrey McRae wrote:
> This commit adds a new audiodev backend to allow QEMU to use JACK as
> both an audio sink and source.
> 
> Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
> ---
>   audio/Makefile.objs    |   5 +
>   audio/audio.c          |   1 +
>   audio/audio_template.h |   2 +
>   audio/jackaudio.c      | 615 +++++++++++++++++++++++++++++++++++++++++
>   configure              |  17 ++
>   qapi/audio.json        |  50 +++-

Focusing just on UI:

> +++ b/qapi/audio.json
> @@ -152,6 +152,51 @@
>       '*out':     'AudiodevPerDirectionOptions',
>       '*latency': 'uint32' } }
>   
> +##
> +# @AudiodevJackPerDirectionOptions:
> +#
> +# Options of the JACK backend that are used for both playback and
> +# recording.
> +#
> +# @server_name: select from among several possible concurrent server instances.
> +# If unspecified, use "default" unless $JACK_DEFAULT_SERVER is defined in the
> +# process environment.

Our convention is to prefer '-' over '_' except in cases of pre-existing 
consistency.  This should be 'server-name' unless you have an example of 
what we have to be consistent with.

> +#
> +# @client_name: the client name to use. The server will modify this name to
> +# create a unique variant, if needed unless @exact_name is true.
> +#
> +# @start_server: set to true to start a jack server instance if one is not
> +# present.
> +#
> +# @exact_name: use the exact name requested otherwise JACK automatically
> +# generates a unique one, if needed.

Ditto for these three.

> +#
> +# Since: 4.0

The earliest this will be added is 5.1, not 4.0.

> +##
> +{ 'struct': 'AudiodevJackPerDirectionOptions',
> +  'base': 'AudiodevPerDirectionOptions',
> +  'data': {
> +    '*server_name':  'str',
> +    '*client_name':  'str',
> +    '*start_server': 'bool',
> +    '*exact_name':   'bool' } }
> +
> +##
> +# @AudiodevJackOptions:
> +#
> +# Options of the JACK audio backend.
> +#
> +# @in: options of the capture stream
> +#
> +# @out: options of the playback stream
> +#
> +# Since: 4.0

5.1

> +##
> +{ 'struct': 'AudiodevJackOptions',
> +  'data': {
> +    '*in':  'AudiodevJackPerDirectionOptions',
> +    '*out': 'AudiodevJackPerDirectionOptions' } }
> +
>   ##
>   # @AudiodevOssPerDirectionOptions:
>   #
> @@ -300,8 +345,8 @@
>   # Since: 4.0
>   ##
>   { 'enum': 'AudiodevDriver',
> -  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'oss', 'pa', 'sdl',
> -            'spice', 'wav' ] }
> +  'data': [ 'none', 'alsa', 'coreaudio', 'dsound', 'jack', 'oss', 'pa',
> +            'sdl', 'spice', 'wav' ] }

It's worth adding a doc comment that @jack was added in 5.1 (I didn't 
check if audio.json has an example of adding to an enum, but other .json 
files do)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


