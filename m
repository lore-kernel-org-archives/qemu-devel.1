Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C862C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 19:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF8D20708
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 19:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bODLWXTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF8D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNM4H-0004Z7-UJ
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 15:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNM3G-0003SF-1J
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 15:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNM3E-0007fd-Fa
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 15:44:25 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNM36-0007a0-0f; Sat, 11 Apr 2020 15:44:16 -0400
Received: by mail-ed1-x541.google.com with SMTP id s29so1110991edc.1;
 Sat, 11 Apr 2020 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GHv9pTOeuC3x7/esHufJn7DTkixSecTb7tb00hoSYSU=;
 b=bODLWXTZ1GB3bLBviUsOHwgf7spibtIKakBJqI0RZ5+GhnqH8+dwnxEdjN2mMf2bpH
 VAIy+2ggzDLyR+C3KjhRnk1IGTJfE6TwqUBFpPTRKLDuv3uxiQLUejf7QZI9NMI9/YqH
 gSxXpBQeOEPWTUI2XCtwStKNllTtE2PiPAClPSPE/IxN3kqVTu9YOXJL14BKHvkSwrQo
 2XvzAoy1Sciq4TH1I6DRCwwjUZJ4efqvU1IKG+EJeCzJE8sFwzREvD0BKuaH6z5M9tA7
 3EwAQSilnnT6laSg+xu0QQUTdk2EskaQZTrJiMZLl6iBPp4R5R3g+3Kxe+lM0H/pWEw0
 Lvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=GHv9pTOeuC3x7/esHufJn7DTkixSecTb7tb00hoSYSU=;
 b=AM03/J0kY2pMY6HZo1A+k1/cYOzoZRC9IN0jiABTcB80JaqoDOTF+bXZDUOjSCk76T
 wea1hNKnPpaP3R74aIYd7NmuJspTK04kuOMieQvyaUSHietgGqVz4aSxaYDVQqpEVFOz
 gHD5/5MyDVN2RiOVyFtyJ4tu4I3JW5zac8XOmwltPBWk2qlOAzjrkxhTr7q+up1PteaD
 llQGDWlrHAeNdOvsw8pDOUFJ2J/uLO3tljEEacvKefhRVGvNlg4bv5QUwxszsZWBFdPl
 dxafBaEEoRg+pNsFwCMyGOnR98AquDntHne8K+/FZb776lm/mPNIuQ1Ut4sNjM95xZLc
 oa4w==
X-Gm-Message-State: AGi0PuY26GwTK6BYLT5GrqvMSYEnDYqg31HP3UyEfrFd//LHP/0wG33N
 q5QMBmgIGytf1oOK/+/vcFKLI4wOJ78=
X-Google-Smtp-Source: APiQypLEW1KQ/x6zV35PQJSfLrpntyfkhO3Fequx7vRu8lE84mSs/IH+jSKddFGs8Hq2MvEeEYudaw==
X-Received: by 2002:a17:906:f251:: with SMTP id
 gy17mr5237863ejb.369.1586634254210; 
 Sat, 11 Apr 2020 12:44:14 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l62sm588819edl.89.2020.04.11.12.44.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2020 12:44:13 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200411091453.30371-1-f4bug@amsat.org>
 <20200411091453.30371-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2004111953020.75236@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <811e2026-963d-e4d6-b90c-2713f9f30404@amsat.org>
Date: Sat, 11 Apr 2020 21:44:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2004111953020.75236@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Zhang Zi Ming <1015138407@qq.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Cc'ing Sebastian Bauer & Aurelien Jarno because I'm not sure the
problem was introduced by commit debc7e7dad1 or 07d8a50cb0e).

On 4/11/20 8:05 PM, BALATON Zoltan wrote:
> On Sat, 11 Apr 2020, Philippe Mathieu-Daudé wrote:
>> Zhang Zi Ming reported a heap overflow in the Drawing Engine of
>> the SM501 companion chip model, in particular in the COPY_AREA()
>> macro in sm501_2d_operation().
>>
>> As I have no idea what this code is supposed to do, add a simple
>> check to avoid the heap overflow. This fixes:
> 
> As the function name says it performs a 2D blitter operation. The code
> had no bounds checking at all and there are easier ways to crash it by
> writing any unimplemented register for which it has abort() calls in the
> device implementation. I'm not sure this patch fixes all possible
> overflows but at least plugs this particular one so why not.

Buffer overflows are security issues because they allow attacker to
arbitrarily write data in the process memory, and eventually take
control of it. When attacker takes control, it can access underlying
private data.
While aborts are pointless to take control, they can still lead to
denial of service (i.e. keeping cloud provider hw busy while rebooting VMs).

I am not sure why 'security researchers' care about the R2D-PLUS and
aCube Sam460ex machines... I suppose they get money each time they
report a such issue.

