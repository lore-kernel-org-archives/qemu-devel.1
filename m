Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FEEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6427A2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZplO+8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6427A2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv1Re-0002Gr-O9
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv1R2-0001Ms-7e; Mon, 13 Jul 2020 12:36:08 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:44192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv1R0-0004yP-5S; Mon, 13 Jul 2020 12:36:07 -0400
Received: by mail-ed1-x544.google.com with SMTP id by13so14206503edb.11;
 Mon, 13 Jul 2020 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=clP8BzdMGzCa8AvduGEd6Kt6VZNsSrfrq2VXoVLtfnY=;
 b=RZplO+8W1Rs8z64lTQcfLuC0r/YmyPw7aAaPZ0t3i5X3ZJQgid47aPw6r55B/sjuUQ
 6rMuiwCF/HdrYGCq5/EZgXXd+HkTnJmb1Jc67/N+7TKy7rRxNU01wYyq9yE8Pz5e8Y7x
 DxI28lXYPaDhyPrW3oGRbG+ROhevNVlFTUjOny9s7RfTM1OYBcvvcmRbkiv5J2jLzUZX
 WMaS7mbKQXRSQU6a3j28isEB42E25nqw0G4brXMmGD13KRQ37hiE3GOKQroLu1APFcLG
 3amYBDczzN2YnAw17qfaOt6pbU9ajAW+f+csB9jKB5GcpztksPehmxTBKn51Sn9AeqEt
 BjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=clP8BzdMGzCa8AvduGEd6Kt6VZNsSrfrq2VXoVLtfnY=;
 b=Wz0ebqEruC4WZcSAzY3xcMFI39kQcuLWqLwy5oGNfVrTEA/oanQa7X1vLWqX4nq8Q/
 64HknMOCytKRBvVEFqtExQILfh8+7zCZokww6xzPNN6MA2SgozZ9ZowcuUlng18Z+u3Y
 Yl2aGPH24PsF9vb1/VACWVOa5ANm748VgXyCe6Uy4auyMUKHV5CxbwX0dL1qCi+tTdet
 gXg1ol2cdR0AYqyxCRYN+5eaeAPmmECFefjtqHRgYpqnguYXIOVrDbnGx4MS92pStiQ0
 pquQl6IMgKUyPRcgfzws5QCatjCiNijbUyC02CovWSbPH6rqE0Hc2uuvhEQbnTuWfECx
 pRng==
X-Gm-Message-State: AOAM532OCnQS8TabkmUa4G6QCQvydrX8a3Pk40R5F7xDUgC6WNsjLJAl
 M4W/0iXEJ7bgDrGdXTLA8MY=
X-Google-Smtp-Source: ABdhPJwhT01nyiU3xWLpK5mp32I80/TxgSeXIrJ3TLf3O1NLToOoExhrAO+N2Ajwq3np+dNEbuvoPg==
X-Received: by 2002:a50:bb48:: with SMTP id y66mr226760ede.147.1594658164245; 
 Mon, 13 Jul 2020 09:36:04 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id u18sm11853278edx.34.2020.07.13.09.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 09:36:03 -0700 (PDT)
Subject: Re: [PATCH v3 03/11] hw/sd/sdcard: Do not switch to ReceivingData if
 address is invalid
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200605102230.21493-1-philmd@redhat.com>
 <20200605102230.21493-4-philmd@redhat.com>
 <CAFEAcA-6Vv5Q31Z0bsXPpWanEj8Z0gBeZFWTCrQF3W8RuaQiMQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <3e682d7b-8d6a-999e-e426-ffcdd0fc323e@amsat.org>
Date: Mon, 13 Jul 2020 18:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-6Vv5Q31Z0bsXPpWanEj8Z0gBeZFWTCrQF3W8RuaQiMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 4:06 PM, Peter Maydell wrote:
> On Fri, 5 Jun 2020 at 11:25, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>> Only move the state machine to ReceivingData if there is no
>> pending error.  This avoids later OOB access while processing
>> commands queued.
>>
>>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
>>
>>   4.3.3 Data Read
>>
>>   Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>   occurred and no data transfer is performed.
>>
>>   4.3.4 Data Write
>>
>>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>   occurred and no data transfer is performed.
> 
> It's not clear from the spec that this should also
> apply to WP_VIOLATION errors. The text about WP_VIOLATION
> suggests that it is handled by aborting the data transfer
> (ie set the error bit, stay in receive-data state, wait for
> a stop command, but ignore all further data transfer),
> which is I think distinct from "rejecting" the command.
> 
> If that theory is right then moving the check for the
> ADDRESS_ERROR in this patch is correct but the WP_VIOLATION
> tests should stay as they are, I think.

I found the correct behavior in table '4.10.1 Card Status':

* OUT_OF_RANGE
  ============
  Type: E R X

  The command's argument was out of the allowed range for this card.

* ADDRESS_ERROR
  =============
  Type: E R X

  A misaligned address which did not match the block length was
  used in the command.

* WP_VIOLATION
  ============
  Type: E R X

  Set when the host attempts to write to a protected block or to
  the temporary or permanent write protected card.

With 'Type':

- E: Error bit.
- R: Detected and set for the actual command response.
- X: Detected and set during command execution. The host can get
     the status by issuing a command with R1 response.

Block Read
==========
[...]
When the last block of user area is read using CMD18, the host should
ignore OUT_OF_RANGE error that may occur even the sequence is correct.
If the host uses partial blocks whose accumulated length is not block
aligned and block misalignment is not allowed, the card shall detect
a block misalignment at the beginning of the first misaligned block,
set the ADDRESS_ERROR error bit in the status register, abort
transmission and wait in the Data State for a stop command.


So I understand we want OUT_OF_RANGE (returned via R1).

