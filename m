Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BB5C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C849B20714
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 15:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFnTVvwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C849B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiSQ-00017Z-QP
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 11:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSi9g-0005o9-4F
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:53:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSi9e-0000At-Ft
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:53:27 -0400
Received: by mail-wr1-x441.google.com with SMTP id s9so4213968wro.8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=55dJtGWWWP4DPdGW1STzyUry5W/enADTZs1V1NZOVpk=;
 b=WFnTVvwpGNGHmrQhXNd60wKrgiyat8qXCb2B2+I+aUcjpBVU59QBW5bMSgnCSgt1nN
 LIaeMEbSKMs9tnka5FgZFE2sbLg1CmzGRKbjhhdVPyJUNfU5Vbzn3/rmDJiR8wBj6vQ0
 OVs+/LdqxFLYoz9F1VY/aPSaFybhrBp+u5rcOiRkHLA0+Z/6/mK/SrKXOnRM3MKMGMAr
 w0mWf8bD9W23x+P3/BS+dP5yJVQ71g/uodLKbk7qE3TxjBomYV9Jn6yj9Cvw5k+6xkCr
 t8JMCTMZUmPV6IFKizcvaC9aXGkpN2vUANhW4zkJpgWGpYQaAALdibLGsikBD3TAwopt
 WzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=55dJtGWWWP4DPdGW1STzyUry5W/enADTZs1V1NZOVpk=;
 b=EgiwBH96RYTIiQ6xNHFq0JI27n3RWXiEJU/ChaU3YlDYsQ6R+98bpxpEc3NrJQoWRj
 0JE5VsEU8oDfS2XFMqVbUocbAZWHL+rxAtpkH+zRI+tnV/kXcYrxScjcf/4C8uyiUIGn
 nDM+Z8zjwPeIWGYAY5vrrxjNQyh8Y5QSt57tsW9h1WpS2dguy/tktlbRuYh2QWVKdpZg
 wKdzZ1DS4FDdxjhH2/OoODH5B+7DRmpi+YhPJHXQiZ7YIuqWKl0WXWLEX+RfsXN8BO0q
 2mpc7y6qIeypemSL7JpNlMptXPHjWhZsFlv+KGYH9iN8zNl2pmN2JsbEIPjdKmMkOCXW
 6TdQ==
X-Gm-Message-State: AOAM533ksoq9Q60Z3q/13fx7gk1J9M1Iz9NuA+NAa8WoS0NXksWqj498
 xoPBU+bz4KpafcX8O8+ojZY=
X-Google-Smtp-Source: ABdhPJyQB02JSGOfwvnIC4gj6QV2FIBXd7WG5GjJwClwv7goXR4euh2K8BxqJRCn06nURai43imOvw==
X-Received: by 2002:adf:f4ca:: with SMTP id h10mr5789274wrp.89.1602687204961; 
 Wed, 14 Oct 2020 07:53:24 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f7sm5624902wrx.64.2020.10.14.07.53.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 07:53:24 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU
 property
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <BYAPR11MB30479E5264D94EF903E9FD92CD040@BYAPR11MB3047.namprd11.prod.outlook.com>
 <515ec755fd8d7219040283f0c27346d762ee3c29.camel@linuxfoundation.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ea0ed6c7-1e3a-f7ee-a962-b471555e362d@amsat.org>
Date: Wed, 14 Oct 2020 16:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <515ec755fd8d7219040283f0c27346d762ee3c29.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <rth@twiddle.net>, Khem Raj <raj.khem@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:14 AM, Richard Purdie wrote:
> On Wed, 2020-10-14 at 01:36 +0000, Victor Kamensky (kamensky) wrote:
>> Thank you very much for looking at this. I gave a spin to
>> your 3 patch series in original setup, and as expected with
>> '-cpu 34Kf,tlb-entries=64' option it works great.
>>
>> If nobody objects, and your patches could be merged, we
>> would greatly appreciate it.
> 
> Speaking as one of the Yocto Project maintainers, this is really
> helpful for us, thanks!
> 
> qemumips is one of our slowest platforms for automated testing so this
> performance improvement helps a lot.

Could you try Richard's suggestion? Using '-cpu P5600' instead?
It is available in Linux since v5.8.

> 
> Cheers,
> 
> Richard
> 
> 

