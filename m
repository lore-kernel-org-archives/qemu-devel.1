Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6BEC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A645D214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6sy819B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A645D214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfifl-0000Fy-Uz
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37147)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1hfieD-0007Ga-OK
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1hfieC-0008Bi-29
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:25:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34690)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1hfie8-00085Q-Kc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:25:54 -0400
Received: by mail-wr1-x443.google.com with SMTP id k11so17253906wrl.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=x4NsOqcfCZxBAUoRul5qsRmFfLKZ15qKXHULqbNkFQE=;
 b=W6sy819BE6TTjHqeCEL912xE+lTQEWLsuozS+YB3P9bGMdwFIRBnwr9xVFNe8zCCYg
 /fTEgHIC+E33HzVASU2minkp6ifpEIIPLSvctMxE5leP1J/SvkR1/CIaSJwVcJt5nHWy
 pFbFUMPPHNBzLLq6P/sdgIJPTLE8hbcdqAxaui46qqSsQoDfnbimL6sDyfAa22ZY0oQV
 OQilWKrpm/wQROQjR7UfcgxhHGz5x0EDrNI5kHX1v10YF7G2tHRuCtNdjaGH3KFxj9Fc
 uf8jFwwBrBL1tLihwzPul34YPFuAsmSVXiUf/IC6taAud48px/xbmELl9Y96mJgeelmk
 1Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=x4NsOqcfCZxBAUoRul5qsRmFfLKZ15qKXHULqbNkFQE=;
 b=VUWbSvxyQ7PVjL0aOZb9vjPOtAENiLvqqrVBQSHz02yWeetZ/09AEG2MF4rg7b/Iwe
 t46pKQ7vL+0KptATygxyn23KErzAIsN+XK/jNr43tzrlYpxoubI5FlX2rmhF/JUADh0v
 DqBlJ4LFiOagifh8T3olvBXctbMGcrUnYm+VW7d3RTvs1Y5PVlPdimYsshxr/nlpOHxk
 kBM35tUgm8J7l8cdPsqsCfRvQ+GT06lzE4nBjg3WwAmhhpRkH3F+GPjZxFsIIlLkjRNR
 6vQpLvsENqAmRgXb7ofkRDqBg3J34eHsVBMtgGwxDjEd3HCG5mbbrkEr2JYoDyBFcKFx
 BDUA==
X-Gm-Message-State: APjAAAXABqdXhw7vm15Phc9fJd+oQkrKdGn112RHFzix+asYwXg2nXcv
 k+TotpRwDz3dmuvWF6vtDFc=
X-Google-Smtp-Source: APXvYqwLP7xSF9L3jais2r0FSVLJtYJvL6dN9qCT/l2cwzZBU24MIBDMqFNKoWk+lvc9/Smw7z7BEg==
X-Received: by 2002:a05:6000:9:: with SMTP id
 h9mr49494119wrx.212.1561458347484; 
 Tue, 25 Jun 2019 03:25:47 -0700 (PDT)
Received: from [10.0.1.34] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id q12sm14950434wrp.50.2019.06.25.03.25.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 03:25:46 -0700 (PDT)
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Message-Id: <0AEAB72A-6168-434C-B19A-F4F05B41108D@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Date: Tue, 25 Jun 2019 13:25:44 +0300
In-Reply-To: <91874483-215c-1ccc-6f33-5ceeb8f6ec47@gmail.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20190621144541.13770-1-skrtbhtngr@gmail.com>
 <a80f7beb-48c1-553a-f137-731e5500b608@gmail.com>
 <1AD565D7-F99E-4879-BFEF-0E2C7474A09A@gmail.com>
 <91874483-215c-1ccc-6f33-5ceeb8f6ec47@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 25 Jun 2019, at 11:49, Marcel Apfelbaum =
<marcel.apfelbaum@gmail.com> wrote:
>=20
> Hi Dmitry,
>=20
> On 6/25/19 11:39 AM, Dmitry Fleytman wrote:
>>=20
>>> On 25 Jun 2019, at 11:14, Marcel Apfelbaum =
<marcel.apfelbaum@gmail.com> wrote:
>>>=20
>>> Hi Sukrit
>>>=20
>>> On 6/21/19 5:45 PM, Sukrit Bhatnagar wrote:
>>>> Hi,
>>> [...]
>>>> This RFC is meant to request suggestions on the things which are
>>>> working and for help on the things which are not.
>>>>=20
>>> [...]
>>>> What is not working:
>>>>=20
>>> [...]
>>>> * It seems that vmxnet3 migration itself is not working properly, =
at least
>>>>   for me. The pvrdma device depends on it, vmxnet3 is function 0 =
and pvrdma
>>>>   is function 1. This is happening even for a build of unmodified =
code from
>>>>   the master branch.
>>>>   After migration, the network connectivity is lost at destination.
>>>>   Things are fine at the source before migration.
>>>>   This is the command I am using at src:
>>>>=20
>>>>   sudo =
/home/skrtbhtngr/qemu/build/x86_64-softmmu/qemu-system-x86_64 \
>>>>     -enable-kvm \
>>>>     -m 2G -smp cpus=3D2 \
>>>>     -hda /home/skrtbhtngr/fedora.img \
>>>>     -netdev tap,id=3Dhostnet0 \
>>>>     -device vmxnet3,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:99:ff:=
bc \
>>>>     -monitor telnet:127.0.0.1:4444,server,nowait \
>>>>     -trace events=3D/home/skrtbhtngr/trace-events \
>>>>     -vnc 0.0.0.0:0
>>>>=20
>>>>   Similar command is used for the dest. Currently, I am trying
>>>>   same-host migration for testing purpose, without the pvrdma =
device.
>>>>   Two tap interfaces, for src and dest were created successfully at
>>>>   the host. Kernel logs:
>>>>   ...
>>>>   br0: port 2(tap0) entered forwarding state
>>>>   ...
>>>>   br0: port 3(tap1) entered forwarding state
>>>>=20
>>>>   tcpdump at the dest reports only outgoing ARP packets, which ask
>>>>   for gateway: "ARP, Request who-has _gateway tell guest1".
>>>>=20
>>>>   Tried using user (slirp) as the network backend, but no luck.
>>>>      Also tried git bisect to find the issue using a working commit =
(given
>>>>   by Marcel), but it turns out that it is very old and I faced =
build
>>>>   errors one after another.
>>>>=20
>>>>   Please note that e1000 live migration is working fine in the same =
setup.
>>>>=20
>>> I tried to git bisect , but I couldn't find a working version of =
vmxnet supporting live migration ....
>>> I tried even a commit from December 2014 and it didn't work.
>>>=20
>>> What is strange (to me) is that the networking packets can't be sent =
from the guest (after migration)
>>> even after rebooting the guest.
>> This makes me think that some network offload configuration wasn=E2=80=99=
t properly migrated or applied.
>> What network backend are you using?
>=20
> Suktrit tried with tap device, I tried with slirp.
> If you can point me to the property that disables all the offloads it =
will really help.
>=20
>> Do you see any outgoing packets in the sniffer?
>=20
> I didn't use the sniffer, I checked dmesg in guest, there was a line =
complaining that it can't send packets.

I see. If it cannot send packet on the guest side, then it=E2=80=99s not =
an offload.
A snippet from dmesg will be helpful indeed.

>=20
> Thanks,
> Marcel
>=20
>>> Any help or pointer would be greatly appreciated.
>>> Thanks,
>>> Marcel
>>>=20
>>>=20
>>> [...]

