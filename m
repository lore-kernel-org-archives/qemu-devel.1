Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED088C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 793A82070A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk5kXPbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793A82070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZu4A-00034U-Ki
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 04:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZu2u-00022w-M7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZu2l-0002hH-KU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:55:40 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:37938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZu2l-0002gh-6r
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:55:31 -0500
Received: by mail-oi1-x230.google.com with SMTP id a14so19552369oid.5
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 01:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=9c0GMopH97NYyM9gh2npxdUA/ruLcSW48IpH9WknuBE=;
 b=Fk5kXPbOJYZ1L2Uvldo10K678/CFi2LTl+X7IowacCdEZ2lf8+RaYEGDY6xjy4F0B3
 ca/shyO+QlLIJtOt8Wu6epnjLmRoaisz+GfDjoIXga4TbAyVJskch4qtQRARrDkdlCws
 hbFGxiCvrhwBnfPR1fvIizkpAeKAvxl38X3Vf0P739wX38xuxKzAVJT9Hu1eW0AUNSzS
 7LaoBi5eKHUEsH1aIBgZO+Ap3+r870nhrKdrOrDtOf1FJBfNtzMir3s3bmf/thGyeudi
 wbw7scSEYlaM2O6JHpM6MQSvXY6YrrUgYSQmw1oXcjp4BB7HapjU5Ua7+8r3dmyCi62d
 FjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=9c0GMopH97NYyM9gh2npxdUA/ruLcSW48IpH9WknuBE=;
 b=VNUOsHuBe0ZP4RNcH20ansiFFPnliOpndPBikuIX6qpyK/sr8YyevbWMGkUbl1IMuF
 Zm62tw+qbtz085EeTDepUEaD0sb0SeSdzCZroEtdC6NVDOK74LxQBYHGRKnuRnjNmDpq
 KKycC/27UimRUCrX+75QLKia1QM6dy4jmQo2LktgP9VvhPd6AzA5Yh1Gc0p/uF1/0En6
 7Jovsl2M3mDflyAYzX5AEFmbUmQgAlc7O5SU7UQWqPZdwSsKuiqmk6jj1APfH/Y2mVtO
 zemOihJACC4iHhLcFIpN09BY2dTqcsKBVTJlxJZI9KSH5nrOpY81A1k3AcdN+aNIJ8Tg
 JmAw==
X-Gm-Message-State: APjAAAX3Cxutrjox3yao7JYTorsgA9skMmWLODj9xmJeXuSbzu2VQ84F
 zxs+1TGZeMQG9Agq9Y5q7f3wWZy22ieegXSS980=
X-Google-Smtp-Source: APXvYqywQQV9C2bCfnJSgjHFWXSlqbx2qXgKiiOuK/CRBXVe2zS6KCwOu/PP9J7tx+lrUvhiEpRWAFozzxJ6eJTxgl8=
X-Received: by 2002:aca:d985:: with SMTP id q127mr3447025oig.62.1574848529844; 
 Wed, 27 Nov 2019 01:55:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Wed, 27 Nov 2019 01:55:29
 -0800 (PST)
In-Reply-To: <20191126124433.860-6-aaron.zakhrov@gmail.com>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
 <20191126124433.860-6-aaron.zakhrov@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 27 Nov 2019 10:55:29 +0100
Message-ID: <CAL1e-=hY5b73ocsG9xiUFVuJYL36ch4=AyqjPvmtaXRUi730pQ@mail.gmail.com>
Subject: [RFC 09/10] Clean up Radeon Header files
To: "aaron.zakhrov@gmail.com" <aaron.zakhrov@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000324fa6059850ff72"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000324fa6059850ff72
Content-Type: text/plain; charset="UTF-8"

On Tuesday, November 26, 2019, <aaron.zakhrov@gmail.com> wrote:

> From: Aaron Dominick <aaron.zakhrov@gmail.com>
>
> ---


Your commit message is poor. You should have clearly explained what do you
do in this cleanup, and why.

Aleksandar


