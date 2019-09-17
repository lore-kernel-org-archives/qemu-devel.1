Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3EBC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E755721852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E755721852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAEC6-0005it-15
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 10:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iAEBM-0005CL-Rv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iAEBL-00079m-Km
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:10:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47233)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iAEBL-00079I-CP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:10:15 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2AA8981F13
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 14:10:14 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f63so920129wma.7
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 07:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SyNqH6Cc1SGYjgaEDtrZWB1CcfZiTeRCqymf/LoB9Q8=;
 b=kgbuZFBHUziYD3Nw1AGE/lZ0ZLiQs6ItSf6fDm9rx0oCoYAuaiW4CM77YYcRUMmgaU
 K3cribFlAf8HG0w7/69Hhjr1E4VFdNeyEpEzhzmyysiSlpVu825LfekExqDWAeDPAHBQ
 pl+wyjeuyLcvUzK64P2wKKW1UIQkLozfpNp89MjqJZQY/tOX65f+y/yLwKsBEzPIEdMs
 vJHl+eWOHZB8he6O/iC+BJ/Wj5ffpck2XvN6SzYru+92f3El61E+JLDvTgTYueEg8yut
 yXxfUNTGHQd4ejRXX29TMnfd3e38roTUMLW6pPagZCbKJl7SvgOs0qwjqkveLm4af7r3
 UYrw==
X-Gm-Message-State: APjAAAVh2RzFWwT42k9012Iqdeq150pvaRO33tU4DhFJ3vww3zNzxFQ0
 Y/Xj2Lk2eru14O+8qbYbRBkBwaJfWJKAMWYLcq7Ris4VXVTTH5gG7ZNvpvnUeG7aQs1cawKVsWg
 3p21HkbQn7qDoPkA=
X-Received: by 2002:adf:c504:: with SMTP id q4mr3428724wrf.266.1568729412676; 
 Tue, 17 Sep 2019 07:10:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyWX90Z+mRjq7IB5LlAELO3tncSNHo70JNB65Ytl9uF0eJSOJZtSZloi82AMz/jjJyrr2NM1g==
X-Received: by 2002:adf:c504:: with SMTP id q4mr3428701wrf.266.1568729412412; 
 Tue, 17 Sep 2019 07:10:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8?
 ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id o3sm3016106wmh.38.2019.09.17.07.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 07:10:11 -0700 (PDT)
To: Palmer Dabbelt <palmer@sifive.com>
References: <20190915202011.30459-1-palmer@sifive.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e96a4b7a-84c8-6293-14b1-bc5a33b52e75@redhat.com>
Date: Tue, 17 Sep 2019 16:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190915202011.30459-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vl.c: Report unknown machines correctly
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing Mr command line...

Paolo

On 15/09/19 22:20, Palmer Dabbelt wrote:
> I was recently typing in a QEMU command line, and ended up with
> something like
> 
>     qemu-system-riscv64 -machine virt ... -M 8G
> 
> which is, in retrospect, obviously incorrect: there is no "8G" machine.
> I should have typed something like
> 
>     qemu-system-riscv64 -machine virt ... -m 8G
> 
> but since QEMU was giving me the excessively unhelpful error message
> 
>     qemu-system-riscv64: -machine virt: unsupported machine type
>     Use -machine help to list supported machines
> 
> I had to spend a few minutes scratching my head to figure out what was
> going on.  For some reason I felt like I'd done that before, so I
> figured I'd take a whack at fixing the problem this time.  It turns out
> the error reporting for non-existant machines is just wrong: the invalid
> machine is detected after we've lost the argument pointer, so it just
> prints out the first instance of "-machine" instead of the one we're
> actually looking for.
> 
> I've fixed this by just printing out "-machine $NAME" directly, but I
> feel like there's a better way to do this.  Specifically, my issue is
> that it always prints out "-machine" instead of "-M" -- that's actually
> a regression for users just passing a single invalid machine via "-M",
> which I assume is the more common case.
> 
> I'm not sure how to do this right, though, and my flight is boarding so
> I figured I'd send this out as a way to ask the question.  I didn't have
> time to run the test suite or figure out how to add a test for this, as
> I'm assuming there's a better way to do it.
> 
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index 630f5c5e9c..821a5d91c8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2487,7 +2487,7 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
>  
>      mc = find_machine(name, machines);
>      if (!mc) {
> -        error_report("unsupported machine type");
> +        error_printf("-machine %s: unsupported machine type\n", name);
>          error_printf("Use -machine help to list supported machines\n");
>          exit(1);
>      }
> 


