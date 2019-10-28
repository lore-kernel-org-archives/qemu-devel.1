Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A27BCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 19:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2F620873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 19:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD4Fy6XS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2F620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPAq7-0001nR-P1
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 15:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1iP9vG-0000Cs-4b
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1iP9vE-0006RJ-OT
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:39:21 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:33607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1iP9vE-0006Q5-HT; Mon, 28 Oct 2019 14:39:20 -0400
Received: by mail-qt1-x841.google.com with SMTP id y39so10717596qty.0;
 Mon, 28 Oct 2019 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2hmznyP4ZTFQYt5FY266nVXWD/zh57MpnSzDaNjhhgI=;
 b=aD4Fy6XSaoNV4t6Jewmceuo4gDhsfye4Fx0/F/r+0K3hSZApF2OOckgZ/t9CWl99I4
 0dYbVlYTU8tY/Rh4uYaZSJJ2ydmgnngFGfMMobRxzf/z9UJmSNcgpiWJkLmmU+l1wjZH
 si7UplMflcB+EPG/qJ5RT4yiQLe9cYd6i86411ieBYGHGDPbtMPzOYC53SguatBrdcLm
 Lry5E3UyOQL55uQBMZcpcmuZJAxex0NaG86l3nRyVmINcuwp4QBb1n+vpCQ23KhtL1sr
 b7yz+5pNfu9TiSjbIknMhB/EB+LseYhPWpzTZ3Ne21mcd3mjAYYy6rcNxBDokKnd6QbS
 Qcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2hmznyP4ZTFQYt5FY266nVXWD/zh57MpnSzDaNjhhgI=;
 b=bt4bFBeKziuHz3DebSBPpIl/g1emuDEsVedu9dFl/h8zX5698GkDhp68V4EUwdc4aK
 aLKIdiUdDtfI3kUjkFkvDS6c0NWak1NuzniRmCZLNjykBnKJXzeAGICljkn5SXCMTgR7
 ZtBJMPOIVMTrEPBNlNQa5AkBEDKHMyShhtErLpbZvNKl5QEliG6lJtx74O6tsAqgPqgj
 yzSHJjsHXOJE2mCVJQ+oX5BDczUxPzm7cKenr1M83hwCxp+JcM5RiaYaptFQ1lTS7dyo
 xWqDOng+91w/T3BM/PQbZgw6gcAksVlXK/19q9TqW1jYlAd43VEu1IENiPbJpTIuP/HS
 MSiw==
X-Gm-Message-State: APjAAAVfrgQXUL6WfKqqsJNFdnEmc3/nds4yyMIZU95K0xM5Pl31TvI7
 VeazkkLiIZlVEpExLM7xcA==
X-Google-Smtp-Source: APXvYqy0jckl6DkH8EwpcwLR4T5NYocU+GIJCDMmkGjVAJHzUEEGkrIYZ4EuqqSTPmJNlJX3uF5n+Q==
X-Received: by 2002:aed:24af:: with SMTP id t44mr18314531qtc.57.1572287957239; 
 Mon, 28 Oct 2019 11:39:17 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id s21sm8376130qtc.12.2019.10.28.11.39.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Oct 2019 11:39:16 -0700 (PDT)
Date: Mon, 28 Oct 2019 14:39:11 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v1 0/5] target/arm/kvm: Provide an option to adjust
 virtual time
Message-ID: <20191028183908.7ss3o4guvfff6lxv@gabell>
References: <20191016143410.5023-1-drjones@redhat.com>
 <20191017211758.ownflk2c7mzv3poh@gabell>
 <20191018120252.sdpi4t7jlectnspu@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018120252.sdpi4t7jlectnspu@kamzik.brq.redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 02:02:52PM +0200, Andrew Jones wrote:
> On Thu, Oct 17, 2019 at 05:17:59PM -0400, Masayoshi Mizuma wrote:
> > Hi Drew,
> > 
> > Thank you for posting the patches, they seems to work well
> > because the softlockup is gone and the timestamp jump of
> > dmesg and ftrace record also disappeared after the guest
> > is virsh resume'ed.
> > 
> > Let me add comments.
> > I think the kvm-adjvtime behavior should be the default.
> > How about introducing 'kvm-noadjvtime' parameter instead?
> > kvm-noadjvtime is to provide the old behavior.
> > 
> > That is because the time jump occurs timeout for timers even though
> > the timer doesn't reach the timeout in the guest time.
> > 
> > For example, below flow shows that user and/or kernel sets timer A
> > for +10 sec and B for +20 sec in Guest, then Guest is suspended and
> > it passes 60 sec, then Guest is resumed. Timer A and B go off because
> > the Guest timestamp (TS) is jumped to 63. That is unexpected timer
> > behavior for Guest.
> > 
> >  Host TS(sec) Guest TS(sec) Event
> >  ============ ============= =============================
> >  00           00            Guest: Set timer A for +10 sec
> >  01           01            Guest: Set timer B for +20 sec
> >  03           03            Host: virsh suspend Guest
> >  63           63            Host: virsh resume Guest
> >                             Guest: Timer A and B go off
> > 
> > I believe kvm-adjvtime behavior is as following. So Time A
> > and B go off as expected time. So, kvm-adjvtime behavior should
> > be the default.
> > 
> >  Host TS(sec) Guest TS(sec) Event
> >  ============ ============= =============================
> >  00           00            Guest: Set timer A for +10 sec
> >  01           01            Guest: Set timer B for +20 sec
> >  03           03            Host: virsh suspend guest
> >  63           03            Host: virsh resume guest
> >  70           10            Guest: Timer A goes off
> >  81           21            Guest: Timer B goes off
> > 
> 
> Thanks for the testing Masa. Your timer test is another good example of
> what can happen when a guest is paused. I'm sure there are many other ways
> a pause could be problematic as well, especially if the guest has devices
> passed through to it that it's actively using. I also don't expect
> kvm-adjvtime to solve all those problems (like, for example, potential
> problems with passthrough devices, networks, etc.)  This means that guest
> pausing should only be done by host admins that are intimately familiar
> with the guest OS, workload, and network connections. They should be sure
> that it can tolerate and recover from the pauses. Since the admins need to
> make the decision to pause at all, then I think it's fair for them to also
> decide if they want to try and mitigate some of the issues with
> kvm-adjvtime, i.e. require them to enable it, rather than have it on by
> default. 

make sense to me, thanks.

>          Also, if we choose to enable it by default, then we'll need to
> deal with the compatibility issues that come with changing a behavior.
> That's not impossible, as this feature could be disabled for older
> machine types, but it's messy.

I agree with you, we shouldn't add such messy codes to resolve
the compatibility issues...

> 
> All that said, I won't argue too hard against kvm-adjvtime being on by
> default, but let's see if others like Peter or Marc want to chime in on
> it too.

Yeah, I look forward to their comments.

Thanks,
Masa