>  hw/display/atom-bits.h           |   48 -
>  hw/display/atom-names.h          |  100 -
>  hw/display/atom-types.h          |   42 -
>  hw/display/atom.h                |  160 -
>  hw/display/atombios.h            | 7981 ------------------------------
>  hw/display/avivod.h              |   62 -
>  hw/display/cayman_blit_shaders.h |   35 -
>  hw/display/ci_dpm.h              |  341 --
>  hw/display/cik_blit_shaders.h    |   32 -
>  hw/display/cikd.h                | 2172 --------
>  hw/display/r300d.h               |  343 --
>  hw/display/r420d.h               |  249 -
>  hw/display/r520d.h               |  187 -
>  hw/display/r600_blit_shaders.h   |   38 -
>  hw/display/r600_dpm.h            |  238 -
>  hw/display/r600d.h               | 2370 ---------
>  hw/display/radeon.h              | 2967 -----------
>  hw/display/radeon_acpi.h         |  456 --
>  hw/display/radeon_asic.h         |  986 ----
>  hw/display/radeon_drv.h          |  121 -
>  hw/display/radeon_family.h       |  122 -
>  hw/display/radeon_mode.h         | 1002 ----
>  hw/display/radeon_object.h       |  197 -
>  hw/display/radeon_trace.h        |  209 -
>  hw/display/radeon_ucode.h        |  227 -
>  hw/display/rs100d.h              |   40 -
>  hw/display/rs400d.h              |  160 -
>  hw/display/rs600d.h              |  685 ---
>  hw/display/rs690d.h              |  313 --
>  hw/display/rs780_dpm.h           |  109 -
>  hw/display/rs780d.h              |  171 -
>  hw/display/rv200d.h              |   36 -
>  hw/display/rv250d.h              |  123 -
>  hw/display/rv350d.h              |   52 -
>  hw/display/rv515d.h              |  638 ---
>  hw/display/rv6xx_dpm.h           |   95 -
>  hw/display/rv6xxd.h              |  246 -
>  hw/display/rv730d.h              |  165 -
>  hw/display/rv740d.h              |  117 -
>  hw/display/rv770_dpm.h           |  285 --
>  hw/display/rv770_smc.h           |  207 -
>  hw/display/rv770d.h              | 1015 ----
>  hw/display/si_blit_shaders.h     |   32 -
>  hw/display/si_dpm.h              |  238 -
>  hw/display/sid.h                 | 1956 --------
>  hw/display/sislands_smc.h        |  424 --
>  hw/display/smu7.h                |  170 -
>  hw/display/smu7_discrete.h       |  514 --
>  hw/display/smu7_fusion.h         |  300 --
>  hw/display/sumo_dpm.h            |  221 -
>  hw/display/sumod.h               |  372 --
>  hw/display/trinity_dpm.h         |  134 -
>  hw/display/trinityd.h            |  228 -
>  53 files changed, 29731 deletions(-)
>  delete mode 100644 hw/display/atom-bits.h
>  delete mode 100644 hw/display/atom-names.h
>  delete mode 100644 hw/display/atom-types.h
>  delete mode 100644 hw/display/atom.h
>  delete mode 100644 hw/display/atombios.h
>  delete mode 100644 hw/display/avivod.h
>  delete mode 100644 hw/display/cayman_blit_shaders.h
>  delete mode 100644 hw/display/ci_dpm.h
>  delete mode 100644 hw/display/cik_blit_shaders.h
>  delete mode 100644 hw/display/cikd.h
>  delete mode 100644 hw/display/r300d.h
>  delete mode 100644 hw/display/r420d.h
>  delete mode 100644 hw/display/r520d.h
>  delete mode 100644 hw/display/r600_blit_shaders.h
>  delete mode 100644 hw/display/r600_dpm.h
>  delete mode 100644 hw/display/r600d.h
>  delete mode 100644 hw/display/radeon.h
>  delete mode 100644 hw/display/radeon_acpi.h
>  delete mode 100644 hw/display/radeon_asic.h
>  delete mode 100644 hw/display/radeon_drv.h
>  delete mode 100644 hw/display/radeon_family.h
>  delete mode 100644 hw/display/radeon_mode.h
>  delete mode 100644 hw/display/radeon_object.h
>  delete mode 100644 hw/display/radeon_trace.h
>  delete mode 100644 hw/display/radeon_ucode.h
>  delete mode 100644 hw/display/rs100d.h
>  delete mode 100644 hw/display/rs400d.h
>  delete mode 100644 hw/display/rs600d.h
>  delete mode 100644 hw/display/rs690d.h
>  delete mode 100644 hw/display/rs780_dpm.h
>  delete mode 100644 hw/display/rs780d.h
>  delete mode 100644 hw/display/rv200d.h
>  delete mode 100644 hw/display/rv250d.h
>  delete mode 100644 hw/display/rv350d.h
>  delete mode 100644 hw/display/rv515d.h
>  delete mode 100644 hw/display/rv6xx_dpm.h
>  delete mode 100644 hw/display/rv6xxd.h
>  delete mode 100644 hw/display/rv730d.h
>  delete mode 100644 hw/display/rv740d.h
>  delete mode 100644 hw/display/rv770_dpm.h
>  delete mode 100644 hw/display/rv770_smc.h
>  delete mode 100644 hw/display/rv770d.h
>  delete mode 100644 hw/display/si_blit_shaders.h
>  delete mode 100644 hw/display/si_dpm.h
>  delete mode 100644 hw/display/sid.h
>  delete mode 100644 hw/display/sislands_smc.h
>  delete mode 100644 hw/display/smu7.h
>  delete mode 100644 hw/display/smu7_discrete.h
>  delete mode 100644 hw/display/smu7_fusion.h
>  delete mode 100644 hw/display/sumo_dpm.h
>  delete mode 100644 hw/display/sumod.h
>  delete mode 100644 hw/display/trinity_dpm.h
>  delete mode 100644 hw/display/trinityd.h
>
> diff --git a/hw/display/atom-bits.h b/hw/display/atom-bits.h
> deleted file mode 100644
> index e8fae5c775..0000000000
> --- a/hw/display/atom-bits.h
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -/*
> - * Copyright 2008 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the
> "Software"),
> - * to deal in the Software without restriction, including without
> limitation
> - * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be
> included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES
> OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Author: Stanislaw Skowronek
> - */
> -
> -#ifndef ATOM_BITS_H
> -#define ATOM_BITS_H
> -
> -static inline uint8_t get_u8(void *bios, int ptr)
> -{
> -    return ((unsigned char *)bios)[ptr];
> -}
> -#define U8(ptr) get_u8(ctx->ctx->bios, (ptr))
> -#define CU8(ptr) get_u8(ctx->bios, (ptr))
> -static inline uint16_t get_u16(void *bios, int ptr)
> -{
> -    return get_u8(bios ,ptr)|(((uint16_t)get_u8(bios, ptr+1))<<8);
> -}
> -#define U16(ptr) get_u16(ctx->ctx->bios, (ptr))
> -#define CU16(ptr) get_u16(ctx->bios, (ptr))
> -static inline uint32_t get_u32(void *bios, int ptr)
> -{
> -    return get_u16(bios, ptr)|(((uint32_t)get_u16(bios, ptr+2))<<16);
> -}
> -#define U32(ptr) get_u32(ctx->ctx->bios, (ptr))
> -#define CU32(ptr) get_u32(ctx->bios, (ptr))
> -#define CSTR(ptr) (((char *)(ctx->bios))+(ptr))
> -
> -#endif
> diff --git a/hw/display/atom-names.h b/hw/display/atom-names.h
> deleted file mode 100644
> index 6f907a5ffa..0000000000
> --- a/hw/display/atom-names.h
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -/*
> - * Copyright 2008 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the
> "Software"),
> - * to deal in the Software without restriction, including without
> limitation
> - * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be
> included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES
> OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Author: Stanislaw Skowronek
> - */
> -
> -#ifndef ATOM_NAMES_H
> -#define ATOM_NAMES_H
> -
> -#include "atom.h"
> -
> -#ifdef ATOM_DEBUG
> -
> -#define ATOM_OP_NAMES_CNT 123
> -static char *atom_op_names[ATOM_OP_NAMES_CNT] = {
> -"RESERVED", "MOVE_REG", "MOVE_PS", "MOVE_WS", "MOVE_FB", "MOVE_PLL",
> -"MOVE_MC", "AND_REG", "AND_PS", "AND_WS", "AND_FB", "AND_PLL", "AND_MC",
> -"OR_REG", "OR_PS", "OR_WS", "OR_FB", "OR_PLL", "OR_MC", "SHIFT_LEFT_REG",
> -"SHIFT_LEFT_PS", "SHIFT_LEFT_WS", "SHIFT_LEFT_FB", "SHIFT_LEFT_PLL",
> -"SHIFT_LEFT_MC", "SHIFT_RIGHT_REG", "SHIFT_RIGHT_PS", "SHIFT_RIGHT_WS",
> -"SHIFT_RIGHT_FB", "SHIFT_RIGHT_PLL", "SHIFT_RIGHT_MC", "MUL_REG",
> -"MUL_PS", "MUL_WS", "MUL_FB", "MUL_PLL", "MUL_MC", "DIV_REG", "DIV_PS",
> -"DIV_WS", "DIV_FB", "DIV_PLL", "DIV_MC", "ADD_REG", "ADD_PS", "ADD_WS",
> -"ADD_FB", "ADD_PLL", "ADD_MC", "SUB_REG", "SUB_PS", "SUB_WS", "SUB_FB",
> -"SUB_PLL", "SUB_MC", "SET_ATI_PORT", "SET_PCI_PORT", "SET_SYS_IO_PORT",
> -"SET_REG_BLOCK", "SET_FB_BASE", "COMPARE_REG", "COMPARE_PS",
> -"COMPARE_WS", "COMPARE_FB", "COMPARE_PLL", "COMPARE_MC", "SWITCH",
> -"JUMP", "JUMP_EQUAL", "JUMP_BELOW", "JUMP_ABOVE", "JUMP_BELOW_OR_EQUAL",
> -"JUMP_ABOVE_OR_EQUAL", "JUMP_NOT_EQUAL", "TEST_REG", "TEST_PS", "TEST_WS",
> -"TEST_FB", "TEST_PLL", "TEST_MC", "DELAY_MILLISEC", "DELAY_MICROSEC",
> -"CALL_TABLE", "REPEAT", "CLEAR_REG", "CLEAR_PS", "CLEAR_WS", "CLEAR_FB",
> -"CLEAR_PLL", "CLEAR_MC", "NOP", "EOT", "MASK_REG", "MASK_PS", "MASK_WS",
> -"MASK_FB", "MASK_PLL", "MASK_MC", "POST_CARD", "BEEP", "SAVE_REG",
> -"RESTORE_REG", "SET_DATA_BLOCK", "XOR_REG", "XOR_PS", "XOR_WS", "XOR_FB",
> -"XOR_PLL", "XOR_MC", "SHL_REG", "SHL_PS", "SHL_WS", "SHL_FB", "SHL_PLL",
> -"SHL_MC", "SHR_REG", "SHR_PS", "SHR_WS", "SHR_FB", "SHR_PLL", "SHR_MC",
> -"DEBUG", "CTB_DS",
> -};
> -
> -#define ATOM_TABLE_NAMES_CNT 74
> -static char *atom_table_names[ATOM_TABLE_NAMES_CNT] = {
> -"ASIC_Init", "GetDisplaySurfaceSize", "ASIC_RegistersInit",
> -"VRAM_BlockVenderDetection", "SetClocksRatio", "MemoryControllerInit",
> -"GPIO_PinInit", "MemoryParamAdjust", "DVOEncoderControl",
> -"GPIOPinControl", "SetEngineClock", "SetMemoryClock", "SetPixelClock",
> -"DynamicClockGating", "ResetMemoryDLL", "ResetMemoryDevice",
> -"MemoryPLLInit", "EnableMemorySelfRefresh", "AdjustMemoryController",
> -"EnableASIC_StaticPwrMgt", "ASIC_StaticPwrMgtStatusChange",
> -"DAC_LoadDetection", "TMDS2EncoderControl", "LCD1OutputControl",
> -"DAC1EncoderControl", "DAC2EncoderControl", "DVOOutputControl",
> -"CV1OutputControl", "SetCRTC_DPM_State", "TVEncoderControl",
> -"TMDS1EncoderControl", "LVDSEncoderControl", "TV1OutputControl",
> -"EnableScaler", "BlankCRTC", "EnableCRTC", "GetPixelClock",
> -"EnableVGA_Render", "EnableVGA_Access", "SetCRTC_Timing",
> -"SetCRTC_OverScan", "SetCRTC_Replication", "SelectCRTC_Source",
> -"EnableGraphSurfaces", "UpdateCRTC_DoubleBufferRegisters",
> -"LUT_AutoFill", "EnableHW_IconCursor", "GetMemoryClock",
> -"GetEngineClock", "SetCRTC_UsingDTDTiming", "TVBootUpStdPinDetection",
> -"DFP2OutputControl", "VRAM_BlockDetectionByStrap", "MemoryCleanUp",
> -"ReadEDIDFromHWAssistedI2C", "WriteOneByteToHWAssistedI2C",
> -"ReadHWAssistedI2CStatus", "SpeedFanControl", "PowerConnectorDetection",
> -"MC_Synchronization", "ComputeMemoryEnginePLL", "MemoryRefreshConversion",
> -"VRAM_GetCurrentInfoBlock", "DynamicMemorySettings", "MemoryTraining",
> -"EnableLVDS_SS", "DFP1OutputControl", "SetVoltage", "CRT1OutputControl",
> -"CRT2OutputControl", "SetupHWAssistedI2CStatus", "ClockSource",
> -"MemoryDeviceInit", "EnableYUV",
> -};
> -
> -#define ATOM_IO_NAMES_CNT 5
> -static char *atom_io_names[ATOM_IO_NAMES_CNT] = {
> -"MM", "PLL", "MC", "PCIE", "PCIE PORT",
> -};
> -
> -#else
> -
> -#define ATOM_OP_NAMES_CNT 0
> -#define ATOM_TABLE_NAMES_CNT 0
> -#define ATOM_IO_NAMES_CNT 0
> -
> -#endif
> -
> -#endif
> diff --git a/hw/display/atom-types.h b/hw/display/atom-types.h
> deleted file mode 100644
> index 1125b866cd..0000000000
> --- a/hw/display/atom-types.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/*
> - * Copyright 2008 Red Hat Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the
> "Software"),
> - * to deal in the Software without restriction, including without
> limitation
> - * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be
> included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES
> OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Author: Dave Airlie
> - */
> -
> -#ifndef ATOM_TYPES_H
> -#define ATOM_TYPES_H
> -
> -/* sync atom types to kernel types */
> -
> -typedef uint16_t USHORT;
> -typedef uint32_t ULONG;
> -typedef uint8_t UCHAR;
> -
> -
> -#ifndef ATOM_BIG_ENDIAN
> -#if defined(__BIG_ENDIAN)
> -#define ATOM_BIG_ENDIAN 1
> -#else
> -#define ATOM_BIG_ENDIAN 0
> -#endif
> -#endif
> -#endif
> diff --git a/hw/display/atom.h b/hw/display/atom.h
> deleted file mode 100644
> index 364b895e7e..0000000000
> --- a/hw/display/atom.h
> +++ /dev/null
> @@ -1,160 +0,0 @@
> -/*
> - * Copyright 2008 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the
> "Software"),
> - * to deal in the Software without restriction, including without
> limitation
> - * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be
> included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES
> OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - *
> - * Author: Stanislaw Skowronek
> - */
> -
> -#ifndef ATOM_H
> -#define ATOM_H
> -
> -#include <linux/types.h>
> -
> -#define ATOM_BIOS_MAGIC                0xAA55
> -#define ATOM_ATI_MAGIC_PTR     0x30
> -#define ATOM_ATI_MAGIC         " 761295520"
> -#define ATOM_ROM_TABLE_PTR     0x48
> -
> -#define ATOM_ROM_MAGIC         "ATOM"
> -#define ATOM_ROM_MAGIC_PTR     4
> -
> -#define ATOM_ROM_MSG_PTR       0x10
> -#define ATOM_ROM_CMD_PTR       0x1E
> -#define ATOM_ROM_DATA_PTR      0x20
> -
> -#define ATOM_CMD_INIT          0
> -#define ATOM_CMD_SETSCLK       0x0A
> -#define ATOM_CMD_SETMCLK       0x0B
> -#define ATOM_CMD_SETPCLK       0x0C
> -#define ATOM_CMD_SPDFANCNTL    0x39
> -
> -#define ATOM_DATA_FWI_PTR      0xC
> -#define ATOM_DATA_IIO_PTR      0x32
> -
> -#define ATOM_FWI_DEFSCLK_PTR   8
> -#define ATOM_FWI_DEFMCLK_PTR   0xC
> -#define ATOM_FWI_MAXSCLK_PTR   0x24
> -#define ATOM_FWI_MAXMCLK_PTR   0x28
> -
> -#define ATOM_CT_SIZE_PTR       0
> -#define ATOM_CT_WS_PTR         4
> -#define ATOM_CT_PS_PTR         5
> -#define ATOM_CT_PS_MASK                0x7F
> -#define ATOM_CT_CODE_PTR       6
> -
> -#define ATOM_OP_CNT            123
> -#define ATOM_OP_EOT            91
> -
> -#define ATOM_CASE_MAGIC                0x63
> -#define ATOM_CASE_END          0x5A5A
> -
> -#define ATOM_ARG_REG           0
> -#define ATOM_ARG_PS            1
> -#define ATOM_ARG_WS            2
> -#define ATOM_ARG_FB            3
> -#define ATOM_ARG_ID            4
> -#define ATOM_ARG_IMM           5
> -#define ATOM_ARG_PLL           6
> -#define ATOM_ARG_MC            7
> -
> -#define ATOM_SRC_DWORD         0
> -#define ATOM_SRC_WORD0         1
> -#define ATOM_SRC_WORD8         2
> -#define ATOM_SRC_WORD16                3
> -#define ATOM_SRC_BYTE0         4
> -#define ATOM_SRC_BYTE8         5
> -#define ATOM_SRC_BYTE16                6
> -#define ATOM_SRC_BYTE24                7
> -
> -#define ATOM_WS_QUOTIENT       0x40
> -#define ATOM_WS_REMAINDER      0x41
> -#define ATOM_WS_DATAPTR                0x42
> -#define ATOM_WS_SHIFT          0x43
> -#define ATOM_WS_OR_MASK                0x44
> -#define ATOM_WS_AND_MASK       0x45
> -#define ATOM_WS_FB_WINDOW      0x46
> -#define ATOM_WS_ATTRIBUTES     0x47
> -#define ATOM_WS_REGPTR         0x48
> -
> -#define ATOM_IIO_NOP           0
> -#define ATOM_IIO_START         1
> -#define ATOM_IIO_READ          2
> -#define ATOM_IIO_WRITE         3
> -#define ATOM_IIO_CLEAR         4
> -#define ATOM_IIO_SET           5
> -#define ATOM_IIO_MOVE_INDEX    6
> -#define ATOM_IIO_MOVE_ATTR     7
> -#define ATOM_IIO_MOVE_DATA     8
> -#define ATOM_IIO_END           9
> -
> -#define ATOM_IO_MM             0
> -#define ATOM_IO_PCI            1
> -#define ATOM_IO_SYSIO          2
> -#define ATOM_IO_IIO            0x80
> -
> -struct card_info {
> -       struct drm_device *dev;
> -       void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*
> filled by driver */
> -        uint32_t (* reg_read)(struct card_info *, uint32_t);          /*
> filled by driver */
> -       void (* ioreg_write)(struct card_info *, uint32_t, uint32_t);
>  /*  filled by driver */
> -        uint32_t (* ioreg_read)(struct card_info *, uint32_t);
> /*  filled by driver */
> -       void (* mc_write)(struct card_info *, uint32_t, uint32_t);   /*
> filled by driver */
> -        uint32_t (* mc_read)(struct card_info *, uint32_t);          /*
> filled by driver */
> -       void (* pll_write)(struct card_info *, uint32_t, uint32_t);   /*
> filled by driver */
> -        uint32_t (* pll_read)(struct card_info *, uint32_t);          /*
> filled by driver */
> -};
> -
> -struct atom_context {
> -       struct card_info *card;
> -       struct mutex mutex;
> -       struct mutex scratch_mutex;
> -       void *bios;
> -       uint32_t cmd_table, data_table;
> -       uint16_t *iio;
> -
> -       uint16_t data_block;
> -       uint32_t fb_base;
> -       uint32_t divmul[2];
> -       uint16_t io_attr;
> -       uint16_t reg_block;
> -       uint8_t shift;
> -       int cs_equal, cs_above;
> -       int io_mode;
> -       uint32_t *scratch;
> -       int scratch_size_bytes;
> -};
> -
> -extern int atom_debug;
> -
> -struct atom_context *atom_parse(struct card_info *, void *);
> -int atom_execute_table(struct atom_context *, int, uint32_t *);
> -int atom_execute_table_scratch_unlocked(struct atom_context *, int,
> uint32_t *);
> -int atom_asic_init(struct atom_context *);
> -void atom_destroy(struct atom_context *);
> -bool atom_parse_data_header(struct atom_context *ctx, int index, uint16_t
> *size,
> -                           uint8_t *frev, uint8_t *crev, uint16_t
> *data_start);
> -bool atom_parse_cmd_header(struct atom_context *ctx, int index,
> -                          uint8_t *frev, uint8_t *crev);
> -int atom_allocate_fb_scratch(struct atom_context *ctx);
> -#include "atom-types.h"
> -#include "atombios.h"
> -#include "ObjectID.h"
> -
> -#endif
> diff --git a/hw/display/atombios.h b/hw/display/atombios.h
> deleted file mode 100644
> index 4b86e8b450..0000000000
> --- a/hw/display/atombios.h
> +++ /dev/null
> @@ -1,7981 +0,0 @@
> -/*
> - * Copyright 2006-2007 Advanced Micro Devices, Inc.
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a
> - * copy of this software and associated documentation files (the
> "Software"),
> - * to deal in the Software without restriction, including without
> limitation
> - * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> - * and/or sell copies of the Software, and to permit persons to whom the
> - * Software is furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be
> included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES
> OR
> - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - * OTHER DEALINGS IN THE SOFTWARE.
> - */
> -
> -
> -/****************************************************************************/
>
> -/*Portion I: Definitions  shared between VBIOS and Driver
>    */
> -/**********************************************************
> ******************/
> -
> -
> -#ifndef _ATOMBIOS_H
> -#define _ATOMBIOS_H
> -
> -#define ATOM_VERSION_MAJOR                   0x00020000
> -#define ATOM_VERSION_MINOR                   0x00000002
> -
> -#define ATOM_HEADER_VERSION (ATOM_VERSION_MAJOR | ATOM_VERSION_MINOR)
> -
> -/* Endianness should be specified before inclusion,
> - * default to little endian
> - */
> -#ifndef ATOM_BIG_ENDIAN
> -#error Endian not specified
> -#endif
> -
> -#ifdef _H2INC
> -  #ifndef ULONG
> -    typedef unsigned long ULONG;
> -  #endif
> -
> -  #ifndef UCHAR
> -    typedef unsigned char UCHAR;
> -  #endif
> -
> -  #ifndef USHORT
> -    typedef unsigned short USHORT;
> -  #endif
> -#endif
> -
> -#define ATOM_DAC_A            0
> -#define ATOM_DAC_B            1
> -#define ATOM_EXT_DAC          2
> -
> -#define ATOM_CRTC1            0
> -#define ATOM_CRTC2            1
> -#define ATOM_CRTC3            2
> -#define ATOM_CRTC4            3
> -#define ATOM_CRTC5            4
> -#define ATOM_CRTC6            5
> -#define ATOM_CRTC_INVALID     0xFF
> -
> -#define ATOM_DIGA             0
> -#define ATOM_DIGB             1
> -
> -#define ATOM_PPLL1            0
> -#define ATOM_PPLL2            1
> -#define ATOM_DCPLL            2
> -#define ATOM_PPLL0            2
> -#define ATOM_PPLL3            3
> -
> -#define ATOM_EXT_PLL1         8
> -#define ATOM_EXT_PLL2         9
> -#define ATOM_EXT_CLOCK        10
> -#define ATOM_PPLL_INVALID     0xFF
> -
> -#define ENCODER_REFCLK_SRC_P1PLL       0
> -#define ENCODER_REFCLK_SRC_P2PLL       1
> -#define ENCODER_REFCLK_SRC_DCPLL       2
> -#define ENCODER_REFCLK_SRC_EXTCLK      3
> -#define ENCODER_REFCLK_SRC_INVALID     0xFF
> -
> -#define ATOM_SCALER1          0
> -#define ATOM_SCALER2          1
> -
> -#define ATOM_SCALER_DISABLE   0
> -#define ATOM_SCALER_CENTER    1
> -#define ATOM_SCALER_EXPANSION 2
> -#define ATOM_SCALER_MULTI_EX  3
> -
> -#define ATOM_DISABLE          0
> -#define ATOM_ENABLE           1
> -#define ATOM_LCD_BLOFF                          (ATOM_DISABLE+2)
> -#define ATOM_LCD_BLON                           (ATOM_ENABLE+2)
> -#define ATOM_LCD_BL_BRIGHTNESS_CONTROL          (ATOM_ENABLE+3)
> -#define ATOM_LCD_SELFTEST_START
>                               (ATOM_DISABLE+5)
> -#define ATOM_LCD_SELFTEST_STOP
>                      (ATOM_ENABLE+5)
> -#define ATOM_ENCODER_INIT
> (ATOM_DISABLE+7)
> -#define ATOM_INIT
> (ATOM_DISABLE+7)
> -#define ATOM_GET_STATUS                         (ATOM_DISABLE+8)
> -
> -#define ATOM_BLANKING         1
> -#define ATOM_BLANKING_OFF     0
> -
> -#define ATOM_CURSOR1          0
> -#define ATOM_CURSOR2          1
> -
> -#define ATOM_ICON1            0
> -#define ATOM_ICON2            1
> -
> -#define ATOM_CRT1             0
> -#define ATOM_CRT2             1
> -
> -#define ATOM_TV_NTSC          1
> -#define ATOM_TV_NTSCJ         2
> -#define ATOM_TV_PAL           3
> -#define ATOM_TV_PALM          4
> -#define ATOM_TV_PALCN         5
> -#define ATOM_TV_PALN          6
> -#define ATOM_TV_PAL60         7
> -#define ATOM_TV_SECAM         8
> -#define ATOM_TV_CV            16
> -
> -#define ATOM_DAC1_PS2         1
> -#define ATOM_DAC1_CV          2
> -#define ATOM_DAC1_NTSC        3
> -#define ATOM_DAC1_PAL         4
> -
> -#define ATOM_DAC2_PS2         ATOM_DAC1_PS2
> -#define ATOM_DAC2_CV          ATOM_DAC1_CV
> -#define ATOM_DAC2_NTSC        ATOM_DAC1_NTSC
> -#define ATOM_DAC2_PAL         ATOM_DAC1_PAL
> -
> -#define ATOM_PM_ON            0
> -#define ATOM_PM_STANDBY       1
> -#define ATOM_PM_SUSPEND       2
> -#define ATOM_PM_OFF           3
> -
> -/* Bit0:{=0:single, =1:dual},
> -   Bit1 {=0:666RGB, =1:888RGB},
> -   Bit2:3:{Grey level}
> -   Bit4:{=0:LDI format for RGB888, =1 FPDI format for RGB888}*/
> -
> -#define ATOM_PANEL_MISC_DUAL               0x00000001
> -#define ATOM_PANEL_MISC_888RGB             0x00000002
> -#define ATOM_PANEL_MISC_GREY_LEVEL         0x0000000C
> -#define ATOM_PANEL_MISC_FPDI               0x00000010
> -#define ATOM_PANEL_MISC_GREY_LEVEL_SHIFT   2
> -#define ATOM_PANEL_MISC_SPATIAL            0x00000020
> -#define ATOM_PANEL_MISC_TEMPORAL           0x00000040
> -#define ATOM_PANEL_MISC_API_ENABLED        0x00000080
> -
> -
> -#define MEMTYPE_DDR1              "DDR1"
> -#define MEMTYPE_DDR2              "DDR2"
> -#define MEMTYPE_DDR3              "DDR3"
> -#define MEMTYPE_DDR4              "DDR4"
> -
> -#define ASIC_BUS_TYPE_PCI         "PCI"
> -#define ASIC_BUS_TYPE_AGP         "AGP"
> -#define ASIC_BUS_TYPE_PCIE        "PCI_EXPRESS"
> -
> -/* Maximum size of that FireGL flag string */
> -
> -#define ATOM_FIREGL_FLAG_STRING     "FGL"             //Flag used to
> enable FireGL Support
> -#define ATOM_MAX_SIZE_OF_FIREGL_FLAG_STRING  3        //sizeof(
> ATOM_FIREGL_FLAG_STRING )
> -
> -#define ATOM_FAKE_DESKTOP_STRING    "DSK"             //Flag used to
> enable mobile ASIC on Desktop
> -#define ATOM_MAX_SIZE_OF_FAKE_DESKTOP_STRING
> ATOM_MAX_SIZE_OF_FIREGL_FLAG_STRING
> -
> -#define ATOM_M54T_FLAG_STRING       "M54T"            //Flag used to
> enable M54T Support
> -#define ATOM_MAX_SIZE_OF_M54T_FLAG_STRING    4        //sizeof(
> ATOM_M54T_FLAG_STRING )
> -
> -#define HW_ASSISTED_I2C_STATUS_FAILURE          2
> -#define HW_ASSISTED_I2C_STATUS_SUCCESS          1
> -
> -#pragma pack(1)                                       /* BIOS data must
> use byte alignment */
> -
> -/*  Define offset to location of ROM header. */
> -
> -#define OFFSET_TO_POINTER_TO_ATOM_ROM_HEADER           0x00000048L
> -#define OFFSET_TO_ATOM_ROM_IMAGE_SIZE
> 0x00000002L
> -
> -#define OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE    0x94
> -#define MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE   20    /* including the
> terminator 0x0! */
> -#define        OFFSET_TO_GET_ATOMBIOS_STRINGS_NUMBER           0x002f
> -#define        OFFSET_TO_GET_ATOMBIOS_STRINGS_START            0x006e
> -
> -/* Common header for all ROM Data tables.
> -  Every table pointed  _ATOM_MASTER_DATA_TABLE has this common header.
> -  And the pointer actually points to this header. */
> -
> -typedef struct _ATOM_COMMON_TABLE_HEADER
> -{
> -  USHORT usStructureSize;
> -  UCHAR  ucTableFormatRevision;   /*Change it when the Parser is not
> backward compatible */
> -  UCHAR  ucTableContentRevision;  /*Change it only when the table needs
> to change but the firmware */
> -                                  /*Image can't be updated, while Driver
> needs to carry the new table! */
> -}ATOM_COMMON_TABLE_HEADER;
> -
> -/****************************************************************************/
>
> -// Structure stores the ROM header.
> -/****************************************************************************/
>
> -typedef struct _ATOM_ROM_HEADER
> -{
> -  ATOM_COMMON_TABLE_HEADER             sHeader;
> -  UCHAR         uaFirmWareSignature[4];    /*Signature to distinguish
> between Atombios and non-atombios,
> -                                      atombios should init it as "ATOM",
> don't change the position */
> -  USHORT usBiosRuntimeSegmentAddress;
> -  USHORT usProtectedModeInfoOffset;
> -  USHORT usConfigFilenameOffset;
> -  USHORT usCRC_BlockOffset;
> -  USHORT usBIOS_BootupMessageOffset;
> -  USHORT usInt10Offset;
> -  USHORT usPciBusDevInitCode;
> -  USHORT usIoBaseAddress;
> -  USHORT usSubsystemVendorID;
> -  USHORT usSubsystemID;
> -  USHORT usPCI_InfoOffset;
> -  USHORT usMasterCommandTableOffset; /*Offset for SW to get all command
> table offsets, Don't change the position */
> -  USHORT usMasterDataTableOffset;   /*Offset for SW to get all data table
> offsets, Don't change the position */
> -  UCHAR  ucExtendedFunctionCode;
> -  UCHAR  ucReserved;
> -}ATOM_ROM_HEADER;
> -
> -/*==============================Command Table
> Portion==================================== */
> -
> -#ifdef UEFI_BUILD
> -       #define UTEMP   USHORT
> -       #define USHORT  void*
> -#endif
> -
> -/****************************************************************************/
>
> -// Structures used in Command.mtb
> -/****************************************************************************/
>
> -typedef struct _ATOM_MASTER_LIST_OF_COMMAND_TABLES{
> -  USHORT ASIC_Init;                              //Function Table, used
> by various SW components,latest version 1.1
> -  USHORT GetDisplaySurfaceSize;                  //Atomic Table,  Used by
> Bios when enabling HW ICON
> -  USHORT ASIC_RegistersInit;                     //Atomic Table,
> indirectly used by various SW components,called from ASIC_Init
> -  USHORT VRAM_BlockVenderDetection;              //Atomic Table,  used
> only by Bios
> -  USHORT DIGxEncoderControl;
>                               //Only used by Bios
> -  USHORT MemoryControllerInit;                   //Atomic Table,
> indirectly used by various SW components,called from ASIC_Init
> -  USHORT EnableCRTCMemReq;                       //Function
> Table,directly used by various SW components,latest version 2.1
> -  USHORT MemoryParamAdjust;
>                                //Atomic Table,  indirectly used by various
> SW components,called from SetMemoryClock if needed
> -  USHORT DVOEncoderControl;                      //Function
> Table,directly used by various SW components,latest version 1.2
> -  USHORT GPIOPinControl;
>                                               //Atomic Table,  only used by
> Bios
> -  USHORT SetEngineClock;                         //Function
> Table,directly used by various SW components,latest version 1.1
> -  USHORT SetMemoryClock;                         //Function
> Table,directly used by various SW components,latest version 1.1
> -  USHORT SetPixelClock;                          //Function
> Table,directly used by various SW components,latest version 1.2
> -  USHORT EnableDispPowerGating;                  //Atomic Table,
> indirectly used by various SW components,called from ASIC_Init
> -  USHORT ResetMemoryDLL;                         //Atomic Table,
> indirectly used by various SW components,called from SetMemoryClock
> -  USHORT ResetMemoryDevice;                      //Atomic Table,
> indirectly used by various SW components,called from SetMemoryClock
> -  USHORT MemoryPLLInit;                          //Atomic Table,  used
> only by Bios
> -  USHORT AdjustDisplayPll;
>                                       //Atomic Table,  used by various SW
> componentes.
> -  USHORT AdjustMemoryController;                 //Atomic Table,
> indirectly used by various SW components,called from SetMemoryClock
>
> -  USHORT EnableASIC_StaticPwrMgt;                //Atomic Table,  only
> used by Bios
> -  USHORT SetUniphyInstance;                      //Atomic Table,  only
> used by Bios
> -  USHORT DAC_LoadDetection;                      //Atomic Table,
> directly used by various SW components,latest version 1.2
> -  USHORT LVTMAEncoderControl;                    //Atomic Table,directly
> used by various SW components,latest version 1.3
> -  USHORT HW_Misc_Operation;                      //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT DAC1EncoderControl;                     //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT DAC2EncoderControl;                     //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT DVOOutputControl;                       //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT CV1OutputControl;                       //Atomic Table,  Atomic
> Table,  Obsolete from Ry6xx, use DAC2 Output instead
> -  USHORT GetConditionalGoldenSetting;            //Only used by Bios
> -  USHORT TVEncoderControl;                       //Function
> Table,directly used by various SW components,latest version 1.1
> -  USHORT PatchMCSetting;                         //only used by BIOS
> -  USHORT MC_SEQ_Control;                         //only used by BIOS
> -  USHORT Gfx_Harvesting;                         //Atomic Table,
> Obsolete from Ry6xx, Now only used by BIOS for GFX harvesting
> -  USHORT EnableScaler;                           //Atomic Table,  used
> only by Bios
> -  USHORT BlankCRTC;                              //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT EnableCRTC;                             //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT GetPixelClock;                          //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT EnableVGA_Render;                       //Function
> Table,directly used by various SW components,latest version 1.1
> -  USHORT GetSCLKOverMCLKRatio;                   //Atomic Table,  only
> used by Bios
> -  USHORT SetCRTC_Timing;                         //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT SetCRTC_OverScan;                       //Atomic Table,  used by
> various SW components,latest version 1.1
> -  USHORT SetCRTC_Replication;                    //Atomic Table,  used
> only by Bios
> -  USHORT SelectCRTC_Source;                      //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT EnableGraphSurfaces;                    //Atomic Table,  used
> only by Bios
> -  USHORT UpdateCRTC_DoubleBufferRegisters;                      //Atomic
> Table,  used only by Bios
> -  USHORT LUT_AutoFill;                           //Atomic Table,  only
> used by Bios
> -  USHORT EnableHW_IconCursor;                    //Atomic Table,  only
> used by Bios
> -  USHORT GetMemoryClock;                         //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT GetEngineClock;                         //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT SetCRTC_UsingDTDTiming;                 //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT ExternalEncoderControl;                 //Atomic Table,
> directly used by various SW components,latest version 2.1
> -  USHORT LVTMAOutputControl;                     //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT VRAM_BlockDetectionByStrap;             //Atomic Table,  used
> only by Bios
> -  USHORT MemoryCleanUp;                          //Atomic Table,  only
> used by Bios
> -  USHORT ProcessI2cChannelTransaction;           //Function Table,only
> used by Bios
> -  USHORT WriteOneByteToHWAssistedI2C;            //Function
> Table,indirectly used by various SW components
> -  USHORT ReadHWAssistedI2CStatus;                //Atomic Table,
> indirectly used by various SW components
> -  USHORT SpeedFanControl;                        //Function
> Table,indirectly used by various SW components,called from ASIC_Init
> -  USHORT PowerConnectorDetection;                //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT MC_Synchronization;                     //Atomic Table,
> indirectly used by various SW components,called from SetMemoryClock
> -  USHORT ComputeMemoryEnginePLL;                 //Atomic Table,
> indirectly used by various SW components,called from SetMemory/EngineClock
> -  USHORT MemoryRefreshConversion;                //Atomic Table,
> indirectly used by various SW components,called from SetMemory or
> SetEngineClock
> -  USHORT VRAM_GetCurrentInfoBlock;               //Atomic Table,  used
> only by Bios
> -  USHORT DynamicMemorySettings;                  //Atomic Table,
> indirectly used by various SW components,called from SetMemoryClock
> -  USHORT MemoryTraining;                         //Atomic Table,  used
> only by Bios
> -  USHORT EnableSpreadSpectrumOnPPLL;             //Atomic Table,
> directly used by various SW components,latest version 1.2
> -  USHORT TMDSAOutputControl;                     //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT SetVoltage;                             //Function
> Table,directly and/or indirectly used by various SW components,latest
> version 1.1
> -  USHORT DAC1OutputControl;                      //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT DAC2OutputControl;                      //Atomic Table,
> directly used by various SW components,latest version 1.1
> -  USHORT ComputeMemoryClockParam;                //Function Table,only
> used by Bios, obsolete soon.Switch to use "ReadEDIDFromHWAssistedI2C"
> -  USHORT ClockSource;                            //Atomic Table,
> indirectly used by various SW components,called from ASIC_Init
> -  USHORT MemoryDeviceInit;                       //Atomic Table,
> indirectly used by various SW components,called from SetMemoryClock
> -  USHORT GetDispObjectInfo;                      //Atomic Table,
> indirectly used by various SW components,called from EnableVGARender
> -  USHORT DIG1EncoderControl;                     //Atomic Table,directly
> used by various SW components,latest version 1.1
> -  USHORT DIG2EncoderControl;                     //Atomic Table,directly
> used by various SW components,latest version 1.1
> -  USHORT DIG1TransmitterControl;                 //Atomic Table,directly
> used by various SW components,latest version 1.1
> -  USHORT DIG2TransmitterControl;                      //Atomic
> Table,directly used by various SW components,latest version 1.1
> -  USHORT ProcessAuxChannelTransaction;
> //Function Table,only used by Bios
> -  USHORT DPEncoderService;
>                                       //Function Table,only used by Bios
> -  USHORT GetVoltageInfo;                         //Function Table,only
> used by Bios since SI
> -}ATOM_MASTER_LIST_OF_COMMAND_TABLES;
> -
> -// For backward compatible
> -#define ReadEDIDFromHWAssistedI2C
> ProcessI2cChannelTransaction
> -#define DPTranslatorControl                      DIG2EncoderControl
> -#define UNIPHYTransmitterControl
> DIG1TransmitterControl
> -#define LVTMATransmitterControl
>  DIG2TransmitterControl
> -#define SetCRTC_DPM_State
> GetConditionalGoldenSetting
> -#define ASIC_StaticPwrMgtStatusChange            SetUniphyInstance
> -#define HPDInterruptService                      ReadHWAssistedI2CStatus
> -#define EnableVGA_Access                         GetSCLKOverMCLKRatio
> -#define EnableYUV                                GetDispObjectInfo
>
> -#define DynamicClockGating                       EnableDispPowerGating
> -#define SetupHWAssistedI2CStatus                 ComputeMemoryClockParam
> -
> -#define TMDSAEncoderControl                      PatchMCSetting
> -#define LVDSEncoderControl                       MC_SEQ_Control
> -#define LCD1OutputControl                        HW_Misc_Operation
> -#define TV1OutputControl                         Gfx_Harvesting
> -
> -typedef struct _ATOM_MASTER_COMMAND_TABLE
> -{
> -  ATOM_COMMON_TABLE_HEADER           sHeader;
> -  ATOM_MASTER_LIST_OF_COMMAND_TABLES ListOfCommandTables;
> -}ATOM_MASTER_COMMAND_TABLE;
> -
> -/****************************************************************************/
>
> -// Structures used in every command table
> -/****************************************************************************/
>
> -typedef struct _ATOM_TABLE_ATTRIBUTE
> -{
> -#if ATOM_BIG_ENDIAN
> -  USHORT  UpdatedByUtility:1;         //[15]=Table updated by utility flag
> -  USHORT  PS_SizeInBytes:7;           //[14:8]=Size of parameter space in
> Bytes (multiple of a dword),
> -  USHORT  WS_SizeInBytes:8;           //[7:0]=Size of workspace in Bytes
> (in multiple of a dword),
> -#else
> -  USHORT  WS_SizeInBytes:8;           //[7:0]=Size of workspace in Bytes
> (in multiple of a dword),
> -  USHORT  PS_SizeInBytes:7;           //[14:8]=Size of parameter space in
> Bytes (multiple of a dword),
> -  USHORT  UpdatedByUtility:1;         //[15]=Table updated by utility flag
> -#endif
> -}ATOM_TABLE_ATTRIBUTE;
> -
> -typedef union _ATOM_TABLE_ATTRIBUTE_ACCESS
> -{
> -  ATOM_TABLE_ATTRIBUTE sbfAccess;
> -  USHORT               susAccess;
> -}ATOM_TABLE_ATTRIBUTE_ACCESS;
> -
> -/****************************************************************************/
>
> -// Common header for all command tables.
> -// Every table pointed by _ATOM_MASTER_COMMAND_TABLE has this common
> header.
> -// And the pointer actually points to this header.
> -/****************************************************************************/
>
> -typedef struct _ATOM_COMMON_ROM_COMMAND_TABLE_HEADER
> -{
> -  ATOM_COMMON_TABLE_HEADER CommonHeader;
> -  ATOM_TABLE_ATTRIBUTE     TableAttribute;
> -}ATOM_COMMON_ROM_COMMAND_TABLE_HEADER;
> -
> -/****************************************************************************/
>
> -// Structures used by ComputeMemoryEnginePLLTable
> -/****************************************************************************/
>
> -#define COMPUTE_MEMORY_PLL_PARAM        1
> -#define COMPUTE_ENGINE_PLL_PARAM        2
> -#define ADJUST_MC_SETTING_PARAM         3
> -
> -/****************************************************************************/
>
> -// Structures used by AdjustMemoryControllerTable
> -/****************************************************************************/
>
> -typedef struct _ATOM_ADJUST_MEMORY_CLOCK_FREQ
> -{
> -#if ATOM_BIG_ENDIAN
> -  ULONG ulPointerReturnFlag:1;      // BYTE_3[7]=1 - Return the pointer
> to the right Data Block; BYTE_3[7]=0 - Program the right Data Block
> -  ULONG ulMemoryModuleNumber:7;     // BYTE_3[6:0]
> -  ULONG ulClockFreq:24;
> -#else
> -  ULONG ulClockFreq:24;
> -  ULONG ulMemoryModuleNumber:7;     // BYTE_3[6:0]
> -  ULONG ulPointerReturnFlag:1;      // BYTE_3[7]=1 - Return the pointer
> to the right Data Block; BYTE_3[7]=0 - Program the right Data Block
> -#endif
> -}ATOM_ADJUST_MEMORY_CLOCK_FREQ;
> -#define POINTER_RETURN_FLAG             0x80
> -
> -typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS
> -{
> -  ULONG   ulClock;        //When returen, it's the re-calculated clock
> based on given Fb_div Post_Div and ref_div
> -  UCHAR   ucAction;       //0:reserved //1:Memory //2:Engine
> -  UCHAR   ucReserved;     //may expand to return larger Fbdiv later
> -  UCHAR   ucFbDiv;        //return value
> -  UCHAR   ucPostDiv;      //return value
> -}COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS;
> -
> -typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V2
> -{
> -  ULONG   ulClock;        //When return, [23:0] return real clock
> -  UCHAR   ucAction;       //0:reserved;COMPUTE_MEMORY_P
> LL_PARAM:Memory;COMPUTE_ENGINE_PLL_PARAM:Engine. it return ref_div to be
> written to register
> -  USHORT  usFbDiv;                 //return Feedback value to be written
> to register
> -  UCHAR   ucPostDiv;      //return post div to be written to register
> -}COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V2;
> -#define COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_PS_ALLOCATION
>  COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS
> -
> -
> -#define SET_CLOCK_FREQ_MASK                     0x00FFFFFF  //Clock
> change tables only take bit [23:0] as the requested clock value
> -#define USE_NON_BUS_CLOCK_MASK                  0x01000000  //Applicable
> to both memory and engine clock change, when set, it uses another clock as
> the temporary clock (engine uses memory and vice versa)
> -#define USE_MEMORY_SELF_REFRESH_MASK            0x02000000     //Only
> applicable to memory clock change, when set, using memory self refresh
> during clock transition
> -#define SKIP_INTERNAL_MEMORY_PARAMETER_CHANGE   0x04000000  //Only
> applicable to memory clock change, when set, the table will skip predefined
> internal memory parameter change
> -#define FIRST_TIME_CHANGE_CLOCK
>                               0x08000000      //Applicable to both memory
> and engine clock change,when set, it means this is 1st time to change clock
> after ASIC bootup
> -#define SKIP_SW_PROGRAM_PLL
>                                       0x10000000      //Applicable to both
> memory and engine clock change, when set, it means the table will not
> program SPLL/MPLL
> -#define USE_SS_ENABLED_PIXEL_CLOCK  USE_NON_BUS_CLOCK_MASK
> -
> -#define b3USE_NON_BUS_CLOCK_MASK                  0x01       //Applicable
> to both memory and engine clock change, when set, it uses another clock as
> the temporary clock (engine uses memory and vice versa)
> -#define b3USE_MEMORY_SELF_REFRESH                 0x02      //Only
> applicable to memory clock change, when set, using memory self refresh
> during clock transition
> -#define b3SKIP_INTERNAL_MEMORY_PARAMETER_CHANGE   0x04       //Only
> applicable to memory clock change, when set, the table will skip predefined
> internal memory parameter change
> -#define b3FIRST_TIME_CHANGE_CLOCK
>                               0x08       //Applicable to both memory and
> engine clock change,when set, it means this is 1st time to change clock
> after ASIC bootup
> -#define b3SKIP_SW_PROGRAM_PLL
>                                       0x10                     //Applicable
> to both memory and engine clock change, when set, it means the table will
> not program SPLL/MPLL
> -
> -typedef struct _ATOM_COMPUTE_CLOCK_FREQ
> -{
> -#if ATOM_BIG_ENDIAN
> -  ULONG ulComputeClockFlag:8;                 // =1:
> COMPUTE_MEMORY_PLL_PARAM, =2: COMPUTE_ENGINE_PLL_PARAM
> -  ULONG ulClockFreq:24;                       // in unit of 10kHz
> -#else
> -  ULONG ulClockFreq:24;                       // in unit of 10kHz
> -  ULONG ulComputeClockFlag:8;                 // =1:
> COMPUTE_MEMORY_PLL_PARAM, =2: COMPUTE_ENGINE_PLL_PARAM
> -#endif
> -}ATOM_COMPUTE_CLOCK_FREQ;
> -
> -typedef struct _ATOM_S_MPLL_FB_DIVIDER
> -{
> -  USHORT usFbDivFrac;
> -  USHORT usFbDiv;
> -}ATOM_S_MPLL_FB_DIVIDER;
> -
> -typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V3
> -{
> -  union
> -  {
> -    ATOM_COMPUTE_CLOCK_FREQ  ulClock;         //Input Parameter
> -    ULONG ulClockParams;                      //ULONG access for BE
> -    ATOM_S_MPLL_FB_DIVIDER   ulFbDiv;         //Output Parameter
> -  };
> -  UCHAR   ucRefDiv;                           //Output Parameter
> -  UCHAR   ucPostDiv;                          //Output Parameter
> -  UCHAR   ucCntlFlag;                         //Output Parameter
> -  UCHAR   ucReserved;
> -}COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V3;
> -
> -// ucCntlFlag
> -#define ATOM_PLL_CNTL_FLAG_PLL_POST_DIV_EN          1
> -#define ATOM_PLL_CNTL_FLAG_MPLL_VCO_MODE            2
> -#define ATOM_PLL_CNTL_FLAG_FRACTION_DISABLE         4
> -#define ATOM_PLL_CNTL_FLAG_SPLL_ISPARE_9
>                8
> -
> -
> -// V4 are only used for APU which PLL outside GPU
> -typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V4
> -{
> -#if ATOM_BIG_ENDIAN
> -  ULONG  ucPostDiv:8;        //return parameter: post divider which is
> used to program to register directly
> -  ULONG  ulClock:24;         //Input= target clock, output = actual clock
> -#else
> -  ULONG  ulClock:24;         //Input= target clock, output = actual clock
> -  ULONG  ucPostDiv:8;        //return parameter: post divider which is
> used to program to register directly
> -#endif
> -}COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V4;
> -
> -typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V5
> -{
> -  union
> -  {
> -    ATOM_COMPUTE_CLOCK_FREQ  ulClock;         //Input Parameter
> -    ULONG ulClockParams;                      //ULONG access for BE
> -    ATOM_S_MPLL_FB_DIVIDER   ulFbDiv;         //Output Parameter
> -  };
> -  UCHAR   ucRefDiv;                           //Output Parameter
> -  UCHAR   ucPostDiv;                          //Output Parameter
> -  union
> -  {
> -    UCHAR   ucCntlFlag;                       //Output Flags
> -    UCHAR   ucInputFlag;                      //Input Flags.
> ucInputFlag[0] - Strobe(1)/Performance(0) mode
> -  };
> -  UCHAR   ucReserved;
> -}COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V5;
> -
> -
> -typedef struct _COMPUTE_GPU_CLOCK_INPUT_PARAMETERS_V1_6
> -{
> -  ATOM_COMPUTE_CLOCK_FREQ  ulClock;         //Input Parameter
> -  ULONG   ulReserved[2];
> -}COMPUTE_GPU_CLOCK_INPUT_PARAMETERS_V1_6;
> -
> -//ATOM_COMPUTE_CLOCK_FREQ.ulComputeClockFlag
> -#define COMPUTE_GPUCLK_INPUT_FLAG_CLK_TYPE_MASK            0x0f
> -#define COMPUTE_GPUCLK_INPUT_FLAG_DEFAULT_GPUCLK           0x00
> -#define COMPUTE_GPUCLK_INPUT_FLAG_SCLK                     0x01
> -
> -typedef struct _COMPUTE_GPU_CLOCK_OUTPUT_PARAMETERS_V1_6
> -{
> -  COMPUTE_MEMORY_ENGINE_PLL_PARAMETERS_V4  ulClock;         //Output
> Parameter: ucPostDiv=DFS divider
> -  ATOM_S_MPLL_FB_DIVIDER   ulFbDiv;         //Output Parameter: PLL FB
> divider
> -  UCHAR   ucPllRefDiv;                      //Output Parameter: PLL ref
> divider
> -  UCHAR   ucPllPostDiv;                     //Output Parameter: PLL post
> divider
> -  UCHAR   ucPllCntlFlag;                    //Output Flags: control flag
> -  UCHAR   ucReserved;
> -}COMPUTE_GPU_CLOCK_OUTPUT_PARAMETERS_V1_6;
> -
> -//ucPllCntlFlag
> -#define SPLL_CNTL_FLAG_VCO_MODE_MASK            0x03
> -
> -
> -// ucInputFlag
> -#define ATOM_PLL_INPUT_FLAG_PLL_STROBE_MODE_EN  1   // 1-StrobeMode,
> 0-PerformanceMode
> -
> -// use for ComputeMemoryClockParamTable
> -typedef struct _COMPUTE_MEMORY_CLOCK_PARAM_PARAMETERS_V2_1
> -{
> -  union
> -  {
> -    ULONG  ulClock;
> -    ATOM_S_MPLL_FB_DIVIDER   ulFbDiv;
>  //Output:UPPER_WORD=FB_DIV_INTEGER,  LOWER_WORD=FB_DIV_FRAC shl
> (16-FB_FRACTION_BITS)
> -  };
> -  UCHAR   ucDllSpeed;                         //Output
> -  UCHAR   ucPostDiv;                          //Output
> -  union{
> -    UCHAR   ucInputFlag;                      //Input :
> ATOM_PLL_INPUT_FLAG_PLL_STROBE_MODE_EN: 1-StrobeMode, 0-PerformanceMode
> -    UCHAR   ucPllCntlFlag;                    //Output:
> -  };
> -  UCHAR   ucBWCntl;
> -}COMPUTE_MEMORY_CLOCK_PARAM_PARAMETERS_V2_1;
> -
> -// definition of ucInputFlag
> -#define MPLL_INPUT_FLAG_STROBE_MODE_EN          0x01
> -// definition of ucPllCntlFlag
> -#define MPLL_CNTL_FLAG_VCO_MODE_MASK            0x03
> -#define MPLL_CNTL_FLAG_BYPASS_DQ_PLL            0x04
> -#define MPLL_CNTL_FLAG_QDR_ENABLE               0x08
> -#define MPLL_CNTL_FLAG_AD_HALF_RATE             0x10
> -
> -//MPLL_CNTL_FLAG_BYPASS_AD_PLL has a wrong name, should be BYPASS_DQ_PLL
> -#define MPLL_CNTL_FLAG_BYPASS_AD_PLL            0x04
> -
> -typedef struct _DYNAMICE_MEMORY_SETTINGS_PARAMETER
> -{
> -  ATOM_COMPUTE_CLOCK_FREQ ulClock;
> -  ULONG ulReserved[2];
> -}DYNAMICE_MEMORY_SETTINGS_PARAMETER;
> -
> -typedef struct _DYNAMICE_ENGINE_SETTINGS_PARAMETER
> -{
> -  ATOM_COMPUTE_CLOCK_FREQ ulClock;
> -  ULONG ulMemoryClock;
> -  ULONG ulReserved;
> -}DYNAMICE_ENGINE_SETTINGS_PARAMETER;
> -
> -/****************************************************************************/
> <

