Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFA3C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4299C2076A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OW6mgHXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4299C2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjvp-0001Ad-F8
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 11:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOjun-0008LE-7D
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOjul-0003dn-AY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:25:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35513
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOjul-0003dc-5d
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586964322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EG/kL3pX3zkhGghvOLmjrJacJm2KlCLgA1d1KqAqM54=;
 b=OW6mgHXSVr755XSmAsEXKUN3coXDQqVyZJvt1zM8wHMloGk3/uYmRfhUOzqtRdMZ152wb+
 z6JKn9SmIOV/YYRaPSVTS4pBlOsi4lZwGOdqXwGXK4pITJoutQhSCK8HdLJktqB89Yrk1M
 0g3bt5PapYBY/BpQBYaER5Jl5TaoH9Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-IWzWEPFTPTKeYeJ1DNShGA-1; Wed, 15 Apr 2020 11:25:16 -0400
X-MC-Unique: IWzWEPFTPTKeYeJ1DNShGA-1
Received: by mail-ed1-f72.google.com with SMTP id z25so3254003edx.8
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 08:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aKW9pYoT2HEX35rsEZKjwIHSLHxB4kZclx2VH0kJPfA=;
 b=N5akdZOB5tk28kbCTNEnk9Q9llE+wK29E+XTUO7gQtm+G44psxp53hZzexGXw2+gmO
 l9ekO9bjkYRYtTB7XGp/OdtsGADTrA8sY2r5Bcv5C6DxdhNmj1zLltHuN7FAByh9k0+V
 1nCwcAgNmBrhdniOZBT3xqFnDesePxr1fiCu+xoi9t/dGM2rMYBjR0ENOvPf+2n9NqRp
 dDcdd+yDYhm2LNPXsP6eoHo7BS9ZTzuR95KvNIBjPx8fDkoVXU5N0RKaDxrXMXdaAKdF
 jsXJRvSCW+c47in6SnC0Kq9o4F885HqtkdsS7LDEEO0cmaxmYQH6Sg+sTIpsQ14k4FRq
 2J0Q==
X-Gm-Message-State: AGi0PuaFcxT5fCoXqMwyoZiAaqObyAmyahSTJknRI5CQ+U26ikJp1nRv
 9SyGyX1amDDcZpOSzLgQ3hS8ct8ptgOqBQoApwpWq1oRT/ENran2hMQhOIr5W+l3Bxk0UlF3oK0
 3tcBvGBBDb9cCS0U=
X-Received: by 2002:a17:906:4353:: with SMTP id
 z19mr5544620ejm.363.1586964315378; 
 Wed, 15 Apr 2020 08:25:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypLjFMMwzWUEhFpvDtDfGMomcMJgCQ9q+HsGp3NYlVH3A0R9taTN/MIQy/S5nVyqXxt/wbp2Hg==
X-Received: by 2002:a17:906:4353:: with SMTP id
 z19mr5544598ejm.363.1586964315127; 
 Wed, 15 Apr 2020 08:25:15 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id p20sm2227569edw.31.2020.04.15.08.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 08:25:14 -0700 (PDT)
Subject: Re: [PULL for-5.0 4/4] qga: Restrict guest-file-read count to 48 MB
 to avoid crashes
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200415152202.14463-1-mdroth@linux.vnet.ibm.com>
 <20200415152202.14463-5-mdroth@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d29b5190-f872-668e-cb81-abcfaf5e1db4@redhat.com>
Date: Wed, 15 Apr 2020 17:25:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415152202.14463-5-mdroth@linux.vnet.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 5:22 PM, Michael Roth wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> On [*] Daniel Berrang=C3=A9 commented:
>=20
>    The QEMU guest agent protocol is not sensible way to access huge
>    files inside the guest. It requires the inefficient process of
>    reading the entire data into memory than duplicating it again in
>    base64 format, and then copying it again in the JSON serializer /
>    monitor code.
>=20
>    For arbitrary general purpose file access, especially for large
>    files, use a real file transfer program or use a network block
>    device, not the QEMU guest agent.
>=20
> To avoid bug reports as BZ#1594054 (CVE-2018-12617), follow his
> suggestion to put a low, hard limit on "count" in the guest agent
> QAPI schema, and don't allow count to be larger than 48 MB.
>=20
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg693176.html
>=20
> Fixes: CVE-2018-12617
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> *update schema documentation to indicate 48MB limit instead of 10MB

Thanks!

> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>   qga/commands.c       | 9 ++++++++-
>   qga/qapi-schema.json | 6 ++++--
>   2 files changed, 12 insertions(+), 3 deletions(-)