> 
> Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> Otherwise this device emulation should be rewritten sometimes but I had
> not time for that.

It is pointless to implement features we'll never use, so if you are
happy with this fix as it, I'm happy too :) No need to rewrite a device
that works for our use cases.

> 
> Regards,
> BALATON Zoltan
> 
>>  =================================================================
>>  ==20518==ERROR: AddressSanitizer: heap-buffer-overflow on address
>> 0x7f6f4c3fffff at pc 0x55b1e1d358f0 bp 0x7ffce464dfb0 sp 0x7ffce464dfa8
>>  READ of size 1 at 0x7f6f4c3fffff thread T0
>>      #0 0x55b1e1d358ef in sm501_2d_operation hw/display/sm501.c:788:13
>>      #1 0x55b1e1d32c38 in sm501_2d_engine_write
>> hw/display/sm501.c:1466:13
>>      #2 0x55b1e0cd19d8 in memory_region_write_accessor memory.c:483:5
>>      #3 0x55b1e0cd1404 in access_with_adjusted_size memory.c:544:18
>>      #4 0x55b1e0ccfb9d in memory_region_dispatch_write memory.c:1476:16
>>      #5 0x55b1e0ae55a8 in flatview_write_continue exec.c:3125:23
>>      #6 0x55b1e0ad3e87 in flatview_write exec.c:3165:14
>>      #7 0x55b1e0ad3a24 in address_space_write exec.c:3256:18
>>
>>  0x7f6f4c3fffff is located 4194303 bytes to the right of 4194304-byte
>> region [0x7f6f4bc00000,0x7f6f4c000000)
>>  allocated by thread T0 here:
>>      #0 0x55b1e0a6e715 in __interceptor_posix_memalign
>> (ppc64-softmmu/qemu-system-ppc64+0x19c0715)
>>      #1 0x55b1e31c1482 in qemu_try_memalign util/oslib-posix.c:189:11
>>      #2 0x55b1e31c168c in qemu_memalign util/oslib-posix.c:205:27
>>      #3 0x55b1e11a00b3 in spapr_reallocate_hpt hw/ppc/spapr.c:1560:23
>>      #4 0x55b1e11a0ce4 in spapr_setup_hpt hw/ppc/spapr.c:1593:5
>>      #5 0x55b1e11c2fba in spapr_machine_reset hw/ppc/spapr.c:1644:9
>>      #6 0x55b1e1368b01 in qemu_system_reset softmmu/vl.c:1391:9
>>      #7 0x55b1e1375af3 in qemu_init softmmu/vl.c:4436:5
>>      #8 0x55b1e2fc8a59 in main softmmu/main.c:48:5
>>      #9 0x7f6f8150bf42 in __libc_start_main (/lib64/libc.so.6+0x23f42)
>>
>>  SUMMARY: AddressSanitizer: heap-buffer-overflow
>> hw/display/sm501.c:788:13 in sm501_2d_operation
>>  Shadow bytes around the buggy address:
>>    0x0fee69877fa0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>    0x0fee69877fb0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>    0x0fee69877fc0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>    0x0fee69877fd0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>    0x0fee69877fe0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>>  =>0x0fee69877ff0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa[fa]
>>    0x0fee69878000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>    0x0fee69878010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>    0x0fee69878020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>    0x0fee69878030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>    0x0fee69878040: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  Shadow byte legend (one shadow byte represents 8 application bytes):
>>    Addressable:           00
>>    Partially addressable: 01 02 03 04 05 06 07
>>    Heap left redzone:       fa
>>    Freed heap region:       fd
>>    Poisoned by user:        f7
>>    ASan internal:           fe
>>  ==20518==ABORTING
>>

I forgot here:

Cc: qemu-stable@nongnu.org

>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1786026
>> Reported-by: Zhang Zi Ming <1015138407@qq.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Per the links on
>> https://bugzilla.redhat.com/show_bug.cgi?id=1808510 there is probably
>> a CVE assigned to this, but I don't have access to the information,
>> https://bugzilla.redhat.com/show_bug.cgi?id=1786593 only show:
>>
>>  You are not authorized to access bug #1786593.
>>  Most likely the bug has been restricted for internal development
>> processes and we cannot grant access.
>> ---
>> hw/display/sm501.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index de0ab9d977..902acb3875 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -726,6 +726,12 @@ static void sm501_2d_operation(SM501State *s)
>>     int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
>>     int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s,
>> crt);
>>
>> +    if (rtl && (src_x < operation_width || src_y < operation_height)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "sm501: Illegal RTL address
>> (%i, %i)\n",
>> +                      src_x, src_y);
>> +        return;
>> +    }
>> +
>>     if (addressing != 0x0) {
>>         printf("%s: only XY addressing is supported.\n", __func__);
>>         abort();
>>

Thanks Zoltan for the review,

Phil.

