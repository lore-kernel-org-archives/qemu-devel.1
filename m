Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955FDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA9320738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BY2t8lej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA9320738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgmDO-0004Lr-I5
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jgmCk-0003r0-11
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:30:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1jgmCj-0000d9-0D
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591263027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y3WA2xhNJg5rMIbfY3vG/WjjvXSKMjQM94ig6TTC5rM=;
 b=BY2t8lej7C0R79xsU02y7sVT6Wj7tFeG5kLMYx+VZldqtNuGka6shqAghu3OPLJ4u1g6eR
 Dswl5H11+7WBvvg4zgBv72sJ+JMAVlYV4m1mEZFijzCSEjmmGKeNgwhh93Qm+EWxLwnHOO
 a7X90vFnbuU5v1iY1vdHAFydg/0zUFc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-HKmVKGPiMDSxeUC8FH3hoQ-1; Thu, 04 Jun 2020 05:30:23 -0400
X-MC-Unique: HKmVKGPiMDSxeUC8FH3hoQ-1
Received: by mail-io1-f72.google.com with SMTP id y14so3235933ion.11
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 02:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y3WA2xhNJg5rMIbfY3vG/WjjvXSKMjQM94ig6TTC5rM=;
 b=ORGJvhEBOKu477S4NjknuXwW17n4LdlPenWr+UKrVzZ5mvYxUIqbI0BeRlVRdhc3qp
 p2sCYoksn6zoM6zS0UQmM7BouB7Qvw/4ESF+qowTu/2FoUN3bbfQ5vveqEZ8la3RDU01
 a2x5sTWzIfGIzeV+rxLhmWEWrTqViG5nff9GtoHNo7mFaLZs5VdGWmRNO8ECNilHdc+q
 mqAr0BtiEYWqv/YYztCQiUICkFVakBqbAaGPuEtWpwQm4H+OW0UQW18SpiN+RCxcag5S
 gkk6n996sUWFYS8XUMBeZYpuxYVe4jp3h9sGQKGRef0ue1Q/UlqmOnAbrC59X9AuPT/c
 cPMg==
X-Gm-Message-State: AOAM530kuw7aCMLSvInqU8tLwjHIyKkUmLVe1r3O6mUQ6VD3MSGxZ46Q
 5/HndCCTk1vRmWzOz/EfUwp2YapHye4JZhaW78711uiF3nNhNzyu369MFDXOUVyFux7kYyojE8G
 2vYK6B36UZiCcgLLxV79zz2IgfwtkP2k=
X-Received: by 2002:a92:914d:: with SMTP id t74mr3030646ild.182.1591263022156; 
 Thu, 04 Jun 2020 02:30:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzIfBdmhodeeA0YCQBsXrLbumCDSwup3hPbFanP/FXM/WMHGtl+rAjMkbAWYbhsdM0GZnbzSQ+9rG/liHbYTk=
X-Received: by 2002:a92:914d:: with SMTP id t74mr3030634ild.182.1591263021772; 
 Thu, 04 Jun 2020 02:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0+p2U8uf+Vq_sn=1agSYbZ1iQu_+La8QLCVhMVkK-SKtA@mail.gmail.com>
In-Reply-To: <CAATJJ0+p2U8uf+Vq_sn=1agSYbZ1iQu_+La8QLCVhMVkK-SKtA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 4 Jun 2020 11:30:10 +0200
Message-ID: <CAMxuvaw=EmQXfZCa=V+508d3UycWNNiVizJUt3BjnXgSKfKN5Q@mail.gmail.com>
Subject: Re: qemu-guest agent asserts on shutdown
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mlureau@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:14:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Jun 4, 2020 at 10:54 AM Christian Ehrhardt
<christian.ehrhardt@canonical.com> wrote:
>
> Hi,
> while debugging a report I got in Ubuntu I found that since qemu 4.0 the =
guest agent shutdown feature works (guest is shutting down) but crashes whe=
n doing so each time. This can be a big red herring when debugging other th=
ings as well as people start to get "an application crashed, do you want to=
 report" pop-ups if they have set up automatic crash reports.
