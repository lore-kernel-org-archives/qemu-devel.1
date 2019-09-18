Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C353AC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CB320856
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 05:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CB320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iASVN-0002Kq-2s
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 01:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iASTb-0001rw-62
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iASTY-0006Pz-Kd
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iASTW-0006OK-TW
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 01:25:59 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6795F859FF
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 05:25:56 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id 32so1912698wrk.15
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 22:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=vevpk34rXm6JK5vv7gijD1iPBGu2RaEosfU/ZfCaERU=;
 b=H+PBBtOZvPXSAkyNm9qV07NY4SAHZi0rXoWPjpYVb2lP+ruUiZmf+lBYc8WNnH1j/5
 28pjuiQQt3I/09bgUp38LFi84Ld276vLfg8NAlEAeSD40H2/EXoyREJWm5Oeqz5lq/Rc
 P9O5dFzT39bylRuj737/HXUfHVqHeklbPreCjDASwPmk0fAogV/OcQ1ooYZfeV+7s6A/
 fjMAkXwS8/uH4liqQQwh2Sd/kold5SNqCian+hO1X10+WUVBQY4yKQO8Wo4tle63AmwN
 cAqI5f85YlmKAg4Y/ENAdOn+20IB++YBVpzo0LJM3zeO3bQAW2wYQ+USCIy+R8Oj/DaX
 7+rQ==
X-Gm-Message-State: APjAAAUOStTDc57m2z74+gpl1kI45cIRDRzowK4o+Jr4UmKIR891zbij
 0FzbU+ZJ7dFA4GSKbMg5HWgpdWTcmomEb/pU3oKd/qpdva2EPzuqu9BE2K5giWe4eAj4xlLs1QQ
 qNKQnWGtbD2A47lo=
X-Received: by 2002:a5d:6647:: with SMTP id f7mr1445363wrw.170.1568784355175; 
 Tue, 17 Sep 2019 22:25:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwYL85ObLRUr9ngqs86URaXSkVjUzvDoZEQAUpTYL+WvaoBe/J9EwgNupa9A3PZ1EunB+rqfQ==
X-Received: by 2002:a5d:6647:: with SMTP id f7mr1445346wrw.170.1568784354935; 
 Tue, 17 Sep 2019 22:25:54 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id s13sm1052056wmc.28.2019.09.17.22.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 22:25:54 -0700 (PDT)
References: <CAJSP0QVMjw_zm16MRo25Gq0J9w=9vrKDZtaH=WGwjSJiDAVm9Q@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
In-reply-to: <CAJSP0QVMjw_zm16MRo25Gq0J9w=9vrKDZtaH=WGwjSJiDAVm9Q@mail.gmail.com>
Date: Wed, 18 Sep 2019 07:25:46 +0200
Message-ID: <87k1a6yy3p.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Call for volunteers: LWN.net articles about KVM
 Forum talks
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
Cc: libvir-list@redhat.com, kvm <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Stefan Hajnoczi <stefanha@gmail.com> writes:

> Hi,
> LWN.net is a popular open source news site that covers Linux and other
> open source communities (Python, GNOME, Debian, etc).  It has published
> a few KVM articles in the past too.
>
> Let's raise awareness of QEMU, KVM, and libvirt by submitting articles covering
> KVM Forum.
>
> I am looking for ~5 volunteers who are attending KVM Forum to write an article
> about a talk they find interesting.
>
> Please pick a talk you'd like to cover and reply to this email thread.
> I will then send an email to LWN with a heads-up so they can let us know
> if they are interested in publishing a KVM Forum special.  I will not
> ask LWN.net for money.
>
> KVM Forum schedule:
> https://events.linuxfoundation.org/events/kvm-forum-2019/program/schedule/
>
> LWN.net guidelines:
> https://lwn.net/op/AuthorGuide.lwn
> "Our general guideline is for articles to be around 1500 words in
> length, though somewhat longer or shorter can work too. The best
> articles cover a fairly narrow topic completely, without any big
> omissions or any extra padding."
>
> I volunteer to cover Michael Tsirkin's "VirtIO without the Virt -
> Towards Implementations in Hardware" talk.

I volunteer to cover Jun Nakajima's  "Enhancing KVM for Guest Protection
and Security"

Sergio.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2Bv9oACgkQ9GknjS8M
AjXK7hAAnAk5MQVl8C7cK2i3gybVBP2D0o2A6JADUprU37pP+Uuhsy2M5Oh8K/Ra
4wG6GH/cQeQCRNfhMJ8mcAtkm0K7iF3EQrtklLceSBjS8VJLpNPmG52O5xtGJcnt
kioUPLe17zg5axrnAl/AhEtM8KHKYu3IdYSCGNiZbVVo+CfMBJOO/qk3IJOppVQ+
O5R5ukO2htiRsro7m4v+9lva2xp5mou6RAbA2U6QdDfVAFL9IUw24nRQ9Vtj7d5j
jeV/TDuoEzssmLVQ2I6oEybtdbyR9MQqXhi/FXXrrCGBStgfI+MzBBNG2UXco7FG
4eGbhQ6c5I2c63uh2yk8ZyNKy4aIuyUA11vw9ZGFmyOIn3VS9Ru4ZqGiEcnkXsjm
8SfFU+mTv1IQyIY2uWWOr988DdFTObpIs6bSHJFjoTow6+cCtdEiNB6iHQXYUJSE
2IFuOanzD+Yga9L8JEeVfQwgTXK/JUUMA3AEm9BXnw/dackiLz4JaqmnPVRrwnjd
epxjqo+vzzcHUeMwGalgpj3iH0N3QEUmIDAfJl06Is5X5x1/GK0RKfI7jq6/6xYv
J6OdHX97NZiIvqRL43mdDNOpfeyqrjebocoaqXc70qBA/XFDwO1cpcMxUmnxuOG/
Vk/b4kK75ZhBtUa85Pjim5HiR+P1gqzBLdO4DyW/pNW/hAbcKiA=
=lNS2
-----END PGP SIGNATURE-----
--=-=-=--

