Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BAAC35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9059A218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlOQ5iwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9059A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6OpI-0000g4-P3
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 20:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanrin@gmail.com>) id 1j6G0M-0005lg-I9
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanrin@gmail.com>) id 1j6G0L-0006YK-DJ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 10:50:46 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:38326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanrin@gmail.com>)
 id 1j6G0I-0006Sg-Lp; Mon, 24 Feb 2020 10:50:42 -0500
Received: by mail-il1-x141.google.com with SMTP id f5so8120962ilq.5;
 Mon, 24 Feb 2020 07:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HB4Yaexi3A+0xi/sdNHMhtBo/bWsUVAq4KlU5Wa3waM=;
 b=GlOQ5iwTq1IBI+j8Stfunv3uxUVpVPt24x+grd0VN3QDQsifXKHGha95IfybLueN4x
 vX6SPDEFQNEgEUHy34Z/PY1s+plnfhsdcCX2nuRbsOcrhBg/9DB9aMJf2fXrC4s5txiK
 gmGEXlIaU98HLCr7MvE4kYTr/BLeVPrFtbl9+OwKhfirHLRnnKLkVOMubC+kXQz1n1hL
 JI2kg4k4KAyINzHXpzsc719Pavk0nm+ihgb9HCfGPuGz87XfIaZf91TFoV0HiOB75Qsh
 TJG7jDbfUib7nBxtBY9UxDBNFjeJk43vHg7EQMqmpl1wZSp5Hm9a2/mitpOP+zDUEI4l
 a3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HB4Yaexi3A+0xi/sdNHMhtBo/bWsUVAq4KlU5Wa3waM=;
 b=RzLWMX0VA7b5FsbfyiDvUyr6FukwBQuvOHeKdjhMAoyh5dXhIfI33NszjhcltfOfqW
 5oSi1vsBzwZEYB6qjRyk6DG9ZGxJOOmkm/u8agIRbHPCykcUsumrUAGg/gGiAlB2BCWg
 FCa0Dy6GEK2EV6MylCQkyJx61FwdDsWb95ptYjBgzRFdWz8yP1jaqY3RCmb9glTGrM+s
 Oz9q7AmAnNgDwrf3MPsouGNxyxXdnGyr84T/yCra9uuAFJe/XReDIUtvDOAoIOifO/LE
 lsY5C9AwpVc95Ibba5taBCeJhFFJr81goEryaT9eClsxFc8hP8mkmP6FQDB+fvDnvLWk
 YHBw==
X-Gm-Message-State: APjAAAVT7fU6KOzVTGggR+BaNNAi0aWSLgwpTiPPIZoWQSz4au+zshGx
 yalrT1g3CezMCivr8GNp15tLpgnwtXMCeP8onpw=
X-Google-Smtp-Source: APXvYqw6FYRbOlcD+/Pw0lAw4V9263zL48LWNiTbMiHmOmi4Upefh/s3GBFeMzDZRX7ZU07QbqH1denKuzLNj/Oc35A=
X-Received: by 2002:a92:8311:: with SMTP id f17mr61759571ild.82.1582559441699; 
 Mon, 24 Feb 2020 07:50:41 -0800 (PST)
MIME-Version: 1.0
References: <CAAxjCEzHQz4cG_8m7S6=CwCBoN5daQs+KVyuU5GL5Tq3Bky1NA@mail.gmail.com>
 <CAAxjCEx79Fkjw9tFbSMo+b1LGv2LNivLRXf1GS9JsYnXrNVVkQ@mail.gmail.com>
 <20200224132652.GA7088@linux.fritz.box>
In-Reply-To: <20200224132652.GA7088@linux.fritz.box>
From: Stefan Ring <stefanrin@gmail.com>
Date: Mon, 24 Feb 2020 16:50:30 +0100
Message-ID: <CAAxjCExn4d0vvB8oyG1EPW9LsF4K6VLw+smWp5tsH=Mv2k-ThA@mail.gmail.com>
Subject: Re: Strange data corruption issue with gluster (libgfapi) and ZFS
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
X-Mailman-Approved-At: Mon, 24 Feb 2020 20:12:27 -0500
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
Cc: integration@gluster.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 2:27 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > > There are quite a few machines running on this host, and we have not
> > > experienced other problems so far. So right now, only ZFS is able to
> > > trigger this for some reason. The guest has 8 virtual cores. I also
> > > tried writing directly to the affected device from user space in
> > > patterns mimicking what I see in blktrace, but so far have been unabl=
e
> > > to trigger the same issue that way. Of the many ZFS knobs, I know at
> > > least one that makes a huge difference: When I set
> > > zfs_vdev_async_write_max_active to 1 (as opposed to 2 or 10), the
> > > error count goes through the roof (11.000).
>
> Wait, that does this setting actually do? Does it mean that QEMU should
> never sees more than a single active write request at the same time?
> So if this makes the error a lot more prominent, does this mean that
> async I/O actually makes the problem _less_ likely to occur?
>
> This sounds weird, so probably I'm misunderstanding the setting?

Yes, this is strange, and I will not follow this as I cannot reproduce
it on my home setup. Let=E2=80=99s just hope that it=E2=80=99s some kind of=
 anomaly
that will go away once the real issue has been eliminated ;).

> > I can actually reproduce this on my Fedora 31 home machine with 3 VMs.
>
> This means QEMU 4.1.1, right?

Yes, qemu-system-x86-4.1.1-1.fc31.x86_64.

> > All 3 running CentOS 7.7. Two for glusterd, one for ZFS. Briefly, I
> > also got rid of the 2 glusterd VMs altogether, i.e. running glusterd
> > (the Fedora version) directly on the host, and it would still occur.
> > So my impression is that the server side of GlusterFS does not matter
> > much =E2=80=93 I=E2=80=99ve seen it happen on 4.x, 6.x, 7.2 and 7.3. Al=
so, as it
> > happens in the same way on a Fedora 31 qemu as well as a CentOS 7 one,
> > the qemu version is equally irrelevant.
> >
> > The main conclusion so far is that it has to do with growing the qcow2
> > image. With a fully pre-populated image, I cannot trigger it.
>
> Ok, that's a good data point.
>
> Is the corruption that you're seeing only in the guest data or is qcow2
> metadata also affected (does 'qemu-img check' report errors)?

"No errors were found on the image."

I don=E2=80=99t entirely rule out the possibility of qcow metadata corrupti=
on,
but at least it seems to be very unlikely compared to guest data
corruption.

> > What I plan to do next is look at the block ranges being written in
> > the hope of finding overlaps there.
>
> Either that, or other interesting patterns.
>
> Did you try to remove the guest from the equation? If you say that the
> problem is with multiple parallel requests, maybe 'qemu-img bench' can
> cause the same kind of corruption? (Though if it's only corruption in
> the content rather than qcow2 metadata, it may be hard to detect.
> Giving qemu-io an explicit list of requests could still be an option
> once we have a suspicion what pattern creates the problem.)

Did not know about qemu-img bench, but narrowing it down as much as
possible =E2=80=93 and that entails removing the guest VM =E2=80=93 is my n=
umber one
priority here.

