Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55480C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24123214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 17:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOpxAOxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24123214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irm9m-0000mz-9J
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 12:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irm8v-00087Q-CG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irm8u-0002ld-4s
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:07:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irm8u-0002lW-1g
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 12:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579108063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dO7wnpMCGwzlSeew0BxHPdU1KB8zB+amZi4fqdOTeRk=;
 b=KOpxAOxIyth106zByu0KHpCbX2BmF3EVbaUh8KXb9JvOXUGuqwlovqH23p+61ifSH8QSCJ
 Ysgdd87DYzhPJnFt84uLPmK9viRlNaGKEJinOZNEA+wQT/FdMZspQmVdFK6XEsRGeE9JP4
 SxUQ2P9Esg78UbKILEzTmoO+anpuL9M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-xCPBRYOHPe2GTIC62jhRqA-1; Wed, 15 Jan 2020 12:07:42 -0500
Received: by mail-wm1-f70.google.com with SMTP id 7so93781wmf.9
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 09:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bYD7jgIlCqamDnccIAOWMNutaPuNMDEMGvJtCtaEwYY=;
 b=QsR9nfuzM9gq0/X2UKdLaktCbfLdhn2oV4vb0qsc8IiR/o3V83lMHoZ/hNjJ99E24P
 8EH25RJdUcS2s+5Nx5iK9aBbdmDgW8bnFAlGJPoF6JmijAZin7FO8/hqSF29pjreAzwV
 j1eaSCYWznPOS+4YLdsGaQlCx2p80St7F9hzc/l97fMSlsHO5RW5cyq0RNpJZuDvi6LV
 E1AgPilD8iuOz6Mpy007fXaDYWwSyITUKFR1LIvGkaBZIHSlgYFJxzmMQdAhazOleawg
 Gc7a4I6szB6uJF5MWSqW5OdVtffUBFRcI8EIDhngGMxjxskasoICOEceUcgl0gm8AlEa
 nodg==
X-Gm-Message-State: APjAAAXZoVpi7i+S9eFV/BcFZbdp2fYmcYgOXFdPfauufGg4J8Fu38/+
 Eb6UViokx4QAC/tkYQNI2Ee8Atimpd22WuNGvCPKHoeSmRWVnwBTjXmw6xSa67CiNPUxVPQyDiW
 Bvew0jw2J9QNDsm8=
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr33868173wrs.276.1579108061445; 
 Wed, 15 Jan 2020 09:07:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyt2zKcPjMkVRBT4HM4VMe778T3mAw9pC4rph/xvjVSwLemk1fnnahmivhC2dWE28u47Db4EA==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr33868151wrs.276.1579108061237; 
 Wed, 15 Jan 2020 09:07:41 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id l7sm25681482wrq.61.2020.01.15.09.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 09:07:40 -0800 (PST)
Subject: Re: [PATCH 055/104] virtiofsd: fix libfuse information leaks
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-56-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0f69156f-8950-c4bd-5bc7-613e121a206b@redhat.com>
Date: Wed, 15 Jan 2020 18:07:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-56-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: xCPBRYOHPe2GTIC62jhRqA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 12/12/19 5:38 PM, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Some FUSE message replies contain padding fields that are not
> initialized by libfuse.  This is fine in traditional FUSE applications
> because the kernel is trusted.  virtiofsd does not trust the guest and
> must not expose uninitialized memory.
>=20
> Use C struct initializers to automatically zero out memory.  Not all of
> these code changes are strictly necessary but they will prevent future
> information leaks if the structs are extended.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tools/virtiofsd/fuse_lowlevel.c | 150 ++++++++++++++++----------------
>   1 file changed, 76 insertions(+), 74 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


