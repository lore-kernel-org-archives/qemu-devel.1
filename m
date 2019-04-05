Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F65CC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B73217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B73217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38739 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKz0-0003P6-89
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:17:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKy2-0002te-Na
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKy1-0008Ht-Ks
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:16:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCKy1-0008BG-09
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:16:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so7050748wrn.11
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 02:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=dbcVRNCU4BmZKYSJyylCjt43tqPQVRKrjkMWr33Q4QY=;
	b=Y2MDGSOkljdiqdqHXoN7Rdcn801pKibl4r0I7p3/CjRAE/1WmKlhIEzoqfOzzzftsC
	g7glMN+jNWEmHauKLbUf7E86Y6Bz8MpzrySEHAxnkuUn3bX5857lCUx3Hy6XLkPVdLUU
	QEtqeg2bNerSWTDyU8K+zidM1jUOKPgRhIkFhD4aUeBgGWO0+hymk6q3n6Vap/DxxHvO
	pZlTjxvnEigcf8on32Of9pbi3UsNDxt206uTVH4a4ZT+teXMU0xnEpIIQ2t74vVkU++k
	ey3sO66YkC40Kf9UndqlpueydwxuwORI5iTYaXuxVhqFVDDlB1eUHf4D0GhRrMpvhMEL
	gO5A==
X-Gm-Message-State: APjAAAXXgR6FWvogmHb7Kne4uH70/s2TJHszx2VwQqGVQVBt54Xk+agA
	859R9Xeqji6ZZsZzaZjki9TO9A==
X-Google-Smtp-Source: APXvYqwH3HF5LBXjMVD+P/oKJ8r1pPWV8BuE13mBhC6tNxG2aQ8UL2ZkuAfLEMg4NkWo75hDRASqoA==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr7852085wrs.278.1554455816081; 
	Fri, 05 Apr 2019 02:16:56 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	q4sm30406851wrx.25.2019.04.05.02.16.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 02:16:55 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
	<20190405090212.GF6105@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
Date: Fri, 5 Apr 2019 11:16:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405090212.GF6105@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
	Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405091654.y_JiJ_grPZy8CHa8BwKa22i45ihLgFdUrEuH6zoNdC4@z>

On 4/5/19 11:02 AM, Daniel P. Berrangé wrote:
> On Fri, Apr 05, 2019 at 10:47:54AM +0200, Philippe Mathieu-Daudé wrote:
>> Hi Helge,
>>
>> On 4/5/19 9:56 AM, Helge Deller wrote:
>>> On 05.04.19 03:34, Peter Maydell wrote:
>>>> On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
>>>>> If a non-release architecture is found, and it's known that there is no
>>>>> native TCG support for that CPU, automatically fall back to the TCI
>>>>> implementation instead of requesting the user to run configure again
>>>>> with the --enable-tcg-interpreter option.
>>>>>
>>>>> This change simplifies building qemu in automatic build environments
>>>>> (like in my case the debian buildds) because one does not need to
>>>>> special case on the architectures.
>>>>
>>>> I don't think we should do this. TCI is unmaintained, has several
>>>> known flaws,
>>>
>>> Just out of interest: Is there a list with those flaws somewhere?
>>
>> The last big discussion is in this thread:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06528.html

I just noticed this link doesn't show the full thread replies list, and
want to point out Stefan's one:

https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06841.html

I guess remember someone (Thomas? you Daniel?) posting a link of 3 forks
using TCI for reverse engineering but I can't find it to check if they
are still active.

> Do the various crashes that you illustrate in that cover letter
> still exist today ? If so, 2 years of continued brokenness with no
> fixes would reinforce the the view that it is time to remove TCI
> from the codebase.

Or find a maintainer and add tests...

