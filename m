Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAFCC31E40
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 13:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424672085B
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 13:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424672085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1httla-0000j5-JW
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 09:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33544)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1httkq-0008W0-3K
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 09:07:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1httkp-0000e3-3Y
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 09:07:24 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1httko-0000dV-VV
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 09:07:23 -0400
Received: by mail-oi1-f174.google.com with SMTP id w79so58955047oif.10
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 06:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fwUQ6tNKOqRSy7kX+oFp4wbartpWeUFMkbznppeqod4=;
 b=dwXd6I5VEdiUdU6qZSyOfGHLJOWJI8vAfdjdCSDVxEs6vLgFGbubxi+H2Cyx5s0YJz
 ID0BoqG/i9EB51NQzQoGYhEzZ4ayw5s4mBsF2xfekT5cJvTr+F/VSroGW6G0IemoSgcd
 OdB4iFLa9CyhXKB4AkTOn6OG/xHhrYNg/xbD+UPEUKK8ORmPZbNQspuyvDSobXwHec+i
 GB+DYAzraZ37pQHdx1v94pJiYBwgY25Z1ltzXcd5JkdFQvUgn6rM9OTKYQlmZpISOWIR
 r55FBEjkR4zfyTJO5SNyJzc8X1ZvQGv+nzeWOgoSyj5s/73EbpozzoLeagYAVnczR0bA
 6zzw==
X-Gm-Message-State: APjAAAURTiMiJrgDGVY1I/6jZgCQOehXazIrdAEdsG8PdndOmYGxFXcV
 91nYG5Ux7QLUHAto/hszI/TFvyCfBO2M3XnB8iNbvA==
X-Google-Smtp-Source: APXvYqxQhe4bdXmxZRYg0LdKs/hf/EzYHBVHhV5rFe2gvaxG8zbcbuklzxJg0KxCSIG2LD/x3Yr/BAX5P1bRBLxC99o=
X-Received: by 2002:aca:f513:: with SMTP id t19mr6078011oih.76.1564837640960; 
 Sat, 03 Aug 2019 06:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190802131509.lplyvrbdwiwo2tve@auriga.localdomain>
In-Reply-To: <20190802131509.lplyvrbdwiwo2tve@auriga.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 3 Aug 2019 17:07:09 +0400
Message-ID: <CAMxuvawykqui1GA4ojF5gdPwzOF5ETWnaGMhxyC97FR=HmB7DQ@mail.gmail.com>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.174
Subject: Re: [Qemu-devel] qemu-ga -- virtio driver version reporting
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
Cc: Gal Hammer <ghammer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Aug 2, 2019 at 5:12 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com> wrote:
>
> Hi,
>
> I would like to add version reporting of Windows virtio drivers to qemu-g=
a.
> Obviously this is specific to Windows as for POSIX systems it corelates w=
ith
> the version of kernel. I would appreciate your ideas on a few topics.
>
> Does it make sense to add this information as new (optonal) field to resu=
lt of
> 'guest-get-osinfo'. Or would it be better to add whole new command? I exp=
ect

If the information is cheap to retrieve, I think it is fine as part of
get-osinfo.

> the result to look something like this:
>
>     "component-versions": [
>         {
>             "name": "VirtIO Balloon Driver",
>             "version": "03/10/2019,62.77.104.16900"
>         },
>         {
>             "name": "QEMU PVPanic Device",
>             "version": "06/11/2018,62.76.104.15400"
>         },
>         ...
>     ]

I am not a Windows expert, but I can imagine drivers have a more
uniquely identifiable ID than a human string.

>
> Alternatively we could report all available versions of the specific
> driver instead of just the latest. Note that this does not say much
> about which version is in use or if a device is available in the
> system.

What's the goal of this version reporting btw? to audit the VM? Isn't
there other mechanism to keep Windows systems up to date and alert
management layers? Perhaps that's Windows business/enterprise
solutions that are too expensive though, and we want something more
specific to qemu VMs.

>
>
> I have checked the available drivers and the names quite vary. I guess we=
'll
> need to list and match the complete name and not just some substring (lik=
e
> "VirtIO"). See the following list:
>
>     QEMU FWCfg Device
>     QEMU PVPanic Device
>     QEMU Serial PCI Card
>     Red Hat Q35 SM Bus driver
>     Red Hat QXL controller
>     Red Hat VirtIO Ethernet Adapter
>     Red Hat VirtIO SCSI controller
>     Red Hat VirtIO SCSI controller
>     Red Hat VirtIO SCSI pass-through controller
>     VirtIO Balloon Driver
>     VirtIO Input Driver
>     VirtIO RNG Device
>     VirtIO Serial Driver
>     VirtIO-Serial Driver
>
> Is it OK to hardcode the list in qemu-ga source? Is there already any sup=
port
> for dealing with regexes or tries in qemu source tree?

glib has GRegexp.

>
> Any other ideas, concerns?
>
>     Tomas
>
> --
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