--000000000000324fa6059850ff72
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, November 26, 2019,  &lt;<a href=3D"mailto:aaron.zakhrov=
@gmail.com" target=3D"_blank">aaron.zakhrov@gmail.com</a>&gt; wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">From: Aaron Dominick &lt;<a href=3D"mailto:aaro=
n.zakhrov@gmail.com" target=3D"_blank">aaron.zakhrov@gmail.com</a>&gt;<br>
<br>
---</blockquote><div><br></div><div>Your commit message is poor. You should=
 have clearly explained what do you do in this cleanup, and why.</div><div>=
<br></div><div>Aleksandar</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
=C2=A0hw/display/atom-bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A048 -<br>
=C2=A0hw/display/atom-names.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 100=
 -<br>
=C2=A0hw/display/atom-types.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A042 -<br>
=C2=A0hw/display/atom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 160 -<br>
=C2=A0hw/display/atombios.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 7981=
 ------------------------------<br>
=C2=A0hw/display/avivod.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A062 -<br>
=C2=A0hw/display/cayman_blit_shader<wbr>s.h |=C2=A0 =C2=A035 -<br>
=C2=A0hw/display/ci_dpm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 341 --<br>
=C2=A0hw/display/cik_blit_shaders.h<wbr>=C2=A0 =C2=A0 |=C2=A0 =C2=A032 -<br=
>
=C2=A0hw/display/cikd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 2172 --------<br>
=C2=A0hw/display/r300d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 343 --<br>
=C2=A0hw/display/r420d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 249 -<br>
=C2=A0hw/display/r520d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 187 -<br>
=C2=A0hw/display/r600_blit_shaders.<wbr>h=C2=A0 =C2=A0|=C2=A0 =C2=A038 -<br=
>
=C2=A0hw/display/r600_dpm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 238 -<br>
=C2=A0hw/display/r600d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 2370 ---------<br>
=C2=A0hw/display/radeon.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 2967 -----------<br>
=C2=A0hw/display/radeon_acpi.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 456=
 --<br>
