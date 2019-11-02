Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43280CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 19:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBD22080F
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 19:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TU16wUnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBD22080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQzWi-00055i-66
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 15:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQzVz-0004Hr-BZ
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQzVy-0004Ye-GM
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:56:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23521
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQzVy-0004YF-83
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 15:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572724609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NzAygiJepL/8WEjRsFowDoetuqNs/P38x7uA7zQTJYE=;
 b=TU16wUnfsxe6b3b27MQEel/c7Gtd1Q/nCiRWw3YgeCMGpLQ3pNusS2aYi7Z10pJmNugQoK
 Fopw5enq/foPomFPzq7BkDZadfMVT+Ld2wlYDLQk51vhngsnyF3B50tMdt3ojbq7EQ7I5v
 ByFywufZ+0y8dO4n05+Q2UY6iiWjpJI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-xQzUHDyNNmS6F_Noy9q8cQ-1; Sat, 02 Nov 2019 15:56:47 -0400
Received: by mail-wr1-f71.google.com with SMTP id g17so3021381wru.4
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 12:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fYkQ/qjDRXej74iDDTt3pkdoGwTsQinEPiaihxJ3Opc=;
 b=HfURjY6jyOpw+k41Qi6NLEDmOPkpts6upl0ImfMax7qDIK2DwAPlj41VFqvCV8Dm5o
 iQUQpBi+xc3RNE4g9Ac5sY63m7R/31V6t943ik+BOXFJpWsXXp8CwQ/UCuOHM8oXzavL
 c5PvGNKRr/n2Jss0BZQ/4c8JGBgYU2bptjTKMrjZ2KlehoOUE/vaJoh6En5XdzPA4swJ
 uA60M/pfQHBh/EE712A5PTQyU7gSjvGJEeRNWp1DMjcbIC/u52fkDxF2L83OXth4ONgY
 gwaDZ4woR8cEzwRh+ZsY+33BV8j4q+5F9zLrsALX6Q50Q4DfieY1isYe0vNJYCulhSxv
 M7tA==
X-Gm-Message-State: APjAAAX5ihjPvalQtop7Zu+l/qnGOqKKl7ICE1TdBckMY+g8sVCmI2aB
 4kQIiNCdmcnXmZZp1ycACD8MKGepHgnZ2UeDtDHtUhTEXrLY9cVG8JPrWyx61JhcIHnIupdUx2G
 uSqDFMkG57iXocZ0=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr16076110wrn.67.1572724606277; 
 Sat, 02 Nov 2019 12:56:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNgoiKh6lCC1xk/MAY2Cm9QcWigSD1duVxLlw9w7dR5jrvdJ3r7I7fkdER19pGu3cSMTcM0Q==
X-Received: by 2002:adf:ee10:: with SMTP id y16mr16076102wrn.67.1572724606097; 
 Sat, 02 Nov 2019 12:56:46 -0700 (PDT)
Received: from [10.34.4.205] ([109.190.253.11])
 by smtp.gmail.com with ESMTPSA id y78sm3711051wmd.32.2019.11.02.12.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Nov 2019 12:56:45 -0700 (PDT)
Subject: Re: Sparc Solaris 10
To: Zainuddin AR <zar1969@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <CA+gXNfhCRT1kPq4KVumXwRiJvVaXYZZBRhs-QsVNKv+WzeMM+A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <54af7410-569e-2b4b-70ed-f09039014bda@redhat.com>
Date: Sat, 2 Nov 2019 20:56:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CA+gXNfhCRT1kPq4KVumXwRiJvVaXYZZBRhs-QsVNKv+WzeMM+A@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: xQzUHDyNNmS6F_Noy9q8cQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Cc'ing the SPARC maintainers.

On 11/1/19 4:49 AM, Zainuddin AR wrote:
> Hi,
>=20
> I like to find to find out if you have a working qemu on solaris 10 or=20
> 11. I have tried the=C2=A0qemu-sun4vniagara but without networking. Is th=
e=20
> networking support for niagara version available?
>=20
> Regards
>=20
> Zai


