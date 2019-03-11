Received: from eggs.gnu.org ([209.51.188.92]:49978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3CCi-0006Ze-Mm
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 00:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3CCh-0003ND-R7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 00:06:20 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:30967 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3CCh-0003F5-Ex
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 00:06:19 -0400
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
	by postfix.smtp1.imsva1 (Postfix) with ESMTPS id C7C1A2B944
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 05:06:10 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A45BE110054
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 05:06:10 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99862110050
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 05:06:10 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
	by imsva1.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 05:06:10 +0100 (CET)
Received: from mail-it1-f179.google.com (mail-it1-f179.google.com
	[209.85.166.179]) by smtp1 (Postfix) with ESMTPSA id 48D1C2B944
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 05:06:10 +0100 (CET)
Received: by mail-it1-f179.google.com with SMTP id l15so5117163iti.4
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 21:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190306031221.GA53@03612eec87fc>
	<20190306045019.GF75@03612eec87fc>
	<63800576-160f-a104-ede7-ca0fd2386bd9@vivier.eu>
In-Reply-To: <63800576-160f-a104-ede7-ca0fd2386bd9@vivier.eu>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Mon, 11 Mar 2019 05:05:59 +0100
Message-ID: <CAGZZdDGs+qY4Kj5pPwMhpxVNTMDKP1CvbYgeZs+pTQMzGru-jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 6/10] qemu-binfmt-conf.sh: generalize
 <CPU> to positional <CPUS>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org, riku.voipio@iki.fi, Eric Blake <eblake@redhat.com>

2019/3/10 18:02, Laurent Vivier:
> On 06/03/2019 05:50, Unai Martinez-Corral wrote:
> > The list can be separated by spaces, tabs, newlines or commas. If no
>
> I think it would be simpler to not manage commas, and to use the default
> field separator.

Commas were supported because the same function is used to parse CPUS
here and ARCHS in patch 7/10. ARCHS must be separated by commas.
Nonetheless, if we do not support CPUS and ARCHS in a single command,
we can avoid managing commas.

Agree and thanks for all of the remaining comments. I will apply them:

> Why do you need to introduce a new variable "all", you can use directly
> "qemu_target_list".

> No need to introduce a new variable, you can use directly
> checked_target_list

> Use directly "qemu_target_list"
> You don't need a new variable, you can check "x$cpu" = "x$target" to
> know if you have found the target.

> I think you don't need to add the ":" at the beginning of the list.

Regards,
Unai
