Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE99C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 00:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC38F206C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 00:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="YOI4Ozb+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC38F206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sfconservancy.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIiFV-0002D5-Mf
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 20:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bkuhn@sfconservancy.org>)
 id 1kIiE3-0001Gn-Sy
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 20:56:39 -0400
Received: from pine.sfconservancy.org
 ([2001:4801:7822:103:be76:4eff:fe10:7c55]:47802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bkuhn@sfconservancy.org>)
 id 1kIiDt-0007xu-0L
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 20:56:38 -0400
Received: from localhost (unknown [216.161.86.19])
 (Authenticated sender: bkuhn)
 by pine.sfconservancy.org (Postfix) with ESMTPSA id 3FE47E833;
 Thu, 17 Sep 2020 00:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
 s=pine; t=1600304186;
 bh=FqiHtaCeMiUCXARQ/S2ALeC80mn1verlRPHJodx0xFY=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=YOI4Ozb+aP1hiX1l9gtBjBaYqjoM8fPDcvI8Oudec7OfqoWzGktNlm/U0Ryci0DcK
 +kO+nrtNb1t8PsjodICppBpH00hYtpFlEjPS4ppDalHgs1QJ3WfBbwEvk4Ffj/tN3c
 t78vFfRPJAMR4dX+O7ghU4msXQkuzRKGnO98oQdLAPjEykDruRtb3dVU5Bk4bjRnoi
 gVvrHtWV6K/YXOgbo3kUFj0guROMrm9XG3AIFkjYUbQmvcQQhsh4QHgFxp8AODKOLe
 5utObTfkGBZ+2SJKnI0t4EtvmBQiHpD1OCCUqUHPjjg2eETLS+vrF9UYgqbrBLqc0s
 HeRefbcNpXenA==
From: "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To: "qemu\@sfconservancy.org" <qemu@sfconservancy.org>
Subject: Re: Should we apply for GitLab's open source program?
Organization: Software Freedom Conservancy
References: <878sdp4ks9.fsf@linaro.org>
 <20200908141701.GB7154@stefanha-x1.localdomain>
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAABGdBTUEAALGPC/xhBQAAABVQ
 TFRFAAAAWjotvpiH/PHt27Sj7sq8lXFeBchlBgAAAAFiS0dEAIgFHUgAAAAJcEhZcwAACxMAAAsT
 AQCanBgAAAAHdElNRQfiCx4VFw6omMmeAAACAklEQVQ4y43UPZPbIBAGYGdu0puzQ51bI+qMdXId
 r0F1RoLrwfb+/5+QF307VVR4PDxiF14h7Xa7t3q8LJGjavj7a1euCYiZnaPnv9DF4FyMLKdXOPs4
 XM7KKzzKaF83gem+hUuF8QYUg7Fb4LEQAK1OG3hu4bbC3LpUC87+B9AMfQOg0yv0owEOK4x1+gnu
 M3yaV3jOMGxvKoXEKC9gAoabJtZYlXO8wJcb1hMHQClZgSj7cbzsY4a2vSqltIlz8nMpZnMkEmVw
 N4DtcYJo3AMPXFIMRMax/BjhOxZi2CpKKpWSZCd4C8aZ4CpzjR+Cint9WEp5H12IbbySEpHdaYVh
 OY9onf0Qq9//zDCFEW0MbFjUz7mHD1UdO4B3iErk9whdKdWVRuW5YLl5KnU2rjTBDyPmQImm5mec
 WQx7X3fBNwAzQ9kvBTKR0BwR3Bewhisn2mpkhea3BZwBcdorRlQk9QKecyZukRPeHTmuEL1FdjlJ
 tmTlvoAJPnRaMnKinNICn4QthNaKlNAlLae9sc5UODaelVh+l345u7ZMIY89GNdmWV8cIaTFlLGm
 QKLrzQykh/Aw02WsdoE2l1g7JIPdyWGFL6Hy1uJZsEjavLUXkVyeIdrbpPoXQHxDG0l68wEoW8vG
 BLI6qc2XoUEWCUI26aQfK1wypuwV7v6mtMhtgL8avOP/pBCiigAAAABJRU5ErkJggg==
Date: Wed, 16 Sep 2020 16:39:55 -0700
In-Reply-To: <20200908141701.GB7154@stefanha-x1.localdomain> (Stefan
 Hajnoczi's message of "Tue, 8 Sep 2020 15:17:01 +0100")
Message-ID: <87zh5puw8k.fsf@ebb.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4801:7822:103:be76:4eff:fe10:7c55;
 envelope-from=bkuhn@sfconservancy.org; helo=pine.sfconservancy.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:56:26
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: , QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On Fri, Sep 04, 2020 at 04:35:34PM +0100, Alex Benn=C3=A9e wrote:
>> Given our growing reliance on GitLab and the recent announcement about
>> free tier minutes:
>>=20
>>   https://about.gitlab.com/pricing/faq-consumption-cicd/
>>=20
>> is it time we officially apply for GitLab's Open Source Program:
>>=20
>>   https://about.gitlab.com/solutions/open-source/program/

Sorry for my late response on this thread.  Since GitLab is requiring that
organizations be non-profits as part of this program, Conservancy will need
to coordinate your application with you as we're the parent non-profit for
this purpose.

Given my late reply, you may already be coordinating with my colleague Brett
about this, but I'll check in with him tomorrow to verify.

One thing to note is that my understanding is that most of what you're
getting access to through this program is proprietary software features that
GitLab offers as add-ons.  I really encourage you as a project not enable
such features, as ultimately you'll probably start to rely on them, and then
you'll be effectively relying on proprietary software infrastructure to
develop your project.

I'm also curious: is there something you need now from the GitLab software
that self-hosting might improve?
--=20
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

