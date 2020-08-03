Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F08C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7800620775
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9DW/wfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7800620775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2cTt-0000lg-KW
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 11:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2cTF-0000KT-G4
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 11:33:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2cTC-0005u6-CW
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 11:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596468824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UscEmlzvJiGyV6xsj1UJotgjlhgYt4npF7Mx/38qdHU=;
 b=Z9DW/wfjHos0wbjB+oEF08BgvZ8smpUINP/X77AEZK6c2S9VqFxAaLHhOe3RJEGgWFsUi4
 DZdUto3Uth57H2c2UUB7EfYbGTpwrLx4OgtaVdgevBWaVOlXQGUNW+eiVz309nC4RMF8yN
 87xdFsVy26PppyO8nJsyrr3FTYDhfrg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-lKCU1GWgPWSxdN_0TGKLVg-1; Mon, 03 Aug 2020 11:33:42 -0400
X-MC-Unique: lKCU1GWgPWSxdN_0TGKLVg-1
Received: by mail-wm1-f71.google.com with SMTP id t26so5602318wmn.4
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 08:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UscEmlzvJiGyV6xsj1UJotgjlhgYt4npF7Mx/38qdHU=;
 b=lGRJOU7xDXbwvzBvOw8Evq20tvDlCkXy4DFc2wg0X51t6SA9zOzlwT0hYikd+yL5vD
 k/bZI81xSIsUj91or7NSoy3XBICej6yKPfnNVhy5c3kVgWgdus3W4NEaiC15NvNkh7Z1
 RQC1Gt4Lm1vatnyY7ZMdc1xo3jV3wGJ4FASkiCmb30uPDk8PYsLlI9S2KxZRy0Iag4li
 rNkQBJfnYaaSSuzw6iH01trNsajB6ounTyoDbr9T7YDKHMrxVx2s4pX8lTuZ55zg4JTL
 4S/2VqRE/LbF0mpqemr57A6PivBbxaScuFj8CKkJ3+CB0dpyN7DuiJuXrgnbKpFh/Pzv
 hpbg==
X-Gm-Message-State: AOAM533cj0AOnCvIUsy+ICKPu9sxacDgkqN69l/LyY+ga9xlBg6cS/Ch
 fxN0pQ6Ql1AGXhme6eLEm+oZAZhPeel8doNhoD6pidA6Eb5NFsaT6fy23EjRojQmZ/oxRd+6cDY
 OwBU/Kc/eMR76JSE=
X-Received: by 2002:adf:818b:: with SMTP id 11mr14784660wra.141.1596468821756; 
 Mon, 03 Aug 2020 08:33:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx59JhrurRVPasfTrj3owVxPbGcahUGhxsa8iwp150YMCgab4H856SEk565BiGDP/0XP58Slg==
X-Received: by 2002:adf:818b:: with SMTP id 11mr14784648wra.141.1596468821554; 
 Mon, 03 Aug 2020 08:33:41 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id j5sm26203956wma.45.2020.08.03.08.33.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 08:33:40 -0700 (PDT)
Subject: Re: [Bug 1890160] [NEW] Abort in vmxnet3_validate_queues
To: Bug 1890160 <1890160@bugs.launchpad.net>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <159646547209.2548.10551566895698007373.malonedeb@gac.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
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
Message-ID: <ad6c1942-b467-e74d-896d-26bea2cb496b@redhat.com>
Date: Mon, 3 Aug 2020 17:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159646547209.2548.10551566895698007373.malonedeb@gac.canonical.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cc'ing Dmitry as he doesn't have lauchpad account :/

On 8/3/20 4:37 PM, Alexander Bulekov wrote:
> Public bug reported:
> 
> Hello,
> Reproducer:
> 
> cat << EOF | ./i386-softmmu/qemu-system-i386 \
> -device vmxnet3 -m 64 -nodefaults -qtest stdio -nographic
> outl 0xcf8 0x80001014
> outl 0xcfc 0xe0001000
> outl 0xcf8 0x80001018
> outl 0xcf8 0x80001004
> outw 0xcfc 0x7
> write 0x0 0x1 0xe1
> write 0x1 0x1 0xfe
> write 0x2 0x1 0xbe
> write 0x3 0x1 0xba
> write 0x3e 0x1 0xe1

struct Vmxnet3_MiscConf {
    struct Vmxnet3_DriverInfo driverInfo;
    __le64        uptFeatures;
    __le64        ddPA;         /* driver data PA */
    __le64        queueDescPA;  /* queue descriptor table PA */
    __le32        ddLen;        /* driver data len */
    __le32        queueDescLen; /* queue desc. table len in bytes */
    __le32        mtu;
    __le16        maxNumRxSG;
    u8        numTxQueues;
   ^^^
     \_________ @0x3e = 0xe1 = 225 queues (max is 8).

    u8        numRxQueues;
    __le32        reserved[4];

> writeq 0xe0001020 0xef0bff5ecafe0000
> EOF
> 
> ==============================================================
> qemu: hardware error: Bad TX queues number: 225
> 
>     #6 0x7f04b89d455a in abort /build/glibc-GwnBeO/glibc-2.30/stdlib/abort.c:79:7
>     #7 0x558f5be89b67 in hw_error /home/alxndr/Development/qemu/general-fuzz/softmmu/cpus.c:927:5
>     #8 0x558f5d3c3968 in vmxnet3_validate_queues /home/alxndr/Development/qemu/general-fuzz/hw/net/vmxnet3.c:1388:9
>     #9 0x558f5d3bb716 in vmxnet3_activate_device /home/alxndr/Development/qemu/general-fuzz/hw/net/vmxnet3.c:1449:5
>     #10 0x558f5d3b6fba in vmxnet3_handle_command /home/alxndr/Development/qemu/general-fuzz/hw/net/vmxnet3.c:1576:9
>     #11 0x558f5d3b410f in vmxnet3_io_bar1_write /home/alxndr/Development/qemu/general-fuzz/hw/net/vmxnet3.c:1772:9
>     #12 0x558f5bec4193 in memory_region_write_accessor /home/alxndr/Development/qemu/general-fuzz/softmmu/memory.c:483:5
>     #13 0x558f5bec3637 in access_with_adjusted_size /home/alxndr/Development/qemu/general-fuzz/softmmu/memory.c:544:18
>     #14 0x558f5bec1256 in memory_region_dispatch_write /home/alxndr/Development/qemu/general-fuzz/softmmu/memory.c:1466:16
> 
> -Alex
> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> 


