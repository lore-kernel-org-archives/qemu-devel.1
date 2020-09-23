Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53C5C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BBC2223E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpB1M/25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BBC2223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL91F-0001sD-8h
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <will.senn@gmail.com>)
 id 1kL87p-0007EZ-MD; Wed, 23 Sep 2020 13:00:15 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:38816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <will.senn@gmail.com>)
 id 1kL87i-0006K3-3P; Wed, 23 Sep 2020 13:00:10 -0400
Received: by mail-oi1-x22a.google.com with SMTP id 26so584655ois.5;
 Wed, 23 Sep 2020 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=qHpZzEacpXLsAtZUqq0yFHYGywfXgQksKlr2ULhjjwM=;
 b=mpB1M/25aZIoIF4hpbwZ3wVyB4wX/753wYjfInCQkSUTiJDmUCLWAkravi8aL+fvG4
 RDhMh+7kSsgLli6Rx3hKcgwgCjPiFPcaP0ZRa/NXY5HURik9BvvRoXRqTpvUQngr/otm
 +5A1P96ff3UNBkngpnFEbT2mE7S5cKeFzDsEjSeR5OJI/H1YIKDlO+/tptx3xZnLypWQ
 HXCz2TbwWJg9TWgR0dRPOFF2etlhxcVQV0FueOcNaVMNyfsj6yvzmOIRxiYmbPXBCiUO
 SOPu1OkSM8GrBCbA2qL5Y3v1XxRzpVT84U9VgO63Ssw70m/pRad8VXKX3Y68AK/bjXWJ
 VEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=qHpZzEacpXLsAtZUqq0yFHYGywfXgQksKlr2ULhjjwM=;
 b=GHLGxM2dQGHoNAcFATE6mneA0Mac10m4r95MQGVYRDMt/Doq8hV/fbbK5wadrX8z9N
 ukxg8GMF1PMN+UerddOx0bNu+XT3ym1znTLjSGh4wtwplPGCc8DA6qN98Hovppra2v0/
 9yWyfWXM12JWCYnMwkCKvFSAjlhnPrh7x3r1dd/PmwYrvGoOsYH9LNzwIJih6J4J+vAs
 l+T3XLQ9d9sfCNmVqgFQ6J5gjLOeHZQbNWhVdTVxv2x/DSSQcygTyeQk1Bul24do30qi
 uKsu2WuyiWhyreMPjv5jsTwqLB1xkWqBEmXiAb7aqW67jzBAxp869C9YAuHL1zjWN1n/
 LksA==
X-Gm-Message-State: AOAM533ATjlFnSIRGsAUDF+2427h3rOsZKOONwBeWhTPrUBV6amWmiy+
 1Gb12x+ooIjtC3e1Ncel+QQ=
X-Google-Smtp-Source: ABdhPJxnnSabDdaVBkNiLwQaa9mIVNYnzO/SwwXK78OuTM+YDRI7yUq/DBjZzqdUaEX/hlJWMp1DGQ==
X-Received: by 2002:a05:6808:2d7:: with SMTP id
 a23mr248507oid.51.1600880402508; 
 Wed, 23 Sep 2020 10:00:02 -0700 (PDT)
Received: from terra.local ([12.154.58.98])
 by smtp.gmail.com with ESMTPSA id y84sm57999oia.10.2020.09.23.10.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 10:00:02 -0700 (PDT)
Subject: Re: Minix 1.1 with QEMU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-discuss@nongnu.org, qemu-devel <qemu-devel@nongnu.org>
References: <5e534cc7-2a99-baa5-fc8f-63d0d8e85c97@gmail.com>
 <edc82d55-e5d1-abba-9a8e-7954b1dbe66e@amsat.org>
From: Will Senn <will.senn@gmail.com>
Message-ID: <6ab2235a-519b-2079-34eb-2dfe3b774fe4@gmail.com>
Date: Wed, 23 Sep 2020 12:00:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <edc82d55-e5d1-abba-9a8e-7954b1dbe66e@amsat.org>
Content-Type: multipart/alternative;
 boundary="------------5D98E4672419F97F14870E0B"
