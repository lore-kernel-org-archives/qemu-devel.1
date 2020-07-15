Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C27C433F2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433AE2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 16:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQOagnfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433AE2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvkXL-0002NY-Dz
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 12:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvkWd-0001kO-Sn
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 12:44:55 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvkWb-0006xb-Vx
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 12:44:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id z2so3451961wrp.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=scY49mbUNKHZrdbIfXTfGUb/BOXGOeiwdsMsfe7K8d0=;
 b=aQOagnfzn71psy5waK0/DWZOqsCBjOWbQuoEkV7AeBmaMomR6qyvxhHNDeyBUACad8
 tqygAJN5Qtl8z9xToOvRD7cL91pYyKJuXpdb270/TQ0Ycy0ifbnFk5+aYoJV74o7gUac
 RtWEuncBdvm+saUi4dQWlIGVeWLK4mSYZmnZ7VMooOuEOpbkvBXJ2OnYsFo4oM9wWK/d
 1HcLC+C4xbGcsqizCj5RbXY8IPJm8g4FS+mo5Hk9OTgWar4akTGyVGXBTdyjn7/XmWbY
 c+9qRMoCO4tFBdmxVAhD7/E1nBLTH/JEw7+8TllH1cHUia71PHpz46Zo+djuMP1SF5Y0
 J/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=scY49mbUNKHZrdbIfXTfGUb/BOXGOeiwdsMsfe7K8d0=;
 b=E20lsJBvW47yOYwYjNaEw5fFGg5aVLPXvTvpYl6/txslZSb2Wynbim9raRz41T4/2t
 iCQlCTEy05VBtJO4GBv6GctGVZyHcUOQOH/vW1r4AHooCwq0KtdXH8740zMK8ZOzxbCf
 Dl6kDIw2V+MJbLZOqzEkgwpGdX44us6A4+9aEUVX7v1YxZ5dQuGyIHo/sjQi+ny3GMtN
 GBrKB1C5sgx43zVfgT07EkrdqNrtub/KX5WdlqUEzDqJWNk3l4jEx5RGCv/zuN0y/7Qh
 YY805BuLn07DDSqituSSpoUjBpxHaFlEZ9CDrfl7DmabkwbkVBoAkhZRnSOrgifGjXlg
 WIsA==
X-Gm-Message-State: AOAM5319bsCsVhg+vIIn6Snd7kD5B+aiZBRp1Ghg77h4fBpn4iNXrZI3
 2GSvbZ/4e+F7POvWPy/g50wwaw==
X-Google-Smtp-Source: ABdhPJxqCJAxO1Z/aM4Dkpxpe268YRDuzB0oQUo2Ktlydz81nlJFEhIipTm9uoq3YPYJU6WlyBbHNg==
X-Received: by 2002:adf:f889:: with SMTP id u9mr259344wrp.149.1594831491338;
 Wed, 15 Jul 2020 09:44:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m4sm3991733wmi.48.2020.07.15.09.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 09:44:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0BBF61FF7E;
 Wed, 15 Jul 2020 17:44:49 +0100 (BST)
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
 <20200715112342.GD18817@stefanha-x1.localdomain>
 <deb5788e-c828-6996-025d-333cf2bca7ab@siemens.com>
 <20200715153855.GA47883@stefanha-x1.localdomain>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Inter-VM device emulation (call on Mon 20th July 2020)
In-reply-to: <20200715153855.GA47883@stefanha-x1.localdomain>
Date: Wed, 15 Jul 2020 17:44:49 +0100
Message-ID: <87y2nkwwvy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "John G. Johnson" <john.g.johnson@oracle.com>,
 Andra-Irina Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Alexander Graf <graf@amazon.com>, Thanos Makatos <thanos.makatos@nutanix.com>,
 Nikos Dragazis <ndragazis@arrikto.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Wed, Jul 15, 2020 at 01:28:07PM +0200, Jan Kiszka wrote:
>> On 15.07.20 13:23, Stefan Hajnoczi wrote:
>> > Let's have a call to figure out:
>> >=20
>> > 1. What is unique about these approaches and how do they overlap?
>> > 2. Can we focus development and code review efforts to get something
>> >    merged sooner?
>> >=20
>> > Jan and Nikos: do you have time to join on Monday, 20th of July at 15:=
00
>> > UTC?
>> > https://www.timeanddate.com/worldclock/fixedtime.html?iso=3D20200720T1=
500
>> >=20
>>=20
>> Not at that slot, but one hour earlier or later would work for me (so fa=
r).
>
> Nikos: Please let us know which of Jan's timeslots works best for you.

I'm in - the earlier slot would be preferential for me to avoid clashing wi=
th
family time.

--=20
Alex Benn=C3=A9e

