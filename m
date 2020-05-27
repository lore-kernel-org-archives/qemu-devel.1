Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F07C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:20:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABD320C09
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 07:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6Pw6DEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABD320C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdqMS-0002aA-HK
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 03:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdqLo-00025X-Tw
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:19:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdqLo-0007DN-04
 for qemu-devel@nongnu.org; Wed, 27 May 2020 03:19:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so22976697wru.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CT1L4Qf12+U27w7c7Ps1Vz5+TjylryQnseFmxo8ZWp0=;
 b=r6Pw6DEt98ICLNC9BXb1X6tCyUcBvQXfq1g7z1iDWyNSF07licQcI7bv9S1k+I7Ppx
 r0m/D3YD4WT484VOJWT0nFzPekOh5m6SdJurD7cg1zfkJJUyoOnxDV49TcsIxaBw3EEi
 zIBKwtzZhncFrHnkq3nrcqHvC45IY2cHwsde82lHP9NrxF16NMhYNkvlSYMabgqKsgph
 8KLuNouLTy65EkhlsoRAadijFF/YBCmKQN5k+QyLSIRi362P1MkixNW8fiXEyrmJVoDt
 7jszVCobnvkr5jDJpEB0FkM7OXISBBfuJVise6/HpEl7u9QvaMckAde9YpTPX9HcBxM6
 rD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CT1L4Qf12+U27w7c7Ps1Vz5+TjylryQnseFmxo8ZWp0=;
 b=h4XZ6j+PW49WsRSS7eTXyy/6xXa1oe2hWOXWmAtHrvMOiwEE60Jzb8Exux/BZ9JQhL
 VLAT0P/b7s6qwL4OXIB/vHVD9InwuyOQvV6Y2x7+BsGDLh1jQxIC+uQEX8ECK23KHz1B
 2TxUTbm20GwZWBLri3HipGN6HbAm+kMW6XLsU+voxfzQyeOswVBql53STjfLUCtXx9Aw
 Q92c/fn8OdjZ9p39eunpr/EM2VqscfQWKBS6u9MjoL7ExrwYcDJpU5gw+7JSF1R6+TPB
 f8MIxJ5Z2mBt6lNPa++QqSVJ52LBaGXv682/1zLx3bqfIAcPxiM01SI6PJ3aot9yB7zA
 jghQ==
X-Gm-Message-State: AOAM5319wfkKwUWnAPmH+lcnTgB71hIQOZeHN2g6ZLEEzNHrLuwM1qqk
 eYz6shzAugKXqkiNOBOxCsI=
X-Google-Smtp-Source: ABdhPJzw57aM0fGr64C15U+6nv6kFCUVfYYFVniIWwpR2OJdaQT7y3DuOneIa95q79vy1XAkNOSJVg==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr22668712wrt.29.1590563981497; 
 Wed, 27 May 2020 00:19:41 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id o6sm1999775wrp.3.2020.05.27.00.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 00:19:40 -0700 (PDT)
Subject: Re: GDB get wrong debug infos on TI DSP architecture extension
To: casmac <1482995675@qq.com>, qemu-devel <qemu-devel@nongnu.org>
References: <tencent_86D9DB902C46CBAC4F3A6FD5B4CDA93B7506@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8b83e11b-e593-b7db-48b6-252e23c599da@amsat.org>
Date: Wed, 27 May 2020 09:19:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <tencent_86D9DB902C46CBAC4F3A6FD5B4CDA93B7506@qq.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Xiaolei,

Cc'ing more developers who might answer you.

On 5/27/20 8:48 AM, casmac wrote:
> Hi all,
>    I am working on a TI DSP architecture extension for QEMU.

FYI you can find the TI TMS320C6x target implemented here:
https://github.com/philmd/qemu/releases/tag/target-c6x-2.4

I started rebasing it to QEMU 4.2 but then got distracted.

> Now, we are
> adding GDB debugging features.
>    We have done the following, but not sure we are on the right track :
>    - add a xml description file in gdb-xml, without understanding the
> purpose of the file, why some architectures don't provide such xml file?
>    - add ***_cpu_gdb_read_register(), ***_cpu_gdb_write_register();
>    - added  dsp_cpu_get_phys_page_attrs_debug(), but uncertain about
> what to return
>      dsp_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
> MemTxAttrs *attrs)
>      {
>         return addr & TARGET_PAGE_MASK;  
>      }
>   
>    We run QEMU with the these arguments
>    qemu-system-dsp ... -kernel filename.out -S -s
>   
>    It turns out that gdb reads incorrect register values, and complains
> : "warning: Target-supplied registers are not supported by the current
> architecture".
>   
>    Something is missing here, or we do it in a wrong way.  Any advise
> would be helpful to us.
>   
>    Thanks.
>    
> xiaolei
> 
>    ----- ti_dsp.xml  -----
>   
>    <?xml version="1.0"?>
> <!DOCTYPE feature SYSTEM "gdb-target.dtd">
> <feature name="org.gnu.gdb.tic3x.core">
>     <reg name="r0"  bitsize="32"></reg>
>  <reg name="r1"  bitsize="32"/>
>  <reg name="r2"  bitsize="32"></reg>
>  <reg name="r3"  bitsize="32"/>
>  <reg name="r4"  bitsize="32"/>
>  <reg name="r5"  bitsize="32"/>
>  <reg name="r6"  bitsize="32"/>
>  <reg name="r7"  bitsize="32"/>
>  <reg name="ar0" bitsize="32"/>
>  <reg name="ar1" bitsize="32"/>
>  <reg name="ar2" bitsize="32"/>
>  <reg name="ar3" bitsize="32"/>
>  <reg name="ar4" bitsize="32"/>
>  <reg name="ar5" bitsize="32"/>
>  <reg name="ar6" bitsize="32"/>
>  <reg name="ar7" bitsize="32"/>
>  <reg name="dp"  bitsize="32"/>
>  <reg name="ir0" bitsize="32"/>
>  <reg name="ir1" bitsize="32"/>
>  <reg name="bk"  bitsize="32"/>
>  <reg name="sp"  bitsize="32" type="data_ptr"/>
>  <reg name="st"  bitsize="32"></reg>
>  <reg name="ie"  bitsize="32"/>
>  <reg name="if"  bitsize="32"/>
>  <reg name="iof" bitsize="32"/>
>  <reg name="rs"  bitsize="32"/>
>  <reg name="re"  bitsize="32"/>
>  <reg name="rc"  bitsize="32"/>
>  <reg name="pc"  bitsize="32" type="data_ptr"/>
>  <reg name="clk"  bitsize="32"/>
> </feature>
>   


