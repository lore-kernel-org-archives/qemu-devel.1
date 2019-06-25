Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB25C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47343215EA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9oRFnUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47343215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfgzl-0004K6-JX
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 04:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55491)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1hfgyz-0003sw-8W
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1hfgyy-0007jq-6O
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:39:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1hfgyx-0007iN-W7
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:39:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so1989494wma.4
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 01:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=xYGDMWi+chB1JMu/bRQDsxri1VmEcky8dUQz7Qj9IAc=;
 b=u9oRFnUdrNd0gegIAe7Fw3LRtA0zSJHT3oS8wM08Tk4Nyd0BZYDvYvgG9jzLDKmTys
 NyiyLiTx7XfnxiQbYoCA8N7hF6vNK83rrfY7ALQ28aJmv2gyAg81wW9Nlbc9OH68/DQ6
 6+092hRG5E5XKHr36jIRl2ayqS9UZBuPvAVp0kp6pe8mHcRa7Tc9vgJFDVvOXiN+kebA
 mcuQeVEwhWi7QgZoKUVSNzFsB/iljmMoUuyzuzkBDcNcRXJgBoWhEBpoynQx9/b0usQ8
 JeccwNkGh0wXClTGZUAXsMVR0OM4Ke9mC1olNeUvczoV76rHVe4tgLP4A5pC8ck+tMaC
 XF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=xYGDMWi+chB1JMu/bRQDsxri1VmEcky8dUQz7Qj9IAc=;
 b=nsatEI9Cedags2nQsbZD2Kj0q1r6QcgF0zDBPKmTMYb2mtLnzVbGoXFtDukr/2l2U3
 i8h3VHG8hhZ95aqwtJOlQadsyHv1g0l3KeJ7x24h74vyiDXsV2MMo8b4sPV/t91wJRFT
 hawXCp1PBAoXogaB7AJSvGs8vYoWG86Fg7ESiew1XH2pJfeBptLzxMJOejhP7EzVmXby
 sxfhAq9x5NhabZOnXO9GGwOeyWeyPGIHDHoN32pd7wvusaxwES+JByyHHuc3jceUiIEE
 BfBY6lzIF4JTTmwuOPIJ0mDHxqQcf1pHQwphfQhMznfgQHEaA96RVx6H9drbmn9XHp6O
 qzZw==
X-Gm-Message-State: APjAAAW2fR+h5gfXA4WtU2lBWF5XxcmvoLNSciG9MPj2mLSyuKQ6yNhO
 dDT98wwuOYWCliDBDW0Cvt+GLl0hkxaerg==
X-Google-Smtp-Source: APXvYqwUxpUDbTYDGIOR43I/f0BpiG/0oH7dHEJRJIaCbiaq8/ATIQW23fYXTKdnOf7FvqA0N45h/Q==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr19472333wmc.77.1561451954384; 
 Tue, 25 Jun 2019 01:39:14 -0700 (PDT)
Received: from [10.0.1.34] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id j18sm16177718wre.23.2019.06.25.01.39.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 01:39:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <a80f7beb-48c1-553a-f137-731e5500b608@gmail.com>
Date: Tue, 25 Jun 2019 11:39:11 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AD565D7-F99E-4879-BFEF-0E2C7474A09A@gmail.com>
References: <20190621144541.13770-1-skrtbhtngr@gmail.com>
 <a80f7beb-48c1-553a-f137-731e5500b608@gmail.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC 0/1] Add live migration support to the PVRDMA
 device
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
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 25 Jun 2019, at 11:14, Marcel Apfelbaum =
<marcel.apfelbaum@gmail.com> wrote:
>=20
> Hi Sukrit
>=20
> On 6/21/19 5:45 PM, Sukrit Bhatnagar wrote:
>> Hi,
> [...]
>> This RFC is meant to request suggestions on the things which are
>> working and for help on the things which are not.
>>=20
> [...]
>> What is not working:
>>=20
> [...]
>>=20
>> * It seems that vmxnet3 migration itself is not working properly, at =
least
>>   for me. The pvrdma device depends on it, vmxnet3 is function 0 and =
pvrdma
>>   is function 1. This is happening even for a build of unmodified =
code from
>>   the master branch.
>>   After migration, the network connectivity is lost at destination.
>>   Things are fine at the source before migration.
>>   This is the command I am using at src:
>>=20
>>   sudo /home/skrtbhtngr/qemu/build/x86_64-softmmu/qemu-system-x86_64 =
\
>>     -enable-kvm \
>>     -m 2G -smp cpus=3D2 \
>>     -hda /home/skrtbhtngr/fedora.img \
>>     -netdev tap,id=3Dhostnet0 \
>>     -device vmxnet3,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:99:ff:bc=
 \
>>     -monitor telnet:127.0.0.1:4444,server,nowait \
>>     -trace events=3D/home/skrtbhtngr/trace-events \
>>     -vnc 0.0.0.0:0
>>=20
>>   Similar command is used for the dest. Currently, I am trying
>>   same-host migration for testing purpose, without the pvrdma device.
>>   Two tap interfaces, for src and dest were created successfully at
>>   the host. Kernel logs:
>>   ...
>>   br0: port 2(tap0) entered forwarding state
>>   ...
>>   br0: port 3(tap1) entered forwarding state
>>=20
>>   tcpdump at the dest reports only outgoing ARP packets, which ask
>>   for gateway: "ARP, Request who-has _gateway tell guest1".
>>=20
>>   Tried using user (slirp) as the network backend, but no luck.
>>      Also tried git bisect to find the issue using a working commit =
(given
>>   by Marcel), but it turns out that it is very old and I faced build
>>   errors one after another.
>>=20
>>   Please note that e1000 live migration is working fine in the same =
setup.
>>=20
>=20
> I tried to git bisect , but I couldn't find a working version of =
vmxnet supporting live migration ....
> I tried even a commit from December 2014 and it didn't work.
>=20
> What is strange (to me) is that the networking packets can't be sent =
from the guest (after migration)
> even after rebooting the guest.

This makes me think that some network offload configuration wasn=E2=80=99t=
 properly migrated or applied.
What network backend are you using?

Do you see any outgoing packets in the sniffer?

>=20
> Any help or pointer would be greatly appreciated.
> Thanks,
> Marcel
>=20
>=20
> [...]