=C2=A0hw/display/radeon_asic.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 986=
 ----<br>
=C2=A0hw/display/radeon_drv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 121=
 -<br>
=C2=A0hw/display/radeon_family.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 122 -<br=
>
=C2=A0hw/display/radeon_mode.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1002 ----=
<br>
=C2=A0hw/display/radeon_object.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 197 -<br=
>
=C2=A0hw/display/radeon_trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 209 -<br=
>
=C2=A0hw/display/radeon_ucode.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 227 -<br=
>
=C2=A0hw/display/rs100d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A040 -<br>
=C2=A0hw/display/rs400d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 160 -<br>
=C2=A0hw/display/rs600d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 685 ---<br>
=C2=A0hw/display/rs690d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 313 --<br>
=C2=A0hw/display/rs780_dpm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 109 -<br>
=C2=A0hw/display/rs780d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 171 -<br>
=C2=A0hw/display/rv200d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A036 -<br>
=C2=A0hw/display/rv250d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 123 -<br>
=C2=A0hw/display/rv350d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A052 -<br>
=C2=A0hw/display/rv515d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 638 ---<br>
=C2=A0hw/display/rv6xx_dpm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A095 -<br>
=C2=A0hw/display/rv6xxd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 246 -<br>
=C2=A0hw/display/rv730d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 165 -<br>
=C2=A0hw/display/rv740d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 117 -<br>
=C2=A0hw/display/rv770_dpm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 285 --<br>
=C2=A0hw/display/rv770_smc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 207 -<br>
=C2=A0hw/display/rv770d.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 1015 ----<br>
=C2=A0hw/display/si_blit_shaders.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A032 -<br=
>
=C2=A0hw/display/si_dpm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 238 -<br>
=C2=A0hw/display/sid.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 1956 --------<br>
=C2=A0hw/display/sislands_smc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 424 --<b=
r>
=C2=A0hw/display/smu7.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 170 -<br>
=C2=A0hw/display/smu7_discrete.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 514 --<b=
r>
=C2=A0hw/display/smu7_fusion.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 300=
 --<br>
=C2=A0hw/display/sumo_dpm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 221 -<br>
=C2=A0hw/display/sumod.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 372 --<br>
=C2=A0hw/display/trinity_dpm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 134=
 -<br>
