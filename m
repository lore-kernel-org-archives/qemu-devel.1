Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB31C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 17:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6007207DE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 17:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuXyzkLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6007207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFgyT-0006Rp-11
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 13:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFgxP-0004pQ-Ak; Tue, 08 Sep 2020 12:58:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFgxM-0004kU-ED; Tue, 08 Sep 2020 12:58:59 -0400
Received: by mail-wm1-x342.google.com with SMTP id z9so77284wmk.1;
 Tue, 08 Sep 2020 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nSBgklw4wGsNqIPp9QVuYHwaBYmm3hYIFyQRgN8Vg10=;
 b=XuXyzkLiZBNi35JspGu2X6khC1gmJ5vzWL8NDw+UvO4yJB/GZ9MZoPkh+VXLD+jrEX
 hwdTIRg/wcZwQAkZ7RGHCMO6gA9Mm3vX7UV4nCoc5/1FqVpyLeuzAt7Afz2SSvd/ev3j
 HXImYJp+1XEQ63tFpTdwpCchB/OD3R40lGLjTFiL74d0xSJyuvE3QBp4Z+EbESkQIFTY
 LFx2vPMGHBIEJ7cdoPHMdwJLdLJsI0Bg4jOnACkjIicNW+xD3TuxwWt2h6buwLyIbHJR
 I3qGK59g/4zhNIXkXiOkiktgJQTLMu64sknIPi33w5yMl5JCZr82mr45qcMzFE/zr2rh
 Demg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=nSBgklw4wGsNqIPp9QVuYHwaBYmm3hYIFyQRgN8Vg10=;
 b=AePngDTG3zs9RHqRCHGxXMbow+6r6GrT2hs9peilXHiFtZqRyiWR12Z28K/HoU39r/
 dGZH/MKRZaA56L1ulIaT63Seiz8uDnYRnmlNxShodwqF9AeQIDixLYVgwmiJ+rXIK51Q
 oz8qiqOLEEvi64dLcHRdBrYnWlt1Vn8oKtmXEBCsBQ1Ex4t9i1DKhafR5bi3qtQrcx88
 BVKzphmd43OvlNhcLZm9sWGMcXmTt4aq51RrjdJ3yYJ+mfjrlMDrwH7NJbnkCWMax1Vo
 vvUmPZjS9ZHXVU3gz0cvBXY0Z8b5a+BTBt4Fm7IlkSdqZGtLOBF3ncIlwwZTf/jpOJZn
 9oKQ==
X-Gm-Message-State: AOAM532yPxt19ayF9BE/c9ssDtE8fSrJ3yhDFRwxAltQzx8OrhZeASod
 EP6yVVUXLLML5akbhBGsKEE=
X-Google-Smtp-Source: ABdhPJwkRRa/2bTbbLoAVmOPJZKhV0iybfYwgH3H+KMovkd/u3h+A5vy0r1uhE3QYshb9PTFeKziKA==
X-Received: by 2002:a1c:2742:: with SMTP id n63mr93768wmn.24.1599584334244;
 Tue, 08 Sep 2020 09:58:54 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l10sm60762wru.59.2020.09.08.09.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 09:58:53 -0700 (PDT)
Subject: Re: [PATCH v8 00/14] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Alexander Bulekov <alxndr@bu.edu>,
 Havard Skinnemoen <hskinnemoen@google.com>
References: <20200825001711.1340443-1-hskinnemoen@google.com>
 <20200908150224.pkuyhpmw33xqhmjn@mozz.bu.edu>
 <d88bc6ae-e07e-700f-d3cc-c093d2d44594@amsat.org>
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
Message-ID: <bfb442b4-9700-5591-eeef-00bc6675c89f@amsat.org>
Date: Tue, 8 Sep 2020 18:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d88bc6ae-e07e-700f-d3cc-c093d2d44594@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.626,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kfting@nuvoton.com, Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 5:52 PM, Philippe Mathieu-Daudé wrote:
> On 9/8/20 5:02 PM, Alexander Bulekov wrote:
>> Hi Havard,
>> I fuzzed the npcm750-evb machine until I hit over 85% coverage over all
>> the new npcm.*\.c files. The only thing I found specific to the new
>> code, so far:
>>
>> cat << EOF | ./qemu-system-arm -machine npcm750-evb -m 128M -qtest stdio 
>> write 0xf0009040 0x4 0xc4c4c4c4
>> write 0xf0009040 0x4 0x4
>> EOF
> 
> This is an odd test because with -qtest the timer is not running,
> so this can not really happen on real hw.
> 
> The fix is:
> 
> -    g_assert(t->remaining_ns > 0);
> +    g_assert(qtest_enabled() || t->remaining_ns > 0);

