Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EECC282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 12:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5B5207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 12:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5B5207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45816 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haJ3z-0003WU-LK
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 08:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54398)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1haJ25-0002Z5-Pt
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1haJ22-0002Lx-6n
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:04:12 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1haJ20-00025X-CJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 08:04:09 -0400
Received: by mail-wm1-f44.google.com with SMTP id s15so5459262wmj.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 05:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z5A6X8AkRuuHAvmEEszQeDZC0lEJa3VbK5TkPlorm/c=;
 b=YDQzD+QlnvrX/9UrDcOC9e8uA7SvATV2Pep27zn27I40C1dBJzQT3gYFh9VLtGxq7W
 HDW45X7WMfQbmjH43o5FWnUNP1t9LexyJGArkzoQhGRlZUOcnRJveb/i5n1jFNrINyrT
 KDu8WefZRgxlD5OtS+HRryTa+6CKX5nfkTgqF5w0VbI/adHrW/J4HubdHEbMJP/UIQXQ
 r65jkISuW/EKFHUlxaJTLHjC0KRHYlIGIoGyMrs8J/nVENOxRZs3vPuGEGjCHsmAYwql
 iFKOH2M6/Ulz5vxBGygU3Y5o/Doap0TuFDaT4TviJmKaqVc6go0B45Y6Y57xi/NY8jDD
 wJMw==
X-Gm-Message-State: APjAAAUabmQOjQ/ZPyOPe96vp4Rdp1328ReCKNLFpmtxZai7Z0ufn4ii
 M2rshTTK0C1evAX/CaIMSbEy1g==
X-Google-Smtp-Source: APXvYqxbuMBVXZTIZCLzIpTgttVCnWSYcC8dwMq4urKF0yRptz776XZnRQ2hTUgWXW4Tt2qrjhqADw==
X-Received: by 2002:a1c:acc8:: with SMTP id
 v191mr13791303wme.177.1560168224821; 
 Mon, 10 Jun 2019 05:03:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:49d3:a711:c5a3:8ebf?
 ([2001:b07:6468:f312:49d3:a711:c5a3:8ebf])
 by smtp.gmail.com with ESMTPSA id r6sm3932821wrp.85.2019.06.10.05.03.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 05:03:44 -0700 (PDT)
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
 Natalia Fursova <Natalia.Fursova@ispras.ru>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
 <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
 <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>
Date: Mon, 10 Jun 2019 14:03:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.44
Subject: Re: [Qemu-devel] qgraph
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
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/19 13:57, Andreas Färber wrote:
> Your question doesn't make sense grammatically or conceptually. As Paolo
> explained below, QOM is a pure object model, with object types/classes
> and properties. Buses are just object instances attached as properties
> and don't necessarily even need their own type of bus object (e.g, CPU).
> An answer you don't like doesn't change by asking it to other people...
> The information is all there, you just need to interpret it correctly.
> 
> There is no technical discussion (no concrete proposal of yours) to
> comment on here, and kindly refer to last week's change of maintainers.
> 
> You would be better off just explaining what you really want to achieve.

Well, that was explained upthread---finding out what device can be
plugged where.

Let's see what is in QOM right now:

$ qemu-kvm -qmp unix:foo.sock,server,nowait -device virtio-scsi-pci,id=vs
$ ./qmp/qom-list -s ~/foo.sock /machine/peripheral/vs|less

There is a "virtio-bus" here, and iside it there is a scsi-bus.

$ ./qmp/qom-list -s ~/foo.sock /machine/peripheral/vs/virtio-bus/child[0]/
vs.0/

I guess you could add to virtio-scsi-pci a class property for the bus,
and then make "vs.0" an alias to that class property.  This would allow
you find buses by enumerating the class properties.

Paolo