=C2=A0hw/display/trinityd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 228 -<br>
=C2=A053 files changed, 29731 deletions(-)<br>
=C2=A0delete mode 100644 hw/display/atom-bits.h<br>
=C2=A0delete mode 100644 hw/display/atom-names.h<br>
=C2=A0delete mode 100644 hw/display/atom-types.h<br>
=C2=A0delete mode 100644 hw/display/atom.h<br>
=C2=A0delete mode 100644 hw/display/atombios.h<br>
=C2=A0delete mode 100644 hw/display/avivod.h<br>
=C2=A0delete mode 100644 hw/display/cayman_blit_shaders<wbr>.h<br>
=C2=A0delete mode 100644 hw/display/ci_dpm.h<br>
=C2=A0delete mode 100644 hw/display/cik_blit_shaders.h<br>
=C2=A0delete mode 100644 hw/display/cikd.h<br>
=C2=A0delete mode 100644 hw/display/r300d.h<br>
=C2=A0delete mode 100644 hw/display/r420d.h<br>
=C2=A0delete mode 100644 hw/display/r520d.h<br>
=C2=A0delete mode 100644 hw/display/r600_blit_shaders.h<br>
=C2=A0delete mode 100644 hw/display/r600_dpm.h<br>
=C2=A0delete mode 100644 hw/display/r600d.h<br>
=C2=A0delete mode 100644 hw/display/radeon.h<br>
=C2=A0delete mode 100644 hw/display/radeon_acpi.h<br>
=C2=A0delete mode 100644 hw/display/radeon_asic.h<br>
=C2=A0delete mode 100644 hw/display/radeon_drv.h<br>
=C2=A0delete mode 100644 hw/display/radeon_family.h<br>
=C2=A0delete mode 100644 hw/display/radeon_mode.h<br>
=C2=A0delete mode 100644 hw/display/radeon_object.h<br>
=C2=A0delete mode 100644 hw/display/radeon_trace.h<br>
=C2=A0delete mode 100644 hw/display/radeon_ucode.h<br>
=C2=A0delete mode 100644 hw/display/rs100d.h<br>
=C2=A0delete mode 100644 hw/display/rs400d.h<br>
=C2=A0delete mode 100644 hw/display/rs600d.h<br>
=C2=A0delete mode 100644 hw/display/rs690d.h<br>
=C2=A0delete mode 100644 hw/display/rs780_dpm.h<br>
=C2=A0delete mode 100644 hw/display/rs780d.h<br>
=C2=A0delete mode 100644 hw/display/rv200d.h<br>
=C2=A0delete mode 100644 hw/display/rv250d.h<br>
=C2=A0delete mode 100644 hw/display/rv350d.h<br>
=C2=A0delete mode 100644 hw/display/rv515d.h<br>
=C2=A0delete mode 100644 hw/display/rv6xx_dpm.h<br>
=C2=A0delete mode 100644 hw/display/rv6xxd.h<br>
=C2=A0delete mode 100644 hw/display/rv730d.h<br>
=C2=A0delete mode 100644 hw/display/rv740d.h<br>
=C2=A0delete mode 100644 hw/display/rv770_dpm.h<br>
=C2=A0delete mode 100644 hw/display/rv770_smc.h<br>
=C2=A0delete mode 100644 hw/display/rv770d.h<br>
=C2=A0delete mode 100644 hw/display/si_blit_shaders.h<br>
=C2=A0delete mode 100644 hw/display/si_dpm.h<br>
=C2=A0delete mode 100644 hw/display/sid.h<br>
=C2=A0delete mode 100644 hw/display/sislands_smc.h<br>
=C2=A0delete mode 100644 hw/display/smu7.h<br>
=C2=A0delete mode 100644 hw/display/smu7_discrete.h<br>
=C2=A0delete mode 100644 hw/display/smu7_fusion.h<br>
=C2=A0delete mode 100644 hw/display/sumo_dpm.h<br>
=C2=A0delete mode 100644 hw/display/sumod.h<br>
=C2=A0delete mode 100644 hw/display/trinity_dpm.h<br>
=C2=A0delete mode 100644 hw/display/trinityd.h<br>
<br>
diff --git a/hw/display/atom-bits.h b/hw/display/atom-bits.h<br>
deleted file mode 100644<br>
index e8fae5c775..0000000000<br>
--- a/hw/display/atom-bits.h<br>
+++ /dev/null<br>
@@ -1,48 +0,0 @@<br>
-/*<br>
- * Copyright 2008 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- * Author: Stanislaw Skowronek<br>
- */<br>
-<br>
-#ifndef ATOM_BITS_H<br>
-#define ATOM_BITS_H<br>
-<br>
-static inline uint8_t get_u8(void *bios, int ptr)<br>
-{<br>
-=C2=A0 =C2=A0 return ((unsigned char *)bios)[ptr];<br>
-}<br>
-#define U8(ptr) get_u8(ctx-&gt;ctx-&gt;bios, (ptr))<br>
-#define CU8(ptr) get_u8(ctx-&gt;bios, (ptr))<br>
-static inline uint16_t get_u16(void *bios, int ptr)<br>
-{<br>
-=C2=A0 =C2=A0 return get_u8(bios ,ptr)|(((uint16_t)get_u8(bios, ptr+1))&lt=
;&lt;8);<br>
-}<br>
-#define U16(ptr) get_u16(ctx-&gt;ctx-&gt;bios, (ptr))<br>
-#define CU16(ptr) get_u16(ctx-&gt;bios, (ptr))<br>
-static inline uint32_t get_u32(void *bios, int ptr)<br>
-{<br>
-=C2=A0 =C2=A0 return get_u16(bios, ptr)|(((uint32_t)get_u16(bios, ptr+2))&=
lt;&lt;16);<br>
-}<br>
-#define U32(ptr) get_u32(ctx-&gt;ctx-&gt;bios, (ptr))<br>
-#define CU32(ptr) get_u32(ctx-&gt;bios, (ptr))<br>
-#define CSTR(ptr) (((char *)(ctx-&gt;bios))+(ptr))<br>
-<br>
-#endif<br>
diff --git a/hw/display/atom-names.h b/hw/display/atom-names.h<br>
deleted file mode 100644<br>
index 6f907a5ffa..0000000000<br>
--- a/hw/display/atom-names.h<br>
+++ /dev/null<br>
@@ -1,100 +0,0 @@<br>
-/*<br>
- * Copyright 2008 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- * Author: Stanislaw Skowronek<br>
- */<br>
-<br>
-#ifndef ATOM_NAMES_H<br>
-#define ATOM_NAMES_H<br>
-<br>
-#include &quot;atom.h&quot;<br>
-<br>
-#ifdef ATOM_DEBUG<br>
-<br>
-#define ATOM_OP_NAMES_CNT 123<br>
-static char *atom_op_names[ATOM_OP_NAMES_C<wbr>NT] =3D {<br>
-&quot;RESERVED&quot;, &quot;MOVE_REG&quot;, &quot;MOVE_PS&quot;, &quot;MOV=
E_WS&quot;, &quot;MOVE_FB&quot;, &quot;MOVE_PLL&quot;,<br>
-&quot;MOVE_MC&quot;, &quot;AND_REG&quot;, &quot;AND_PS&quot;, &quot;AND_WS=
&quot;, &quot;AND_FB&quot;, &quot;AND_PLL&quot;, &quot;AND_MC&quot;,<br>
-&quot;OR_REG&quot;, &quot;OR_PS&quot;, &quot;OR_WS&quot;, &quot;OR_FB&quot=
;, &quot;OR_PLL&quot;, &quot;OR_MC&quot;, &quot;SHIFT_LEFT_REG&quot;,<br>
-&quot;SHIFT_LEFT_PS&quot;, &quot;SHIFT_LEFT_WS&quot;, &quot;SHIFT_LEFT_FB&=
quot;, &quot;SHIFT_LEFT_PLL&quot;,<br>
-&quot;SHIFT_LEFT_MC&quot;, &quot;SHIFT_RIGHT_REG&quot;, &quot;SHIFT_RIGHT_=
PS&quot;, &quot;SHIFT_RIGHT_WS&quot;,<br>
-&quot;SHIFT_RIGHT_FB&quot;, &quot;SHIFT_RIGHT_PLL&quot;, &quot;SHIFT_RIGHT=
_MC&quot;, &quot;MUL_REG&quot;,<br>
-&quot;MUL_PS&quot;, &quot;MUL_WS&quot;, &quot;MUL_FB&quot;, &quot;MUL_PLL&=
quot;, &quot;MUL_MC&quot;, &quot;DIV_REG&quot;, &quot;DIV_PS&quot;,<br>
-&quot;DIV_WS&quot;, &quot;DIV_FB&quot;, &quot;DIV_PLL&quot;, &quot;DIV_MC&=
quot;, &quot;ADD_REG&quot;, &quot;ADD_PS&quot;, &quot;ADD_WS&quot;,<br>
-&quot;ADD_FB&quot;, &quot;ADD_PLL&quot;, &quot;ADD_MC&quot;, &quot;SUB_REG=
&quot;, &quot;SUB_PS&quot;, &quot;SUB_WS&quot;, &quot;SUB_FB&quot;,<br>
-&quot;SUB_PLL&quot;, &quot;SUB_MC&quot;, &quot;SET_ATI_PORT&quot;, &quot;S=
ET_PCI_PORT&quot;, &quot;SET_SYS_IO_PORT&quot;,<br>
-&quot;SET_REG_BLOCK&quot;, &quot;SET_FB_BASE&quot;, &quot;COMPARE_REG&quot=
;, &quot;COMPARE_PS&quot;,<br>
-&quot;COMPARE_WS&quot;, &quot;COMPARE_FB&quot;, &quot;COMPARE_PLL&quot;, &=
quot;COMPARE_MC&quot;, &quot;SWITCH&quot;,<br>
-&quot;JUMP&quot;, &quot;JUMP_EQUAL&quot;, &quot;JUMP_BELOW&quot;, &quot;JU=
MP_ABOVE&quot;, &quot;JUMP_BELOW_OR_EQUAL&quot;,<br>
-&quot;JUMP_ABOVE_OR_EQUAL&quot;, &quot;JUMP_NOT_EQUAL&quot;, &quot;TEST_RE=
G&quot;, &quot;TEST_PS&quot;, &quot;TEST_WS&quot;,<br>
-&quot;TEST_FB&quot;, &quot;TEST_PLL&quot;, &quot;TEST_MC&quot;, &quot;DELA=
Y_MILLISEC&quot;, &quot;DELAY_MICROSEC&quot;,<br>
-&quot;CALL_TABLE&quot;, &quot;REPEAT&quot;, &quot;CLEAR_REG&quot;, &quot;C=
LEAR_PS&quot;, &quot;CLEAR_WS&quot;, &quot;CLEAR_FB&quot;,<br>
-&quot;CLEAR_PLL&quot;, &quot;CLEAR_MC&quot;, &quot;NOP&quot;, &quot;EOT&qu=
ot;, &quot;MASK_REG&quot;, &quot;MASK_PS&quot;, &quot;MASK_WS&quot;,<br>
-&quot;MASK_FB&quot;, &quot;MASK_PLL&quot;, &quot;MASK_MC&quot;, &quot;POST=
_CARD&quot;, &quot;BEEP&quot;, &quot;SAVE_REG&quot;,<br>
-&quot;RESTORE_REG&quot;, &quot;SET_DATA_BLOCK&quot;, &quot;XOR_REG&quot;, =
&quot;XOR_PS&quot;, &quot;XOR_WS&quot;, &quot;XOR_FB&quot;,<br>
-&quot;XOR_PLL&quot;, &quot;XOR_MC&quot;, &quot;SHL_REG&quot;, &quot;SHL_PS=
&quot;, &quot;SHL_WS&quot;, &quot;SHL_FB&quot;, &quot;SHL_PLL&quot;,<br>
-&quot;SHL_MC&quot;, &quot;SHR_REG&quot;, &quot;SHR_PS&quot;, &quot;SHR_WS&=
quot;, &quot;SHR_FB&quot;, &quot;SHR_PLL&quot;, &quot;SHR_MC&quot;,<br>
-&quot;DEBUG&quot;, &quot;CTB_DS&quot;,<br>
-};<br>
-<br>
-#define ATOM_TABLE_NAMES_CNT 74<br>
-static char *atom_table_names[ATOM_TABLE_N<wbr>AMES_CNT] =3D {<br>
-&quot;ASIC_Init&quot;, &quot;GetDisplaySurfaceSize&quot;, &quot;ASIC_Regis=
tersInit&quot;,<br>
-&quot;VRAM_BlockVenderDetection&quot;, &quot;SetClocksRatio&quot;, &quot;M=
emoryControllerInit&quot;,<br>
-&quot;GPIO_PinInit&quot;, &quot;MemoryParamAdjust&quot;, &quot;DVOEncoderC=
ontrol&quot;,<br>
-&quot;GPIOPinControl&quot;, &quot;SetEngineClock&quot;, &quot;SetMemoryClo=
ck&quot;, &quot;SetPixelClock&quot;,<br>
-&quot;DynamicClockGating&quot;, &quot;ResetMemoryDLL&quot;, &quot;ResetMem=
oryDevice&quot;,<br>
-&quot;MemoryPLLInit&quot;, &quot;EnableMemorySelfRefresh&quot;, &quot;Adju=
stMemoryController&quot;,<br>
-&quot;EnableASIC_StaticPwrMgt&quot;, &quot;ASIC_StaticPwrMgtStatusChange<w=
br>&quot;,<br>
-&quot;DAC_LoadDetection&quot;, &quot;TMDS2EncoderControl&quot;, &quot;LCD1=
OutputControl&quot;,<br>
-&quot;DAC1EncoderControl&quot;, &quot;DAC2EncoderControl&quot;, &quot;DVOO=
utputControl&quot;,<br>
-&quot;CV1OutputControl&quot;, &quot;SetCRTC_DPM_State&quot;, &quot;TVEncod=
erControl&quot;,<br>
-&quot;TMDS1EncoderControl&quot;, &quot;LVDSEncoderControl&quot;, &quot;TV1=
OutputControl&quot;,<br>
-&quot;EnableScaler&quot;, &quot;BlankCRTC&quot;, &quot;EnableCRTC&quot;, &=
quot;GetPixelClock&quot;,<br>
-&quot;EnableVGA_Render&quot;, &quot;EnableVGA_Access&quot;, &quot;SetCRTC_=
Timing&quot;,<br>
-&quot;SetCRTC_OverScan&quot;, &quot;SetCRTC_Replication&quot;, &quot;Selec=
tCRTC_Source&quot;,<br>
-&quot;EnableGraphSurfaces&quot;, &quot;UpdateCRTC_DoubleBufferRegist<wbr>e=
rs&quot;,<br>
-&quot;LUT_AutoFill&quot;, &quot;EnableHW_IconCursor&quot;, &quot;GetMemory=
Clock&quot;,<br>
-&quot;GetEngineClock&quot;, &quot;SetCRTC_UsingDTDTiming&quot;, &quot;TVBo=
otUpStdPinDetection&quot;,<br>
-&quot;DFP2OutputControl&quot;, &quot;VRAM_BlockDetectionByStrap&quot;, &qu=
ot;MemoryCleanUp&quot;,<br>
-&quot;ReadEDIDFromHWAssistedI2C&quot;, &quot;WriteOneByteToHWAssistedI2C&q=
uot;,<br>
-&quot;ReadHWAssistedI2CStatus&quot;, &quot;SpeedFanControl&quot;, &quot;Po=
werConnectorDetection&quot;,<br>
-&quot;MC_Synchronization&quot;, &quot;ComputeMemoryEnginePLL&quot;, &quot;=
MemoryRefreshConversion&quot;,<br>
-&quot;VRAM_GetCurrentInfoBlock&quot;, &quot;DynamicMemorySettings&quot;, &=
quot;MemoryTraining&quot;,<br>
-&quot;EnableLVDS_SS&quot;, &quot;DFP1OutputControl&quot;, &quot;SetVoltage=
&quot;, &quot;CRT1OutputControl&quot;,<br>
-&quot;CRT2OutputControl&quot;, &quot;SetupHWAssistedI2CStatus&quot;, &quot=
;ClockSource&quot;,<br>
-&quot;MemoryDeviceInit&quot;, &quot;EnableYUV&quot;,<br>
-};<br>
-<br>
-#define ATOM_IO_NAMES_CNT 5<br>
-static char *atom_io_names[ATOM_IO_NAMES_C<wbr>NT] =3D {<br>
-&quot;MM&quot;, &quot;PLL&quot;, &quot;MC&quot;, &quot;PCIE&quot;, &quot;P=
CIE PORT&quot;,<br>
-};<br>
-<br>
-#else<br>
-<br>
-#define ATOM_OP_NAMES_CNT 0<br>
-#define ATOM_TABLE_NAMES_CNT 0<br>
-#define ATOM_IO_NAMES_CNT 0<br>
-<br>
-#endif<br>
-<br>
-#endif<br>
diff --git a/hw/display/atom-types.h b/hw/display/atom-types.h<br>
deleted file mode 100644<br>
index 1125b866cd..0000000000<br>
--- a/hw/display/atom-types.h<br>
+++ /dev/null<br>
@@ -1,42 +0,0 @@<br>
-/*<br>
- * Copyright 2008 Red Hat Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- * Author: Dave Airlie<br>
- */<br>
-<br>
-#ifndef ATOM_TYPES_H<br>
-#define ATOM_TYPES_H<br>
-<br>
-/* sync atom types to kernel types */<br>
-<br>
-typedef uint16_t USHORT;<br>
-typedef uint32_t ULONG;<br>
-typedef uint8_t UCHAR;<br>
-<br>
-<br>
-#ifndef ATOM_BIG_ENDIAN<br>
-#if defined(__BIG_ENDIAN)<br>
-#define ATOM_BIG_ENDIAN 1<br>
-#else<br>
-#define ATOM_BIG_ENDIAN 0<br>
-#endif<br>
-#endif<br>
-#endif<br>
diff --git a/hw/display/atom.h b/hw/display/atom.h<br>
deleted file mode 100644<br>
index 364b895e7e..0000000000<br>
--- a/hw/display/atom.h<br>
+++ /dev/null<br>
@@ -1,160 +0,0 @@<br>
-/*<br>
- * Copyright 2008 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- * Author: Stanislaw Skowronek<br>
- */<br>
-<br>
-#ifndef ATOM_H<br>
-#define ATOM_H<br>
-<br>
-#include &lt;linux/types.h&gt;<br>
-<br>
-#define ATOM_BIOS_MAGIC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0xAA55<br>
-#define ATOM_ATI_MAGIC_PTR=C2=A0 =C2=A0 =C2=A00x30<br>
-#define ATOM_ATI_MAGIC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; 761295520&q=
uot;<br>
-#define ATOM_ROM_TABLE_PTR=C2=A0 =C2=A0 =C2=A00x48<br>
-<br>
-#define ATOM_ROM_MAGIC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;ATOM&quot;<b=
r>
-#define ATOM_ROM_MAGIC_PTR=C2=A0 =C2=A0 =C2=A04<br>
-<br>
-#define ATOM_ROM_MSG_PTR=C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>
-#define ATOM_ROM_CMD_PTR=C2=A0 =C2=A0 =C2=A0 =C2=A00x1E<br>
-#define ATOM_ROM_DATA_PTR=C2=A0 =C2=A0 =C2=A0 0x20<br>
-<br>
-#define ATOM_CMD_INIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-#define ATOM_CMD_SETSCLK=C2=A0 =C2=A0 =C2=A0 =C2=A00x0A<br>
-#define ATOM_CMD_SETMCLK=C2=A0 =C2=A0 =C2=A0 =C2=A00x0B<br>
-#define ATOM_CMD_SETPCLK=C2=A0 =C2=A0 =C2=A0 =C2=A00x0C<br>
-#define ATOM_CMD_SPDFANCNTL=C2=A0 =C2=A0 0x39<br>
-<br>
-#define ATOM_DATA_FWI_PTR=C2=A0 =C2=A0 =C2=A0 0xC<br>
-#define ATOM_DATA_IIO_PTR=C2=A0 =C2=A0 =C2=A0 0x32<br>
-<br>
-#define ATOM_FWI_DEFSCLK_PTR=C2=A0 =C2=A08<br>
-#define ATOM_FWI_DEFMCLK_PTR=C2=A0 =C2=A00xC<br>
-#define ATOM_FWI_MAXSCLK_PTR=C2=A0 =C2=A00x24<br>
-#define ATOM_FWI_MAXMCLK_PTR=C2=A0 =C2=A00x28<br>
-<br>
-#define ATOM_CT_SIZE_PTR=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
-#define ATOM_CT_WS_PTR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<br>
-#define ATOM_CT_PS_PTR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05<br>
-#define ATOM_CT_PS_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x7F<br>
-#define ATOM_CT_CODE_PTR=C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
-<br>
-#define ATOM_OP_CNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 123<br>
-#define ATOM_OP_EOT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 91<br>
-<br>
-#define ATOM_CASE_MAGIC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x63<br>
-#define ATOM_CASE_END=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x5A5A<br>
-<br>
-#define ATOM_ARG_REG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
-#define ATOM_ARG_PS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-#define ATOM_ARG_WS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
-#define ATOM_ARG_FB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
-#define ATOM_ARG_ID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
-#define ATOM_ARG_IMM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05<br>
-#define ATOM_ARG_PLL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
-#define ATOM_ARG_MC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 7<br>
-<br>
-#define ATOM_SRC_DWORD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
-#define ATOM_SRC_WORD0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
-#define ATOM_SRC_WORD8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
-#define ATOM_SRC_WORD16=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 3<br>
-#define ATOM_SRC_BYTE0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<br>
-#define ATOM_SRC_BYTE8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05<br>
-#define ATOM_SRC_BYTE16=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 6<br>
-#define ATOM_SRC_BYTE24=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 7<br>
-<br>
-#define ATOM_WS_QUOTIENT=C2=A0 =C2=A0 =C2=A0 =C2=A00x40<br>
-#define ATOM_WS_REMAINDER=C2=A0 =C2=A0 =C2=A0 0x41<br>
-#define ATOM_WS_DATAPTR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x42<br>
-#define ATOM_WS_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x43<br>
-#define ATOM_WS_OR_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x44<br>
-#define ATOM_WS_AND_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x45<br>
-#define ATOM_WS_FB_WINDOW=C2=A0 =C2=A0 =C2=A0 0x46<br>
-#define ATOM_WS_ATTRIBUTES=C2=A0 =C2=A0 =C2=A00x47<br>
-#define ATOM_WS_REGPTR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x48<br>
-<br>
-#define ATOM_IIO_NOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
-#define ATOM_IIO_START=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
-#define ATOM_IIO_READ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
-#define ATOM_IIO_WRITE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
-#define ATOM_IIO_CLEAR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<br>
-#define ATOM_IIO_SET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05<br>
-#define ATOM_IIO_MOVE_INDEX=C2=A0 =C2=A0 6<br>
-#define ATOM_IIO_MOVE_ATTR=C2=A0 =C2=A0 =C2=A07<br>
-#define ATOM_IIO_MOVE_DATA=C2=A0 =C2=A0 =C2=A08<br>
-#define ATOM_IIO_END=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09<br>
-<br>
-#define ATOM_IO_MM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
-#define ATOM_IO_PCI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-#define ATOM_IO_SYSIO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
-#define ATOM_IO_IIO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x80<br>
-<br>
-struct card_info {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_device *dev;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void (* reg_write)(struct card_info *, uint32_t=
, uint32_t);=C2=A0 =C2=A0/*=C2=A0 filled by driver */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t (* reg_read)(struct card_info *, uint=
32_t);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 filled by driver */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void (* ioreg_write)(struct card_info *, uint32=
_t, uint32_t);=C2=A0 =C2=A0/*=C2=A0 filled by driver */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t (* ioreg_read)(struct card_info *, ui=
nt32_t);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 filled by driver */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void (* mc_write)(struct card_info *, uint32_t,=
 uint32_t);=C2=A0 =C2=A0/*=C2=A0 filled by driver */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t (* mc_read)(struct card_info *, uint3=
2_t);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 filled by driver */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void (* pll_write)(struct card_info *, uint32_t=
, uint32_t);=C2=A0 =C2=A0/*=C2=A0 filled by driver */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t (* pll_read)(struct card_info *, uint=
32_t);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 filled by driver */<br>
-};<br>
-<br>
-struct atom_context {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct card_info *card;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex mutex;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0struct mutex scratch_mutex;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0void *bios;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t cmd_table, data_table;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t *iio;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t data_block;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t fb_base;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t divmul[2];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t io_attr;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t reg_block;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t shift;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int cs_equal, cs_above;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int io_mode;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *scratch;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int scratch_size_bytes;<br>
-};<br>
-<br>
-extern int atom_debug;<br>
-<br>
-struct atom_context *atom_parse(struct card_info *, void *);<br>
-int atom_execute_table(struct atom_context *, int, uint32_t *);<br>
-int atom_execute_table_scratch_unl<wbr>ocked(struct atom_context *, int, u=
int32_t *);<br>
-int atom_asic_init(struct atom_context *);<br>
-void atom_destroy(struct atom_context *);<br>
-bool atom_parse_data_header(struct atom_context *ctx, int index, uint16_t =
*size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *frev, uint8_t *crev, uint16_t *data_start)=
;<br>
-bool atom_parse_cmd_header(struct atom_context *ctx, int index,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint8_t *frev, uint8_t *crev);<br>
-int atom_allocate_fb_scratch(struc<wbr>t atom_context *ctx);<br>
-#include &quot;atom-types.h&quot;<br>
-#include &quot;atombios.h&quot;<br>
-#include &quot;ObjectID.h&quot;<br>
-<br>
-#endif<br>
diff --git a/hw/display/atombios.h b/hw/display/atombios.h<br>
deleted file mode 100644<br>
index 4b86e8b450..0000000000<br>
--- a/hw/display/atombios.h<br>
+++ /dev/null<br>
@@ -1,7981 +0,0 @@<br>
-/*<br>
- * Copyright 2006-2007 Advanced Micro Devices, Inc.=C2=A0 <br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.=C2=A0 IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- */<br>
-<br>
-<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-/*Portion I: Definitions=C2=A0 shared between VBIOS and Driver=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-/****************************<wbr>******************************<wbr>*****=
*************/<br>
-<br>
-<br>
-#ifndef _ATOMBIOS_H<br>
-#define _ATOMBIOS_H<br>
-<br>
-#define ATOM_VERSION_MAJOR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00x00020000<br>
-#define ATOM_VERSION_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00x00000002<br>
-<br>
-#define ATOM_HEADER_VERSION (ATOM_VERSION_MAJOR | ATOM_VERSION_MINOR)<br>
-<br>
-/* Endianness should be specified before inclusion,<br>
- * default to little endian<br>
- */<br>
-#ifndef ATOM_BIG_ENDIAN<br>
-#error Endian not specified<br>
-#endif<br>
-<br>
-#ifdef _H2INC<br>
-=C2=A0 #ifndef ULONG <br>
-=C2=A0 =C2=A0 typedef unsigned long ULONG;<br>
-=C2=A0 #endif<br>
-<br>
-=C2=A0 #ifndef UCHAR<br>
-=C2=A0 =C2=A0 typedef unsigned char UCHAR;<br>
-=C2=A0 #endif<br>
-<br>
-=C2=A0 #ifndef USHORT <br>
-=C2=A0 =C2=A0 typedef unsigned short USHORT;<br>
-=C2=A0 #endif<br>
-#endif<br>
-=C2=A0 =C2=A0 =C2=A0 <br>
-#define ATOM_DAC_A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0 <br>
-#define ATOM_DAC_B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-#define ATOM_EXT_DAC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
-<br>
-#define ATOM_CRTC1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-#define ATOM_CRTC2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-#define ATOM_CRTC3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
-#define ATOM_CRTC4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
-#define ATOM_CRTC5=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
-#define ATOM_CRTC6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 5<br>
-#define ATOM_CRTC_INVALID=C2=A0 =C2=A0 =C2=A00xFF<br>
-<br>
-#define ATOM_DIGA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
-#define ATOM_DIGB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
-<br>
-#define ATOM_PPLL1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-#define ATOM_PPLL2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-#define ATOM_DCPLL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
-#define ATOM_PPLL0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
-#define ATOM_PPLL3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
-<br>
-#define ATOM_EXT_PLL1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08<br>
-#define ATOM_EXT_PLL2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09<br>
-#define ATOM_EXT_CLOCK=C2=A0 =C2=A0 =C2=A0 =C2=A0 10<br>
-#define ATOM_PPLL_INVALID=C2=A0 =C2=A0 =C2=A00xFF<br>
-<br>
-#define ENCODER_REFCLK_SRC_P1PLL=C2=A0 =C2=A0 =C2=A0 =C2=A00=C2=A0 =C2=A0 =
=C2=A0 =C2=A0<br>
-#define ENCODER_REFCLK_SRC_P2PLL=C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
-#define ENCODER_REFCLK_SRC_DCPLL=C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
-#define ENCODER_REFCLK_SRC_EXTCLK=C2=A0 =C2=A0 =C2=A0 3<br>
-#define ENCODER_REFCLK_SRC_INVALID=C2=A0 =C2=A0 =C2=A00xFF<br>
-<br>
-#define ATOM_SCALER1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-#define ATOM_SCALER2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-<br>
-#define ATOM_SCALER_DISABLE=C2=A0 =C2=A00=C2=A0 =C2=A0<br>
-#define ATOM_SCALER_CENTER=C2=A0 =C2=A0 1=C2=A0 =C2=A0<br>
-#define ATOM_SCALER_EXPANSION 2=C2=A0 =C2=A0<br>
-#define ATOM_SCALER_MULTI_EX=C2=A0 3=C2=A0 =C2=A0<br>
-<br>
-#define ATOM_DISABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-#define ATOM_ENABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
-#define ATOM_LCD_BLOFF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ATOM_DISABLE+2)<br>
-#define ATOM_LCD_BLON=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ATOM_ENABLE+2)<br>
-#define ATOM_LCD_BL_BRIGHTNESS_CONTROL<wbr>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (ATOM_ENABLE+3)<br>
-#define ATOM_LCD_SELFTEST_START=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ATOM_DISABL=
E+5)<br>
-#define ATOM_LCD_SELFTEST_STOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ATOM_ENABLE+5)<br>
-#define ATOM_ENCODER_INIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (ATOM_DISABLE+7)<br>
-#define ATOM_INIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ATOM_DISABLE+7)<br>
-#define ATOM_GET_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ATOM_DISABLE+8)<br>
-<br>
-#define ATOM_BLANKING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
-#define ATOM_BLANKING_OFF=C2=A0 =C2=A0 =C2=A00<br>
-<br>
-#define ATOM_CURSOR1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-#define ATOM_CURSOR2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-<br>
-#define ATOM_ICON1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-#define ATOM_ICON2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-<br>
-#define ATOM_CRT1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
-#define ATOM_CRT2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
-<br>
-#define ATOM_TV_NTSC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-#define ATOM_TV_NTSCJ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
-#define ATOM_TV_PAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
-#define ATOM_TV_PALM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
-#define ATOM_TV_PALCN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A05<br>
-#define ATOM_TV_PALN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6<br>
-#define ATOM_TV_PAL60=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A07<br>
-#define ATOM_TV_SECAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08<br>
-#define ATOM_TV_CV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 16<br>
-<br>
-#define ATOM_DAC1_PS2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
-#define ATOM_DAC1_CV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
-#define ATOM_DAC1_NTSC=C2=A0 =C2=A0 =C2=A0 =C2=A0 3<br>
-#define ATOM_DAC1_PAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<br>
-<br>
-#define ATOM_DAC2_PS2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ATOM_DAC1_PS2<br>
-#define ATOM_DAC2_CV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ATOM_DAC1_CV<br>
-#define ATOM_DAC2_NTSC=C2=A0 =C2=A0 =C2=A0 =C2=A0 ATOM_DAC1_NTSC<br>
-#define ATOM_DAC2_PAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ATOM_DAC1_PAL<br>
- <br>
-#define ATOM_PM_ON=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-#define ATOM_PM_STANDBY=C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
-#define ATOM_PM_SUSPEND=C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
-#define ATOM_PM_OFF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
-<br>
-/* Bit0:{=3D0:single, =3D1:dual},<br>
-=C2=A0 =C2=A0Bit1 {=3D0:666RGB, =3D1:888RGB},<br>
-=C2=A0 =C2=A0Bit2:3:{Grey level}<br>
-=C2=A0 =C2=A0Bit4:{=3D0:LDI format for RGB888, =3D1 FPDI format for RGB888=
}*/<br>
-<br>
-#define ATOM_PANEL_MISC_DUAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x00000001<br>
-#define ATOM_PANEL_MISC_888RGB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x00000002<br>
-#define ATOM_PANEL_MISC_GREY_LEVEL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0000=
000C<br>
-#define ATOM_PANEL_MISC_FPDI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x00000010<br>
-#define ATOM_PANEL_MISC_GREY_LEVEL_SHI<wbr>FT=C2=A0 =C2=A02<br>
-#define ATOM_PANEL_MISC_SPATIAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0=
x00000020<br>
-#define ATOM_PANEL_MISC_TEMPORAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=
x00000040<br>
-#define ATOM_PANEL_MISC_API_ENABLED=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000080<=
br>
-<br>
-<br>
-#define MEMTYPE_DDR1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;DDR1&quot;<br>
-#define MEMTYPE_DDR2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;DDR2&quot;<br>
-#define MEMTYPE_DDR3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;DDR3&quot;<br>
-#define MEMTYPE_DDR4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
;DDR4&quot;<br>
-<br>
-#define ASIC_BUS_TYPE_PCI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;PCI&quot;=
<br>
-#define ASIC_BUS_TYPE_AGP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;AGP&quot;=
<br>
-#define ASIC_BUS_TYPE_PCIE=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;PCI_EXPRESS&qu=
ot;<br>
-<br>
-/* Maximum size of that FireGL flag string */<br>
-<br>
-#define ATOM_FIREGL_FLAG_STRING=C2=A0 =C2=A0 =C2=A0&quot;FGL&quot;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Flag used to enable FireGL Suppo=
rt<br>
-#define ATOM_MAX_SIZE_OF_FIREGL_FLAG_S<wbr>TRING=C2=A0 3=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 //sizeof( ATOM_FIREGL_FLAG_STRING )<br>
-<br>
-#define ATOM_FAKE_DESKTOP_STRING=C2=A0 =C2=A0 &quot;DSK&quot;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Flag used to enable mobile ASIC on Des=
ktop<br>
-#define ATOM_MAX_SIZE_OF_FAKE_DESKTOP_<wbr>STRING=C2=A0 ATOM_MAX_SIZE_OF_F=
IREGL_FLAG_S<wbr>TRING <br>
-<br>
-#define ATOM_M54T_FLAG_STRING=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;M54T&quot;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Flag used to enable M54T Suppor=
t<br>
-#define ATOM_MAX_SIZE_OF_M54T_FLAG_STR<wbr>ING=C2=A0 =C2=A0 4=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 //sizeof( ATOM_M54T_FLAG_STRING )<br>
-<br>
-#define HW_ASSISTED_I2C_STATUS_FAILURE<wbr>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 2<br>
-#define HW_ASSISTED_I2C_STATUS_SUCCESS<wbr>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1<br>
-<br>
-#pragma pack(1)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* BIOS data must use byte alignment */<br>
-<br>
-/*=C2=A0 Define offset to location of ROM header. */<br>
-<br>
-#define OFFSET_TO_POINTER_TO_ATOM_ROM_<wbr>HEADER=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x00000048L<br>
-#define OFFSET_TO_ATOM_ROM_IMAGE_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000=
00002L<br>
-<br>
-#define OFFSET_TO_ATOMBIOS_ASIC_BUS_ME<wbr>M_TYPE=C2=A0 =C2=A0 0x94<br>
-#define MAXSIZE_OF_ATOMBIOS_ASIC_BUS_M<wbr>EM_TYPE=C2=A0 =C2=A020=C2=A0 =
=C2=A0 /* including the terminator 0x0! */<br>
-#define=C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_TO_GET_ATOMBIOS_STRINGS<wbr>_NUM=
BER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x002f<br>
-#define=C2=A0 =C2=A0 =C2=A0 =C2=A0 OFFSET_TO_GET_ATOMBIOS_STRINGS<wbr>_STA=
RT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x006e<br>
-<br>
-/* Common header for all ROM Data tables.<br>
-=C2=A0 Every table pointed=C2=A0 _ATOM_MASTER_DATA_TABLE has this common h=
eader. <br>
-=C2=A0 And the pointer actually points to this header. */<br>
-<br>
-typedef struct _ATOM_COMMON_TABLE_HEADER<br>
-{<br>
-=C2=A0 USHORT usStructureSize;<br>
-=C2=A0 UCHAR=C2=A0 ucTableFormatRevision;=C2=A0 =C2=A0/*Change it when the=
 Parser is not backward compatible */<br>
-=C2=A0 UCHAR=C2=A0 ucTableContentRevision;=C2=A0 /*Change it only when the=
 table needs to change but the firmware */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*Image can&#39;t be updated,=
 while Driver needs to carry the new table! */<br>
-}ATOM_COMMON_TABLE_HEADER;<br>
-<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-// Structure stores the ROM header.<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-typedef struct _ATOM_ROM_HEADER<br>
-{<br>
-=C2=A0 ATOM_COMMON_TABLE_HEADER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0sHeader;<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uaFirmWareSignature[4];=C2=
=A0 =C2=A0 /*Signature to distinguish between Atombios and non-atombios, <b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 atombios should=
 init it as &quot;ATOM&quot;, don&#39;t change the position */<br>
-=C2=A0 USHORT usBiosRuntimeSegmentAddress;<br>
-=C2=A0 USHORT usProtectedModeInfoOffset;<br>
-=C2=A0 USHORT usConfigFilenameOffset;<br>
-=C2=A0 USHORT usCRC_BlockOffset;<br>
-=C2=A0 USHORT usBIOS_BootupMessageOffset;<br>
-=C2=A0 USHORT usInt10Offset;<br>
-=C2=A0 USHORT usPciBusDevInitCode;<br>
-=C2=A0 USHORT usIoBaseAddress;<br>
-=C2=A0 USHORT usSubsystemVendorID;<br>
-=C2=A0 USHORT usSubsystemID;<br>
-=C2=A0 USHORT usPCI_InfoOffset; <br>
-=C2=A0 USHORT usMasterCommandTableOffset; /*Offset for SW to get all comma=
nd table offsets, Don&#39;t change the position */<br>
-=C2=A0 USHORT usMasterDataTableOffset;=C2=A0 =C2=A0/*Offset for SW to get =
all data table offsets, Don&#39;t change the position */<br>
-=C2=A0 UCHAR=C2=A0 ucExtendedFunctionCode;<br>
-=C2=A0 UCHAR=C2=A0 ucReserved;<br>
-}ATOM_ROM_HEADER;<br>
-<br>
-/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<wbr>=3D=3D=3DCommand Table Portion=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<wbr>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D */<br>
-<br>
-#ifdef UEFI_BUILD<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0#define UTEMP=C2=A0 =C2=A0USHORT<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0#define USHORT=C2=A0 void*<br>
-#endif<br>
-<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-// Structures used in Command.mtb <br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-typedef struct _ATOM_MASTER_LIST_OF_COMMAND_T<wbr>ABLES{<br>
-=C2=A0 USHORT ASIC_Init;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Function Table, u=
sed by various SW components,latest version 1.1<br>
-=C2=A0 USHORT GetDisplaySurfaceSize;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 Used by Bios when enabling H=
W ICON<br>
-=C2=A0 USHORT ASIC_RegistersInit;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 indirectly used by=
 various SW components,called from ASIC_Init<br>
