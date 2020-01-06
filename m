Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2183CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E014620731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbY4pDHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E014620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTBp-0007Ct-1m
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 09:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioTAz-0006gZ-9A
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioTAy-0006y9-8t
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:16:13 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:37775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioTAs-0006eZ-9a; Mon, 06 Jan 2020 09:16:06 -0500
Received: by mail-qk1-x743.google.com with SMTP id 21so39537693qky.4;
 Mon, 06 Jan 2020 06:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4GeIjC3aEEZC33G7wpjwbmQhBnrZvM32nlecyXy0AJI=;
 b=FbY4pDHkiECQAvlvcVnGsBOOnb6RGORc/9gS9zL4nndXWBXNPlc5Zmxsn9ipeDnDe8
 2QPcBEW6CjMeKz0/i6kahVJcA/pUUZIFfITLO8vOQAfsDdgv3FFLrfdxCwwtpggV2W3+
 Thki8j3BREqp08tynaA0teCqEHHMFe1nYPBb2se+s2jjBRcHD6j+g3IQgPfh4zwD9zOE
 pwpqpS3FNsCMK2XnFFk7O8QCY6VDVRPZrr01WEN4cIwk5Mn067evdH2YjRUK3mBrkhcA
 kkD9fo0kTsjr24IeuUVgMRLfPIi3jOxd94qjzgT3KpKLiEG74h9aLKKwVx+cXgoQrUQD
 K+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4GeIjC3aEEZC33G7wpjwbmQhBnrZvM32nlecyXy0AJI=;
 b=e4WmCi7q+1oHRboL+2RaTSL8lIw6K3RDkWRdK/o3Pf1bz+CKK1MpL7/RjtW5qyp3hh
 EHgHjGRcY0Qn48/n182S+Vg6poOeO139aFBRjWxTL+XZ2LvKnX9MmXLGS5Pfl4Mh4HqE
 9G2AZlQM5iHw+F5OjVvqtCye8Az7XfgUnmCa9UeqbkNEOeMcVF3K70GSa5U2A2BJ8b7y
 sMP2gvgbBvaSqUILtB0rS9yWsfZdn4gHXfETDWCKjM4RNC6ir5EPsAa9FQniZPsAdXsJ
 gOvJEQp17lE5StD5j9I3x1Sv4tnB17p4V10RVqnOQ6hHXXp1LTa2O0PuFkn43PEkhj8B
 Au4Q==
X-Gm-Message-State: APjAAAVvFeZYbszJLdAQkAFsegf9exLeLi3ZKvn7Ip+TZP3ajPc9CIea
 FQnkjo7cyrj81evL9ps5vBs=
X-Google-Smtp-Source: APXvYqzNjkd5aFRJ/ZJT7ZGE1I47NFeG4dZLdoY9Hn9Zl0zrHg4nrla9kBoPYQoXekhkUcWzzgDjgQ==
X-Received: by 2002:a37:9ec2:: with SMTP id h185mr81561040qke.14.1578320164403; 
 Mon, 06 Jan 2020 06:16:04 -0800 (PST)
Received: from ?IPv6:2804:431:c7c6:655b:9e1c:e865:3705:e1df?
 ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id k1sm19672896qtq.86.2020.01.06.06.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 06:16:04 -0800 (PST)
Subject: Re: [RFC PATCH qemu] spapr: Kill SLOF
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20200103074404.30853-1-aik@ozlabs.ru>
 <3cf3e733-199a-61ba-7aaa-05e9546cd4d9@ozlabs.ru>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <dd98618f-01c6-850f-ac00-454a2f798508@gmail.com>
Date: Mon, 6 Jan 2020 11:15:57 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <3cf3e733-199a-61ba-7aaa-05e9546cd4d9@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Fabiano Rosas <farosas@linux.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Leonardo Bras <leonardo@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hey,

On 1/5/20 8:38 PM, Alexey Kardashevskiy wrote:
> Another version is coming, I'll start putting fewer people in the cc:
> list, watch qemu-ppc@nongnu.org for further updates if interested. Thanks,


Question: does Petitboot already replaces SLOF in every possible scenario for all
the spapr machine features? Or is Petitboot 'good enough' to get the ball
rolling and then we'll incrementally improve Petitboot/spapr code to add the
missing bits?

I am asking because this "SLOF-less" feature is something we'll want to expose on
Libvirt - users will sure enjoy enjoy the shorter boot time - and I want to brace
for impact when users starts opening bugs about the SLOF-less machine missing stuff
that the SLOF version does.


Thanks,


DHB

