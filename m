Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607FBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 23:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F3720826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 23:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9uI4vNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F3720826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrVL3-0006x1-CZ
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 19:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrVKM-0006S4-El; Fri, 03 Jul 2020 19:42:42 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrVKK-0001sm-NW; Fri, 03 Jul 2020 19:42:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id f139so35671647wmf.5;
 Fri, 03 Jul 2020 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RzXv0/aKMQdbFXDbikxnemBRNYBqAR193rNV/2PPACw=;
 b=W9uI4vNXyvQG38IgrbvCuOwfPLqd7GGdJMNNuElYOwJlG3hDh05XkY1z24mKRN/yE0
 QaemcBkv/qxGh/prS0LXQi0dNXqwrHhw2tPS2fUlB++wmoE/c5WQSiSCymoCJMqiroW5
 aU7n6YeziCcttKlu6o3kbKqF/tkQ3z6BLzSC8UbXPuj5IdgUeMalWcETi3iKmJUMH5Ml
 HeNl6Nl7+fwjoM7GyykFEDO6GA/p/3Jd5O2SM00SkC4+5eJAM+ZwUzB/sdKa8JZ2M4uR
 cdGuz4kGm1Mar/DxueVMM+PkdHrhNx9i63UAJ6T8jh1gIEsrEwADq4irGo6yyF90G/v2
 VYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=RzXv0/aKMQdbFXDbikxnemBRNYBqAR193rNV/2PPACw=;
 b=R5by7bz9iDurw4m0Cn00L01CdmixfWP5vCujGR3GLbyjvpAEkE0Nzdm3zdDqattv8M
 KJLQls+u11G4yOqp1Q67NB4sV6S/PFL5RKwlNpVN5jy/pyzwEGcyN+VNC+o5QovzHs73
 13fhitTrGS3YKzuNRVreT/N+lAexzR2j1WY8PacZfr9U7bfpzhhlAGiwN8MzJoe+e1zr
 0u0tPIc8sFaVgcxBRLLF4bECsYcdvrSP3K7930MpbozMaCSb6f51jpx/Ny4dxboMBX/6
 /6VY8uLrRwksdmT5N7nQ2dYngQl0DOP3+LXhbNBKDTOt7CZne0PmHkDrOB0oqi0QajjX
 de9w==
X-Gm-Message-State: AOAM533L4r7LHnDs0ULcLEVps2b+PA+9XMTHQQjHbV7xUbP4Z9v86Ak+
 PslqkZDU2JSU9JgE5p8Rbrc=
X-Google-Smtp-Source: ABdhPJx9AoFau9gmO+9MJxLCSmAcfYtslnTb2XpANtSimYS8MmmXn9SBR4RhqUlO51OGhvywBJ2fdg==
X-Received: by 2002:a1c:5418:: with SMTP id i24mr37303059wmb.47.1593819758741; 
 Fri, 03 Jul 2020 16:42:38 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x124sm10244394wmx.16.2020.07.03.16.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 16:42:38 -0700 (PDT)
Subject: Re: [PATCH v7 09/17] hw/sd/sdcard: Special case the -ENOMEDIUM error
To: Philippe Mathieu Daude <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-10-f4bug@amsat.org>
 <CAFEAcA_dhbr6cjK40H0=e39sD2r8ERTZYrY5nhJtx81Rk+RmUg@mail.gmail.com>
 <2c77e134-4762-89b2-b60d-aabde740f25f@amsat.org>
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
Message-ID: <2a6b8801-038e-d67c-6d96-a3df526c44a0@amsat.org>
Date: Sat, 4 Jul 2020 01:42:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2c77e134-4762-89b2-b60d-aabde740f25f@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eddie James <eajames@linux.vnet.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 5:16 PM, Philippe Mathieu-Daudé wrote:
> On 7/3/20 3:23 PM, Peter Maydell wrote:
>> On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>
>>> As we have no interest in the underlying block geometry,
>>> directly call blk_getlength(). We have to care about machines
>>> creating SD card with not drive attached (probably incorrect
>>> API use). Simply emit a warning when such Frankenstein cards
>>> of zero size are reset.
>>
>> Which machines create SD cards without a backing block device?
> 
> The Aspeed machines:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg718116.html
> 
>> I have a feeling that also the monitor "change" and "eject"
>> commands can remove the backing block device from the SD card
>> object.
> 
> This is what I wanted to talk about on IRC. This seems wrong to me,
> we should eject the card and destroy it, and recreate a new card
> when plugging in another backing block device.
> 
> Keep the reparenting on the bus layer, not on the card.

I was wrong, the current code is correct:

void sdbus_reparent_card(SDBus *from, SDBus *to)
{
    SDState *card = get_card(from);
    SDCardClass *sc;
    bool readonly;

    /* We directly reparent the card object rather than implementing this
     * as a hotpluggable connection because we don't want to expose SD cards
     * to users as being hotpluggable, and we can get away with it in this
     * limited use case. This could perhaps be implemented more cleanly in
     * future by adding support to the hotplug infrastructure for "device
     * can be hotplugged only via code, not by user".
     */

    if (!card) {
        return;
    }

    sc = SD_CARD_GET_CLASS(card);
    readonly = sc->get_readonly(card);

    sdbus_set_inserted(from, false);
    qdev_set_parent_bus(DEVICE(card), &to->qbus);
    sdbus_set_inserted(to, true);
    sdbus_set_readonly(to, readonly);
}

What I don't understand is why create a sdcard with no block backend.

Maybe this is old code before the null-co block backend existed? I
haven't checked the git history yet.

I'll try to restrict sdcard with only block backend and see if
something break (I doubt) at least it simplifies the code.
But I need to update the Aspeed machines first.

The problem when not using block backend, is the size is 0,
so the next patch abort in sd_reset() due to:

  static uint64_t sd_addr_to_wpnum(SDState *sd, uint64_t addr)
  {
      assert(addr < sd->size);