-=C2=A0 USHORT VRAM_BlockVenderDetection;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 used only by Bios<br>
-=C2=A0 USHORT DIGxEncoderControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 //Only used by Bios<br>
-=C2=A0 USHORT MemoryControllerInit;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 indirectly used by var=
ious SW components,called from ASIC_Init<br>
-=C2=A0 USHORT EnableCRTCMemReq;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Function Table,directly used by =
various SW components,latest version 2.1<br>
-=C2=A0 USHORT MemoryParamAdjust;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0//Atomic Table,=C2=A0 indirectly used by various SW components,ca=
lled from SetMemoryClock if needed<br>
-=C2=A0 USHORT DVOEncoderControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Function Table,directly used by variou=
s SW components,latest version 1.2<br>
-=C2=A0 USHORT GPIOPinControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Ato=
mic Table,=C2=A0 only used by Bios<br>
-=C2=A0 USHORT SetEngineClock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Function Table,directly used=
 by various SW components,latest version 1.1<br>
-=C2=A0 USHORT SetMemoryClock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Function Table,directly used=
 by various SW components,latest version 1.1<br>
-=C2=A0 USHORT SetPixelClock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Function Table,directly use=
d by various SW components,latest version 1.2=C2=A0 <br>
-=C2=A0 USHORT EnableDispPowerGating;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 indirectly used by various S=
W components,called from ASIC_Init<br>
-=C2=A0 USHORT ResetMemoryDLL;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 indirect=
ly used by various SW components,called from SetMemoryClock<br>
-=C2=A0 USHORT ResetMemoryDevice;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 indirectly used by=
 various SW components,called from SetMemoryClock<br>