Content-Language: en-GB
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=will.senn@gmail.com; helo=mail-oi1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Sep 2020 13:54:49 -0400
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
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------5D98E4672419F97F14870E0B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/20 11:53 AM, Philippe Mathieu-Daudé wrote:
> Hi Will,
>
> On 9/23/20 6:45 PM, Will Senn wrote:
>> Long time user, first time poster :)
>>
>> So, I'd like to be able to run Minix 1.1 on my Macbook Pro mid-2012
>> w/16gb RAM (MacOS 10.14.6 Mojave). Qemu will run pretty ancient OS'es
>> such as DOS 2.0, which I use all of the time. However, I'm having some
>> difficulty getting Minix to run. I am able to boot the first floppy, but
>> when I change to the second floppy, the system freezes and I can't tell
>> what is going on. Here's what I did to get this far:
>>
>> brew install qemu
>>
>> qemu-system-i386 --version
>> QEMU emulator version 5.1.0
>>
>> mkdir ~/workspaces/retro-workspace/minix-1.1
>> cd ~/workspaces/retro-workspace/minix-1.1
>> aria2c
>> http://download.minix3.org/previous-versions/bzipped/Intel-1.1.tar.bz2
>> tar xvjf Intel-1.1.tar.bz2
>> cp Intel-1.1/floppy_disk1 ./Disk01.img
>> cp Intel-1.1/floppy_disk2 ./Disk02.img
>> cp Intel-1.1/floppy_disk3 ./Disk03.img
>> cp Intel-1.1/floppy_disk4 ./Disk04.img
>>
>>
>> qemu-system-i386 -drive
>> file=Disk01.img,format=raw,if=floppy,media=disk,readonly=off,index=0,snapshot=on
>> \
>>    -boot a \
>>    -no-fd-bootchk \
>>    -monitor telnet::2222,server,nowait -serial mon:stdio
>>
>> Qemu boots to the Minix 1.1 Boot screen and says to swap to floppy 2, so
>> in the monitor:
>> change floppy0 Disk02.img raw
>>
>> I press l (el) and it scans the disk, lists the files on the disk and
>> reports no errors, but when I press =, it does a carriage return and
>> just sits there. I'm pretty sure this is the Minix going bye bye and not
>> necessarily QEMU, but I'm wondering if there is a way to see what QEMU
>> thinks it is doing or if it is what's hung? Usually, at this point,
>> Minix reads the disk contents into a Ramdisk and boots Minix.
>>
>> Food for thought... Minix expects to run on an IBM PC (5150), IBM PC XT
>> (5160), or compatible, and therefore the I/O is written for whatever
>> floppy controller was extant at that time (I'm guessing here), so if
>> that's different than modern day floppies, I suppose this could cause
>> the problem I'm experiencing here. Is there a way to see the floppy
>> controller activity in QEMU? Similarly, I gather it expects a CGA
>> compatible monitor (EGA/VGA, etc should be fine).
> Can you try adding '-machine isapc', which is closer to the 5150?
>
>> I appreciate your help on this.
>>
>> Minix 1.1 works 'ok' in 86Box and other IBM PC emulations, so I know the
>> floppies are fine.
>>
>> Thanks!
>>
>> Will
>>
>>
>>
>> -- 
>> GPG Fingerprint: 68F4 B3BD 1730 555A 4462  7D45 3EAA 5B6D A982 BAAF
>>
Phillipe,

My new incantation is:

qemu-system-i386 -machine isapc -drive 
file=Disk01.img,format=raw,if=floppy,media=disk,readonly=off,index=0,snapshot=on 
-boot a   -no-fd-bootchk   -monitor telnet::2222,server,nowait -serial 
mon:stdio

with the same outcome :(. Thanks for the suggestion, I'll keep it in 
mind for other projects.

Will

-- 
GPG Fingerprint: 68F4 B3BD 1730 555A 4462  7D45 3EAA 5B6D A982 BAAF


--------------5D98E4672419F97F14870E0B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 9/23/20 11:53 AM, Philippe
      Mathieu-Daudé wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:edc82d55-e5d1-abba-9a8e-7954b1dbe66e@amsat.org">
      <pre class="moz-quote-pre" wrap="">Hi Will,

On 9/23/20 6:45 PM, Will Senn wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Long time user, first time poster :)

So, I'd like to be able to run Minix 1.1 on my Macbook Pro mid-2012
w/16gb RAM (MacOS 10.14.6 Mojave). Qemu will run pretty ancient OS'es
such as DOS 2.0, which I use all of the time. However, I'm having some
difficulty getting Minix to run. I am able to boot the first floppy, but
when I change to the second floppy, the system freezes and I can't tell
what is going on. Here's what I did to get this far:

brew install qemu

qemu-system-i386 --version
QEMU emulator version 5.1.0

mkdir ~/workspaces/retro-workspace/minix-1.1
cd ~/workspaces/retro-workspace/minix-1.1
aria2c
<a class="moz-txt-link-freetext" href="http://download.minix3.org/previous-versions/bzipped/Intel-1.1.tar.bz2">http://download.minix3.org/previous-versions/bzipped/Intel-1.1.tar.bz2</a>
tar xvjf Intel-1.1.tar.bz2
cp Intel-1.1/floppy_disk1 ./Disk01.img
cp Intel-1.1/floppy_disk2 ./Disk02.img
cp Intel-1.1/floppy_disk3 ./Disk03.img
cp Intel-1.1/floppy_disk4 ./Disk04.img


qemu-system-i386 -drive
file=Disk01.img,format=raw,if=floppy,media=disk,readonly=off,index=0,snapshot=on
\
  -boot a \
  -no-fd-bootchk \
  -monitor <a class="moz-txt-link-freetext" href="telnet::2222,server,nowait">telnet::2222,server,nowait</a> -serial mon:stdio

Qemu boots to the Minix 1.1 Boot screen and says to swap to floppy 2, so
in the monitor:
change floppy0 Disk02.img raw

I press l (el) and it scans the disk, lists the files on the disk and
reports no errors, but when I press =, it does a carriage return and
just sits there. I'm pretty sure this is the Minix going bye bye and not
necessarily QEMU, but I'm wondering if there is a way to see what QEMU
thinks it is doing or if it is what's hung? Usually, at this point,
Minix reads the disk contents into a Ramdisk and boots Minix.

Food for thought... Minix expects to run on an IBM PC (5150), IBM PC XT
(5160), or compatible, and therefore the I/O is written for whatever
floppy controller was extant at that time (I'm guessing here), so if
that's different than modern day floppies, I suppose this could cause
the problem I'm experiencing here. Is there a way to see the floppy
controller activity in QEMU? Similarly, I gather it expects a CGA
compatible monitor (EGA/VGA, etc should be fine).
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Can you try adding '-machine isapc', which is closer to the 5150?

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
I appreciate your help on this.

Minix 1.1 works 'ok' in 86Box and other IBM PC emulations, so I know the
floppies are fine.

Thanks!

Will



-- 
GPG Fingerprint: 68F4 B3BD 1730 555A 4462  7D45 3EAA 5B6D A982 BAAF

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <font face="Helvetica, Arial, sans-serif">Phillipe,<br>
      <br>
      My new incantation is:<br>
      <br>
      qemu-system-i386 -machine isapc -drive
file=Disk01.img,format=raw,if=floppy,media=disk,readonly=off,index=0,snapshot=on  
      -boot a   -no-fd-bootchk   -monitor <a class="moz-txt-link-freetext" href="telnet::2222,server,nowait">telnet::2222,server,nowait</a>
      -serial mon:stdio<br>
      <br>
      with the same outcome :(. Thanks for the suggestion, I'll keep it
      in mind for other projects.<br>
      <br>
      Will<br>
    </font><br>
    <pre class="moz-signature" cols="72">-- 
GPG Fingerprint: 68F4 B3BD 1730 555A 4462  7D45 3EAA 5B6D A982 BAAF</pre>
  </body>
</html>

--------------5D98E4672419F97F14870E0B--

