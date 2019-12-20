Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03096C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 07:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5452467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 07:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fBQ9jD6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5452467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiCkc-0007Ol-Rc
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 02:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iiCgP-0006Sx-3I
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:26:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iiCgN-0001dN-KH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:26:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:56989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iiCgN-0001R3-1T
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 02:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1576826794;
 bh=nINrhK5SzgyJD+3bBWX3eE0WEWwLRTL5dci0Yz9K0Cc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=fBQ9jD6bBAHKfoswz4gh+jKbrZjwlt0eTYxb8cGoC5RWRmv1/Cbxj07UHK/JLwtlK
 wjik8f5JfIdEOBuYUZD2qBl4ao0RmCJcj1Ng7HVNvWZUCgv1zpn1MrebnsTZN+ECqy
 fMjWtQ0Tx9DpFBjLMhsrYbxIJZKeranHg4HP96FM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.172.235]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1i9xrF21AZ-00aHQv; Fri, 20
 Dec 2019 08:26:34 +0100
Subject: Re: [PATCH v4 5/6] hppa: Add emulation of Artist graphics
To: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191103205607.6590-1-svens@stackframe.org>
 <20191103205607.6590-6-svens@stackframe.org>
 <8a34a5a3-eb8f-c600-b17e-f9b448ea0925@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <e8efe083-eed1-d7e8-8513-b26d2878bfdd@gmx.de>
Date: Fri, 20 Dec 2019 08:26:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8a34a5a3-eb8f-c600-b17e-f9b448ea0925@linaro.org>
Content-Type: multipart/mixed; boundary="------------24D1A24289FC9A2C79055C47"
Content-Language: en-US
X-Provags-ID: V03:K1:AGuY/Uv7oQVrqR+FjqB1+fvXxJW9fhumbyKC51fLYeT4OWS3OSG
 qN8jvUN3Vux49X4DFDA/AfwEqJZxc1mHctTukb5+O5PRyMKlTAPhtDLQcicNYe3gm7ZCgSW
 W5+bOcF6Jnj/POur5Rz18e+l68zeeo8Xv4lCNjjp7miMGWhjiYi9lfI+1ZS+st7X4jn7GUR
 wjukiu5PanzQ4t70zgzNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vgtvk+HXTmU=:Jgc0S9zVN3xzoljNS/5sNW
 wY1Im/zuTzHxwAFLrFjl+BM6QBBSAoHoQf64o+r6JC9PYX1CPRBQhVjXMOfkn44Mfl+WQL37L
 bPl0zeZ07HPNkTYcGTSGdJTeUIIMZewmgktPT1E37FoIf3fpI6OkoSdzufTkFrMA3z1gf9My+
 dGiqSnNTMIHo/cbwHPz+DB6QpgKd+X4ZBhsJw3zFBHHuqpeOQl6JnO6RjI5DvHGhUUkUXyjOr
 wbnomlkhH+dtwEhG65ePgk4kSfLyiOxvn+6OQHN4AAiCyMDIp/eKcLg7nptnC/aiVbrsJGwp4
 Wrzc1QLvD+g+tRmNREpdr+8/0JQJk/i/Brax13/AL8Jz8Q9H78j/oxL1he3g2thAWG35CwGGh
 PAQIG35k4eiEoJ1r/5BQpp4wuPELGl6wWsE4xgl3BPCLNskZvJQYVO1QVlakv7FJ7vH52RdrF
 Mq4AfZ+UsrsgIRKHjEPq/9ZGBnynpFyh8Et2IPjksByVrG42oL1FnmkjtwU1Cqnyv2Lkwb7AG
 jZouvH5nhtpn2zVFKA6SeaJepBrvWM/vKRdIhuasw9n2m4mUjClr8hN9yXqZffj44t8dbgyEF
 dx8BPwg+CZoH9MpwsXh8PGmXwXW9m3Z68nEUBC5AA54Ix7b+HFTcYUZQQdm8fSfA1zCTIOA1D
 vAchvzEttKIio68kKZIoghf2nmNOSjMwktwJIW8p2fvMmp9e6/qajmuIC7xqq/Wb2Z0r1zZzT
 wNmva6x/aqXQE32BU9ZkMaOMv1N1qdjzZKGD/XYEHXwi6wg3Bk8/xow9/50jsEvYTn5LF9KZE
 xNmm9zncaaVcF/piHzg7nq92MAL5t73UgXV7GwwnD5xfSJYcTWsH36inKdQSHfs22L8fIFirm
 2NcZm09OO5RybQME2CXTJiqCIqAxQFwC7aLOSDZs+wKheO4ED4tRrbCWvtIPWTd2gMo1MHKAy
 FSm8BR6RZTjRoTRYitl/dWuuhnbOEvyHn04o/QMUJEJQxVcTyIBWjc9td+Acjqx0utXB2aeke
 R0qBO9dB3VX4EGvzf/u7k1ThfBg1oqAy5R0QhpPjrXrGtayb0YzMHAYWIchA2Q3VpDIuO7Nhf
 r+NRrPnXTEcLKQa4+ohkmN4ekUW0W3htMZIpNhSBSNpN1OHsEZUvqCen+oblpwDFSDxuqUzaR
 iWg36exAmX/uFNdE4kbXXp16HxVoRfvEfM4VqzYiVXHPtaICXVerDw4Ogd2qCOikQmtNVr0tW
 qYdkOZWhtWU0pV5d+iBAktXxpyLtALUqxbW/oVA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.18
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------24D1A24289FC9A2C79055C47
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.12.19 01:28, Richard Henderson wrote:
> On 11/3/19 10:56 AM, Sven Schnelle wrote:
>> This adds emulation of Artist graphics good enough
>> to get a Text console on both Linux and HP-UX. The
>> X11 server from HP-UX also works.
>>
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> ---
>>  hw/display/Kconfig       |    4 +
>>  hw/display/Makefile.objs |    1 +
>>  hw/display/artist.c      | 1449 ++++++++++++++++++++++++++++++++++++++
>>  hw/display/trace-events  |    9 +
>>  hw/hppa/Kconfig          |    1 +
>>  hw/hppa/hppa_hardware.h  |    1 +
>>  hw/hppa/machine.c        |    9 +
>>  7 files changed, 1474 insertions(+)
>>  create mode 100644 hw/display/artist.c
>
> Seems to have some problems rebased upon master:
>
>
>> Thread 6 "qemu-system-hpp" received signal SIGSEGV, Segmentation fault.
>> [Switching to Thread 0x7fffee3b6700 (LWP 11752)]
>> 0x00005555558bba54 in artist_rop8 (s=3Ds@entry=3D0x555556105400,
>>     dst=3Ddst@entry=3D0x7fffed740000 "", val=3D0 '\000')
>>     at /home/rth/qemu/qemu/hw/display/artist.c:288
>> 288	        *dst |=3D val & plane_mask;
>> (gdb) where
>> #0  0x00005555558bba54 in artist_rop8
>>     (s=3Ds@entry=3D0x555556105400, dst=3Ddst@entry=3D0x7fffed740000 "",=
 val=3D0 '\000')