-=C2=A0 USHORT MemoryPLLInit;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 used on=
ly by Bios<br>
-=C2=A0 USHORT AdjustDisplayPll;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 used by variou=
s SW componentes. <br>
-=C2=A0 USHORT AdjustMemoryController;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 indirectly used by various=
 SW components,called from SetMemoryClock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 <br>
-=C2=A0 USHORT EnableASIC_StaticPwrMgt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 only used by Bios<br>
-=C2=A0 USHORT SetUniphyInstance;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 only used by Bios=
=C2=A0 =C2=A0<br>
-=C2=A0 USHORT DAC_LoadDetection;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 directly used by v=
arious SW components,latest version 1.2=C2=A0 <br>
-=C2=A0 USHORT LVTMAEncoderControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,directly used by various SW =
components,latest version 1.3<br>
-=C2=A0 USHORT HW_Misc_Operation;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 directly used by v=
arious SW components,latest version 1.1 <br>
-=C2=A0 USHORT DAC1EncoderControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly used by v=
arious SW components,latest version 1.1=C2=A0 <br>
-=C2=A0 USHORT DAC2EncoderControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly used by v=
arious SW components,latest version 1.1 <br>
-=C2=A0 USHORT DVOOutputControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly use=
d by various SW components,latest version 1.1 <br>
-=C2=A0 USHORT CV1OutputControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 Atomic Table=
,=C2=A0 Obsolete from Ry6xx, use DAC2 Output instead <br>
-=C2=A0 USHORT GetConditionalGoldenSetting;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 //Only used by Bios<br>
-=C2=A0 USHORT TVEncoderControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Function Table,directly used by =
various SW components,latest version 1.1<br>
-=C2=A0 USHORT PatchMCSetting;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//only used by BIOS<br>
-=C2=A0 USHORT MC_SEQ_Control;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//only used by BIOS<br>
-=C2=A0 USHORT Gfx_Harvesting;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 Obsolete=
 from Ry6xx, Now only used by BIOS for GFX harvesting<br>
-=C2=A0 USHORT EnableScaler;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 u=
sed only by Bios<br>
-=C2=A0 USHORT BlankCRTC;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=
=A0 directly used by various SW components,latest version 1.1 <br>
-=C2=A0 USHORT EnableCRTC;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=
=A0 directly used by various SW components,latest version 1.1 <br>
-=C2=A0 USHORT GetPixelClock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 directl=
y used by various SW components,latest version 1.1 <br>
-=C2=A0 USHORT EnableVGA_Render;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Function Table,directly used by =
various SW components,latest version 1.1<br>
-=C2=A0 USHORT GetSCLKOverMCLKRatio;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 only used by Bios<br>
-=C2=A0 USHORT SetCRTC_Timing;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly=
 used by various SW components,latest version 1.1<br>
-=C2=A0 USHORT SetCRTC_OverScan;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 used by vari=
ous SW components,latest version 1.1 <br>
-=C2=A0 USHORT SetCRTC_Replication;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 used only by Bios<br>
-=C2=A0 USHORT SelectCRTC_Source;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 directly used by v=
arious SW components,latest version 1.1 <br>
-=C2=A0 USHORT EnableGraphSurfaces;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 used only by Bios<br>
-=C2=A0 USHORT UpdateCRTC_DoubleBufferRegiste<wbr>rs;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=
=A0 used only by Bios<br>
-=C2=A0 USHORT LUT_AutoFill;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 o=
nly used by Bios<br>
-=C2=A0 USHORT EnableHW_IconCursor;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 only used by Bios<br>
-=C2=A0 USHORT GetMemoryClock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly=
 used by various SW components,latest version 1.1 <br>
-=C2=A0 USHORT GetEngineClock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly=
 used by various SW components,latest version 1.1 <br>
-=C2=A0 USHORT SetCRTC_UsingDTDTiming;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly used by various S=
W components,latest version 1.1<br>
-=C2=A0 USHORT ExternalEncoderControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly used by various S=
W components,latest version 2.1<br>
-=C2=A0 USHORT LVTMAOutputControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly used by v=
arious SW components,latest version 1.1<br>
-=C2=A0 USHORT VRAM_BlockDetectionByStrap;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 used only by Bios<br>
-=C2=A0 USHORT MemoryCleanUp;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 only us=
ed by Bios=C2=A0 =C2=A0 <br>
-=C2=A0 USHORT ProcessI2cChannelTransaction;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0//Function Table,only used by Bios<br>
-=C2=A0 USHORT WriteOneByteToHWAssistedI2C;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 //Function Table,indirectly used by various SW components <br>
-=C2=A0 USHORT ReadHWAssistedI2CStatus;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 indirectly used by various SW co=
mponents<br>
-=C2=A0 USHORT SpeedFanControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Function Table,indirectly used =
by various SW components,called from ASIC_Init<br>
-=C2=A0 USHORT PowerConnectorDetection;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 directly used by various SW comp=
onents,latest version 1.1<br>
-=C2=A0 USHORT MC_Synchronization;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 indirectly used by=
 various SW components,called from SetMemoryClock<br>
-=C2=A0 USHORT ComputeMemoryEnginePLL;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 indirectly used by various=
 SW components,called from SetMemory/EngineClock<br>
-=C2=A0 USHORT MemoryRefreshConversion;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 indirectly used by various SW co=
mponents,called from SetMemory or SetEngineClock<br>
-=C2=A0 USHORT VRAM_GetCurrentInfoBlock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 used only by Bios<br>
-=C2=A0 USHORT DynamicMemorySettings;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 indirectly used by various S=
W components,called from SetMemoryClock<br>
-=C2=A0 USHORT MemoryTraining;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 used onl=
y by Bios<br>
-=C2=A0 USHORT EnableSpreadSpectrumOnPPLL;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly used by various SW componen=
ts,latest version 1.2<br>
-=C2=A0 USHORT TMDSAOutputControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 directly used by v=
arious SW components,latest version 1.1<br>
-=C2=A0 USHORT SetVoltage;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Function Table,dir=
ectly and/or indirectly used by various SW components,latest version 1.1<br=
>
-=C2=A0 USHORT DAC1OutputControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 directly used by v=
arious SW components,latest version 1.1<br>
-=C2=A0 USHORT DAC2OutputControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 directly used by v=
arious SW components,latest version 1.1<br>
-=C2=A0 USHORT ComputeMemoryClockParam;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 //Function Table,only used by Bios, obsolete soon.Swit=
ch to use &quot;ReadEDIDFromHWAssistedI2C&quot;<br>
-=C2=A0 USHORT ClockSource;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 ind=
irectly used by various SW components,called from ASIC_Init<br>
-=C2=A0 USHORT MemoryDeviceInit;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,=C2=A0 indirectly u=
sed by various SW components,called from SetMemoryClock<br>
-=C2=A0 USHORT GetDispObjectInfo;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,=C2=A0 indirectly used by=
 various SW components,called from EnableVGARender<br>
-=C2=A0 USHORT DIG1EncoderControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,directly used by various =
SW components,latest version 1.1<br>
-=C2=A0 USHORT DIG2EncoderControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,directly used by various =
SW components,latest version 1.1<br>
-=C2=A0 USHORT DIG1TransmitterControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0//Atomic Table,directly used by various SW compo=
nents,latest version 1.1<br>
-=C2=A0 USHORT DIG2TransmitterControl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Atomic Table,directly used by v=
arious SW components,latest version 1.1 <br>
-=C2=A0 USHORT ProcessAuxChannelTransaction;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 //Function Table,only used by Bios<br>
-=C2=A0 USHORT DPEncoderService;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Function Table,only used by Bios<b=
r>
-=C2=A0 USHORT GetVoltageInfo;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Function Table,only used by =
Bios since SI<br>
-}ATOM_MASTER_LIST_OF_COMMAND_<wbr>TABLES;=C2=A0 =C2=A0<br>
-<br>
-// For backward compatible <br>
-#define ReadEDIDFromHWAssistedI2C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ProcessI2cChannelTransaction<br>
-#define DPTranslatorControl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DIG2EncoderControl<br>
-#define UNIPHYTransmitterControl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DIG1TransmitterCont=
rol<br>
-#define LVTMATransmitterControl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0DIG2TransmitterControl<br>
-#define SetCRTC_DPM_State=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GetConditionalGoldenSetting<br>
-#define ASIC_StaticPwrMgtStatusChange=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 SetUniphyInstance <br>
-#define HPDInterruptService=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ReadHWAssistedI2CStatus<br>
-#define EnableVGA_Access=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GetSCLKOverMCLKRatio<br>
-#define EnableYUV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GetDispObjectInfo=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0<br>
-#define DynamicClockGating=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EnableDispPowerGating<br>
-#define SetupHWAssistedI2CStatus=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ComputeMemoryClockParam<br>
-<br>
-#define TMDSAEncoderControl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PatchMCSetting<br>
-#define LVDSEncoderControl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MC_SEQ_Control<br>
-#define LCD1OutputControl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HW_Misc_Operation<br>
-#define TV1OutputControl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gfx_Harvesting<br>
-<br>
-typedef struct _ATOM_MASTER_COMMAND_TABLE<br>
-{<br>
-=C2=A0 ATOM_COMMON_TABLE_HEADER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sH=
eader;<br>
-=C2=A0 ATOM_MASTER_LIST_OF_COMMAND_TA<wbr>BLES ListOfCommandTables;<br>
-}ATOM_MASTER_COMMAND_TABLE;<br>
-<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-// Structures used in every command table<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-typedef struct _ATOM_TABLE_ATTRIBUTE<br>
-{<br>
-#if ATOM_BIG_ENDIAN<br>
-=C2=A0 USHORT=C2=A0 UpdatedByUtility:1;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
/[15]=3DTable updated by utility flag<br>
-=C2=A0 USHORT=C2=A0 PS_SizeInBytes:7;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0//[14:8]=3DSize of parameter space in Bytes (multiple of a dword), <b=
r>
-=C2=A0 USHORT=C2=A0 WS_SizeInBytes:8;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0//[7:0]=3DSize of workspace in Bytes (in multiple of a dword), <br>
-#else<br>
-=C2=A0 USHORT=C2=A0 WS_SizeInBytes:8;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0//[7:0]=3DSize of workspace in Bytes (in multiple of a dword), <br>
-=C2=A0 USHORT=C2=A0 PS_SizeInBytes:7;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0//[14:8]=3DSize of parameter space in Bytes (multiple of a dword), <b=
r>
-=C2=A0 USHORT=C2=A0 UpdatedByUtility:1;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
/[15]=3DTable updated by utility flag<br>
-#endif<br>
-}ATOM_TABLE_ATTRIBUTE;<br>
-<br>
-typedef union _ATOM_TABLE_ATTRIBUTE_ACCESS<br>
-{<br>
-=C2=A0 ATOM_TABLE_ATTRIBUTE sbfAccess;<br>
-=C2=A0 USHORT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0susAcc=
ess;<br>
-}ATOM_TABLE_ATTRIBUTE_ACCESS;<br>
-<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-// Common header for all command tables.<br>
-// Every table pointed by _ATOM_MASTER_COMMAND_TABLE has this common heade=
r. <br>
-// And the pointer actually points to this header.<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-typedef struct _ATOM_COMMON_ROM_COMMAND_TABLE<wbr>_HEADER<br>
-{<br>
-=C2=A0 ATOM_COMMON_TABLE_HEADER CommonHeader;<br>
-=C2=A0 ATOM_TABLE_ATTRIBUTE=C2=A0 =C2=A0 =C2=A0TableAttribute;=C2=A0 =C2=
=A0 =C2=A0<br>
-}ATOM_COMMON_ROM_COMMAND_TABL<wbr>E_HEADER;<br>
-<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-// Structures used by ComputeMemoryEnginePLLTable<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-#define COMPUTE_MEMORY_PLL_PARAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-#define COMPUTE_ENGINE_PLL_PARAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
-#define ADJUST_MC_SETTING_PARAM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
-<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-// Structures used by AdjustMemoryControllerTable<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ <br>
-typedef struct _ATOM_ADJUST_MEMORY_CLOCK_FREQ<br>
-{<br>
-#if ATOM_BIG_ENDIAN<br>
-=C2=A0 ULONG ulPointerReturnFlag:1;=C2=A0 =C2=A0 =C2=A0 // BYTE_3[7]=3D1 -=
 Return the pointer to the right Data Block; BYTE_3[7]=3D0 - Program the ri=
ght Data Block <br>
-=C2=A0 ULONG ulMemoryModuleNumber:7;=C2=A0 =C2=A0 =C2=A0// BYTE_3[6:0]<br>
-=C2=A0 ULONG ulClockFreq:24;<br>
-#else<br>
-=C2=A0 ULONG ulClockFreq:24;<br>
-=C2=A0 ULONG ulMemoryModuleNumber:7;=C2=A0 =C2=A0 =C2=A0// BYTE_3[6:0]<br>
-=C2=A0 ULONG ulPointerReturnFlag:1;=C2=A0 =C2=A0 =C2=A0 // BYTE_3[7]=3D1 -=
 Return the pointer to the right Data Block; BYTE_3[7]=3D0 - Program the ri=
ght Data Block <br>
-#endif<br>
-}ATOM_ADJUST_MEMORY_CLOCK_FRE<wbr>Q;<br>
-#define POINTER_RETURN_FLAG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x80<br>
-<br>
-typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PAR<wbr>AMETERS<br>
-{<br>
-=C2=A0 ULONG=C2=A0 =C2=A0ulClock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 //When reture=
n, it&#39;s the re-calculated clock based on given Fb_div Post_Div and ref_=
div<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucAction;=C2=A0 =C2=A0 =C2=A0 =C2=A0//0:reserved =
//1:Memory //2:Engine=C2=A0 <br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucReserved;=C2=A0 =C2=A0 =C2=A0//may expand to re=
turn larger Fbdiv later<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucFbDiv;=C2=A0 =C2=A0 =C2=A0 =C2=A0 //return valu=
e<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucPostDiv;=C2=A0 =C2=A0 =C2=A0 //return value<br>
-}COMPUTE_MEMORY_ENGINE_PLL_PA<wbr>RAMETERS;<br>
-<br>
-typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PAR<wbr>AMETERS_V2<br>
-{<br>
-=C2=A0 ULONG=C2=A0 =C2=A0ulClock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 //When return=
, [23:0] return real clock <br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucAction;=C2=A0 =C2=A0 =C2=A0 =C2=A0//0:reserved;=
COMPUTE_MEMORY_P<wbr>LL_PARAM:Memory;COMPUTE_ENGINE<wbr>_PLL_PARAM:Engine. =
it return ref_div to be written to register<br>
-=C2=A0 USHORT=C2=A0 usFbDiv;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0//return Feedback value to be written to register<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucPostDiv;=C2=A0 =C2=A0 =C2=A0 //return post div =
to be written to register<br>
-}COMPUTE_MEMORY_ENGINE_PLL_PA<wbr>RAMETERS_V2;<br>
-#define COMPUTE_MEMORY_ENGINE_PLL_PARA<wbr>METERS_PS_ALLOCATION=C2=A0 =C2=
=A0COMPUTE_MEMORY_ENGINE_PLL_PAR<wbr>AMETERS<br>
-<br>
-<br>
-#define SET_CLOCK_FREQ_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00FFFFFF=C2=A0 //Clock change tables only =
take bit [23:0] as the requested clock value<br>
-#define USE_NON_BUS_CLOCK_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x01000000=C2=A0 //Applicable to both memory and engin=
e clock change, when set, it uses another clock as the temporary clock (eng=
ine uses memory and vice versa)<br>
-#define USE_MEMORY_SELF_REFRESH_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x02000000=C2=A0 =C2=A0 =C2=A0//Only applicable to memory clock change,=
 when set, using memory self refresh during clock transition<br>
