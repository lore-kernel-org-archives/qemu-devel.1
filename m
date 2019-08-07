Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A4C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FF521BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="tgXKDZcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FF521BF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLP8-0003Yy-R1
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 08:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49517)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jusual@mail.ru>) id 1hvLOJ-0002Z3-15
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@mail.ru>) id 1hvLOI-0006x1-47
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:50:06 -0400
Received: from smtp17.mail.ru ([94.100.176.154]:45182)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@mail.ru>) id 1hvLOH-0006vf-Gd
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version;
 bh=6h49YPArgWHdzPA4iCBASGOJEyAgWoaMhxj48bqxw3U=; 
 b=tgXKDZcQ5MHeuw/3YP4EGjPSCSlP2anbWCSj3LFD2UCTcgLgSiP8bcawHTA2uFKdWvEeSUZdg2T3QK1u1YkFSmgoYHRIi0YDVj6AwOec/T/Zn+OxLy2Tm2Dfd/Q9TaNzs6IlIBKEKIrxFlSDkfe9yKZet1+ynXx3Tr9VfM33CwY=;
Received: by smtp17.mail.ru with esmtpa (envelope-from <jusual@mail.ru>)
 id 1hvLOE-0005zQ-ST
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 15:50:03 +0300
Received: by mail-lj1-f174.google.com with SMTP id v18so85301048ljh.6
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 05:50:02 -0700 (PDT)
X-Gm-Message-State: APjAAAXAHo6Oes3FlOaQWc2wDEYpYD5kjWJW5kcUVGcBbkpPycADACW3
 +cpT8x5kSOJTAuaMZ4lhNwecjMRMNAk4JiMEtNdM8A==
X-Google-Smtp-Source: APXvYqwXPcCY4iMHDO8w2tTZj0HtOJiZd2yOiVAZ9xhnkX9tXUfcnx4gfczB8WpRLw+fllwL0N5SvMfFObk++wkSe8E=
X-Received: by 2002:a2e:8515:: with SMTP id j21mr4811564lji.233.1565182202252; 
 Wed, 07 Aug 2019 05:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
 <20190801234031.29561-8-mehta.aaru20@gmail.com>
 <CAMDeoFUMSupka-F+TCHSq+1UMd_UbNXFyPwzdC738BSmNWXi2w@mail.gmail.com>
 <CAEg9+6Kwn2Fw8X+v5r9eMTitiG9e4bjdfKwtxX2pu23JQe_5_w@mail.gmail.com>
In-Reply-To: <CAEg9+6Kwn2Fw8X+v5r9eMTitiG9e4bjdfKwtxX2pu23JQe_5_w@mail.gmail.com>
Date: Wed, 7 Aug 2019 14:49:51 +0200
X-Gmail-Original-Message-ID: <CAMDeoFW6PBWhfkdB0=wDmW_oDkgDPcygkKDu44qD=8dWDZwW=g@mail.gmail.com>
Message-ID: <CAMDeoFW6PBWhfkdB0=wDmW_oDkgDPcygkKDu44qD=8dWDZwW=g@mail.gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: smtp17.mail.ru; auth=pass smtp.auth=jusual@mail.ru
 smtp.mailfrom=jusual@mail.ru
X-77F55803: 257C4F86AB09C89C5A78504BD2AC2941988784FC6C4AE31F008FB112C33F354973EEBED7C40B6A1F32A01734863C1AB62F8D63F82F6B3C42
X-7FA49CB5: 0D63561A33F958A5189E88E76BFB900B8AA512D63BEF5CDFDF45F86FF8CC88A88941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224999DB8DEEBFCC4B663AA81AA40904B5D9CF19DD082D7633A093541453170D46FCD81D268191BDAD3D78DA827A17800CE71CA018B0ACC86ABBEC76A7562686271EF5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE73AD7D39B70A38E49EE97C23572E270FB75ECD9A6C639B01B4E70A05D1297E1BBC6867C52282FAC85D9B7C4F32B44FF57DE7CCDD3542A186E00306258E7E6ABB4E4A6367B16DE6309
X-Mailru-Sender: 4C235FE2E5D2D89003AD55F913C7BF9E5F807A11EDBD70F64393E6B40285FA57DE35B75AAAF117FD342D7E53901C55FD6F53C80213D1719C4487B406A59785443329DBF425CF03A167EA787935ED9F1B
X-Mras: OK
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 94.100.176.154
Subject: Re: [Qemu-devel] [PATCH v9 07/17] blockdev: adds bdrv_parse_aio to
 use io_uring
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
From: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Julia Suvorova <jusual@mail.ru>
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 7, 2019 at 2:06 PM Aarushi Mehta <mehta.aaru20@gmail.com> wrote:
>
>
>
> On Wed, 7 Aug, 2019, 17:15 Julia Suvorova, <jusual@mail.ru> wrote:
>>
>> On Fri, Aug 2, 2019 at 1:41 AM Aarushi Mehta <mehta.aaru20@gmail.com> wrote:
>> > +int bdrv_parse_aio(const char *mode, int *flags)
>> > +{
>> > +    if (!strcmp(mode, "threads")) {
>> > +        /* do nothing, default */
>> > +    } else if (!strcmp(mode, "native")) {
>> > +        *flags |= BDRV_O_NATIVE_AIO;
>>
>> This 'if' should be covered with CONFIG_LINUX_AIO.
>
>
> The aio=native definition is shared with Windows hosts' native aio and will break if it was covered.
>
> file-posix handles the case.

Fair enough. Then you can remove all ifdefs for io_uring from
raw_open_common in file-posix.c as this case was already checked here.

Best regards, Julia Suvorova.

>> > +#ifdef CONFIG_LINUX_IO_URING
>> > +    } else if (!strcmp(mode, "io_uring")) {
>> > +        *flags |= BDRV_O_IO_URING;
>> > +#endif
>> > +    } else {
>> > +        return -1;
>> > +    }
>> > +
>> > +    return 0;
>> > +}

