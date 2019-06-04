Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D804C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 10:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE8A245C5
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 10:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBAh0fWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE8A245C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY6mI-00029E-8j
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 06:34:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1hY6lW-0001pE-Hh
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1hY6lV-0003yN-AO
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:34:02 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1hY6lV-0003pk-3w
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:34:01 -0400
Received: by mail-pg1-x541.google.com with SMTP id f25so10103388pgv.10
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=r9BnbXicuaXTkYiLzProMIcySUc6/7HXa6wHWSyQNbA=;
	b=fBAh0fWn8admaRbMt8ujx/wMVhoVYXCa+sNcrPVKzLEFRNmthXzAUWK4SZji4aCozu
	0YNr4XhcjvacdkCHjiqCmVNC6C8uzEP+/kdsxLAJy6fp4UAb+vYkHpnuXYMIt9jiIloJ
	HuX0X+FlN4JtXO/L9Szy/Yxd+ib2Mq8kYazVEzo32pfhW+zdViWMc4pqNFE91rlrBfdP
	PEKt6OOIt7v3YzyDvoK6P4mMmvmdba8vdr2o9RXzKCkX9UHfiDP6Y/BVf5iDhqwTJbSx
	kwlpU84xxfTG4HpC92F1ewbE+AfTO6LkUfB/uv7Jip8Imls5EYdo3LL5EDnDMfB6Q+rH
	SsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=r9BnbXicuaXTkYiLzProMIcySUc6/7HXa6wHWSyQNbA=;
	b=Y02q7ST2vYQKL5DhH8hoIZTJTAdW0VRSu+OFsEzs6Ov016VSJXEbyVgTtU6QJ2MH7E
	IPSHSt6JpzaIERhkEZtmDCAtoM4ftchybnqmCqQ/33pFS7VM5EAQfr6DSDlazEg37UkN
	UlWfmmu/JeXEa2zZyMMIAbTyW6kj0PFMaKFHaTZvNpp3Htzd5HWV4WdniAmVDLQQCKKv
	6aWlHfVdK4/3wS0TQjBIxxFQ9Ed3z+PNr2tOBD40xhmeEJpCuKami7ZRIZ9lBy2TlO9B
	7R9OQ1naN2BwWU85L3c0Tr/4332u46hUVX9apBiBL6smcO6SOwPoB2djdIl2YVmeF7Cl
	NzTA==
X-Gm-Message-State: APjAAAXInJtVteam1ubAaVPMxgKtR2AdzBPz6E7OkpBXIWudcQs3GVVN
	Kt1iTfuAALF1DU9fILO0jcU=
X-Google-Smtp-Source: APXvYqwldH8TNCeglMzB+UPeXBa0sa3rKBM5ulXU3Y2o6Ypwd4vFKRmIbRtL8ZXXRsGtedisZZjguw==
X-Received: by 2002:a17:90a:8586:: with SMTP id
	m6mr36055691pjn.129.1559644432819; 
	Tue, 04 Jun 2019 03:33:52 -0700 (PDT)
Received: from localhost (g30.211-19-85.ppp.wakwak.ne.jp. [211.19.85.30])
	by smtp.gmail.com with ESMTPSA id
	m20sm1542783pjn.16.2019.06.04.03.33.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 04 Jun 2019 03:33:52 -0700 (PDT)
Date: Tue, 4 Jun 2019 19:33:49 +0900
From: Stafford Horne <shorne@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190604103349.GD3379@lianli.shorne-pla.net>
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-3-armbru@redhat.com>
	<20190531033601.GB3379@lianli.shorne-pla.net>
	<30db7d52-b304-da2d-f84d-42a57dc28135@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30db7d52-b304-da2d-f84d-42a57dc28135@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: Improve section headlines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 10:45:14AM +0200, Philippe Mathieu-Daudé wrote:
> On 5/31/19 5:36 AM, Stafford Horne wrote:
> > On Wed, May 29, 2019 at 05:08:52PM +0200, Markus Armbruster wrote:
> >> When scripts/get_maintainer.pl reports something like
> >>
> >>     John Doe <jdoe@example.org> (maintainer:Overall)
> >>
> >> the user is left to wonder *which* of our three "Overall" sections
> >> applies.  We have three, one each under "Guest CPU cores (TCG)",
> >> "Guest CPU Cores (KVM)", and "Overall usermode emulation".
> >>
> >> Rename sections under
> >>
> >> * "Guest CPU cores (TCG)" from "FOO" to "FOO CPU cores (TCG)"
> >>
> >> * "Guest CPU Cores (KVM)" from "FOO" to "FOO CPU cores (KVM)"
> >>
> >> * "Guest CPU Cores (Xen)" from "FOO" to "FOO CPU cores (Xen)"
> >>
> >> * "Architecture support" from "FOO" to "FOO general architecture
> >>   support"
> >>
> >> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target"
> >>
> >> While there,
> >>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  MAINTAINERS | 78 ++++++++++++++++++++++++++---------------------------
> >>  1 file changed, 39 insertions(+), 39 deletions(-)
> > 
> > ... 
> > 
> >> -OpenRISC
> >> +OpenRISC CPU cores (TCG)
> >>  M: Stafford Horne <shorne@gmail.com>
> >>  S: Odd Fixes
> >>  F: target/openrisc/
> >>  F: hw/openrisc/
> >>  F: tests/tcg/openrisc/
> >>  
> > 
> > As directories listed there I look over both target/ (TCG?) and hw/.
> > Would it be better to be 'OpenRISC general architecture'?
> 
> There is a historical separation between target/ and hw/ because they
> cover different concepts, and have different maintainers/reviewers.
> 
> - target/$arch/ is for TCG/KVM
> - hw/ is for machines and their devices
>   (some devices are reused by multiple archs)
> 
> Although the separation is not always clear (some devices are tied to an
> architecture, some architecture instruction directly access devices) I'd
> prefer we keep 2 distincts MAINTAINERS sections (keeping you maintainer
> of both). This will ease developper with specific background/interests
> to volunteer to a particular section.

Hello,

Thanks for the explaination.  I think it makes sense to have 2 different
maintainer sections.  In that case should this patch be amended to move the
'F: hw/openrisc/' etc out to a different section with the different header?

-Stafford