-#define SKIP_INTERNAL_MEMORY_PARAMETER<wbr>_CHANGE=C2=A0 =C2=A00x04000000=
=C2=A0 //Only applicable to memory clock change, when set, the table will s=
kip predefined internal memory parameter change<br>
-#define FIRST_TIME_CHANGE_CLOCK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08000000=
=C2=A0 =C2=A0 =C2=A0 //Applicable to both memory and engine clock change,wh=
en set, it means this is 1st time to change clock after ASIC bootup<br>
-#define SKIP_SW_PROGRAM_PLL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10000000=C2=A0 =C2=A0 =C2=A0 //Applicable to =
both memory and engine clock change, when set, it means the table will not =
program SPLL/MPLL<br>
-#define USE_SS_ENABLED_PIXEL_CLOCK=C2=A0 USE_NON_BUS_CLOCK_MASK<br>
-<br>
-#define b3USE_NON_BUS_CLOCK_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x01=C2=A0 =C2=A0 =C2=A0 =C2=A0//Applicable to both me=
mory and engine clock change, when set, it uses another clock as the tempor=
ary clock (engine uses memory and vice versa)<br>
-#define b3USE_MEMORY_SELF_REFRESH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00x02=C2=A0 =C2=A0 =C2=A0 //Only applicable to memory c=
lock change, when set, using memory self refresh during clock transition<br=
>
-#define b3SKIP_INTERNAL_MEMORY_PARAMET<wbr>ER_CHANGE=C2=A0 =C2=A00x04=C2=
=A0 =C2=A0 =C2=A0 =C2=A0//Only applicable to memory clock change, when set,=
 the table will skip predefined internal memory parameter change<br>
-#define b3FIRST_TIME_CHANGE_CLOCK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08=C2=A0 =C2=A0 =
=C2=A0 =C2=A0//Applicable to both memory and engine clock change,when set, =
it means this is 1st time to change clock after ASIC bootup<br>
-#define b3SKIP_SW_PROGRAM_PLL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x10=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0//Applicable to both memory and engine clock cha=
nge, when set, it means the table will not program SPLL/MPLL<br>
-<br>
-typedef struct _ATOM_COMPUTE_CLOCK_FREQ<br>
-{<br>
-#if ATOM_BIG_ENDIAN<br>
-=C2=A0 ULONG ulComputeClockFlag:8;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0// =3D1: COMPUTE_MEMORY_PLL_PARAM, =3D2: COMPUTE_EN=
GINE_PLL_PARAM<br>
-=C2=A0 ULONG ulClockFreq:24;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// in unit of 10kHz<br>
-#else<br>
-=C2=A0 ULONG ulClockFreq:24;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// in unit of 10kHz<br>
-=C2=A0 ULONG ulComputeClockFlag:8;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0// =3D1: COMPUTE_MEMORY_PLL_PARAM, =3D2: COMPUTE_EN=
GINE_PLL_PARAM<br>
-#endif<br>
-}ATOM_COMPUTE_CLOCK_FREQ;<br>
-<br>
-typedef struct _ATOM_S_MPLL_FB_DIVIDER<br>
-{<br>
-=C2=A0 USHORT usFbDivFrac;=C2=A0 <br>
-=C2=A0 USHORT usFbDiv;=C2=A0 <br>
-}ATOM_S_MPLL_FB_DIVIDER;<br>
-<br>
-typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PAR<wbr>AMETERS_V3<br>
-{<br>
-=C2=A0 union<br>
-=C2=A0 {<br>
-=C2=A0 =C2=A0 ATOM_COMPUTE_CLOCK_FREQ=C2=A0 ulClock;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0//Input Parameter<br>
-=C2=A0 =C2=A0 ULONG ulClockParams;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //ULONG access for BE<br>
-=C2=A0 =C2=A0 ATOM_S_MPLL_FB_DIVIDER=C2=A0 =C2=A0ulFbDiv;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0//Output Parameter<br>
-=C2=A0 };<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucRefDiv;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Output Paramet=
er=C2=A0 =C2=A0 =C2=A0 <br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucPostDiv;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Output Parameter=C2=
=A0 =C2=A0 =C2=A0 <br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucCntlFlag;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Output Parameter=C2=
=A0 =C2=A0 =C2=A0 <br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucReserved;<br>
-}COMPUTE_MEMORY_ENGINE_PLL_PA<wbr>RAMETERS_V3;<br>
-<br>
-// ucCntlFlag<br>
-#define ATOM_PLL_CNTL_FLAG_PLL_POST_DI<wbr>V_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 1<br>
-#define ATOM_PLL_CNTL_FLAG_MPLL_VCO_MO<wbr>DE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 2<br>
-#define ATOM_PLL_CNTL_FLAG_FRACTION_DI<wbr>SABLE=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A04<br>
-#define ATOM_PLL_CNTL_FLAG_SPLL_ISPARE<wbr>_9=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08<br>
-<br>
-<br>
-// V4 are only used for APU which PLL outside GPU<br>
-typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PAR<wbr>AMETERS_V4<br>
-{<br>
-#if ATOM_BIG_ENDIAN<br>
-=C2=A0 ULONG=C2=A0 ucPostDiv:8;=C2=A0 =C2=A0 =C2=A0 =C2=A0 //return parame=
ter: post divider which is used to program to register directly<br>
-=C2=A0 ULONG=C2=A0 ulClock:24;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Input=3D=
 target clock, output =3D actual clock <br>
-#else<br>
-=C2=A0 ULONG=C2=A0 ulClock:24;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Input=3D=
 target clock, output =3D actual clock <br>
-=C2=A0 ULONG=C2=A0 ucPostDiv:8;=C2=A0 =C2=A0 =C2=A0 =C2=A0 //return parame=
ter: post divider which is used to program to register directly<br>
-#endif<br>
-}COMPUTE_MEMORY_ENGINE_PLL_PA<wbr>RAMETERS_V4;<br>
-<br>
-typedef struct _COMPUTE_MEMORY_ENGINE_PLL_PAR<wbr>AMETERS_V5<br>
-{<br>
-=C2=A0 union<br>
-=C2=A0 {<br>
-=C2=A0 =C2=A0 ATOM_COMPUTE_CLOCK_FREQ=C2=A0 ulClock;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0//Input Parameter<br>
-=C2=A0 =C2=A0 ULONG ulClockParams;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //ULONG access for BE<br>
-=C2=A0 =C2=A0 ATOM_S_MPLL_FB_DIVIDER=C2=A0 =C2=A0ulFbDiv;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0//Output Parameter<br>
-=C2=A0 };<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucRefDiv;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Output Paramet=
er=C2=A0 =C2=A0 =C2=A0 <br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucPostDiv;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Output Parameter=C2=
=A0 =C2=A0 =C2=A0 <br>
-=C2=A0 union<br>
-=C2=A0 {<br>
-=C2=A0 =C2=A0 UCHAR=C2=A0 =C2=A0ucCntlFlag;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Output Flags<br>
-=C2=A0 =C2=A0 UCHAR=C2=A0 =C2=A0ucInputFlag;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Input Flags. ucInputFlag=
[0] - Strobe(1)/Performance(0) mode<br>
-=C2=A0 };<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucReserved;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
-}COMPUTE_MEMORY_ENGINE_PLL_PA<wbr>RAMETERS_V5;<br>
-<br>
-<br>
-typedef struct _COMPUTE_GPU_CLOCK_INPUT_PARAM<wbr>ETERS_V1_6<br>
-{<br>
-=C2=A0 ATOM_COMPUTE_CLOCK_FREQ=C2=A0 ulClock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0//Input Parameter<br>
-=C2=A0 ULONG=C2=A0 =C2=A0ulReserved[2];<br>
-}COMPUTE_GPU_CLOCK_INPUT_PARA<wbr>METERS_V1_6;<br>
-<br>
-//ATOM_COMPUTE_CLOCK_FREQ.ulC<wbr>omputeClockFlag<br>
-#define COMPUTE_GPUCLK_INPUT_FLAG_CLK_<wbr>TYPE_MASK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x0f<br>
-#define COMPUTE_GPUCLK_INPUT_FLAG_DEFA<wbr>ULT_GPUCLK=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00x00<br>
-#define COMPUTE_GPUCLK_INPUT_FLAG_SCLK<wbr>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x01<br>
-<br>
-typedef struct _COMPUTE_GPU_CLOCK_OUTPUT_PARA<wbr>METERS_V1_6<br>
-{<br>
-=C2=A0 COMPUTE_MEMORY_ENGINE_PLL_PARA<wbr>METERS_V4=C2=A0 ulClock;=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0//Output Parameter: ucPostDiv=3DDFS divider<br>
-=C2=A0 ATOM_S_MPLL_FB_DIVIDER=C2=A0 =C2=A0ulFbDiv;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0//Output Parameter: PLL FB divider<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucPllRefDiv;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Output Parameter: PLL ref divid=
er=C2=A0 =C2=A0 =C2=A0 <br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucPllPostDiv;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Output Parameter: PLL post divid=
er=C2=A0 =C2=A0 =C2=A0 <br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucPllCntlFlag;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Output Flags: control flag<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucReserved;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
-}COMPUTE_GPU_CLOCK_OUTPUT_PAR<wbr>AMETERS_V1_6;<br>
-<br>
-//ucPllCntlFlag<br>
-#define SPLL_CNTL_FLAG_VCO_MODE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x03 <br>
-<br>
-<br>
-// ucInputFlag<br>
-#define ATOM_PLL_INPUT_FLAG_PLL_STROBE<wbr>_MODE_EN=C2=A0 1=C2=A0 =C2=A0//=
 1-StrobeMode, 0-PerformanceMode<br>
-<br>
-// use for ComputeMemoryClockParamTable<br>
-typedef struct _COMPUTE_MEMORY_CLOCK_PARAM_PA<wbr>RAMETERS_V2_1<br>
-{<br>
-=C2=A0 union<br>
-=C2=A0 {<br>
-=C2=A0 =C2=A0 ULONG=C2=A0 ulClock;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
-=C2=A0 =C2=A0 ATOM_S_MPLL_FB_DIVIDER=C2=A0 =C2=A0ulFbDiv;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0//Output:UPPER_WORD=3DFB_DIV_IN<wbr>TEGER,=C2=A0 LOWER_WOR=
D=3DFB_DIV_FRAC shl (16-FB_FRACTION_BITS)<br>
-=C2=A0 };<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucDllSpeed;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//Output <br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucPostDiv;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Output<br>
-=C2=A0 union{<br>
-=C2=A0 =C2=A0 UCHAR=C2=A0 =C2=A0ucInputFlag;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Input : ATOM_PLL_INPUT_F=
LAG_PLL_STROBE<wbr>_MODE_EN: 1-StrobeMode, 0-PerformanceMode<br>
-=C2=A0 =C2=A0 UCHAR=C2=A0 =C2=A0ucPllCntlFlag;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Output: <br>
-=C2=A0 };<br>
-=C2=A0 UCHAR=C2=A0 =C2=A0ucBWCntl;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
-}COMPUTE_MEMORY_CLOCK_PARAM_P<wbr>ARAMETERS_V2_1;<br>
-<br>
-// definition of ucInputFlag<br>
-#define MPLL_INPUT_FLAG_STROBE_MODE_EN<wbr>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x01<br>
-// definition of ucPllCntlFlag<br>
-#define MPLL_CNTL_FLAG_VCO_MODE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x03 <br>
-#define MPLL_CNTL_FLAG_BYPASS_DQ_PLL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x04<br>
-#define MPLL_CNTL_FLAG_QDR_ENABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00x08<br>
-#define MPLL_CNTL_FLAG_AD_HALF_RATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x10<br>
-<br>
-//MPLL_CNTL_FLAG_BYPASS_AD_PL<wbr>L has a wrong name, should be BYPASS_DQ_=
PLL<br>
-#define MPLL_CNTL_FLAG_BYPASS_AD_PLL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x04<br>
-<br>
-typedef struct _DYNAMICE_MEMORY_SETTINGS_PARA<wbr>METER<br>
-{<br>
-=C2=A0 ATOM_COMPUTE_CLOCK_FREQ ulClock;<br>
-=C2=A0 ULONG ulReserved[2];<br>
-}DYNAMICE_MEMORY_SETTINGS_PAR<wbr>AMETER;<br>
-<br>
-typedef struct _DYNAMICE_ENGINE_SETTINGS_PARA<wbr>METER<br>
-{<br>
-=C2=A0 ATOM_COMPUTE_CLOCK_FREQ ulClock;<br>
-=C2=A0 ULONG ulMemoryClock;<br>
-=C2=A0 ULONG ulReserved;<br>
-}DYNAMICE_ENGINE_SETTINGS_PAR<wbr>AMETER;<br>
-<br>
-/****************************<wbr>******************************<wbr>*****=
*************/ &lt;</blockquote>

--000000000000324fa6059850ff72--