>
> If you boot the guest after starting it again and check the guest-agent s=
tatus you will see in journal:
> -- Logs begin at Tue 2020-06-02 07:41:32 UTC, end at Thu 2020-06-04 08:07=
:37 UTC. --
> Jun 02 07:47:58 focal systemd[1]: Started QEMU Guest Agent.
> Jun 02 07:49:03 focal qemu-ga[1984]: info: guest-shutdown called, mode: (=
null)
> Jun 02 07:49:03 focal qemu-ga[1984]: **
> Jun 02 07:49:03 focal qemu-ga[1984]: ERROR:/build/qemu-7aKH5L/qemu-4.2/qg=
a/main.c:532:send_response: assertion failed: (rsp && s->channel)
> Jun 02 07:49:03 focal qemu-ga[1984]: Bail out! ERROR:/build/qemu-7aKH5L/q=
emu-4.2/qga/main.c:532:send_response: assertion failed: (rsp && s->channel)
> Jun 02 07:49:04 focal systemd[1]: Stopping QEMU Guest Agent...
> Jun 02 07:49:04 focal systemd[1]: qemu-guest-agent.service: Succeeded.
> Jun 02 07:49:04 focal systemd[1]: Stopped QEMU Guest Agent.
>
> The actual assert is from "forever" [3] (v0.15) which is the initial addi=
tion of qemu guest agent in 2011. That was later restructured in [1] (v1.1)=
 and [2] (v4.0).
>
> In a check through Ubuntu releases I got
> 1) Host: Q 2.11 L 4.0 (Bionic) - G 2.11 (Bionic)
> 2) Host: Q 4.0 L 5.4 (Eoan) - G 2.11 (Bionic)
> 3) Host: Q 4.2 L 6.0 (Focal) - G 2.11 (Bionic)
> 4) Host: Q 2.11 L 4.0 (Bionic) - G 4.0 (Eoan)
> 5) Host: Q 4.0 L 5.4 (Eoan) - G 4.0 (Eoan)
> 6) Host: Q 4.2 L 6.0 (Focal) - G 4.0 (Eoan)
> 7) Host: Q 2.11 L 4.0 (Bionic) - G 4.2 (Focal)
> 8) Host: Q 4.0 L 5.4 (Eoan) - G 4.2 (Focal)
> 9) Host: Q 4.2 L 6.0 (Focal) - G 4.2 (Focal)
>
> So it seemed to be the qemu-guest-agent portion since >=3D4.0.
> I did a build with [2] reverted and the crash is gone.
>
> I see from the host:
> $ virsh qemu-agent-command focal '{"execute": "guest-shutdown"}'
> "error: Guest agent is not responding: Guest agent disappeared while exec=
uting command"
>
> I'm not sure which part of the communication breaks first, but it could t=
ry to send on a dying connection, the old code had:
>
> rsp =3D qmp_dispatch(&ga_commands, QOBJECT(req), false);
>     if (rsp) {
>         ret =3D send_response(s, rsp)
>
> While the new code is like:
>
>     rsp =3D qmp_dispatch(&ga_commands, obj, false);
> end:
>      ret =3D send_response(s, rsp);
>
> Maybe it runs send_response despite qmp_dispatch failing now?
>
> I didn't stare at it long enough to have a solution yet, but wanted to ma=
ke the maintainer of qga and the Author aware.
>

My bad, "guest-shutdown" is a QCO_NO_SUCCESS_RESP command, and in this
case qmp_dispatch() returns NULL. I'll send a patch.

thanks


> [1]: https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D125b310e1d62
> [2]: https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D781f2b3d1e5e
> [3]: https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D48ff7a625b36
>
> --
> Christian Ehrhardt
> Staff Engineer, Ubuntu Server
> Canonical Ltd


