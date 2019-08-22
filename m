Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71D0C3A5A3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14572133F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14572133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0oVW-0001mo-WF
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0oTt-0000Fx-Qm
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0oTs-00082D-Eu
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:54:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0oTs-00081k-8S
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:54:28 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8C64882EF
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 14:54:26 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g127so3076522wme.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 07:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vZLUCdjmGDLry/6KfukCxbwIVoo+frMqASukmuj6Lxk=;
 b=cnDkj4lV1Sbnj/pOwY5aYt99VzptY9lMeDdx+aCCXdxRcFQkwSTPRmCM1Q4QboTWiJ
 YUAdAH8AqljUq1GthHF+uY3R5NVqpi6PCopxGnP7B1/HIuS6v0t9ndHJDSMo/7B/Z1Qx
 8nTZEDDtdLEWssLBGo1X9djZaJbTd3wLEHfQCEMjRYgVC33F40CTwWpAhTLl1tmjIHNm
 7mmW41nfJ4lI8qa51UZVqVhxBvzswSXIw646KjhT1KWFOAnIeokrqD99Asq+Vm5kBoNn
 EmDXvSYbtkd5S5o8gwllQxpmxM8WMGLxEF67TPqrVlVwCZ8ufms2QqqjHOf8HbYG2HkN
 cEZw==
X-Gm-Message-State: APjAAAWUB+//Tvi4WFrT6G9kBG6Qy4pT0a9B/Af7/y0SDV5XdGCDndnc
 dy0XhtrvSnHRI0eWMmHPgByILU2rjEsEUoNBnYRA3z2lOlkieZawdhDzgfKO6ewoT31S7P0sC8J
 860XvfTso5ATN5ts=
X-Received: by 2002:a5d:4101:: with SMTP id l1mr6930498wrp.202.1566485665741; 
 Thu, 22 Aug 2019 07:54:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzFtm9pXfweH8GpX7c4FGgsDEEBDqpXO9xm4CPvcpwE3due5dxi2wCA9WsVHVQAwTaNbVCrXg==
X-Received: by 2002:a5d:4101:: with SMTP id l1mr6930459wrp.202.1566485665524; 
 Thu, 22 Aug 2019 07:54:25 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id o9sm39257619wrm.88.2019.08.22.07.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 07:54:24 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190822133846.10923-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1fe0ee70-33f5-7fba-744d-070afe36b5e1@redhat.com>
Date: Thu, 22 Aug 2019 16:54:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190822133846.10923-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] pr-manager: Fix invalid g_free() crash bug
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
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, kwolf@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/19 3:38 PM, Markus Armbruster wrote:
> pr_manager_worker() passes its @opaque argument to g_free().  Wrong;
> it points to pr_manager_worker()'s automatic @data.  Broken when
> commit 2f3a7ab39be converted @data from heap- to stack-allocated.  Fix
> by deleting the g_free().
>=20
> Fixes: 2f3a7ab39bec4ba8022dc4d42ea641165b004e3e
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scsi/pr-manager.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
> index ee43663576..0c866e8698 100644
> --- a/scsi/pr-manager.c
> +++ b/scsi/pr-manager.c
> @@ -39,7 +39,6 @@ static int pr_manager_worker(void *opaque)
>      int fd =3D data->fd;
>      int r;
> =20
> -    g_free(data);
>      trace_pr_manager_run(fd, hdr->cmdp[0], hdr->cmdp[1]);
> =20
>      /* The reference was taken in pr_manager_execute.  */
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

