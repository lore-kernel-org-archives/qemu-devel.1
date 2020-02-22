Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560B9C35641
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 00:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF0220675
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 00:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZzGm/11"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF0220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5IWb-0003yt-9u
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 19:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pfeiner@google.com>) id 1j5IW4-0003Xp-HP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 19:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pfeiner@google.com>) id 1j5IW3-0005Gg-G5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 19:19:32 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31]:46003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pfeiner@google.com>) id 1j5IW3-0005GW-AH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 19:19:31 -0500
Received: by mail-vk1-xa31.google.com with SMTP id g7so1067175vkl.12
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 16:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UsBd3ytqG92zDdNjImppskwLTVCcbm12JxL9OGg8W8I=;
 b=QZzGm/11YvvaGeBVzyZmbqy0V7J/e5boHE1YJMQbye/Cbc7hOOS9L7EDK8rTb3O7Re
 BNZL2L7F9T+xiY8aNHrw3+VuCTq15BhpWvFwHGsbxckNTkOg6wlYy4rnC4CukC9t1Xtg
 g2JTp8Eu+Q5Nh/lJhJiHsBUM5LOpg4psg0mW7fRUI0VrW32met8lsb8/ElHaBF43nHpf
 4ope4iraxD67EIFDR+FE7Iib0dW46X+9tKdGcWjax22XdUTF3XyboEVu1s2cw4SN+elD
 tGcmW5MdL5hgsCCNq8ZhCljwCHsxwOdboigGXrFyR4FT/MnuH9Ke9uLTNGhY5NRId49l
 ymag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UsBd3ytqG92zDdNjImppskwLTVCcbm12JxL9OGg8W8I=;
 b=aLQloeSH1sSzJiQt73hCqpX7frDOTINhaE3RGGBLFa8J2wFnbfJRiuSkzEs1osByUE
 BCTfSgX3hoVwH8ipBPqA1amCxBGEcuw++cpRO73c0adfPBjw1jegYaG5wqRH6WSIyGSQ
 S8urnugAjong0n8LyI7VLcqDYyOkedAXAq8vrv56DnW6oSCktUrnjDQRBalXSxElZ8Nh
 hPWJ94wsN0x28fQp2OcSxJDYjh7vp5iDbTRUlnvkdhIY2+ljB9LU/0qcYxvo91Mpifgz
 wZcEYD83rZxQ2mU+GTTre91D/ecxSRRPsMa4arYMFhuxvan3jLRmgzqbrfoC91BepyXF
 3WhA==
X-Gm-Message-State: APjAAAUx2egLHaXLHkj9a+XXHef07Q5UPK9ElIXy+GZ3szDvY5mxMwh1
 L+xXxb5+fj1rbHWceP6vek+8KvVkHpKD37R2MK9Fow==
X-Google-Smtp-Source: APXvYqzlFUI7WlYELa0+SnZAhwG2Z/Xy5yDyHWgfFfREsId3qG8Ifl9kV4pZ81zRy29SRjyYbgs/DbW2AWnJ4Ff+WGw=
X-Received: by 2002:a1f:bf86:: with SMTP id p128mr19261971vkf.3.1582330769692; 
 Fri, 21 Feb 2020 16:19:29 -0800 (PST)
MIME-Version: 1.0
References: <B2D15215269B544CADD246097EACE7474BAF9AB6@DGGEMM528-MBX.china.huawei.com>
 <20200218174311.GE1408806@xz-x1>
 <B2D15215269B544CADD246097EACE7474BAFF835@DGGEMM528-MBX.china.huawei.com>
 <20200219171919.GA34517@xz-x1>
 <B2D15215269B544CADD246097EACE7474BB03772@DGGEMM528-MBX.china.huawei.com>
 <CANgfPd-P_=GqcMiwLSSkUhZDt42aMLUsCJt+CPdUN5yR3RLHmQ@mail.gmail.com>
 <cd4626a1-44b5-1a62-cf4b-716950a6db1b@google.com>
In-Reply-To: <cd4626a1-44b5-1a62-cf4b-716950a6db1b@google.com>
From: Peter Feiner <pfeiner@google.com>
Date: Fri, 21 Feb 2020 16:19:18 -0800
Message-ID: <CAM3pwhGF3ABoew5UOd9xUxtm14VN_o0gr+D=KfR3ZEQjmKgUdQ@mail.gmail.com>
Subject: Re: RFC: Split EPT huge pages in advance of dirty logging
To: Junaid Shahid <junaids@google.com>
Cc: Ben Gardon <bgardon@google.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>,
 Peter Xu <peterx@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>, 
 "Liujinsong (Paul)" <liu.jinsong@huawei.com>,
 "linfeng (M)" <linfeng23@huawei.com>, 
 "wangxin (U)" <wangxinxin.wang@huawei.com>,
 "Huangweidong (C)" <weidong.huang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a31
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

On Fri, Feb 21, 2020 at 2:08 PM Junaid Shahid <junaids@google.com> wrote:
>
> On 2/20/20 9:34 AM, Ben Gardon wrote:
> >
> > FWIW, we currently do this eager splitting at Google for live
> > migration. When the log-dirty-memory flag is set on a memslot we
> > eagerly split all pages in the slot down to 4k granularity.
> > As Jay said, this does not cause crippling lock contention because the
> > vCPU page faults generated by write protection / splitting can be
> > resolved in the fast page fault path without acquiring the MMU lock.
> > I believe +Junaid Shahid tried to upstream this approach at some point
> > in the past, but the patch set didn't make it in. (This was before my
> > time, so I'm hoping he has a link.)
> > I haven't done the analysis to know if eager splitting is more or less
> > efficient with parallel slow-path page faults, but it's definitely
> > faster under the MMU lock.
> >
>
> I am not sure if we ever posted those patches upstream. Peter Feiner woul=
d know for sure. One notable difference in what we do compared to the appro=
ach outlined by Jay is that we don't rely on tdp_page_fault() to do the spl=
itting. So we don't have to create a dummy VCPU and the specialized split f=
unction is also much faster.

We've been carrying these patches since 2015. I've never posted them.
Getting them in shape for upstream consumption will take some work. I
can look into this next week.

Peter

