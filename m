Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221B4C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E092063A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOgzYJjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E092063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMNJ-0000q6-9D
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 05:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPMLm-0000I3-Mu
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:00:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPMLk-0003sq-7k
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:00:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id m6so8633997wrn.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LMRj7yIuZe5JSB4nuuFlt6ZlYKqFb12hcrE3hlxKy0Y=;
 b=YOgzYJjdjyWBrFApD8FvMjP0FD1cPaSgbT7Mzp4h4fW9872eb7CcXkzrzJfbwdvLNk
 pbMGY6ZOImbdnruLv0fVt89pIWrmvwK9RAVNkZ7ey+0Ofa7jGkT0pyIDiqTZYGIIZmps
 IvLIztPaTrO/tPOxMJLiavU4R7TJ9fvqHl9dbBkTlMWBmnD58TYPnUMGT26RCKQ+4uam
 xngr/8M/pZcODKwLf5UV8syKCCOXKFAh3zi0402i02UpTu+uIA3ASQesCpivrqIMpDYc
 F//n3qSxKNGSsLnrvZAdYs+7QT6mceLAZNThNjf2c5K6n9B5QQ4jX1h2j22rfsz2z+Mc
 lldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LMRj7yIuZe5JSB4nuuFlt6ZlYKqFb12hcrE3hlxKy0Y=;
 b=DsmaTZCQlIW2lGFztGpu/bvodynkgZDEB23YSraJCHHKNA+PupkbtDCjpEIEXzWSJ2
 Bt/zE3NI6awZMwWcl1GV4Rzaerx71TpK0mT4bv9iav8Qf9Y/MmRIXwefoRYzaPsTCv1E
 K3FV0MCyhu89UXc4EcrMS5iGqDIDmZJB7pfZgD21BM5IuCyBLqpUp/BhCTF+Ig15hBuu
 yJ3U4B+LeZs/V0yu2RMchT+qyEoSjNkyCMgR0RoAjYejGLcP3RWH4x14S6kfjgoaK7Os
 SXilQ/p2tUSwAAabNUvZYer1eJRstOS9bNrgTpfrzNossrQsqPfnia57IAW6mG6BJyPl
 WUoA==
X-Gm-Message-State: AOAM531KoD4r1X2m16QFJLf6bKmS4T/p3RA/kaFt2r9L/DjCo3oAu+Wv
 EkBM36ru/keBBrtDyrbzf28=
X-Google-Smtp-Source: ABdhPJyUeemQs3yZWOopZZN6v9IWWCIrbCZPQM2frCyc1nWlHm1pl8PkuYC3cbc73PnF6jf2Ngx+fQ==
X-Received: by 2002:adf:ee07:: with SMTP id y7mr6622945wrn.229.1601888402760; 
 Mon, 05 Oct 2020 02:00:02 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u188sm7770536wmu.0.2020.10.05.02.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 02:00:02 -0700 (PDT)
Subject: Re: [RFC PATCH 09/21] contrib/gitdm: Add Nutanix to the domain map
To: Ani Sinha <ani@anisinha.ca>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-10-f4bug@amsat.org>
 <CAARzgwwrUAO8mW=nY3bbnwzyjHX8isf1XDDNR8XnXTO5=J4ovA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4859a37-4697-00ee-3e55-e0fc745f26d6@amsat.org>
Date: Mon, 5 Oct 2020 11:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAARzgwwrUAO8mW=nY3bbnwzyjHX8isf1XDDNR8XnXTO5=J4ovA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Mike Cui <cui@nutanix.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Ani Sinha <ani.sinha@nutanix.com>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>,
 Malcolm Crossley <malcolm@nutanix.com>,
 David Vrabel <david.vrabel@nutanix.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 Jonathan Davies <jonathan.davies@nutanix.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 7:22 AM, Ani Sinha wrote:
