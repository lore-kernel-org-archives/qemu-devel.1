Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1F4C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4981B20770
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7BRYU2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4981B20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGkzc-0005b8-9y
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kGkxs-0004fs-Om
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:27:52 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c]:36597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kGkxn-0006xQ-FQ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:27:52 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id z1so2369123ooj.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 08:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LvQPPPyxhSDdVmsdUdnoGbhJ6/LUlD0/ySFigPsgfww=;
 b=f7BRYU2/l+sCMp/8+ver4kLCj/b2cecA7DXcN3fvOnLmdcbkM3HY7zZwnadsPq6glU
 up+n4ksby2gN/RQCHzVbdx2JAPNYOsMMUmNAj/t5iwFt3TrKy/bXJ9IvK1zHiOhonoyW
 wx+zpeViCtTBt4ncZpE6s54kCysfahfc0ZIZGEgHuKZ5COuwT7k5ligA6NqmUPu4RGYa
 MqRuP776qht/j2S4LVPos1/PaUWMKMFZKcEy2k65UqacHMpnuBvRT6+W39oTx8hyTMDq
 3Mod0hcgJboi6N22xrdqWDh4BZdoJHKmivTR5Ez4llsweV30xSregNX+EStSJcu0xvHi
 vgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LvQPPPyxhSDdVmsdUdnoGbhJ6/LUlD0/ySFigPsgfww=;
 b=QOhCp5cObeeVAXCHgigLw0Qc7AYEJmM5HLl3NOLCv9oLrVvoQ29Xx6sNkZNO/1VMxL
 K+5gk/Fr2fLly+Q3g+AzVO4FfD5gjTYnnVRMD5p+TRjRoAWNRptlgIjUM/8qMRjgbU3H
 agYD+32HxOX6G2xY4DD5VEFRTOKyjiz2qHkM+M/nQxSAp9nobkfMohaNxqyxgrG9qOIA
 FaHmNSA5v2+ATmaVS+NxCBdv1izqMBpRUAu7hYqBxof6CyswV+80QHOBvbrBHLP5GFnf
 IXTk3u3gw+cTWJpfyMnMEp8jW8C9NV1DGnvyN/8biDs6nZ9PeF/azF0lhVLug3D8qBNC
 +f7w==
X-Gm-Message-State: AOAM530QxtPV+2Gs6Hn4vlwUa0EEf/m9+FobgdnftaX5wUGIvSLoQ+My
 6bf5dLVLYHDmMqYGvxtAaqOASvKDUP7ibycmt/Y=
X-Google-Smtp-Source: ABdhPJwtqIEt8BacJbaaZDjj3VslRnDJRykTOSG1qYk22U4qa46JpWP6pgEzyGOHlEHDwhuQS3sOBAWB1ju/NDtKR3w=
X-Received: by 2002:a4a:5a06:: with SMTP id v6mr2020136ooa.22.1599838066279;
 Fri, 11 Sep 2020 08:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
In-Reply-To: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 11 Sep 2020 23:27:10 +0800
Message-ID: <CAKXe6SLEWJZU3a1ut9NL5drzTRX4YhD3waJ4JjyjJf2iWMU1Hw@mail.gmail.com>
Subject: Re: About 'qemu-security' mailing list
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc2c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8811=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:21=E5=86=99=E9=81=93=EF=BC=9A
>
>    Hello all,
>
> Recently while conversing with DanPB this point came up
>
>     -> https://www.qemu.org/contribute/security-process/
>
> * Currently QEMU security team is a handful of individual contacts which
>    restricts community participation in dealing with these issues.
>
> * The Onus also lies with the individuals to inform the community about Q=
EMU
>    security issues, as they come in.
>
>
> Proposal: (to address above limitations)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> * We set up a new 'qemu-security' mailing list.
>
> * QEMU security issues are reported to this new list only.
>
> * Representatives from various communities subscribe to this list. (List =
maybe
>    moderated in the beginning.)
>
> * As QEMU issues come in, participants on the 'qemu-security' list shall
>    discuss and decide about how to triage them further.
>
> Please kindly let us know your views about it. I'd appreciate if you have=
 any
> suggestions/inputs/comments about the same.

Hi Prasad,
Great idea.

Like other project, sometimes they have two mailing lists.
The first is 'security', this list should contains the core developers.
The second is 'predisclosure', the organization can participate this
lists and discuss the disclosure process.

But as for qemu, most of the security issues doesn't need an embargo date.
I think one 'qemu-security' is ok.  I think this mailing lists can
contain the currently individuals and the some qemu developer
and also some organizations who uses qemu.

Thanks,
Li Qiang


>
>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
>
>

