Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B0BC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7993B206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GePtliK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7993B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51855 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hziMa-0004lb-Kv
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 10:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.weiyang@gmail.com>) id 1hziLg-0003fN-Pn
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.weiyang@gmail.com>) id 1hziLf-0005aA-RB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:09:28 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:34924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
 id 1hziLf-0005ZW-Ko
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 10:09:27 -0400
Received: by mail-ed1-x543.google.com with SMTP id w20so1799429edd.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=reBHqxhh6lqyqowyaoICdapoew6jr3tEjg7ToBuYSTI=;
 b=GePtliK+wQPDTi4e3q3L011DXXcbMqMpb3zaSaGbFVR/zmjU/diAg5JusLH6zUC+2G
 0UTHfm53f82PTzirzZMzo7fAXffBJiIo6kAYqcQvDI7DBy9lZWYMgHsBbU8fU9RT07Ld
 E78WLwyj7cdqrPmkY2sKxw8C81ALV1LRRz1AHMbr2yvPQk4V1hcwJNZPdFPopJbRKP5p
 1jXLvrIExgRP0JjcdVpgYtfQ9CXfJnnvdfFZbtKlgxKsQyQk07dM3X134Ftqu+G/hcjB
 iCdAbWx3Dh99JWOccP5OuldRSa6hGToyRLg+IBCVo7+Az8xfZI0kkQJzIROJl0FGo1fh
 LBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=reBHqxhh6lqyqowyaoICdapoew6jr3tEjg7ToBuYSTI=;
 b=BMigrqGZhGaREE04P7f1rcB+iOztNvhLWra0O79WsxHvyguG72F5oL5rUaRejPyrg+
 maibzrnhbJFgYYrkxsp5FKROE3XbZcwXzqCG5UHPaav3mlxkqKjRWSNoawRB8FPU21+R
 vz9/++4szPv29PEka0ZWhUtd62dxYO2iOXf9WUWu3SlX0w63PPMmU6YjKLlvy6Tstt7O
 3T5s5TUzll2Xj/gF+1Wfsuz9DxAmTgk1wawr+EWsbYRQuloEmdkDeWU5i3JVX0X4Ax+F
 sfXBb7XGr2hRpUcRMsTl+nhuXA1JywmUZjTDxCTwZhhSGUNlWd8JV0UM+cIYTezpjj3H
 LtnQ==
X-Gm-Message-State: APjAAAU8pOydug2ebVlfFH+X+tMTWsx/WggpK8FDbtW7IXjKur/NB+ha
 QDMzBhYn3SCXMyOqDwPn7Fk=
X-Google-Smtp-Source: APXvYqwTe8XhtpXABS7l2Zzrx4kShxMurPJyI/+pkuYgJIcvyTsy5BPv4LPBcSDTadndqeg1qDUpLQ==
X-Received: by 2002:a17:906:6d5a:: with SMTP id
 a26mr21154852ejt.97.1566223766543; 
 Mon, 19 Aug 2019 07:09:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id g22sm2114854eje.84.2019.08.19.07.09.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 19 Aug 2019 07:09:25 -0700 (PDT)
Date: Mon, 19 Aug 2019 14:09:25 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Juan Quintela <quintela@redhat.com>
Message-ID: <20190819140925.dziwrlrviilyucki@master>
References: <20190819032804.8579-1-richardw.yang@linux.intel.com>
 <87d0h12rij.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0h12rij.fsf@trasno.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v2] migration: cleanup check on ops in
 savevm.handlers iterations
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 03:50:44PM +0200, Juan Quintela wrote:
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>> During migration, there are several places to iterate on
>> savevm.handlers. And on each iteration, we need to check its ops and
>> related callbacks before invoke it.
>>
>> Generally, ops is the first element to check, and it is only necessary
>> to check it once.
>>
>> This patch clean all the related part in savevm.c to check ops only once
>> in those iterations.
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Reviewed-by: Juan Quintela <quintela@redhat.com>
>
>Nice cleanup.

Thanks

-- 
Wei Yang
Help you, Help me

