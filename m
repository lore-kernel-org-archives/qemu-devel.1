Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33C9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BC4206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BA9WOgEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BC4206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDohQ-0004Sh-GB
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDogD-0002z2-QH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:49:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDogB-00023T-Pz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599137366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S3KCApHiBdB+T3Ty3d0wjIuJXJM2uIW9LtuWaNrykHk=;
 b=BA9WOgEphzNAlQ63KOulKI0egzKCy/oN1gQQgSn6asJtvEBNn0CGAi/hVyJupOoaQjHHjH
 cb1OQ02ZRIeVIi+i29Aiw+H+GpNhWCd6IB7JJ49DwXFzQQnlpCIo7cu4SvBIvXeZOGBtuc
 s1z3tdpdw06yrkGDOWnmdKgjWrBoMtY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-glOLTwdLOhyNv9fLjRTnoQ-1; Thu, 03 Sep 2020 08:49:24 -0400
X-MC-Unique: glOLTwdLOhyNv9fLjRTnoQ-1
Received: by mail-wr1-f70.google.com with SMTP id f18so1030349wrv.19
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=S3KCApHiBdB+T3Ty3d0wjIuJXJM2uIW9LtuWaNrykHk=;
 b=q/neeYPxdV4GgTfjau28jze6MPb0//0lFqjOzGrKbHXGD+RFmTWIQwJaatCmP23m1f
 KILztTyaRp9ruCo/Z9n7B+q/HOtYtu3ARF0PRcu0qhsn3DLJ2t0Vwc/OfOh6tDYZUGkM
 HrwGw2GOUndj3fw5QvcpTYo5PQPnkeWpt5DSiTE1257RDcBl+bhb28CjbZ4VrP1QOp11
 C4Q67dv6Ulfj++rf5RGNtKfx1hPsTvcsXiEDevutAAN/dQEaXCTeza+ao/xvPvs0w6gf
 /0rCM4X4XMmTMwys4f5+NnH7dt/mgPhNjdndSx/xyK3FLtZF9C6gAcygGyAUIfy9TKkh
 UjaA==
X-Gm-Message-State: AOAM531TxUm0vWyNEuAqG4rnFfce/q7PiWBOYSgWCbb8ifAxOpE28VuT
 JdSt4hAktJMECBMRd/O5tg6JbIeW6BW2tQMoYpziLgfPedli8bXWhWBoFkqK4rpkkWv8OHveQv1
 9ZZRrihYLrvMB3zg=
X-Received: by 2002:adf:8187:: with SMTP id 7mr2342805wra.266.1599137363450;
 Thu, 03 Sep 2020 05:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmupgbQuv81e2xEHRaZFWWqmYk3kJzGASA22O68dDb9cRtuY3uaMNQvdnfFnhZjvLVrFvKiQ==
X-Received: by 2002:adf:8187:: with SMTP id 7mr2342787wra.266.1599137363278;
 Thu, 03 Sep 2020 05:49:23 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id u17sm4114031wmm.4.2020.09.03.05.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 05:49:22 -0700 (PDT)
Subject: Re: [PATCH 02/63] chardev: Rename TYPE_CHARDEV_* to TYPE_*_CHARDEV
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-3-ehabkost@redhat.com>
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
Message-ID: <b40ae788-c711-06fe-eae3-951d64ba92c8@redhat.com>
Date: Thu, 3 Sep 2020 14:49:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-3-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> This will make the TYPE_* constants consistent with the name of
> most type checking macros we have today.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Alex Bennée" <alex.bennee@linaro.org>
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  chardev/chardev-internal.h       |  4 ++--
>  include/chardev/char-fd.h        |  4 ++--
>  include/chardev/char-win-stdio.h |  2 +-
>  include/chardev/char-win.h       |  4 ++--
>  include/chardev/char.h           | 30 +++++++++++++++---------------
>  include/chardev/spice.h          |  8 ++++----
>  chardev/baum.c                   |  6 +++---
>  chardev/char-console.c           |  4 ++--
>  chardev/char-fd.c                |  2 +-
>  chardev/char-file.c              |  6 +++---
>  chardev/char-mux.c               |  2 +-
>  chardev/char-null.c              |  2 +-
>  chardev/char-parallel.c          |  4 ++--
>  chardev/char-pipe.c              |  6 +++---
>  chardev/char-pty.c               |  4 ++--
>  chardev/char-ringbuf.c           |  8 ++++----
>  chardev/char-serial.c            |  6 +++---
>  chardev/char-socket.c            |  4 ++--
>  chardev/char-stdio.c             |  6 +++---
>  chardev/char-udp.c               |  4 ++--
>  chardev/char-win-stdio.c         |  4 ++--
>  chardev/char-win.c               |  2 +-
>  chardev/char.c                   |  2 +-
>  chardev/msmouse.c                |  6 +++---
>  chardev/spice.c                  | 10 +++++-----
>  chardev/testdev.c                |  6 +++---
>  chardev/wctablet.c               |  6 +++---
>  gdbstub.c                        |  6 +++---
>  hw/display/vhost-user-gpu.c      |  2 +-
>  tests/test-char.c                |  4 ++--
>  ui/console.c                     |  8 ++++----
>  ui/gtk.c                         |  6 +++---
>  ui/spice-app.c                   | 10 +++++-----
>  33 files changed, 94 insertions(+), 94 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


