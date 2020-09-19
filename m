Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25F7C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 11:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463A721481
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 11:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvkxZCsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463A721481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJasE-0000W7-DF
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 07:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJarg-0008W6-8d
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 07:17:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJare-0007Jn-5f
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 07:17:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id w5so8055736wrp.8
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+ilFZNnYoYIYiL4CGDdlLQ9udt7KqUaPBi+PM3pg+gE=;
 b=QvkxZCsZ9nA2Opdmhzmt+x5MPSqC08R4YguwLb3Au6w5skakWoaPqs0LtPDu/i5Qr6
 /QBu57cFQI+ceAT4Dx1GaTvcBesbgZcOEVK9X3IVKe3qiAYeDk7AcA/TqH5MYu0wZCpf
 KqrKf60/CRm3uUIWJM+N8+qBWORPkvNu6l6KGffmjmn9LZEmY3nAeJWXNMx5B/cLyXJ6
 jUtEZBqwqbrJM6hyGoLfZBd/CJ81MBsafia8Z40Yk0K7JtdEXhnIhHididDKgYRp/gIY
 gQScFV+Ye1yv2MVkOF6YD3i/yCOPNRBTfjn/WMmVccVExVv3sHZ8DnBqCL1PCjSdLpfn
 aEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+ilFZNnYoYIYiL4CGDdlLQ9udt7KqUaPBi+PM3pg+gE=;
 b=a5nWbbi1luBHsZUZ2foi79uDAyk2MdSudbcj1uqZYigSUq8uJwajcrGxs0winTdZ+U
 WdHlRTJqpvjEqW/fqwOF9Nd6TaFhSdWxX10gCTHjeNUAyQu7w6gMfxgYbf0VCBd9Hlk7
 1NIYHa0CVRqam/SA0Ty/zQgdKJTIKg9j19QIA3LB5Kjli2rcTVrCI/2y85QEdxPc2Giq
 wWSRbVeOz2z926i2U7RdNwxm3smFa6a5kn2zgfZE4FJ98sHncqf/rDXQFh/8ZnvUZCBj
 fjGxryzfb0VY3LQCHnWqt3oPSRq0MvtIJtD7gDEAnGOa/G/hygknR1iPbY192qfkBLfG
 zQYA==
X-Gm-Message-State: AOAM532ei9bZ8pO1aaFtdu+11FVU3g0A+zX3mqHUYcZzhQiukPgQ0Une
 5RLM/UoCU28S0T6ZuGB+6TA=
X-Google-Smtp-Source: ABdhPJyO+7UAjZ5/C4VNQU9kdNbroKIYVkazjjaKfMa3acXVGeLSgBSrV9JKXKe0n5t8x5T5tLA2jA==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr43900198wrp.246.1600514228592; 
 Sat, 19 Sep 2020 04:17:08 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t1sm9349211wmi.16.2020.09.19.04.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 04:17:07 -0700 (PDT)
Subject: Re: Bottleneck problem to merge Python patches
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "crosa@redhat.com" <crosa@redhat.com>, Lukas Straub <lukasstraub2@web.de>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-2-ahmedkhaledkaraman@gmail.com>
 <CAL1e-=iA95PR-mM9E+nfsvFRJLhQsj5Q9qPAM=7QS9mg-QvcbQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6ad83ff4-1b4f-69f0-7dbe-85680e2f403e@amsat.org>
Date: Sat, 19 Sep 2020 13:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iA95PR-mM9E+nfsvFRJLhQsj5Q9qPAM=7QS9mg-QvcbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-1.869,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Ben Widawsky <ben@bwidawsk.net>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 "aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

(extending the Cc list to broader audience)

On 9/18/20 10:33 PM, Aleksandar Markovic wrote:
> 
> On Friday, August 28, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com
> <mailto:ahmedkhaledkaraman@gmail.com>> wrote:
> 
>     - Apply pylint and flake8 formatting rules to the script.
>     - Use 'tempfile' instead of '/tmp' for creating temporary files.
> 
>     ---
> 
> Hello, folks.
> 
> This series seems forgotten. Can some of you perhaps take a look,
> review, and possibly integrate some patches in a pull request?
> 
> Ahmed invested quite of time to improve the functionality and quality of
> scripts, and they are truly useful for developers interested in
> performance measurement.

The Python patches are indeed being merged slowly, but are not
forgotten :) Eduardo sent just a pull request *yesterday* for
patches he had queued *before* QEMU 5.1, that is more than 1 year
ago!
https://www.mail-archive.com/qemu-devel@nongnu.org/msg742228.html

I hope he will be able to process the other Python patches sent
the last 12 months. He raised the problem few month ago saying he
was overwhelmed and was looking for help from the community.
Cleber helped a pair of times, I helped once, but then nobody
popped up volunteering.

I agree this is a community problem, nobody wants to become the
de-facto Python maintainer. Current maintainers are already busy
solving problem with low-level languages such C.
As a project, QEMU is evolving, using more and more Python, switched
to Meson, we might have Rust code too. Learning that for current
maintainers takes time. I guess we lack new contributors/maintainers
with interest in Python & QEMU.

This is my simple/rough analysis, as John had the same problem
2/3 months ago, his patches were on the list unreviewed for various
weeks. Same problem with Avocado patches, Lukas sent a series a bit
before Ahmed and it is still unreviewed:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg737272.html

Alex Bennée recently said:

 "review time is the currency of qemu-devel ;-)"

We might be failing at explaining new contributors the importance
of peer-review, as this helps a lot maintainers. It is described
in the wiki but maybe new contributors don't read it, we don't
remember them to:
https://wiki.qemu.org/Contribute/SubmitAPatch#Participating_in_Code_Review
and:
https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor

My 2 cents...

Regards,

Phil.

> 
> Thanks,
> Aleksandar

