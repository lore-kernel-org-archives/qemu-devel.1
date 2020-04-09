Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6284BC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 03:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 213C720757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 03:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD2adWWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 213C720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMNz3-0001fH-B6
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 23:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jMNyO-00019Y-83
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 23:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jMNyM-0001AI-UQ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 23:35:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jMNyM-00019p-LT
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 23:35:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id d202so2615873wmd.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 20:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=w8KCpjZCG8xfuGdDTFu0huL9KfB9sfX0Tqe0uiM/vlM=;
 b=UD2adWWcNFcuniU0Vs1ITgDLiYgD8812dQFojNq457zD4q08LjoX0buVed2UKf0H9g
 kTTuubFyOpFvppLEbMbaUtlohdR7W7eOCQWhKjivRVOQwzIAXJg64gTOz3d2YxNYtTVA
 ds848jSds+2D65sW2TlnIgC5I+zpe15ZiiS5PI4iF7PdTrE7KUxKGU9ZcMYPaAxDIoNX
 IEpatplsifUFsM5eU5sM1be79biPNVPtxIYZ6Khnt/Kd59A9S61rpIktGTMmSolBL/X/
 pSTn9JpivJGm1ysCEiYfUIQsSgNJgI3EpzQntGRhgUQMsNpfqfmEk6WLb+ZsbkKWWIl/
 3rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w8KCpjZCG8xfuGdDTFu0huL9KfB9sfX0Tqe0uiM/vlM=;
 b=ot2DQKrbhXZ9Kyq4m5h1o76YX17S9k1h0Yt2UqMU4iAnE7R3kQ7B7S4j1iFBHVQO1A
 Qa5TPl8G0Z/ugXvANRsBgsymy68GA3vK53TbWoJaCGCzLQKvrloD0azX7yv8c1UbmlcR
 bcgppNPV/QHoDPpa+wFY4Cg1NqSNsyb+1+ORo+xlytaJrOA80QmJ/X88dU9vqFqmYlM8
 0GOUWse8GkYdqtLr4HcIzdYQdeCSUMWTh0mcVlM6ac28ahtztWpt65Yr8c29OPlX2+wF
 FlFxQ/Bi2ql7sBshxqPQh8LHK+e+dML0rWjoyPcLuYEDT1HbkpS0P0YQ7DWpqlAInJUl
 yVUA==
X-Gm-Message-State: AGi0PuZtH2nkgBXsnTv1du1g4S6NAD4I1+kR0i+1GHzM5f862+6oTNbR
 LasLxscoU2f6zIWWeuaw3Qg=
X-Google-Smtp-Source: APiQypLnHt2u83oK72P8YvVW4/RisVeMwrdpqSnMOYZPxr+Ne+H1rbuvY4EBolWy875pdFgcb8BWkw==
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr7777913wml.138.1586403321256; 
 Wed, 08 Apr 2020 20:35:21 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-155-55.inter.net.il. [84.229.155.55])
 by smtp.gmail.com with ESMTPSA id h81sm2104943wme.42.2020.04.08.20.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 20:35:20 -0700 (PDT)
Date: Thu, 9 Apr 2020 06:35:18 +0300
From: Jon Doron <arilou@gmail.com>
To: Roman Kagan <rvkagan@yandex-team.ru>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 QEMU <qemu-devel@nongnu.org>,
 Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200409033518.GC7606@jondnuc>
References: <CAP7QCog_EmLJ=O8Xi9Tc4Jst1=z62DXim9ScCyoPv7WugrSyOw@mail.gmail.com>
 <CAP7QCogMdUis-=KsC--0ar2Zt2Vwcpn4HS+qCxPn5khtDTu+mA@mail.gmail.com>
 <9b9c42d3-af9e-25e9-210e-c58ee5975941@maciej.szmigiero.name>
 <472544e7-498a-4e28-06e9-83c102d6436b@maciej.szmigiero.name>
 <20200406073246.GA7707@rvkaganb>
 <CAP7QCojPsOYjw94k3rkH0A3rLFADLeVhgy502N=8X5wrUnoC6Q@mail.gmail.com>
 <20200407185608.GA178651@rvkaganb>
 <8c278ea8-81c5-7458-8979-c319470440d7@maciej.szmigiero.name>
 <20200408041639.GA7606@jondnuc> <20200408204742.GA709224@rvkaganb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200408204742.GA709224@rvkaganb>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

On 08/04/2020, Roman Kagan wrote:
>On Wed, Apr 08, 2020 at 07:16:39AM +0300, Jon Doron wrote:
>> On 07/04/2020, Maciej S. Szmigiero wrote:
>> > On 07.04.2020 20:56, Roman Kagan wrote:
>> > > On Mon, Apr 06, 2020 at 11:20:39AM +0300, Jon Doron wrote:
>> > > > Well I want it to be merged in :-)
>> > >
>> > > Hmm I'm curious why, it has little to offer over virtio.
>> > >
>> > > Anyway the series you've posted seems to be based on a fairly old
>> > > version.
>> > >
>> > > The one in openvz repo is more recent.  It's still in need for
>> > > improvement, too, but should be testable at least.
>>
>> Well I have implemented the hyperv synthetic kernel debugger interface, but
>> on Windows 10 it requires to have a working VMBus (it's not really using it,
>> but without a function vmbus that will answer to the initiate contact then
>> the kdnet will simply be stuck in a loop.
>
>I see, thanks, I've never heard of this before.
>
>> With the synthetic kernel debugger interface you can debug older OS (Win7 up
>> to latest Win10). The benefit is that its much faster than all other
>> interfaces.
>
>I guess you compare it to debugging via serial port.  I wonder where the
>difference comes from?  I thought the transport didn't require any
>significant throughput, and latency-wise the (emulated) serial port was
>just as good as any other.  Am I missing something?
>
>Thanks,
>Roman.
>

Well kdcom is sending out UART through the virtual serial port, this
results in very slow speeds (try it out if you get a chance), because
of that most Windows kernel developers use  VMWare with a combination
of a tool called VirtualKD which implements it's own debug transport on
the Windows part and patches the hypervisor (aka VMWare) to get the 
VMExits.
This way it can transfer more and bigger blocks faster, to the debugger.

With the synthetic debugger interface in-place (which you can use since 
Windows 7) all these tricks are not really required, you just need to 
implement it :P .

Thanks,
-- Jon.

>> In addition to that Michael Kelley from Microsoft has informed us that
>> Microsoft might be dropped the synthetic kernel debugger interface sometime
>> in the future, and it seems like the new mode is simply to use hvnet device
>> for the communication (which is again much faster).
>>
>> Cheers,
>> -- Jon.
>> >
>> > Isn't the one at
>> > https://src.openvz.org/projects/UP/repos/qemu/commits?until=refs%2Fheads%2Fvmbus
>> > the latest one?
>> >
>> > It seems to be last changed in October 2019 - is there a
>> > later one?
>> >
>> > > Thanks,
>> > > Roman.
>> >
>> > Thanks,
>> > Maciej

