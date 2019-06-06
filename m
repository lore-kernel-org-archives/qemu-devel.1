Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA058C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 20:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762AA208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 20:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="up72pTzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762AA208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38628 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYzSV-000409-Fb
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 16:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47341)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shorne@gmail.com>) id 1hYzRV-0003Xq-Hc
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shorne@gmail.com>) id 1hYzRU-0007sB-6i
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:57:01 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shorne@gmail.com>) id 1hYzRT-0007cp-QF
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:57:00 -0400
Received: by mail-pg1-x542.google.com with SMTP id 20so2026524pgr.4
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 13:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=+yFU2XklpJN/BGpwwTA3GKba4zr29TgNk6pSAhQ4H6A=;
 b=up72pTzQebU7SHLqz9Pi3CJsbG/mhiKew5t4Do0lA6tL4eFU5XzGKfVnHvgHCJ/nx1
 IOh0o3o0IinA54fet5Rwv+yntk/idrscCgsZapmZaGo6lEYIwIOS4CV7VxLexsAD6Ys0
 TJ1LQAERs9UoW0nFj+vzoBsMvY4KE5sREJHaPuTz0Y/WIQJY6O0TLwLzJSnEAx3x2lsp
 yOQt4ydLhIyGSlVR9KargTpeBb5c42xDoq60vRZl+p5knM5EPUdCsJPu4cv3wJQfj0F5
 8VOxJjtLSp/X2AoAJtrs/VN+gARrfSNJ8/syQA9bgs2zpL9lG8R+vrhe2nHy1AIluGFn
 bNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=+yFU2XklpJN/BGpwwTA3GKba4zr29TgNk6pSAhQ4H6A=;
 b=S0zU6JnnM/9Nvl5XCCPpQhJzocbS7qVNOwUKMWvSMU44T4mO+IicsWdjywsBdHJMTI
 BuFbTtC64LXYoZ1ivJM6bHbSSVqxM/oEyx6RKYUWH5I/k4EEDXDv9WhZouOArLJ5RtUC
 MLlvpF7u3zxii8NQS2bmgTVgDRMjcPIQbWqP7SWM4kTUBC8UxZQ8F0o1LhHfHJmiWvp/
 MT/Xez5hw/0uQipwqTCEv86M1PlFLQ4DzXIzsnGmbSh8tiKy0eW/YVE6TfWK7AxuZQVh
 Lq1OwL2a66A39VXV3ULbTbQck4jYR+8RfNPZjEEvAg5Rf36T8VvRtTgiHilbO2Gpw/m9
 zOZQ==
X-Gm-Message-State: APjAAAVg/x0vjqKuRN/trxEE8G6Xx2G8NCH8unalrlrbyHnsbrLBu5c2
 FJGKejSS8dFxNLN2gpNc/u4=
X-Google-Smtp-Source: APXvYqyj+9n/nKFDhN53Ln57L/BzKtonkZVdEUJ7LEw5+seG4mPNnpRTMDdZ9ify1SxfDRrj6gpErQ==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr405924pgm.97.1559854615296;
 Thu, 06 Jun 2019 13:56:55 -0700 (PDT)
Received: from localhost (g30.211-19-85.ppp.wakwak.ne.jp. [211.19.85.30])
 by smtp.gmail.com with ESMTPSA id v126sm50642pfb.81.2019.06.06.13.56.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 06 Jun 2019 13:56:54 -0700 (PDT)
Date: Fri, 7 Jun 2019 05:56:52 +0900
From: Stafford Horne <shorne@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190606205652.GE3379@lianli.shorne-pla.net>
References: <20190529150853.9772-1-armbru@redhat.com>
 <20190529150853.9772-3-armbru@redhat.com>
 <20190531033601.GB3379@lianli.shorne-pla.net>
 <30db7d52-b304-da2d-f84d-42a57dc28135@redhat.com>
 <20190604103349.GD3379@lianli.shorne-pla.net>
 <875zpik5qa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zpik5qa.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: Improve section headlines
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 06, 2019 at 07:01:49PM +0200, Markus Armbruster wrote:
>Stafford Horne <shorne@gmail.com> writes:
>
>> On Mon, Jun 03, 2019 at 10:45:14AM +0200, Philippe Mathieu-Daudé wrote:
>>> On 5/31/19 5:36 AM, Stafford Horne wrote:
>>> > On Wed, May 29, 2019 at 05:08:52PM +0200, Markus Armbruster wrote:
>>> >> When scripts/get_maintainer.pl reports something like
>>> >>
>>> >>     John Doe <jdoe@example.org> (maintainer:Overall)
>>> >>
>>> >> the user is left to wonder *which* of our three "Overall" sections
>>> >> applies.  We have three, one each under "Guest CPU cores (TCG)",
>>> >> "Guest CPU Cores (KVM)", and "Overall usermode emulation".
>>> >>
>>> >> Rename sections under
>>> >>
>>> >> * "Guest CPU cores (TCG)" from "FOO" to "FOO CPU cores (TCG)"
>>> >>
>>> >> * "Guest CPU Cores (KVM)" from "FOO" to "FOO CPU cores (KVM)"
>>> >>
>>> >> * "Guest CPU Cores (Xen)" from "FOO" to "FOO CPU cores (Xen)"
>>> >>
>>> >> * "Architecture support" from "FOO" to "FOO general architecture
>>> >>   support"
>>> >>
>>> >> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target"
>>> >>
>>> >> While there,
>>> >>
>>> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> >> ---
>>> >>  MAINTAINERS | 78 ++++++++++++++++++++++++++---------------------------
>>> >>  1 file changed, 39 insertions(+), 39 deletions(-)
>>> >
>>> > ...
>>> >
>>> >> -OpenRISC
>>> >> +OpenRISC CPU cores (TCG)
>>> >>  M: Stafford Horne <shorne@gmail.com>
>>> >>  S: Odd Fixes
>>> >>  F: target/openrisc/
>>> >>  F: hw/openrisc/
>>> >>  F: tests/tcg/openrisc/
>>> >>
>>> >
>>> > As directories listed there I look over both target/ (TCG?) and hw/.
>>> > Would it be better to be 'OpenRISC general architecture'?
>>>
>>> There is a historical separation between target/ and hw/ because they
>>> cover different concepts, and have different maintainers/reviewers.
>>>
>>> - target/$arch/ is for TCG/KVM
>>> - hw/ is for machines and their devices
>>>   (some devices are reused by multiple archs)
>>>
>>> Although the separation is not always clear (some devices are tied to an
>>> architecture, some architecture instruction directly access devices) I'd
>>> prefer we keep 2 distincts MAINTAINERS sections (keeping you maintainer
>>> of both). This will ease developper with specific background/interests
>>> to volunteer to a particular section.
>>
>> Hello,
>>
>> Thanks for the explaination.  I think it makes sense to have 2 different
>> maintainer sections.  In that case should this patch be amended to move the
>> 'F: hw/openrisc/' etc out to a different section with the different header?
>
>This patch merely improves headlines.  Splitting up the OpenRISC section
>above should be separate.  Care to send the patch?

Sure, now that I look at it, there is a section for 'OpenRISC Machines' and the
maintainer is out of date.

-Stafford