Alex corrected me on IRC, qtest is irrelevant here.
The problem is he disables the timer twice.

So maybe something like:

 static void npcm7xx_timer_pause(NPCM7xxTimer *t)
 {
     int64_t now;

+    if (!timer_pending(&t->qtimer)) {
+        return;
+    }
     timer_del(&t->qtimer);
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     t->remaining_ns = t->expires_ns - now;
     g_assert(t->remaining_ns > 0);
 }

> 
>>
>> ERROR:../hw/timer/npcm7xx_timer.c:160:npcm7xx_timer_pause: assertion failed: (t->remaining_ns > 0)
>> Bail out! ERROR:../hw/timer/npcm7xx_timer.c:160:npcm7xx_timer_pause: assertion failed: (t->remaining_ns > 0)
>> Aborted
>>
>> I'm doing the same for the quanta-gsj machine, but I'm not sure whether
>> it will cover more code, so I'm happy to leave a:
>>
>> Tested-by: Alexander Bulekov <alxndr@bu.edu>
>>
>> for the patches that add new virtual-device code (1-5, 7-12 ?)
>> -Alex
> 
> Very nice from you for testing running the fuzzer!
> 
> Regards,
> 
> Phil.
> 
>>
>>
>> On 200824 1716, Havard Skinnemoen via wrote:
>>> I also pushed this and the previous patchsets to my qemu fork on github.
>>> The branches are named npcm7xx-v[1-8].
>>>
>>>   https://github.com/hskinnemoen/qemu
>>>
>>> This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs to boot
>>> an OpenBMC image built for quanta-gsj. This includes device models for:
>>>
>>>   - Global Configuration Registers
>>>   - Clock Control
>>>   - Timers
>>>   - Fuses
>>>   - Memory Controller
>>>   - Flash Controller
>>>
>>> These modules, along with the existing Cortex A9 CPU cores and built-in
>>> peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in turn form
>>> the foundation for the quanta-gsj and npcm750-evb machines, respectively. The
>>> two SoCs are very similar; the only difference is that NPCM730 is missing some
>>> peripherals that NPCM750 has, and which are not considered essential for
>>> datacenter use (e.g. graphics controllers). For more information, see
>>>
>>> https://www.nuvoton.com/products/cloud-computing/ibmc/
>>>
>>> Both quanta-gsj and npcm750-evb correspond to real boards supported by OpenBMC.
>>> At the end of the series, qemu can boot an OpenBMC image built for one of these
>>> boards with some minor modifications.
>>>
>>> The patches in this series were developed by Google and reviewed by Nuvoton. We
>>> will be maintaining the machine and peripheral support together.
>>>
>>> The data sheet for these SoCs is not generally available. Please let me know if
>>> more comments are needed to understand the device behavior.
>>>
>>> Changes since v7:
>>>
>>>   - Move register enums to .c files throughout, leaving a single
>>>     NPCM7XX_FOO_NR_REGS definition behind in the .h file. A QEMU_BUILD_BUG_ON
>>>     should alert anyone accidentally expanding the register enum that they need
>>>     to update the corresponding NR_REGS define, which in turn has a comment
>>>     reminding them to update the vmstate version_id as well.
>>>   - Skip loading the bootrom if a kernel filename is provided by the user.
>>>   - New patch adding a board setup stub to tweak clocks before booting directly
>>>     into the kernel.
>>>   - Add stuff to meson files instead of Makefiles.
>>>   - Try to disable the slowest drivers and services to speed up the flash boot
>>>     acceptance test a bit. This is somewhat based on the following
>>>     systemd-analyze blame report:
>>>     https://gist.github.com/hskinnemoen/475cb0676530cd2cebaa1754cf16ca97
>>>
>>> Changes since v6:
>>>
>>>   - Use size_to_str to report DRAM sizes in npcm7xx_gcr.
>>>   - Simplify the interrupt logic in npcm7xx_timer.
>>>   - Update global bios_name instead of temporary.
>>>   - Add npcm7xx_bootrom to MAINTAINERS and pc-bios/README.
>>>   - Use a predefined name for the gsj boot image in the acceptance test.
>>>
>>> Changes since v5:
>>>
>>>   - Boot ROM included, as a git submodule and a binary blob, and loaded by
>>>     default, so the -bios option is usually not necessary anymore.
>>>   - Two acceptance tests added (openbmc image boot, and direct kernel boot).
>>>   - npcm7xx_load_kernel() moved to SoC code.
>>>   - NPCM7XX_TIMER_REF_HZ definition moved to CLK header.
>>>   - Comments added clarifying available SPI flash chip selects.
>>>   - Error handling adjustments:
>>>       - Errors from CPU and GCR realization are propagated through the SoC
>>>         since they may be triggered by user-configurable parameters.
>>>       - Machine init uses error_fatal instead of error_abort for SoC
>>>         realization flash init. This makes error messages more helpful.
>>>       - Comments added to indicate whether peripherals may fail to realize.
>>>       - Use ERRP_GUARD() instead of Error *err when possible.
>>>   - Default CPU type is now set, and attempting to set it to anything else
>>>     will fail.
>>>   - Format string fixes (use HWADDR_PRIx, etc.)
>>>   - Simplified memory size encoding and error checking in npcm7xx_gcr.
>>>   - Encapsulate non-obvious pointer subtraction into helper functions in the
>>>     FIU and TIMER modules.
>>>   - Incorporate review feedback into the FIU module:
>>>       - Add select/deselect trace events.
>>>       - Use npcm7xx_fiu_{de,}select() consistently.
>>>       - Use extract/deposit in more places for consistency.
>>>       - Use -Wimplicit-fallthrough compatible fallthrough comments.
>>>       - Use qdev_init_gpio_out_named instead of sysbus_init_irq for chip
>>>         selects.
>>>   - Incorporate review feedback into the TIMER module:
>>>       - Assert that we never pause a timer that has already expired, instead of
>>>         trying to handle it. This should be safe since QEMU_CLOCK_VIRTUAL is
>>>         stopped while this code is running.
>>>       - Simplify the switch blocks in the read and write handlers.
>>>
>>> I made a change to error out if a flash drive was not specified, but reverted
>>> it because it caused make check to fail (qom-test). When specifying a NULL
>>> block device, the m25p flash device initializes its in-memory storage with 0xff
>>> and doesn't attempt to write anything back. This seems correct to me.
>>>
>>> Changes since v4:
>>>
>>>   - OTP cleanups suggested by Philippe Mathieu-Daudé.
>>>       - Added fuse array definitions based on public Nuvoton bootblock code.
>>>       - Moved class structure to .c file since it's only used internally.
>>>       - Readability improvements.
>>>   - Split the first patch and folded parts of it into three other patches so
>>>     that CONFIG_NPCM7XX is only enabled after the initial NPCM7xx machine
>>>     support is added.
>>>   - DRAM init moved to machine init code.
>>>   - Consistently use lower-case hex literals.
>>>   - Switched to fine-grained unimplemented devices, based on public bootblock
>>>     source code. Added a tiny SRAM that got left out previously.
>>>   - Simplified error handling in npcm7xx_realize() since the board code will
>>>     abort anyway, and SoCs are not hot-pluggable.
>>>
>>> Changes since v3:
>>>
>>>   - License headers are now GPL v2-or-later throughout.
>>>   - Added vmstate throughout (except the memory controller, which doesn't
>>>     really have any state worth saving). Successfully booted a gsj image
>>>     with two stop/savevm/quit/loadvm cycles along the way.
>>>       - JFFS2 really doesn't like it if I let qemu keep running after savevm,
>>>         and then jump back in time with loadvm. I assume this is expected.
>>>   - Fixed an error API violation in npcm7xx_realize, removed pointless error
>>>     check after object_property_set_link().
>>>   - Switched the OTP device to use an embedded array instead of a g_malloc0'd
>>>     one because I couldn't figure out how to set up vmstate for the latter.
>>>
>>> Changes since v2:
>>>
>>>   - Simplified the MAINTAINERS entry.
>>>   - Added link to OpenPOWER jenkins for gsj BMC images.
>>>   - Reverted the smpboot change, back to byte swapping.
>>>   - Adapted to upstream API changes:
>>>       - sysbus_init_child_obj -> object_initialize_child
>>>       - object_property_set_bool -> qdev_realize / sysbus_realize
>>>       - ssi_create_slave_no_init -> qdev_new
>>>       - qdev_init_nofail -> qdev_realize_and_unref
>>>       - ssi_auto_connect_slaves removed
>>>   - Moved Boot ROM loading from soc to machine init.
>>>   - Plumbed power-on-straps property from GCR to the machine init code so it
>>>     can be properly initialized. Turns out npcm750 memory init doesn't work
>>>     without this. npcm730 is fine either way, though I'm not sure why.
>>>   - Reworked the flash init code so it looks more like aspeed (i.e. the flash
>>>     device gets added even if there's no drive).
>>>
>>> Changes since v1 (requested by reviewers):
>>>
>>>   - Clarify the source of CLK reset values.
>>>   - Made smpboot a constant byte array, eliinated byte swapping.
>>>   - NPCM7xxState now stores an array of ARMCPUs, not pointers to ARMCPUs.
>>>   - Clarify why EL3 is disabled.
>>>   - Introduce NPCM7XX_NUM_IRQ constant.
>>>   - Set the number of CPUs according to SoC variant, and disallow command line
>>>     overrides (i.e. you can no longer override the number of CPUs with the -smp
>>>     parameter). This is trying to follow the spirit of
>>>     https://patchwork.kernel.org/patch/11595407/.
>>>   - Switch register operations to DEVICE_LITTLE_ENDIAN throughout.
>>>   - Machine documentation added (new patch).
>>>
>>> Changes since v1 to support flash booting:
>>>
>>>   - GCR reset value changes to get past memory initialization when booting
>>>     from flash (patches 2 and 5):
>>>       - INTCR2 now indicates that the DDR controller is initialized.
>>>       - INTCR3 is initialized according to DDR memory size. A realize()
>>> 	method was implemented to achieve this.
>>>   - Refactor the machine initialization a bit to make it easier to drop in
>>>     machine-specific flash initialization (patch 6).
>>>   - Extend the series with additional patches to enable booting from flash:
>>>       - Boot ROM (through the -bios option).
>>>       - OTP (fuse) controller.
>>>       - Memory Controller stub (just enough to skip memory training).
>>>       - Flash controller.
>>>       - Board-specific flash initialization.
>>>
>>> Thanks for reviewing,
>>>
>>> Havard
>>>
>>> Havard Skinnemoen (14):
>>>   hw/misc: Add NPCM7xx System Global Control Registers device model
>>>   hw/misc: Add NPCM7xx Clock Controller device model
>>>   hw/timer: Add NPCM7xx Timer device model
>>>   hw/arm: Add NPCM730 and NPCM750 SoC models
>>>   hw/arm: Add two NPCM7xx-based machines
>>>   roms: Add virtual Boot ROM for NPCM7xx SoCs
>>>   hw/arm: Load -bios image as a boot ROM for npcm7xx
>>>   hw/nvram: NPCM7xx OTP device model
>>>   hw/mem: Stubbed out NPCM7xx Memory Controller model
>>>   hw/ssi: NPCM7xx Flash Interface Unit device model
>>>   hw/arm: Wire up BMC boot flash for npcm750-evb and quanta-gsj
>>>   hw/arm/npcm7xx: add board setup stub for CPU and UART clocks
>>>   docs/system: Add Nuvoton machine documentation
>>>   tests/acceptance: console boot tests for quanta-gsj
>>>
>>>  docs/system/arm/nuvoton.rst            |  90 ++++
>>>  docs/system/target-arm.rst             |   1 +
>>>  Makefile                               |   1 +
>>>  default-configs/arm-softmmu.mak        |   1 +
>>>  include/hw/arm/npcm7xx.h               | 112 +++++
>>>  include/hw/mem/npcm7xx_mc.h            |  36 ++
>>>  include/hw/misc/npcm7xx_clk.h          |  48 +++
>>>  include/hw/misc/npcm7xx_gcr.h          |  43 ++
>>>  include/hw/nvram/npcm7xx_otp.h         |  79 ++++
>>>  include/hw/ssi/npcm7xx_fiu.h           |  73 ++++
>>>  include/hw/timer/npcm7xx_timer.h       |  78 ++++
>>>  hw/arm/npcm7xx.c                       | 532 +++++++++++++++++++++++
>>>  hw/arm/npcm7xx_boards.c                | 197 +++++++++
>>>  hw/mem/npcm7xx_mc.c                    |  84 ++++
>>>  hw/misc/npcm7xx_clk.c                  | 266 ++++++++++++
>>>  hw/misc/npcm7xx_gcr.c                  | 269 ++++++++++++
>>>  hw/nvram/npcm7xx_otp.c                 | 439 +++++++++++++++++++
>>>  hw/ssi/npcm7xx_fiu.c                   | 572 +++++++++++++++++++++++++
>>>  hw/timer/npcm7xx_timer.c               | 509 ++++++++++++++++++++++
>>>  .gitmodules                            |   3 +
>>>  MAINTAINERS                            |  10 +
>>>  hw/arm/Kconfig                         |   9 +
>>>  hw/arm/meson.build                     |   1 +
>>>  hw/mem/meson.build                     |   1 +
>>>  hw/misc/meson.build                    |   4 +
>>>  hw/misc/trace-events                   |   8 +
>>>  hw/nvram/meson.build                   |   1 +
>>>  hw/ssi/meson.build                     |   1 +
>>>  hw/ssi/trace-events                    |  11 +
>>>  hw/timer/meson.build                   |   1 +
>>>  hw/timer/trace-events                  |   5 +
>>>  pc-bios/README                         |   6 +
>>>  pc-bios/npcm7xx_bootrom.bin            | Bin 0 -> 768 bytes
>>>  roms/Makefile                          |   7 +
>>>  roms/vbootrom                          |   1 +
>>>  tests/acceptance/boot_linux_console.py |  83 ++++
>>>  36 files changed, 3582 insertions(+)
>>>  create mode 100644 docs/system/arm/nuvoton.rst
>>>  create mode 100644 include/hw/arm/npcm7xx.h
>>>  create mode 100644 include/hw/mem/npcm7xx_mc.h
>>>  create mode 100644 include/hw/misc/npcm7xx_clk.h
>>>  create mode 100644 include/hw/misc/npcm7xx_gcr.h
>>>  create mode 100644 include/hw/nvram/npcm7xx_otp.h
>>>  create mode 100644 include/hw/ssi/npcm7xx_fiu.h
>>>  create mode 100644 include/hw/timer/npcm7xx_timer.h
>>>  create mode 100644 hw/arm/npcm7xx.c
>>>  create mode 100644 hw/arm/npcm7xx_boards.c
>>>  create mode 100644 hw/mem/npcm7xx_mc.c
>>>  create mode 100644 hw/misc/npcm7xx_clk.c
>>>  create mode 100644 hw/misc/npcm7xx_gcr.c
>>>  create mode 100644 hw/nvram/npcm7xx_otp.c
>>>  create mode 100644 hw/ssi/npcm7xx_fiu.c
>>>  create mode 100644 hw/timer/npcm7xx_timer.c
>>>  create mode 100644 pc-bios/npcm7xx_bootrom.bin
>>>  create mode 160000 roms/vbootrom
>>>
>>> -- 
>>> 2.28.0.297.g1956fa8f8d-goog
>>>
>>>
>>
> 