> 
> 
> On Sun, Oct 4, 2020 at 23:34 Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
> 
>     There is a number of contributors from this domain,
>     add its own entry to the gitdm domain map.
> 
>     Cc: Ani Sinha <ani.sinha@nutanix.com <mailto:ani.sinha@nutanix.com>>
>     Cc: David Vrabel <david.vrabel@nutanix.com
>     <mailto:david.vrabel@nutanix.com>>
>     Cc: Felipe Franciosi <felipe@nutanix.com <mailto:felipe@nutanix.com>>
>     Cc: Jonathan Davies <jonathan.davies@nutanix.com
>     <mailto:jonathan.davies@nutanix.com>>
>     Cc: Malcolm Crossley <malcolm@nutanix.com <mailto:malcolm@nutanix.com>>
>     Cc: Mike Cui <cui@nutanix.com <mailto:cui@nutanix.com>>
>     Cc: Peter Turschmid <peter.turschm@nutanix.com
>     <mailto:peter.turschm@nutanix.com>>
>     Cc: Prerna Saxena <prerna.saxena@nutanix.com
>     <mailto:prerna.saxena@nutanix.com>>
>     Cc: Raphael Norwitz <raphael.norwitz@nutanix.com
>     <mailto:raphael.norwitz@nutanix.com>>
>     Cc: Swapnil Ingle <swapnil.ingle@nutanix.com
>     <mailto:swapnil.ingle@nutanix.com>>
>     Cc: Ani Sinha <ani@anisinha.ca <mailto:ani@anisinha.ca>>
> 
> 
> I’ve left Nutanix and not part of the company anymore. Malcolm, David,
> Mike also has left Nutanix.
> 
> 
> 
>     Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>     ---
>     One Reviewed-by/Ack-by from someone from this domain
>     should be sufficient to get this patch merged.
> 
>     Ani, can you confirm the ani@anisinha.ca <mailto:ani@anisinha.ca> email?
>     Should it go into 'individual contributors' instead?
> 
> 
> Yes I’m an individual contributor now. 
> 
> 
>     ---
>      contrib/gitdm/domain-map        | 1 +
>      contrib/gitdm/group-map-nutanix | 2 ++
>      gitdm.config                    | 1 +
>      3 files changed, 4 insertions(+)
>      create mode 100644 contrib/gitdm/group-map-nutanix
> 
>     diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
>     index 4850eab4c4..39251fd97c 100644
>     --- a/contrib/gitdm/domain-map
>     +++ b/contrib/gitdm/domain-map
>     @@ -24,6 +24,7 @@ linaro.org <http://linaro.org>      Linaro
>      codesourcery.com <http://codesourcery.com> Mentor Graphics
>      microsoft.com <http://microsoft.com>   Microsoft
>      nokia.com <http://nokia.com>       Nokia
>     +nutanix.com <http://nutanix.com>     Nutanix
>      oracle.com <http://oracle.com>      Oracle
>      proxmox.com <http://proxmox.com>     Proxmox
>      redhat.com <http://redhat.com>      Red Hat
>     diff --git a/contrib/gitdm/group-map-nutanix
>     b/contrib/gitdm/group-map-nutanix
>     new file mode 100644
>     index 0000000000..a3f11425b3
>     --- /dev/null
>     +++ b/contrib/gitdm/group-map-nutanix
>     @@ -0,0 +1,2 @@
>     +raphael.s.norwitz@gmail.com <mailto:raphael.s.norwitz@gmail.com>
>     +ani@anisinha.ca <mailto:ani@anisinha.ca>
> 
> 
> Same here. Not part of Nutanix. 

OK I'll correct, thanks for the feedback.

> 
>     <mailto:ani@anisinha.ca>
>     diff --git a/gitdm.config b/gitdm.config
>     index c01c219078..4f821ab8ba 100644
>     --- a/gitdm.config
>     +++ b/gitdm.config
>     @@ -37,6 +37,7 @@ GroupMap contrib/gitdm/group-map-cadence Cadence
>     Design Systems
>      GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
>      GroupMap contrib/gitdm/group-map-ibm IBM
>      GroupMap contrib/gitdm/group-map-janustech Janus Technologies
>     +GroupMap contrib/gitdm/group-map-nutanix Nutanix
> 
>      # Also group together our prolific individual contributors
>      # and those working under academic auspices
>     -- 
>     2.26.2
> 

