Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FB4C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5875321D81
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCwUWSK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5875321D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFiak-00037o-Bv
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iFiZn-0002aB-Kk
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iFiZm-0000ry-A4
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:38:11 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iFiZm-0000rK-0a
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:38:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id v17so7819352wml.4
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=05g3gnta0GqghE7EvZzpaRFhe6OC8zIx1bTzw4XggVU=;
 b=wCwUWSK1P1+6xC08bzrEfml2KsAg4Fu/GUdhsiasHGt2rAxG0yGWFpDJe/tXZQtihU
 hF9GevtIfvvZQAJl1RnUcbKk7iveehIzA6rUioMXXSCT8aUcelds6c2Q5N3OJrrZ12pO
 s46r+E/MbF6POjzfl0Wxi08YflGMovbgDDfWJlXnK9CUwUBm+n7SHr1gGe2Jj7TqI306
 24NJq9ssnCKreOSVXMoF+j/ekSrB6lm/ZjXmQDtguayYB5JFCWW5ZJ26dNlPNoxAUdg5
 4AYzIq1ioWFc6KkiCdFGqcpgFswVTVTa0m+xSriUevcTOE+N9HANWMqWqgDaittcmCPe
 8kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=05g3gnta0GqghE7EvZzpaRFhe6OC8zIx1bTzw4XggVU=;
 b=oQb5VnEam3t9beBAUwFtRprA1deI2hDEDSfOynuRse5Cbvsz6T3tSl8iD1dT5IqsDj
 ypMouQzh/aoMsedQimgP2l4T99cwU3q4nX+xVsBD4E68iS+0B4PevemiwGohUHTNv3ws
 rnqNXyu3gELKVHhADwrYePKAhmVU9PqiGEwx89dH0lXnT7HWgC3TkRP9CUxaaU1kD5T6
 90mTFaumllXQFoqGdnmeI1Qftep5HftKAcZ05Z1uJSLPzVd8UGlcvgmWIwHJBNzdmJ7E
 Y2+dtOh5JuPO1pVeNZqH0C9ON1EBxg39oxFm/VTSzcSfRMWHQ3NxzVDbMSKdo303qtEb
 STCg==
X-Gm-Message-State: APjAAAWBd8Y7qGewFKkSW44yiAa+/3DdO6+z0L2tOvnA9GB28Hv7x0mq
 1g8feHy5lhyUUKfiAbX/LUOQkw==
X-Google-Smtp-Source: APXvYqyi3AnYWi102KtvUr4wtg8DDSX6DhGgQCEbY4xlPK1pX2TCLQy7zaiQpG/pB3zlDlNHSIbIyw==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr271259wme.137.1570037888176;
 Wed, 02 Oct 2019 10:38:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 13sm6188723wmj.29.2019.10.02.10.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2019 10:38:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF0061FF87;
 Wed,  2 Oct 2019 18:38:06 +0100 (BST)
References: <bf30baf5-4d75-dc6f-c30a-57b80714999b@ilande.co.uk>
 <CAL1e-=gcK2mdtrt9vibHGpbm4_FZgQWTA91+p=9ouuMYmZwPqQ@mail.gmail.com>
 <c9679b01-91c3-3d69-fb38-dfef1602dcf4@ilande.co.uk>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: target/ppc: bug in optimised vsl/vsr implementation?
In-reply-to: <c9679b01-91c3-3d69-fb38-dfef1602dcf4@ilande.co.uk>
Date: Wed, 02 Oct 2019 18:38:06 +0100
Message-ID: <87v9t7jbep.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: stefan.brankovic@rt-rk.com, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 28/09/2019 18:45, Aleksandar Markovic wrote:
>
> Hi Aleksandar,
>
> Thanks for taking a look at this!
>
>> Mark and Paul (and Stefan),
>>
>> Thanks for spotting this and pinpointing the culprit commit. I guess Ste=
fan is going
>> to respond soon, but, in the meantime, I took a look at the commit in qu=
estion:
>>
>> https://github.com/qemu/qemu/commit/4e6d0920e7547e6af4bbac5ffe9adfe6ea62=
1822
>>
>> I don't have at the moment any dev/test environment handy, but I did man=
ual
>> inspection of the code, and here is what I found (in order of importance=
, perceived
>> by me):
>>
<snip>
>
>> Given all these circumstances, perhaps the most reasonable solution woul=
d be to
>> revert the commit in question, and allow Stefan enough dev and test time=
 to hopefully
>> submit a new, better, version later on.
>
> Given that it has been broken for 3 months now, I don't think we're in an=
y major rush
> to revert ASAP. I'd prefer to give Stefan a bit more time first since he =
does report
> some substantial speed improvements from these new implementations.

Is the denbcdq instruction exposed in any standard float operations?
Once this is fixed it would be worth adding a testcase (either ppc64
specific or multiarch) so protect it from regression in the future.

>
>
> ATB,
>
> Mark.


--
Alex Benn=C3=A9e

