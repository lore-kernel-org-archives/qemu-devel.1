Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F3DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D24D20885
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHI1FcAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D24D20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrgQH-0005h1-7X
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 07:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrgNL-0000lV-Rh
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 07:30:31 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrgNK-0004Lg-2k
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 07:30:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id g75so34335374wme.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B7D+o8xVfLNVswyHclEdEluQKhWwfRLVvQcr9NZ01ZU=;
 b=lHI1FcAsZselxJzTLHaBmHuqjv/Z4VC5B4YSkPpr6htgV0QyQ9ExxDgmK2n/falSoX
 oJ9MUK/HbI6aTPeOSC56Hx3L0DDOhiR67clx4tzS7ECG/rrpoATcSrpis1YtFK43hXym
 ol3Y+P7zsOve5pWSUoh/sHL8b1b3jICVW1IjzXmVONRw8rosyo0AeRo4yQc8DGRBZWIj
 9iR5+yA4hkeM76MQ+CKEWlDZDwxwd8r9XrnaJa4AhWw9ZngCPvpcoZUFmK9UeAx8xR8b
 xMTL1RvD2I/ERHe0CEupJptJ6QCZPabZxpfUgdCQxn8fdbHh4goT/6foBTqajC4mm3eY
 fiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B7D+o8xVfLNVswyHclEdEluQKhWwfRLVvQcr9NZ01ZU=;
 b=Iw2zrCTEt3cupA4SNENiGwfrb/X1i86hkJ7053aGuGSBMkccUP2CrvjubBBOaMLsRS
 dfyyCkMF/S/6Q2m4F1qMkvSJ1I0rTRr8wJnfpzr20uxXG47GUE+c5U16fGdOz+JCm4KS
 XWgqX1ZRbvJbFvrDEqz8W0kxq7UCHqxuM+VIZp1JHTHwxo5dTZgQU43IyYkqbP2L0sW8
 esO4pUzULQutek9Y+CodiA/05I0rDXJUPw5ujSvDxjMtawfzz5Sxq0S921adWmB375Ow
 r1HqAZQBnQebP0g37iWjiHSCoEYGwhZu3lz9b1x9Zo0/mWEJ4Qa8zDO/hArJtuqNV9XF
 Pp2w==
X-Gm-Message-State: AOAM532iVF/dpIUOU7Uov4H5kwPPe0I/gGxRBzr1hZvRzZbpxN1j8bEK
 bsIi/u2tyQFkIH4BUrvvnlI=
X-Google-Smtp-Source: ABdhPJyQn62M234bNf9YBJo5KDakD7lBRI8w4PzGUIgaIlJFxQ4z7X77mh9/EF6q4Cevn/5meT+ZiQ==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr39232706wml.36.1593862228201; 
 Sat, 04 Jul 2020 04:30:28 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x1sm16750310wrp.10.2020.07.04.04.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 04:30:27 -0700 (PDT)
Subject: Re: gmake in Solaris 11.4: TFR missing
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
 <5EFF7DD7.1000605@mindspring.com> <5EFFA499.7050008@mindspring.com>
 <601a18a7-d564-b9d7-7187-53a05d819551@amsat.org>
 <CAFEAcA8-ECTRrFayHYP1wnf19pn05UXwuxvWobBy9V6qUVJ9aw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e689a79b-0c49-2779-6fc9-24b46a22587b@amsat.org>
Date: Sat, 4 Jul 2020 13:30:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-ECTRrFayHYP1wnf19pn05UXwuxvWobBy9V6qUVJ9aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Tribble <peter.tribble@gmail.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Eric for macros & errno handling

On 7/4/20 11:11 AM, Peter Maydell wrote:
> On Fri, 3 Jul 2020 at 22:55, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> On 7/3/20 11:35 PM, Michele Denber wrote:
>>>   What is TFR?
>>
>> TFR() is defined in include/qemu-common.h:
> 
> Yep; adding #include "qemu-common.h" to tap-solaris.c should fix
> this (I think we missed tap-solaris.c in the header cleanup of
> commit a8d2532645cf5ce4).

Any idea what means TFR? I understand it keeps retrying while
interrupted, but can't find the origin of that abbreviation.

I'm not sure what we gain by using this macro, it seems dangerous
as there is no guaranty we 'expr' is a single libc call updating
errno.

We have:

include/qemu-common.h:13:#define TFR(expr) do { if ((expr) != -1) break;
} while (errno == EINTR)

block/file-posix.c:1515:    } while (errno == EINTR);
block/file-posix.c:1539:        } while (errno == EINTR);
block/file-posix.c:1701:        } while (errno == EINTR);

Good, de-macro-ified form.

chardev/char-fd.c:122:    TFR(fd = qemu_open(src, flags, 0666));
chardev/char-pipe.c:135:    TFR(fd_in = qemu_open(filename_in, O_RDWR |
O_BINARY));
chardev/char-pipe.c:136:    TFR(fd_out = qemu_open(filename_out, O_RDWR
| O_BINARY));
chardev/char-pipe.c:146:        TFR(fd_in = fd_out = qemu_open(filename,
O_RDWR | O_BINARY));

^ few cases, we need to check if qemu_open() is errno safe.
Maybe better to inline instead?

os-posix.c:297:        TFR(fd = qemu_open("/dev/null", O_RDWR));

^ I don't really understand this one.

net/tap-bsd.c:68:        TFR(fd = open(dname, O_RDWR));
net/tap-bsd.c:123:    TFR(fd = open(PATH_NET_TAP, O_RDWR));
net/tap-bsd.c:171:        TFR(fd = open(dname, O_RDWR));
net/tap-linux.c:49:    TFR(fd = open(PATH_NET_TUN, O_RDWR));
net/tap-solaris.c:87:    TFR(ip_fd = open("/dev/udp", O_RDWR, 0));
net/tap-solaris.c:93:    TFR(tap_fd = open("/dev/tap", O_RDWR, 0));
net/tap-solaris.c:107:    TFR(if_fd = open("/dev/tap", O_RDWR, 0));
net/tap-solaris.c:140:    TFR(arp_fd = open ("/dev/tap", O_RDWR, 0));
net/tap.c:625:    TFR(fd = tap_open(ifname, ifname_sz, vnet_hdr,
vnet_hdr_required,

Ditto, is tap_open() errno safe? If this code prefers to keep the
macro, we could move it to net/tap_int.h.

