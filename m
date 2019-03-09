Received: from eggs.gnu.org ([209.51.188.92]:41421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h2Z9e-0006Q0-PG
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 05:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h2Z9e-0004c8-5O
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 05:24:34 -0500
Received: from smtp.lg.ehu.es ([158.227.0.66]:27554 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h2Z9d-0004S1-Qm
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 05:24:34 -0500
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
	by postfix.smtp1.imsva1 (Postfix) with ESMTPS id 39C1F31C52
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 11:24:31 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1087D110054
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 11:24:31 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0587B110050
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 11:24:31 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
	by imsva1.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 11:24:30 +0100 (CET)
Received: from mail-it1-f171.google.com (mail-it1-f171.google.com
	[209.85.166.171]) by smtp1 (Postfix) with ESMTPSA id B74CF31C52
	for <qemu-devel@nongnu.org>; Sat,  9 Mar 2019 11:24:30 +0100 (CET)
Received: by mail-it1-f171.google.com with SMTP id l139so151728ita.5
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 02:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20190306031221.GA53@03612eec87fc>
	<20190306044947.GE75@03612eec87fc>
	<fa52b25f-5f1c-7ec2-e2f1-bbfc73943847@vivier.eu>
In-Reply-To: <fa52b25f-5f1c-7ec2-e2f1-bbfc73943847@vivier.eu>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Sat, 9 Mar 2019 11:24:20 +0100
Message-ID: <CAGZZdDGXTs0QM2KcvceBcUarE3Rn6txYtZ2e+wQLSVtmi8hakQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 5/10] qemu-binfmt-conf.sh: honour
 QEMU_PATH and/or QEMU_SUFFIX
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

2019/3/9 10:46, Laurent Vivier:
> On 06/03/2019 05:49, Unai Martinez-Corral wrote:
> > -QEMU_PATH=/usr/local/bin
> > -
> > +QEMU_PATH="${QEMU_PATH:-/usr/local/bin}"
> > +QEMU_SUFFIX="${QEMU_SUFFIX:-}"
> >  QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
> >  QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
> >
> > -QEMU_SUFFIX=""
>
> Same question as for PATCH 3/10: why?

Same context. Moreover, in this case envvars already existed and were
hardcoded. I don't think it does any harm to let a external caller set
the defaults.

> And I think the usage text should be formatted differently to be cleared and looks
> like more the one of qemu-XXX:

Agree. I will update when the remaining patches are reviewed, since 6
out of 10 are affected by this change.

Unai