>>     at /home/rth/qemu/qemu/hw/display/artist.c:288
>> #1  0x00005555558bc145 in vram_bit_write
>>     (s=3Ds@entry=3D0x555556105400, posx=3D<optimized out>, posy=3D<opti=
mized out>, incr_x=3Dincr_x@entry=3Dfalse, size=3Dsize@entry=3D4, data=3D<=
optimized out>, data@entry=3D0)
>>     at /home/rth/qemu/qemu/hw/display/artist.c:430
>> #2  0x00005555558bd33b in artist_reg_write
>>     (opaque=3D0x555556105400, addr=3D1050144, val=3D0, size=3D4)
>>     at /home/rth/qemu/qemu/hw/display/artist.c:862
>> #3  0x00005555557b271b in memory_region_write_accessor
>>     (mr=3Dmr@entry=3D0x5555561058f0, addr=3Daddr@entry=3D1050144, value=
=3Dvalue@entry=3D0x7fffee3b4f08, size=3Dsize@entry=3D4, shift=3Dshift@entr=
y=3D0, mask=3Dmask@entry=3D4294967295, attrs=3D...) at /home/rth/qemu/qemu=
/memory.c:483
>> #4  0x00005555557b03d3 in access_with_adjusted_size
>>     (addr=3Daddr@entry=3D1050144, value=3Dvalue@entry=3D0x7fffee3b4f08,=
 size=3Dsize@entry=3D4, access_size_min=3D<optimized out>, access_size_max=
=3D<optimized out>, access_fn=3Daccess_fn@entry=3D
>>     0x5555557b25f0 <memory_region_write_accessor>, mr=3D0x5555561058f0,=
 attrs=3D...) at /home/rth/qemu/qemu/memory.c:539
>> #5  0x00005555557b4b34 in memory_region_dispatch_write
>>     (mr=3Dmr@entry=3D0x5555561058f0, addr=3Daddr@entry=3D1050144, data=
=3D<optimized out>, data@entry=3D0, op=3Dop@entry=3DMO_BEUL, attrs=3D...)
>>     at /home/rth/qemu/qemu/memory.c:1475
>> #6  0x00005555557c18ed in io_writex
>>     (env=3Denv@entry=3D0x5555563a6b60, mmu_idx=3Dmmu_idx@entry=3D4, val=
=3Dval@entry=3D0, addr=3Daddr@entry=3D4161799712, retaddr=3D14073641511488=
6, op=3DMO_BEUL, iotlbentry=3D<optimized out>, iotlbentry=3D<optimized out=
>)
>>     at /home/rth/qemu/qemu/accel/tcg/cputlb.c:977
>> #7  0x00005555557c77bc in store_helper
>>     (op=3DMO_BEUL, retaddr=3D140736415114886, oi=3D<optimized out>, val=
=3D0, addr=3D4161799712, env=3D0x5555563a6b60) at /home/rth/qemu/qemu/acce=
l/tcg/cputlb.c:1716
>> #8  0x00005555557c77bc in helper_be_stl_mmu
>>     (env=3D0x5555563a6b60, addr=3D4161799712, val=3D0, oi=3D<optimized =
out>, retaddr=3D140736415114886) at /home/rth/qemu/qemu/accel/tcg/cputlb.c=
:1842
>> #9  0x00007fffc007a686 in code_gen_buffer ()


Richard, the attached patch (for seabios-hppa) fixes it for me.
Can you test as well?
It fixes the sti text column to go out-of-range and thus outside the frame=
buffer memory.

Helge

--------------24D1A24289FC9A2C79055C47
Content-Type: text/x-patch; charset=UTF-8;
 name="sti.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sti.patch"

diff --git a/src/parisc/sti.c b/src/parisc/sti.c
index 7935770..eca79da 100644
--- a/src/parisc/sti.c
+++ b/src/parisc/sti.c
@@ -168,5 +168,8 @@ void sti_putc(const char c)
         }
         return;
     }
-    sti_putchar(rom, row, col++, c);
+
+    sti_putchar(rom, row, col, c);
+    if (col < ((sti_glob_cfg.onscreen_x / font->width) - 1))
+	col++;
 }

--------------24D1A24289FC9A2C79055C47--

