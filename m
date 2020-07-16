Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B47C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F18720760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 07:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHX6X00X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F18720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvymU-0003yM-D0
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 03:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvylv-0003X2-ET
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 03:57:39 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvylt-0004D3-Uz
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 03:57:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id w3so10382907wmi.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ITbZ0mkoHcwNQuKLh6St8K/j5GbXM90gmcivA31R1pQ=;
 b=DHX6X00XsdVEooZ2qGB6GDRvDPHRImIpOs7z0mTwVs46C4xBtJKxuMnBNVyCOOIzco
 957G7MQEvGV7MjH5kjB7GCJwcFB1eberEG8+hu4+GJCQeyVRLPs2UXgmRg4TzxX4ul9d
 dzw+8PtgsDaW8qE+7FYQQRjO8QS0OYJR6ZnCN6Ne4UdDj8ay1cY3IIRkf3ZohXS+8o4g
 R5rwkvqYvFGkbx+CyxuURT2JQkJ4U9qZ3mUGZrRj80o9Ef8hCgO29DLXU2AxKgcEiErY
 qcwDxJE/Sxf4OrZEW29qgwgtA5CUI0Wlh9UuioNH7aatEAO9dhda+CnV0hcScyJGVn/x
 cBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ITbZ0mkoHcwNQuKLh6St8K/j5GbXM90gmcivA31R1pQ=;
 b=BQHIR8Njqnf1On93wXh4UwUqy2OtNUeDpVz3w3crYEU5WZElmusI3yFnZ+wVV79TFh
 I4JPYidC3K4f5Zj6TbQEgl+jhHCmldSe4lc1OslnwMxhp3Cm/GkNQk80n6KmyuAlc30A
 DRkD5PTK6dNd15hiMwI0fJ5OIhFkYNdREBlzhdNHCfIMVjB6AORG81Rfwhbv5sUxaKZy
 BVoc01GjXnvPtVo/tS/SqQUFfD/VsJ6FRGq2aQxCer9YDg8OqkhNNjD8LOR6+h3QS8UG
 m0Om+vpdfA4V+uVsqRamz4/dVlNN/QAQRoRX0wmtG4nvCxLzWNHv8cyHRroJ8lcR6pzD
 qYpQ==
X-Gm-Message-State: AOAM5326jiXbDN3tqYCbGwyep4c8/B1DV4Lol5RVwKrEJaBUlutN0pPH
 cbE67L59jM3vMz3Hbddd22o=
X-Google-Smtp-Source: ABdhPJy5XVcq4oXaDsSqFzxObgkbQvyhosyy4RRFQKnNh/r5bMqCjxNXOrcZOHgx11sFW0vh0d9iog==
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr3139524wmg.123.1594886256391; 
 Thu, 16 Jul 2020 00:57:36 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id b184sm7609185wmc.20.2020.07.16.00.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 00:57:35 -0700 (PDT)
Subject: Re: Implement standard file operation with QEMU
To: casmac <climber.cui@qq.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <tencent_BF749AEC7484FAFD4D5356B065C6679BF705@qq.com>
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
Message-ID: <e9940859-3fd3-8710-a7d8-84ed94a96715@amsat.org>
Date: Thu, 16 Jul 2020 09:57:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <tencent_BF749AEC7484FAFD4D5356B065C6679BF705@qq.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Xiaolei,

+Laurent (user-mode)
+Alex (semihosting)
+Marc-André (chardev)

On 7/16/20 2:51 AM, casmac wrote:
> Hi all,
>   I am trying to implment standard file operation (stdio) with QEMU for
> DSP architecture. The manufacture (TI) provides a runtime library that
> support posix standard IO, but it left the device level implmentation as
> hook function calls, like in the library source , it contains 
> add_device() function, and write(),read(),open() are not implemented:
> 
> int add_device(char      *name,
>                unsigned   flags,
>                int      (*dopen)  (const char *path, unsigned flags, int
> foo),
>                int      (*dclose) (int fno),
>                int      (*dread)  (int fno, char *buf, unsigned count),
>                int      (*dwrite) (int fno, const char *buf, unsigned
> count),
>                fpos_t     (*dlseek) (int fno, fpos_t offset, int origin),
>                int      (*dunlink)(const char *path),
>                int      (*drename)(const char *old_name, const char
> *new_name))
> {
>    _DEVICE *dt;
> 
>    strncpy(dt->name,name,8);
>    dt->name[8] = '\0';
>    dt->flags   = flags;
>    dt->OPEN    = dopen;
>    dt->CLOSE   = dclose;
>    dt->READ    = dread;
>    dt->WRITE   = dwrite;
>    dt->LSEEK   = dlseek;
>    dt->UNLINK  = dunlink;
>    dt->RENAME  = drename;
> }
> 
> int write(int           fildes,
>           const char   *bufptr,
>           unsigned      cnt)
> {
>   
> /*------------------------------------------------------------------------*/
>    /* CALL FUNCTION FROM DEVICE TABLE TO PERFORM WRITE FOR THIS
> DEVICE/FILE  */
>   
> /*------------------------------------------------------------------------*/
>    return (*(_stream[fildes]->WRITE)) (fildes,bufptr,cnt);
> }
> 
>    Then, how can we use this runtime library together with QEMu to
> implement full-stack file oerations?  I really appreaciate any advice.

Trying to understand...

Are you trying to ask "how to implement semihosting for my
qemu-user-tidsp fork"?

Have a look at "hw/semihosting/console.h" and the implementation
(so far only ARM) of qemu_semihosting_console_[in/out].
This might help to plug read/write. Using other stream than
stdin/stdout is not supported (but you can add support) so
open/lseek/close/rename/unlink are not considered.

(for QEMU 'console' is the stdin/stdout subset of stdio).

You can redirect semihosted files with any host chardev,
this is done in qemu_semihosting_connect_chardevs().

You might also have a look at the functions declared in
"hw/semihosting/semihost.h" and how the different TCG helpers
use them.

Regards,

Phil.

