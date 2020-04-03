Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70217C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 20:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389B3206F6
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 20:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2PzJ/TW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389B3206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKTNb-0003Yg-BT
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 16:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKTLs-00035I-IF
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 16:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKTLp-0005Sb-Ne
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 16:55:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKTLp-0005P4-Du
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 16:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585947340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oS3xyQ7zLxTHoHn9YcWNVnliigynbar24G9Z1YUsETw=;
 b=X2PzJ/TWGfPTOSfpyhgofE/O4VnLTvdUUBWeqVOpmNL1sSVzw+8vs+HtXG1LdOvlZDCV7x
 U1W1SJwVQ979IAZPmKgrLL5OTIT4xyleLXcL9ijXYO3EhYQ6547soKHU1xpRapWcz4u4DC
 igb525QN2SGVrzwFsC7tKX6OJVH56Bs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-rm8yBUZ0P36Qvaq3-KjyxQ-1; Fri, 03 Apr 2020 16:55:39 -0400
X-MC-Unique: rm8yBUZ0P36Qvaq3-KjyxQ-1
Received: by mail-wr1-f71.google.com with SMTP id 88so1044879wrq.4
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 13:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nRFtehB20Ey0QXmW52crkJQ3bG+D7LP1F1/RJK+TPqQ=;
 b=dClK0UIEGcYt8c20ybAaKwcWHnDC1rbHdIFZNlPAyWau/Dzho1ZYCH/7SYMiDFy/nj
 xPTCFZGOoW+KlycVS0NVCK6wlhGJvczThGAeET3/rwaYJF6WoPwUn4AqcLPpN79qH/I8
 7N5cqwM5BBF4Kj43NBd74kimevTz6hnmLj/NZxKx1L6n+NxySnVZOY9FQNmL49QodG3N
 K05RQ6vAB2RoiiuHojIOTkqimfzZhOr/T/vHd8te6z4NN6kHX9JXX223VuEC12uPiN23
 Dk5vPTa9StRRdh5y4ldOo6eAoteN9zs9vY7tk97pJyeN4YfSBIrL4sh2hcnpVTZ/D3ZL
 PfUA==
X-Gm-Message-State: AGi0PubQyaAgwF1EOJ9OBu30iwSxvXMTn5CFwD3xdnU2suvoXmi0ms0/
 1E0ws+lAfQ4vkaoTC2ByuWBd7TXPdv1/KhnJdy/dPcAvR+irPRD+rFiaeqCHNTccSckkfr8gfP7
 wNB5z65j3WX/FFjg=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr11797217wrs.56.1585947337759; 
 Fri, 03 Apr 2020 13:55:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypIrfZdDpEU/V7fiJNw1MCmB/HR6YPBz5+hKRdiuEFzLLZ5dErdBGJiS8h8nKY99p0O5E5KcTw==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr11797203wrs.56.1585947337556; 
 Fri, 03 Apr 2020 13:55:37 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b127sm11022164wmd.2.2020.04.03.13.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 13:55:36 -0700 (PDT)
Subject: Re: [PATCH for-5.0] dump: Fix writing of ELF section
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200324173630.12221-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <63099477-98e6-8c16-1c8c-a9a617062143@redhat.com>
Date: Fri, 3 Apr 2020 22:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324173630.12221-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 6:36 PM, Peter Maydell wrote:
> In write_elf_section() we set the 'shdr' pointer to point to local
> structures shdr32 or shdr64, which we fill in to be written out to
> the ELF dump.  Unfortunately the address we pass to fd_write_vmcore()
> has a spurious '&' operator, so instead of writing out the section
> header we write out the literal pointer value followed by whatever is
> on the stack after the 'shdr' local variable.

How did you notice this? While reviewing around?

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Pass the correct address into fd_write_vmcore().
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I have not tested this because I can't reproduce the conditions
> under which we try to actually use write_elf_section() (they
> must be rare, because currently we produce a bogus ELF file
> for this code path). In dump_init() s->list.num must be
> at least UINT16_MAX-1, which I think means it has to be a
> paging-enabled dump and the guest's page table must be
> extremely fragmented ?
> ---
>   dump/dump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/dump/dump.c b/dump/dump.c
> index 6fb6e1245ad..22ed1d3b0d4 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -364,7 +364,7 @@ static void write_elf_section(DumpState *s, int type,=
 Error **errp)
>           shdr =3D &shdr64;
>       }
>  =20
> -    ret =3D fd_write_vmcore(&shdr, shdr_size, s);
> +    ret =3D fd_write_vmcore(shdr, shdr_size, s);
>       if (ret < 0) {
>           error_setg_errno(errp, -ret,
>                            "dump: failed to write section header table");
>=20


