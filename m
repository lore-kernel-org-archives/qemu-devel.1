Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFAC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1DC218EA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 16:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1DC218EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr2vC-0007oG-S5
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 12:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35352)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hr2uv-0007EW-NZ
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:18:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hr2uu-0000Hd-Ic
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:18:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hr2uu-0000BF-9h
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 12:18:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so55044685wrm.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 09:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iwwR0HS52LjVYKAUfnm8n0lPkr+JrMH5OW6mNO4WKno=;
 b=Lr8N0gljwUky/CFT2DFjcQAlVKTVc8O9FujJD/gV9QsFHZIXuEzmpE1Ci3fCFEVppO
 1xYiIinMToMRVMPCQvM+CzOTxqvtuofqcMfajndI5fFqDk89nPl8xNwh4kXrISuHebpx
 lCs8fGQFU09cd0jJOCo76V70hDjc29uzFP2ynlna1GZ0kU9HyZydHvwItlzBWemPjpqJ
 mdgYeqq/4HQPqTBVsGfDlhfZyudABRI0oPP73mTOxsW5VEGVZbmVVRJbzkn2KdMTYneT
 ZAXmlETCTkOu/4lT8u9m9L14kFfTaeWrHfaRA6zRAqFPQcBRuq/N6lwGo+fyaQaCECda
 dBGw==
X-Gm-Message-State: APjAAAVyu31XJ2rBte9Ouj3gO0BOdlArswMbt5jub3luQn9O++o6Y1gZ
 uZrGrw8ytMQrBmtpkqNRCQMT4Q==
X-Google-Smtp-Source: APXvYqygSNrwvdhtu+H/+NOvE1KiJciRB1LVcQWK27PGaJQR6eYcy9Lj8DbWK1xYjGry4hs/4jT8ww==
X-Received: by 2002:adf:dd01:: with SMTP id a1mr13341448wrm.12.1564157878838; 
 Fri, 26 Jul 2019 09:17:58 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id x18sm47123125wmi.12.2019.07.26.09.17.57
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jul 2019 09:17:58 -0700 (PDT)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
 <156415228410.1064338.4486161194061636096.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b52e6301-fd01-7a37-974b-d8e062af9490@redhat.com>
Date: Fri, 26 Jul 2019 18:17:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156415228410.1064338.4486161194061636096.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr/pci: Free MSIs during reset
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
Cc: qemu-stable <qemu-stable@nongnu.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-stable@

On 7/26/19 4:44 PM, Greg Kurz wrote:
> When the machine is reset, the MSI bitmap is cleared but the allocated
> MSIs are not freed. Some operating systems, such as AIX, can detect the
> previous configuration and assert.
> 
> Empty the MSI cache, this performs the needed cleanup.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_pci.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index bc22568bfa71..e45507bf2b53 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -2078,6 +2078,8 @@ static void spapr_phb_reset(DeviceState *qdev)
>      if (spapr_phb_eeh_available(SPAPR_PCI_HOST_BRIDGE(qdev))) {
>          spapr_phb_vfio_reset(qdev);
>      }
> +
> +    g_hash_table_remove_all(sphb->msi);

It is not clear to my why spapr_phb_unrealize() doesn't require the same
call, but this is not related to this patch.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  }
>  
>  static Property spapr_phb_properties[] = {
> 
> 

