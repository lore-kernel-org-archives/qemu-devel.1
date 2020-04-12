Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50CAC2D0EC
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0963206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srKMmtfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0963206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNjl5-0004Sx-Ro
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 17:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNjkH-0003rc-J5
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNjkG-00019y-F2
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 17:02:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNjkB-00015n-L9; Sun, 12 Apr 2020 17:02:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id p10so8383508wrt.6;
 Sun, 12 Apr 2020 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9MfZQoIGnMqnGjUZttdmDIECzyUXJ4JfuQC6iC/LFyk=;
 b=srKMmtflLINVCveBMxTdlhBpvdCiKudxvFzRRPnWcvxYHukdAE3G/SBUBumv2IEkUa
 9ZQ/iSIE7NCvRsk781oZgWB1AKUo3Q6aokbl83ReG0fy/dAXe3OibKGsIcnhq/bSQsuj
 Ta9nHdVNjB0xnU0MehXe0+4KJX5SsdRBmo91dLDxLowWmYzGNMztULNYN9o5aTsLLsoY
 jLZCOLKxXeqL6vypTmLFetrzNl+tW5AWBEL9XagaNJQcHKfFamse002DA+Vt+kOvXNDp
 ojIP5t5VSoRJnWBGW+u7xgGUaXAZtqJjKrdtFKP5h8DzUp4fFZupGbohbwBZipuZdF1d
 pLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=9MfZQoIGnMqnGjUZttdmDIECzyUXJ4JfuQC6iC/LFyk=;
 b=lFP1xFcN/moqWEsUQH2f0sME6TdrlzOOGrY82Ujnb0j5JjWrsOEWZuo6gRF803ZO+q
 hgM4OZmaBh+uvF6zJLBehZG9Mm0hOwlZUmrEBT6M/usF0RAAeBsZwpfIr5n1iWFC2BbE
 kg1pZ+fg/gUiTXYLfPFFOIwa0DQKHO5HFjTEgQEu+rl6vapuP2fa+dkKL8aT3Xtcw13H
 Osr8y5ARf2qdln/JBchOOFBWkRFZyFNpvXcrXxHrN8Nc/A/6uyKUXXXYGR71HP3XEzdy
 6rJU2zYrTm+U0Dfv+RpkZcFeiEeUek58tXjeSnWaEbeGWujDjHbKuUzYNqUAeGax5TBK
 yojQ==
X-Gm-Message-State: AGi0PuaJhdsbjnpq8BSjLVReK1gW4FzcxK117c0wSFSHmJ5ypMbNWQ+j
 bNohSMxcntihIwfYoKbijpQ=
X-Google-Smtp-Source: APiQypL2RRKu0kC7bSEA2zDMMfVZP9WAm+SuXE4G9rl2WYwFuP/GqimV7Amz0jSPgHaN+pTT3FyFDg==
X-Received: by 2002:adf:a345:: with SMTP id d5mr12733141wrb.23.1586725337836; 
 Sun, 12 Apr 2020 14:02:17 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v21sm11617283wmj.8.2020.04.12.14.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2020 14:02:17 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200411091453.30371-1-f4bug@amsat.org>
 <20200411091453.30371-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2004111953020.75236@zero.eik.bme.hu>
 <811e2026-963d-e4d6-b90c-2713f9f30404@amsat.org>
 <CAFEAcA-ntHLEJnQ8Sd_c8n8LJmJ0X44VousM-BtNTndXRdf8ew@mail.gmail.com>
 <98306a3a-46c9-cedd-48c2-af065c597640@amsat.org>
 <CAFEAcA_U-sxDCSt9DPdNw0PUbjySeWUaNWivezq-6qBFOK3-Eg@mail.gmail.com>
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
Message-ID: <bdb51ae0-e978-555e-d6f5-cc77062be358@amsat.org>
Date: Sun, 12 Apr 2020 23:02:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_U-sxDCSt9DPdNw0PUbjySeWUaNWivezq-6qBFOK3-Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/12/20 10:57 PM, Peter Maydell wrote:
> On Sun, 12 Apr 2020 at 21:53, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> "VMs using KVM" as security boundary is very clear, thanks.
>>
>> Note 1: This this doesn't appear on the QEMU security process
>> description: https://www.qemu.org/contribute/security-process/
> 
> It's part of the list of how to decide whether an issue is
> security sensitive:
>  "Is QEMU used in conjunction with a hypervisor (as opposed
>   to TCG binary translation)?"

Indeed I missed this. This bug correctly matches the example described:

  "The ‘generic-sdhci’ interface, instead, had only one user
  in ‘Xilinx Zynq Baseboard emulation’ (hw/arm/xilinx_zynq.c).
  Xilinx Zynq is a programmable systems on chip (SoC) device.
  While QEMU does emulate this device, in practice it is used
  to facilitate cross-platform developmental efforts, i.e. QEMU
  is used to write programs for the SoC device. In such developer
  environments, it is generally assumed that the guest is trusted."

> 
> We also document it in the user manuals now (a relatively
> recent improvement):
>  https://www.qemu.org/docs/master/system/security.html#non-virtualization-use-case
> 
>> Note 2: If a reported bug is not in security boundary, it should be
>> reported as a bug to mainstream QEMU, to give the community a chance to
>> fix it.
> 
> Yes; bugs are still bugs.
> 
> thanks
> -- PMM
> 

