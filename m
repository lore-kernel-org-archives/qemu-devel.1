Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAF8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E3620720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 13:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsgt6uIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E3620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97WX-0002BB-Ci
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 09:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k97VX-00017q-BH
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:55:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k97VV-0002j2-2n
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 09:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FUCah5aFUHZ20O4fF5bjSQ5ftNVnw4nvfKJaUBvB0io=;
 b=fsgt6uIqrLmaN/dfbU+GjIcGMD00WdumFDzMghuhbarzwpU+xECyt9pLULRRNzdkfUnlCF
 hqpcNmFl/tynPRuKSx1UL+jr67fuHXYBcmMbwj4WKavULkJQSzjHZNayBW9QEuhMn6at03
 EB42iEgYsK3Wi1A/ojFU4fGZ+677SAA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236--pl8Z3mdOqeqOB_wyX2vtQ-1; Fri, 21 Aug 2020 09:54:58 -0400
X-MC-Unique: -pl8Z3mdOqeqOB_wyX2vtQ-1
Received: by mail-wm1-f71.google.com with SMTP id u14so803169wml.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 06:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=FUCah5aFUHZ20O4fF5bjSQ5ftNVnw4nvfKJaUBvB0io=;
 b=UgIydMCLDRk9m04utcSK23UScmB+P5JuXZiESNxGbH1yONWGXsxAK2yMrd58qC8I+y
 7gaUJC62HtuV7cNufGPG1Ix+a29uu2KGbAmYYmIxFTXPaLlAvsmAjfiWtYkEcz8/c9Ur
 Xcw82029Py7QKhGQ0B+xQmfXiJvtl/6yXL1L1pjCw8NUdvoLUVtBnu07nV1kMky48lOE
 gWrx4VTPYXtKNkZsUsn9DnzzZcSGpivOHfjKIAqCcVc9YSovELX5ziZKpeJJcm3jXHgs
 v0i/pPwpAVZkfuHALDDg8tp4XaMBO1uw6wc5cgNDcFyJkEtI/cEmUQHkzzBNJfO++E+9
 PElg==
X-Gm-Message-State: AOAM5337y16ZRDcPCVztLjP1SHY7gueKmjZ8s+u6NLvga+rIZayNEcYQ
 T7TLvsb7vyYeXT2a4EdzX920pveu9zTbrr18SCzWoGpwj8M1NotG/lTKVJT3hj7f/BaefzVEMtn
 Krx+0XWv7Q7lRdT4=
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr3039141wra.150.1598018097541; 
 Fri, 21 Aug 2020 06:54:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzumuP+UJfU0XvjhMRMES7AztOh/R2ZoTxUFXSf/3qvvqrAFTHCTo+vR9M+LcBW5qvGIMfKWQ==
X-Received: by 2002:adf:b1ca:: with SMTP id r10mr3039131wra.150.1598018097370; 
 Fri, 21 Aug 2020 06:54:57 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b203sm6361823wmc.22.2020.08.21.06.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 06:54:56 -0700 (PDT)
Subject: Re: [PATCH 1/2] fdmon-poll: reset npfd when upgrading to fdmon-epoll
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200821101252.203056-1-stefanha@redhat.com>
 <20200821101252.203056-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <a82aae63-3db8-b83d-0131-8216420577a3@redhat.com>
Date: Fri, 21 Aug 2020 15:54:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821101252.203056-2-stefanha@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 01:00:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-stable@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 12:12 PM, Stefan Hajnoczi wrote:
> npfd keeps track of how many pollfds are currently being monitored. It
> must be reset to 0 when fdmon_poll_wait() returns.
> 
> When npfd reaches a treshold we switch to fdmon-epoll because it scales
> better.
> 
> This patch resets npfd in the case where we switch to fdmon-epoll.
> Forgetting to do so results in the following assertion failure:
> 
>   util/fdmon-poll.c:65: fdmon_poll_wait: Assertion `npfd == 0' failed.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1869952
> Fixes: 1f050a4690f62a1e7dabc4f44141e9f762c3769f ("aio-posix: extract ppoll(2) and epoll(7) fd monitoring")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/fdmon-poll.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/util/fdmon-poll.c b/util/fdmon-poll.c
> index 488067b679..5fe3b47865 100644
> --- a/util/fdmon-poll.c
> +++ b/util/fdmon-poll.c
> @@ -73,6 +73,7 @@ static int fdmon_poll_wait(AioContext *ctx, AioHandlerList *ready_list,
>  
>      /* epoll(7) is faster above a certain number of fds */
>      if (fdmon_epoll_try_upgrade(ctx, npfd)) {
> +        npfd = 0; /* we won't need pollfds[], reset npfd */
>          return ctx->fdmon_ops->wait(ctx, ready_list, timeout);
>      }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


